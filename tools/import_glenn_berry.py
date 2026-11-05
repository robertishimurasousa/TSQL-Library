"""Split a checksum-pinned local upstream checkout. Never downloads or executes SQL."""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
LOCK = ROOT / 'tools/glenn_berry_sources.json'
MARKER = re.compile(r'^--.*?\(Query\s+(\d+)\)\s*\(([^\n]+)\)', re.M)
TRANSITION = re.compile(r'^-- Database specific queries[^\n]*', re.M)
GROUPS = {
    'diagnostics/instance': 'Version Info|Server Properties|Configuration Values|Global Trace Flags|SQL Server Services Info|Host Info|Hardware Info|System Manufacturer|BIOS Date|Processor Description|Windows Info|SQL Server Install Date|IFI Status|Accelerator Status',
    'diagnostics/databases': 'Database Properties|Database-scoped Configurations|Database Filenames and Paths|File Sizes and Space|Log Space Usage|Last VLF Status|VLF Counts|Azure SQL DB Properties|Azure SQL DB Size',
    'diagnostics/integrity-and-logs': 'Suspect Pages|Error Log Entries|Memory Dump Info',
    'diagnostics/sessions-and-blocking': 'Connection Counts|Connection Counts by IP Address|Detect Blocking|Input Buffer|Page Contention|Optimized Locking',
    'diagnostics/tempdb': 'TempDB Data Files|Tempdb Data Files|Tempdb Data File Sizes|Version Store Space Usage',
    'performance/cpu': 'Core Counts|SQL Server NUMA Info|CPU Vectorization Level|CPU Usage by Database|CPU Utilization History|Avg Task Counts',
    'performance/memory': 'Process Memory|System Memory|Memory Snapshot|Total Buffer Usage by Database|PLE by NUMA Node|Memory Grants Pending|Memory Clerk Usage|Buffer Usage|Long Buffer Pool Scans',
    'performance/io': 'Fixed Drives|Volume Info|Drive Level Latency|IO Latency by File|IO Stalls by File|IO Stats By File|IO Usage By Database|IO Warnings',
    'performance/waits': 'Top Waits|Top DB Waits|Signal Waits|Lock Waits',
    'performance/query-statistics': 'Ad hoc Queries|Top Worker Time Queries|Top Logical Reads Queries|Top Avg Elapsed Time Queries|UDF Stats by DB|Query Execution Counts|SP Execution Counts|SP Avg Elapsed Time|SP Avg Elapsed Variable Time|SP Worker Time|SP Logical Reads|SP Physical Reads|SP Logical Writes|Top IO Statements|UDF Statistics|Inlineable UDFs|Query Store Options|QueryStore Options|Automatic Tuning Options|High Aggregate Duration Queries',
    'performance/resource-governance': 'RG Resource Pools|Avg-Max Resource Usage|Recent Resource Usage|Server Resource Stats',
    'indexes-and-statistics/indexes': 'Missing Indexes All Databases|SP Missing Index|Bad NC Indexes|Missing Indexes|Missing Index Warnings|Table Sizes|Table Properties|Statistics Update|Volatile Indexes|Index Fragmentation|Overall Index Usage - Reads|Overall Index Usage - Writes|Columnstore Index Physical Stat|Resumable Index Rebuild',
    'backup-and-restore/backups': 'Last Backup By Database|Recent Full Backups',
    'high-availability/replication-and-clustering': 'AlwaysOn AG Cluster|AG Status|Cluster Node Properties|Geo-Replication Link Status',
    'sql-agent/jobs-and-alerts': 'SQL Server Agent Jobs|SQL Server Agent Alerts',
}
TOPICS = {title: group for group, titles in GROUPS.items() for title in titles.split('|')}


def digest(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def split_queries(text: str) -> list[dict]:
    """Retain source numbers (including gaps), comments and complete query batches."""
    matches = list(MARKER.finditer(text))
    if not matches:
        raise ValueError('No query markers found')
    numbers = [int(m[1]) for m in matches]
    if len(numbers) != len(set(numbers)):
        raise ValueError('Duplicate upstream query number')
    transition = TRANSITION.search(text)
    result = []
    for index, match in enumerate(matches):
        end = matches[index + 1].start() if index + 1 < len(matches) else len(text)
        # The suite's context switch belongs to neither standalone query.
        if transition and match.start() < transition.start() < end:
            end = transition.start()
        body = text[match.start():end].rstrip() + '\n'
        result.append({
            'number': int(match[1]), 'title': match[2].strip(), 'body': body,
            'line_start': text.count('\n', 0, match.start()) + 1,
            'line_end': text.count('\n', 0, end - 1) + 1,
            'scope': 'database' if transition and match.start() > transition.start() else 'instance',
        })
    return result


def license_notice(text: str) -> str:
    start = text.index('--*   Copyright')
    end = text.index('--******************************************************************************', start)
    return '\n'.join(line.rstrip() for line in text[start:end].rstrip().splitlines()) + '\n'


def describe(query: dict, source: dict) -> dict:
    body, title = query['body'], query['title']
    category, topic = TOPICS[title].split('/')  # Unknown topics fail closed.
    platform = source['platform']
    target = platform.replace('sql-server-', 'SQL Server ').replace('azure-sql-', 'Azure SQL ').replace('-', ' ')
    target = target.replace('2008r2', '2008 R2').replace('2016sp2', '2016 SP2').replace('managed instance', 'Managed Instance').replace('database', 'Database')
    mode = 'metadata reads'
    notes = ['Original explanatory comments are retained; dated recommendations are historical.',
             'Results may disclose environment details, SQL text, plans or log contents; review before sharing.']
    if re.search(r'^\s*(?:CREATE TABLE|DROP TABLE|INSERT INTO)\s+#', body, re.M | re.I):
        mode = 'metadata reads with local temporary tables'
        notes.append('Uses and drops named local temporary tables; run in a fresh dedicated session.')
    if re.search(r'^\s*(?:EXEC|DBCC)\b', body, re.M | re.I):
        mode += '; diagnostic procedure/DBCC calls'
        notes.append('Review diagnostic calls and their additional permissions before execution.')
    if 'sp_MSforeachdb' in body:
        notes.append('Uses undocumented sp_MSforeachdb and dynamic SQL across databases; names containing quotes can fail. Prefer a newer version-specific VLF query where supported.')
    if title == 'Memory Snapshot' and '2025' not in platform:
        notes.append('Upstream description says SQL Server 2025 even in this older suite; compatibility remains unverified.')
    if title in {'Index Fragmentation', 'Total Buffer Usage by Database', 'Buffer Usage', 'Error Log Entries'}:
        notes.append('May scan large metadata/cache/log sets; evaluate resource cost on a test instance first.')
    if platform == 'azure-sql-database':
        context = 'target Azure SQL user database'
    elif query['scope'] == 'database':
        context = 'user database to inspect; select it in the client before execution'
    else:
        context = 'master on the target instance'
    permissions = ('Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. '
                   'Minimum grants have not been execution-tested.')
    return dict(category=category, topic=topic, target=target, context=context,
                permissions=permissions, mode=mode, notes=' '.join(notes))


def render(source_dir: Path) -> tuple[dict[str, str], list[dict]]:
    lock = json.loads(LOCK.read_text())
    files: dict[str, str] = {}
    entries = []
    for source in lock['sources']:
        raw = (source_dir / source['file']).read_bytes()
        if digest(raw) != source['sha256']:
            raise ValueError(f"Source checksum mismatch: {source['file']}")
        text = raw.decode(source['encoding']).replace('\r\n', '\n')
        notice = license_notice(text)
        for query in split_queries(text):
            original_body_hash = digest(query['body'].encode())
            query['body'] = '\n'.join(line.rstrip() for line in query['body'].splitlines()) + '\n'
            adaptations = ['Split the suite into standalone queries; remove the suite context-switch separator; normalize encoding and trailing whitespace; add metadata and attribution.']
            if source['file'] == 'managed.sql' and query['number'] == 64:
                # SQLFluff treats the unquoted definition identifier as a keyword.
                assert query['body'].count('m.definition') == 1
                query['body'] = query['body'].replace('m.definition', 'm.[definition]')
                adaptations.append('Bracket m.[definition] for parser compatibility; projection is unchanged.')
            if source['file'] == '2025sql' and query['title'] == 'CPU Vectorization Level':
                old_guard = "SERVERPROPERTY('ProductMajorVersion')) = '16'"
                assert query['body'].count(old_guard) == 1
                query['body'] = query['body'].replace(old_guard, old_guard.replace("'16'", "'17'"))
                adaptations.append('Correct the copied SQL Server 2022 major-version guard from 16 to 17 for the SQL Server 2025 suite; runtime remains unverified.')
            meta = describe(query, source)
            slug = re.sub(r'[^a-z0-9]+', '-', query['title'].lower()).strip('-')
            path = f"scripts/{meta['category']}/glenn-berry/{meta['topic']}/{source['platform']}/{query['number']:03d}-{slug}.sql"
            reference = f"{lock['repository']}/blob/{lock['commit']}/{source['file']}#L{query['line_start']}-L{query['line_end']}"
            header = (
                f"-- TSQL Library: {query['title']}\n"
                f"-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.\n"
                f"-- Context: {meta['context']}\n"
                f"-- Target platform: {meta['target']} (upstream suite; not execution-tested).\n"
                f"-- Mode: {meta['mode']}\n"
                f"-- Permissions: {meta['permissions']}\n"
                f"-- Notes: {meta['notes']}\n"
                f"-- Reference: {reference}\n"
                f"-- Upstream last modified: {source['last_modified']}; original query {query['number']}.\n"
                f"-- Validation: source integrity and static checks only; see docs/glenn-berry/README.md.\n"
                f"-- License: Glenn Berry terms below; this file is NOT covered by the root MIT license.\n\n"
            )
            content = header + notice + '\n' + query['body']
            files[path] = content
            entries.append(dict(path=path, title=query['title'], **meta,
                status='upstream-static-checked; runtime-unverified', reference=reference,
                author='Glenn Berry', license='LicenseRef-Glenn-Berry',
                platform=source['platform'], source_file=source['file'],
                source_query=query['number'], source_lines=[query['line_start'],query['line_end']],
                sha256=digest(content.encode()), body_sha256=digest(query['body'].encode()),
                upstream_body_sha256=original_body_hash, adaptations=adaptations))
    return files, entries


def write_catalogs(files: dict[str, str], entries: list[dict]) -> None:
    catalog_path = ROOT / 'catalog.json'
    existing = json.loads(catalog_path.read_text())
    curated = [e for e in existing if e.get('author') != 'Glenn Berry']
    files['catalog.json'] = json.dumps(curated + entries, indent=2, ensure_ascii=False) + '\n'
    lock = json.loads(LOCK.read_text())
    for source in lock['sources']:
        rows = [e for e in entries if e['platform'] == source['platform']]
        title = rows[0]['target']
        lines = [f'# Glenn Berry queries: {title}', '', '[Collection guide](README.md) · [Browse by purpose](by-purpose.md)', '',
                 f"Source: [`{source['file']}`]({lock['repository']}/blob/{lock['commit']}/{source['file']}). Last modified upstream: {source['last_modified']}.", '',
                 'Choose a query and read its context, permissions, mode and notes before running it. Version labels identify the upstream suite, not tested compatibility.', '',
                 '| Original query | Purpose | Query | Context | Execution mode |', '|---|---|---|---|---|']
        for e in rows:
            lines.append(f"| {e['source_query']} | {e['category']} / {e['topic']} | [{e['title']}](../../{e['path']}) | {e['context']} | {e['mode']} |")
        if source['file'] == '2017.sql':
            lines += ['', 'Upstream numbering skips 82 and ends at 84; all 83 query blocks are included.']
        files[f"docs/glenn-berry/{source['platform']}.md"] = '\n'.join(lines) + '\n'
    lines = ['# Glenn Berry queries by purpose', '', '[Collection guide and platform index](README.md)', '',
             'Each link opens one standalone query for the indicated upstream platform. Read the file header and collection guide before execution.', '']
    for group in GROUPS:
        category, topic = group.split('/')
        rows = [e for e in entries if e['category'] == category and e['topic'] == topic]
        lines += [f'## {category} / {topic}', '', '| Query | Platform variants |', '|---|---|']
        for title in sorted({e['title'] for e in rows}):
            variants = [f"[{e['target']}](../../{e['path']})" for e in rows if e['title'] == title]
            lines.append(f"| {title} | {' · '.join(variants)} |")
        lines.append('')
    files['docs/glenn-berry/by-purpose.md'] = '\n'.join(lines)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source-dir', required=True, type=Path)
    parser.add_argument('--check', action='store_true', help='Compare generated content without writing.')
    args = parser.parse_args()
    files, entries = render(args.source_dir)
    write_catalogs(files, entries)
    mismatches = []
    for name, content in files.items():
        path = ROOT / name
        if args.check:
            if not path.exists() or path.read_bytes() != content.encode():
                mismatches.append(name)
        else:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(content, encoding='utf-8')
    print(f'{len(entries)} queries; {len(set(e["platform"] for e in entries))} platforms; {len(mismatches)} mismatches.')
    for name in mismatches:
        print(name)
    return int(bool(mismatches))


if __name__ == '__main__':
    raise SystemExit(main())
