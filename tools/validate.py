"""Validate curated SQL and individually reviewed upstream imports. Never executes SQL."""
from __future__ import annotations

import json
import hashlib
from pathlib import Path
import re
import sys

from sqlfluff.core import Linter

ROOT = Path(__file__).resolve().parents[1]
ALLOWED_EXTENSIONS = {'.sql', '.md', '.json', '.yml', '.toml', '.py', '.txt'}
ALLOWED_NAMES = {'LICENSE', '.gitignore', '.sqlfluff'}
IGNORED_PARTS = {'.git', '.venv', '__pycache__', '.pytest_cache'}
ALLOWED_STATEMENTS = {
    'select_statement', 'with_compound_statement', 'set_segment',
    'declare_segment', 'if_then_statement', 'throw_statement',
}
FORBIDDEN_WORDS = {
    'ALTER', 'BACKUP', 'BULK', 'CREATE', 'DBCC', 'DELETE', 'DENY', 'DROP',
    'EXEC', 'EXECUTE', 'GRANT', 'INSERT', 'INTO', 'KILL', 'MERGE',
    'OPENROWSET', 'OPENDATASOURCE', 'RECONFIGURE', 'RESTORE', 'REVOKE',
    'TRUNCATE', 'UPDATE', 'USE', 'XP_CMDSHELL',
}
# Only this exact collector was reviewed for database-name quoting, parameterized
# dynamic catalog reads and session-local temporary-table writes. No directory
# or general EXEC/DDL exemption is granted to other curated files.
REVIEWED_COLLECTORS = {
    'scripts/diagnostics/programmable-objects-all-databases.sql': {
        'sha256': '61f887147212cff2b2bf695df2a7c83fd16fb579c8a39a1fc9603954c4f3c514',
        'expected_findings': {
            'statement type not allowed: create_table_statement',
            'statement type not allowed: while_statement',
            'statement type not allowed: begin_end_block',
            'statement type not allowed: try_catch',
            'statement type not allowed: execute_script_statement',
            'statement type not allowed: insert_statement',
            'statement type not allowed: drop_table_statement',
            *[f'operation not allowed in this collection: {word}'
              for word in ('CREATE', 'DROP', 'EXEC', 'INSERT', 'INTO')],
        },
    },
}
# Scan raw text, including comments. Only report rule and line, never its match.
SENSITIVE_PATTERNS = {
    'credential-literal': re.compile(
        r"(?i)\b(?:password|pwd|secret|accountkey|api_key|@?rmtpassword)\s*=\s*N?'[^']+'"
    ),
    'password-hash': re.compile(r'(?i)\bpassword\s*=\s*0x[0-9a-f]{16,}'),
    'command-credential': re.compile(r'(?i)\bcmdkey\b[^\r\n]*/pass:\S+'),
    'private-key': re.compile(r'-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----'),
    'provider-token': re.compile(r'\b(?:sk-[A-Za-z0-9_-]{30,}|hf_[A-Za-z0-9]{30,}|gh[pousr]_[A-Za-z0-9]{30,})'),
    'unc-path': re.compile(r'\\\\[A-Za-z0-9][^\s\x27\x22]*'),
    'ipv4-literal': re.compile(r'(?<![\w.])(?:\d{1,3}\.){3}\d{1,3}(?![\w.])'),
    'email-literal': re.compile(r'(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b'),
}


def sensitive_findings(text: str) -> list[str]:
    return [f'{rule} at line {text.count(chr(10), 0, match.start()) + 1}'
            for rule, pattern in SENSITIVE_PATTERNS.items()
            for match in pattern.finditer(text)]


def validate_sql(text: str, linter: Linter | None = None) -> list[str]:
    problems = sensitive_findings(text)
    parsed = (linter or Linter(dialect='tsql')).parse_string(text)
    if parsed.violations or parsed.tree is None:
        # Parser descriptions can quote source text. Do not log them.
        problems.extend(f'parse error at line {v.line_no}' for v in parsed.violations)
        if parsed.tree is None:
            problems.append('missing parse tree')
        return problems
    tree = parsed.tree
    if list(tree.recursive_crawl('unparsable')):
        problems.append('unparsable SQL segment')
    for statement in tree.recursive_crawl('statement'):
        for child in statement.segments:
            if child.is_code and child.get_type() not in ALLOWED_STATEMENTS:
                problems.append(f'statement type not allowed: {child.get_type()}')
    for segment in tree.recursive_crawl('set_segment'):
        code = ' '.join(s.raw.upper() for s in segment.raw_segments if s.is_code)
        if code.rstrip(' ;') != 'SET NOCOUNT ON':
            problems.append('only SET NOCOUNT ON is allowed')
    words = [s.raw.upper() for s in tree.raw_segments
             if s.is_code and s.get_type() not in {'literal', 'quoted_literal'}]
    for word in sorted(set(words) & FORBIDDEN_WORDS):
        problems.append(f'operation not allowed in this collection: {word}')
    if re.search(r'\bNEXT VALUE FOR\b', ' '.join(words)):
        problems.append('sequence advancement is not read-only')
    return list(dict.fromkeys(problems))


def validate_imported_sql(text: str, entry: dict, reviews: dict,
                          linter: Linter | None = None) -> list[str]:
    """Exceptions apply to exact reviewed files, never to a folder or SQL keyword."""
    digest = hashlib.sha256(text.encode('utf-8')).hexdigest()
    if digest != entry.get('sha256'):
        return ['import differs from its catalog checksum; review and regenerate from the pinned source']
    problems = validate_sql(text, linter)
    review = reviews.get(entry['path'])
    if not review:
        return problems
    if review.get('sha256') != digest:
        return ['import differs from its reviewed checksum']
    expected = review.get('expected_findings', [])
    # A review receipt cannot exempt credentials, parser errors or arbitrary writes.
    permitted = {
        'statement type not allowed: dbcc_statement',
        'statement type not allowed: execute_script_statement',
        'statement type not allowed: create_table_statement',
        'statement type not allowed: insert_statement',
        'statement type not allowed: drop_table_statement',
        'statement type not allowed: set_local_variable_segment',
        'statement type not allowed: while_statement',
        'statement type not allowed: begin_end_block',
        *[f'operation not allowed in this collection: {word}'
          for word in ('DBCC', 'EXEC', 'CREATE', 'DROP', 'INSERT', 'INTO')],
    }
    for finding in expected:
        if finding in permitted:
            continue
        match = re.fullmatch(r'ipv4-literal at line (\d+)', finding)
        if match:
            lines = text.splitlines()
            index = int(match[1]) - 1
            # Only dated upstream CTP/RC build-table comments, not arbitrary addresses.
            if 0 <= index < len(lines) and re.fullmatch(
                r'--\s+(?:13|14|16|17)\.0\.\d+\.\d+\s+(?:CTP|RC)\s*[\d.]+\s+[\d/-]+\s*',
                lines[index],
            ):
                continue
        return ['review receipt contains a non-exemptible finding']
    if sorted(problems) != sorted(expected):
        return ['review receipt no longer matches static findings', *problems]
    return []


def validate_collector_sql(path: str, text: str, linter: Linter | None = None) -> list[str]:
    review = REVIEWED_COLLECTORS.get(path)
    if not review or hashlib.sha256(text.encode()).hexdigest() != review['sha256']:
        return ['collector has no matching reviewed checksum']
    findings = validate_sql(text, linter)
    if set(findings) != review['expected_findings']:
        return ['collector findings differ from its reviewed operations', *findings]
    return []


def main() -> int:
    errors: list[str] = []
    paths = []
    for path in sorted(ROOT.rglob('*')):
        relative = path.relative_to(ROOT)
        if set(relative.parts) & IGNORED_PARTS:
            continue
        if path.is_symlink():
            errors.append(f'{relative}: symlinks are not allowed')
            continue
        if not path.is_file():
            continue
        paths.append(path)
        if path.suffix not in ALLOWED_EXTENSIONS and path.name not in ALLOWED_NAMES:
            errors.append(f'{relative}: file type not allowed')
        try:
            content = path.read_text(encoding='utf-8')
            if '\x00' in content or content.startswith('\ufeff'):
                errors.append(f'{relative}: use UTF-8 text without BOM or NUL')
        except UnicodeDecodeError:
            errors.append(f'{relative}: not UTF-8 text')
    catalog = json.loads((ROOT / 'catalog.json').read_text(encoding='utf-8'))
    reviews = json.loads((ROOT / 'tools/glenn_berry_review.json').read_text(encoding='utf-8'))
    imported = {row['path']: row for row in catalog if row.get('author') == 'Glenn Berry'}
    if not set(reviews) <= set(imported):
        errors.append('upstream review receipts reference missing catalog entries')
    for row in catalog:
        if ('glenn-berry' in Path(row['path']).parts) != (row['path'] in imported):
            errors.append(f"{row['path']}: imported provenance does not match its location")
    entries = [row['path'] for row in catalog]
    sql_paths = {str(p.relative_to(ROOT)) for p in paths if p.suffix == '.sql'}
    if len(entries) != len(set(entries)) or set(entries) != sql_paths:
        errors.append('catalog must list every SQL file exactly once')
    if not set(REVIEWED_COLLECTORS) <= sql_paths:
        errors.append('reviewed collector is missing from the catalog or working tree')
    linter = Linter(dialect='tsql')
    for path in sorted(sql_paths):
        content = (ROOT / path).read_text(encoding='utf-8')
        for field in ['Context:', 'Target platform:', 'Mode:', 'Permissions:', 'Notes:', 'Reference:', 'Validation:']:
            if field not in content:
                errors.append(f'{path}: missing metadata {field}')
        if path in REVIEWED_COLLECTORS:
            problems = validate_collector_sql(path, content, linter)
        elif path in imported:
            problems = validate_imported_sql(content, imported[path], reviews, linter)
        else:
            problems = validate_sql(content, linter)
        errors.extend(f'{path}: {e}' for e in problems)
    for error in errors:
        print(error)
    print(f'{len(sql_paths)} SQL files checked; {len(errors)} problem(s).')
    return int(bool(errors))


if __name__ == '__main__':
    sys.exit(main())
