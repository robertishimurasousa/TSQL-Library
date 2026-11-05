# Glenn Berry diagnostic queries

This collection contains **951 standalone queries**, organized into **15 purposes** across **13 platform suites**. Glenn Berry wrote the diagnostic queries; TSQL Library split and categorized them, added execution metadata and preserved the author's explanatory comments and copyright notice in every file.

Start with [queries by purpose](by-purpose.md), or choose a platform below. The 50 curated library scripts remain available in the [curated catalog](../catalog.md). The machine-readable [catalog](../../catalog.json) covers both collections.

## Choose a platform

| Upstream suite | Queries | Upstream last modified |
|---|---:|---|
| [SQL Server 2005](sql-server-2005.md) | 51 | January 1, 2025 |
| [SQL Server 2008](sql-server-2008.md) | 59 | January 1, 2025 |
| [SQL Server 2008 R2](sql-server-2008r2.md) | 64 | January 1, 2025 |
| [SQL Server 2012](sql-server-2012.md) | 72 | August 4, 2025 |
| [SQL Server 2014](sql-server-2014.md) | 75 | August 4, 2025 |
| [SQL Server 2016](sql-server-2016.md) | 78 | August 4, 2025 |
| [SQL Server 2016 SP2](sql-server-2016sp2.md) | 81 | August 12, 2025 |
| [SQL Server 2017](sql-server-2017.md) | 83 | August 12, 2025 |
| [SQL Server 2019](sql-server-2019.md) | 86 | August 12, 2025 |
| [SQL Server 2022](sql-server-2022.md) | 88 | August 12, 2025 |
| [SQL Server 2025](sql-server-2025.md) | 89 | August 4, 2025 |
| [Azure SQL Database](azure-sql-database.md) | 56 | January 1, 2025 |
| [Azure SQL Managed Instance](azure-sql-managed-instance.md) | 69 | February 13, 2025 |

These are the versions in the requested mirror snapshot, not a claim that they are the latest author releases. SQL Server 2025 comments include prerelease material. An upstream platform label is not proof of compatibility with every build, edition or compatibility level. Do not substitute another platform's query merely because its title matches.

## Organization and use

Files follow `scripts/<category>/glenn-berry/<purpose>/<platform>/<original-number>-<name>.sql`. For example, CPU queries live under `performance/glenn-berry/cpu/`; backup queries live under `backup-and-restore/glenn-berry/backups/`. Repeated topics retain separate implementations for each platform.

1. Find the symptom or task in the purpose index and select the matching platform.
2. Open one file in SSMS or an equivalent client. Read **Context**, **Mode**, **Permissions** and **Notes**, followed by the original comments.
3. Connect to a test instance first. Select the database explicitly in the client. Database-scoped queries do not change the connection database automatically. Azure SQL Database queries follow the source's instruction to connect to a user database.
4. Use a fresh dedicated session for files that create local temporary tables. They can drop a same-named temporary table already present in that session. Clients must understand `GO` where present.
5. Review any source examples and parameters before execution. Run only the chosen file, not the whole directory. Do not uncomment tuning, cache-clearing, configuration or maintenance examples without a separate operational review.
6. Interpret counter windows, cached-plan bias, estimates and workload cost using the comments. Empty output does not prove absence of a problem. Save results outside the repository.

Unlike the original curated scripts, several imported queries return SQL text, object definitions, execution plans, log contents, host names, login names, addresses or paths by default. These may expose customer information or literals embedded in queries. **The imported source is scanned; future query results are not sanitized.**

## Permissions and execution modes

There is no single least-privilege grant for this collection. Metadata visibility and permissions depend on the exact DMV, platform and build. Older server/database DMVs commonly require `VIEW SERVER STATE` or `VIEW DATABASE STATE`; newer performance DMVs can require the corresponding `VIEW ... PERFORMANCE STATE` permissions. Consult the [Microsoft DMV permission reference](https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-objects/system-dynamic-management-objects?view=sql-server-ver17) and the specific objects in the query. Azure service tiers can impose different requirements.

SQL Agent and backup-history queries also access `msdb`. Error-log readers require additional permissions; see [sp_readerrorlog](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-readerrorlog-transact-sql?view=sql-server-ver17). Windows registry readers are platform-specific and may require elevated privileges. Do not grant `sysadmin` just to work around an unexplained permission failure. Minimum grants have not been tested here.

| Mode or construct | What to review |
|---|---|
| Metadata reads | Can consume resources, take locks and expose sensitive result data. Some counters reset after restart or cache eviction. |
| Local temporary tables | Create, populate and drop session-local tables in `tempdb`; no persistent application changes are intended. |
| Diagnostic procedure/DBCC calls | Includes error-log/registry readers and `DBCC TRACESTATUS`; requires more review than a plain SELECT. |
| Legacy VLF queries | Use undocumented `sp_MSforeachdb`, dynamic SQL and `DBCC LOGINFO` across databases. Quoted database names and undocumented behavior can cause failures. |
| Error Log Entries | Enumerates and reads multiple logs using dynamic SQL and temporary tables. Can return extensive operational data. |

The library does not execute any of these queries during generation or CI. No server, credentials or customer results are bundled.

## Provenance and adaptations

- Author: **Glenn Berry**, [official resources](https://glennsqlperformance.com/resources/).
- Requested source: [Ratithoglys/GlennBerry_DMV_Queries](https://github.com/Ratithoglys/GlennBerry_DMV_Queries).
- Pinned commit: [`0e1f8fe7c9664550f74bea7c03a6030cd46afa42`](https://github.com/Ratithoglys/GlennBerry_DMV_Queries/tree/0e1f8fe7c9664550f74bea7c03a6030cd46afa42).
- [Source lock](../../tools/glenn_berry_sources.json): original filenames, encodings, SHA-256 values and upstream dates. The unusual `2022sql` and `2025sql` filenames are retained in source references.
- [Catalog](../../catalog.json): original query number, source line range, source/body/output hashes, purpose, platform, execution mode and adaptations for every query.

The importer retains the query bodies and attached comments, converts their declared source encodings to UTF-8, normalizes trailing whitespace, and adds headers and the original copyright notice. Suite-level introductions and version checks are replaced by per-file metadata; they are **not runtime version guards**. The database-transition separator and its `USE YourDatabaseName` example are removed when splitting so an instance query cannot accidentally switch context. No query block is omitted.

Two small code adaptations are recorded in the catalog: Managed Instance query 64 brackets `m.[definition]` for SQLFluff parser compatibility, with no intended change to the projection; SQL Server 2025 CPU Vectorization Level changes the copied major-version guard from 16 to 17, so the query does not silently skip SQL Server 2025. The latter remains Windows-specific and execution-unverified.

SQL Server 2017 upstream numbering skips 82 and ends at 84; all 83 available blocks are included. Older suites contain a Memory Snapshot comment naming SQL Server 2025; the header flags this upstream inconsistency without claiming runtime incompatibility. Historical build tables, links and tuning advice remain author commentary, not current recommendations from this library.

## Validation and updates

All 951 imported queries pass SQLFluff 4.5.0 T-SQL parsing. Their file hashes must match the catalog. The original strict validator still governs the curated collection. For imported files, [106 individual review receipts](../../tools/glenn_berry_review.json) bind expected findings to exact SHA-256 values: diagnostic calls, local temporary tables, local control flow, or 22 version-number matches in four comment-only release tables. A folder name alone never disables validation. Credentials and parser errors cannot be exempted by a receipt.

Checks cover syntax, extraction integrity, catalog coverage, encoding and secret patterns. They do **not** validate DMV columns against a server, minimum permissions, performance impact, semantic accuracy, result completeness or version compatibility. SQL Server and Azure execution tests remain pending.

To reproduce without accessing a database, clone the source outside this repository and check out the pinned commit, then run:

```sh
python tools/import_glenn_berry.py --source-dir /path/to/upstream --check
python tools/validate.py
python -m unittest discover -s tests -v
```

Omit `--check` to regenerate the files and navigation. The importer verifies all original file hashes before accepting their contents. It never downloads code or runs SQL. Do not commit the upstream clone or its history. For a new upstream version, review the source diff, permissions, license, boundaries and operational effects before updating the lock, generated files and individual review receipts. Run the full validation and secret/history scans afterwards.

## License

These files retain Glenn Berry's original terms, including the **non-commercial** alteration condition, republication with the copyright notice and credit, and the warranty disclaimer. They are **not MIT-licensed**. See [third-party notices](../../THIRD_PARTY_NOTICES.md) and the notice in every imported SQL file. TSQL Library's own tooling and curated scripts retain the root MIT license.
