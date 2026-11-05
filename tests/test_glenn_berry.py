"""Regression cases for source extraction and narrowly scoped import exceptions."""
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from tools import import_glenn_berry as importer
from tools.validate import validate_imported_sql, validate_sql


class ExtractionTests(unittest.TestCase):
    def test_context_switch_is_not_attached_to_previous_query(self):
        text = ('-- First (Query 1) (Version Info)\nSELECT 1;\n'
                '-- Database specific queries ********\nUSE YourDatabaseName;\n'
                '-- Second (Query 3) (File Sizes and Space)\nDECLARE @n int = 2;\nSELECT @n;\n')
        rows = importer.split_queries(text)
        self.assertEqual([1, 3], [r['number'] for r in rows])
        self.assertEqual(['instance', 'database'], [r['scope'] for r in rows])
        self.assertNotIn('USE ', rows[0]['body'])
        self.assertIn('DECLARE @n', rows[1]['body'])
        self.assertEqual(5, rows[1]['line_start'])

    def test_missing_or_duplicate_markers_fail(self):
        for text in ('SELECT 1;', '-- A (Query 1) (Version Info)\nSELECT 1;\n-- B (Query 1) (Version Info)\nSELECT 2;'):
            with self.assertRaises(ValueError):
                importer.split_queries(text)

    def test_source_checksum_mismatch_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'sample.sql').write_text('SELECT 1;')
            lock = root / 'lock.json'
            lock.write_text(json.dumps({'sources': [{'file': 'sample.sql', 'sha256': '0' * 64}]}))
            with patch.object(importer, 'LOCK', lock), self.assertRaisesRegex(ValueError, 'checksum mismatch'):
                importer.render(root)

    def test_all_pinned_suites_are_fully_cataloged(self):
        rows = json.loads((importer.ROOT / 'catalog.json').read_text())
        imported = [r for r in rows if r.get('author') == 'Glenn Berry']
        counts = {'2005.sql': 51, '2008.sql': 59, '2008R2.sql': 64, '2012.sql': 72,
                  '2014.sql': 75, '2016.sql': 78, '2016SP2.sql': 81, '2017.sql': 83,
                  '2019.sql': 86, '2022sql': 88, '2025sql': 89, 'azure.sql': 56, 'managed.sql': 69}
        self.assertEqual(951, len(imported))
        self.assertEqual(set(counts), {r['source_file'] for r in imported})
        for name, count in counts.items():
            numbers = [r['source_query'] for r in imported if r['source_file'] == name]
            expected = list(range(1, count + 1)) if name != '2017.sql' else [n for n in range(1, 85) if n != 82]
            self.assertEqual(expected, numbers, name)
        for row in imported:
            self.assertEqual('LicenseRef-Glenn-Berry', row['license'])
            text = (importer.ROOT / row['path']).read_text()
            self.assertIn('Copyright (C) 2025 Glenn Berry', text)
            self.assertIn('*non-commercial*', text)
            self.assertIn(row['reference'], text)


class ImportGateTests(unittest.TestCase):
    @staticmethod
    def fixture(text, findings):
        digest = hashlib.sha256(text.encode()).hexdigest()
        entry = {'path': 'fixture.sql', 'sha256': digest}
        review = {'fixture.sql': {'sha256': digest, 'expected_findings': findings}}
        return entry, review

    def test_exact_diagnostic_review_does_not_relax_curated_rules(self):
        text = 'DBCC TRACESTATUS (-1);'
        findings = validate_sql(text)
        self.assertTrue(findings)
        entry, reviews = self.fixture(text, findings)
        self.assertEqual([], validate_imported_sql(text, entry, reviews))
        self.assertTrue(validate_imported_sql(text, entry, {}))
        self.assertTrue(validate_imported_sql(text + '\nDELETE FROM dbo.example;', entry, reviews))

    def test_catalog_hash_alone_cannot_renew_a_review(self):
        text = 'DBCC TRACESTATUS (-1);'
        entry, reviews = self.fixture(text, validate_sql(text))
        changed = 'DBCC FREEPROCCACHE;'
        entry['sha256'] = hashlib.sha256(changed.encode()).hexdigest()
        self.assertTrue(validate_imported_sql(changed, entry, reviews))

    def test_secret_and_parse_error_cannot_be_exempted(self):
        text = '-- pass' + "word = '" + 'synthetic' + "'\nSELECT 1;"
        for text in (text, 'SELECT FROM;'):
            entry, reviews = self.fixture(text, validate_sql(text))
            self.assertTrue(validate_imported_sql(text, entry, reviews))

    def test_only_reviewed_build_table_comments_can_exempt_ipv4_matches(self):
        for text, allowed in (
            ('-- 16.0.600.9 CTP 2.0 5/20/2022\nSELECT 1;', True),
            ('-- endpoint 192.0.2.1\nSELECT 1;', False),
            ("SELECT '16.0.600.9' AS address;", False),
        ):
            entry, reviews = self.fixture(text, validate_sql(text))
            self.assertEqual(allowed, not validate_imported_sql(text, entry, reviews))

    def test_stale_expected_findings_are_rejected(self):
        text = 'SELECT 1;'
        entry, reviews = self.fixture(text, ['operation not allowed in this collection: DBCC'])
        self.assertTrue(validate_imported_sql(text, entry, reviews))


if __name__ == '__main__':
    unittest.main()
