"""Synthetic regression cases for the publication gate, with no real credentials."""
import unittest

from tools.validate import sensitive_findings, validate_sql


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


if __name__ == '__main__':
    unittest.main()
