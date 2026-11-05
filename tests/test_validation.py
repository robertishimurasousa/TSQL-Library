"""Synthetic regression cases for the publication gate, with no real credentials."""
import unittest

from sqlfluff.core import FluffConfig, Lexer, Linter

from tools.validate import ROOT, sensitive_findings, validate_sql, validate_collector_sql


class ValidationTests(unittest.TestCase):
    def test_read_only_cte_and_session_settings(self):
        self.assertEqual([], validate_sql(
            'SET NOCOUNT ON; DECLARE @n int = 1; '
            'WITH x AS (SELECT @n AS n) SELECT n FROM x;'
        ))

    def test_literals_and_comments_do_not_become_operations(self):
        self.assertEqual([], validate_sql("SELECT N'DROP TABLE' AS label; -- ALTER DATABASE"))

    def test_mutations_and_indirect_execution_are_rejected(self):
        statements = [
            'DELETE FROM dbo.example;',
            'SELECT 1 AS n INTO dbo.example;',
            'EXEC sys.sp_configure;',
            'UPDATE dbo.example SET n = 2;',
            'CREATE TABLE dbo.example (n int);',
            'SELECT NEXT VALUE FOR dbo.example;',
            "IF 1 = 1 BEGIN EXEC(N'SELECT 1'); END;",
            'WITH x AS (SELECT n FROM dbo.example) DELETE FROM x;',
        ]
        for statement in statements:
            with self.subTest(statement=statement):
                self.assertTrue(validate_sql(statement))

    def test_session_configuration_is_restricted(self):
        self.assertTrue(validate_sql('SET ANSI_NULLS OFF; SELECT 1 AS n;'))

    def test_parse_failure_is_rejected(self):
        self.assertTrue(validate_sql('SELECT FROM;'))

    def test_secrets_in_comments_are_detected_without_echoing_values(self):
        example_value = 'synthetic-' + 'only'
        sql = '-- PASS' + "WORD = N'" + example_value + "'\nSELECT 1 AS n;"
        findings = sensitive_findings(sql)
        self.assertTrue(findings)
        self.assertNotIn(example_value, '\n'.join(findings))

    def test_hash_assignment_is_detected(self):
        sql = 'PASS' + 'WORD = 0x' + ('AB' * 20)
        self.assertTrue(sensitive_findings(sql))

    def test_parameter_without_literal_is_allowed(self):
        self.assertEqual([], sensitive_findings('DECLARE @PrincipalName sysname = NULL;'))

    def test_collector_exception_is_bound_to_path_and_exact_content(self):
        path = 'scripts/diagnostics/programmable-objects-all-databases.sql'
        sql = (ROOT / path).read_text()
        self.assertEqual([], validate_collector_sql(path, sql))
        self.assertTrue(validate_collector_sql('scripts/diagnostics/unreviewed.sql', sql))
        self.assertTrue(validate_collector_sql(path, sql + '\nDELETE FROM dbo.example;'))
        self.assertTrue(validate_sql(sql))  # The ordinary curated policy is still strict.

    def test_collector_dynamic_body_parses_after_identifier_substitution(self):
        sql = (ROOT / 'scripts/diagnostics/programmable-objects-all-databases.sql').read_text()
        segments, errors = Lexer(config=FluffConfig(overrides={'dialect': 'tsql'})).lex(sql)
        self.assertFalse(errors)
        # Parse the actual inner SQL, not just the outer string literal.
        # Identifier escaping still needs engine tests (SQLFluff does not parse
        # every valid escaped-bracket identifier).
        literals = [s.raw for s in segments if s.raw.startswith("N'")
                    and 'INSERT INTO #LibraryObjects' in s.raw]
        self.assertEqual(1, len(literals))
        payload = literals[0][2:-1].replace("''", "'")
        parsed = Linter(dialect='tsql').parse_string('USE [SyntheticDatabase]' + payload)
        self.assertFalse(parsed.violations)
        self.assertFalse(list(parsed.tree.recursive_crawl('unparsable')))

    def test_command_generators_remain_nonexecuting_curated_queries(self):
        paths = sorted((ROOT / 'scripts/script-generation').glob('*.sql'))
        self.assertEqual(5, len(paths))
        for path in paths:
            with self.subTest(path=path.name):
                self.assertEqual([], validate_sql(path.read_text()))


if __name__ == '__main__':
    unittest.main()
