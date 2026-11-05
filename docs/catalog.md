# Curated script catalog

For the 951 imported diagnostic queries, use the [Glenn Berry purpose index](glenn-berry/by-purpose.md) or [platform guide](glenn-berry/README.md). [catalog.json](../catalog.json) covers all 985 SQL files.

34 read-only scripts and synthetic examples. Target platform: SQL Server 2016+. Execution compatibility still requires validation.

Select the indicated database before running a script. Each file documents its permissions and limitations. Microsoft links in the headers describe the queried objects.

| Script | Purpose | Context |
|---|---|---|
| [instance-info](../scripts/diagnostics/instance-info.sql) | Instance information | any database |
| [database-inventory](../scripts/diagnostics/database-inventory.sql) | Database inventory | any database |
| [database-files](../scripts/diagnostics/database-files.sql) | Database files and growth settings | any database |
| [service-status](../scripts/diagnostics/service-status.sql) | Service status | any database |
| [blocked-sessions](../scripts/diagnostics/blocked-sessions.sql) | Blocked sessions and their blockers | any database |
| [active-requests](../scripts/diagnostics/active-requests.sql) | Active requests | any database |
| [session-resources](../scripts/diagnostics/session-resources.sql) | Resources by session | any database |
| [session-locks](../scripts/diagnostics/session-locks.sql) | Locks in the selected database | database to inspect |
| [suspect-pages](../scripts/diagnostics/suspect-pages.sql) | Recorded suspect pages | any database |
| [tempdb-space](../scripts/diagnostics/tempdb-space.sql) | tempdb data file usage | tempdb |
| [file-io](../scripts/performance/file-io.sql) | Cumulative file I/O | any database |
| [scheduler-pressure](../scripts/performance/scheduler-pressure.sql) | Scheduler queues | any database |
| [procedure-statistics](../scripts/performance/procedure-statistics.sql) | Cached procedure statistics | database to inspect |
| [trigger-statistics](../scripts/performance/trigger-statistics.sql) | Cached trigger statistics | database to inspect |
| [top-query-cpu](../scripts/performance/top-query-cpu.sql) | Cached queries by CPU usage | any database |
| [top-query-logical-reads](../scripts/performance/top-query-logical-reads.sql) | Cached queries by logical reads | any database |
| [memory-configuration](../scripts/performance/memory-configuration.sql) | Memory configuration and status | any database |
| [wait-statistics](../scripts/performance/wait-statistics.sql) | Cumulative instance wait statistics | any database |
| [table-space](../scripts/indexes-and-statistics/table-space.sql) | Disk-based table space | database to inspect |
| [index-inventory](../scripts/indexes-and-statistics/index-inventory.sql) | Index and data space inventory | database to inspect |
| [index-usage](../scripts/indexes-and-statistics/index-usage.sql) | Index usage counters | database to inspect |
| [missing-index-estimates](../scripts/indexes-and-statistics/missing-index-estimates.sql) | Missing index estimates | database to inspect |
| [statistics-properties](../scripts/indexes-and-statistics/statistics-properties.sql) | Statistics properties | database to inspect |
| [latest-backups](../scripts/backup-and-restore/latest-backups.sql) | Latest backups by type | any database |
| [replica-status](../scripts/high-availability/replica-status.sql) | Database replica status | instance with Always On enabled |
| [sysadmin-members](../scripts/security/sysadmin-members.sql) | Direct sysadmin members | any database |
| [database-permissions](../scripts/security/database-permissions.sql) | Explicit database permissions | database to inspect |
| [orphan-sql-users](../scripts/security/orphan-sql-users.sql) | Potential orphaned SQL users | user database |
| [encryption-status](../scripts/security/encryption-status.sql) | Database encryption status | any database |
| [job-status](../scripts/sql-agent/job-status.sql) | Job status and latest completion | instance with SQL Server Agent |
| [job-history](../scripts/sql-agent/job-history.sql) | Job completion history | instance with SQL Server Agent |
| [pagination](../examples/pagination.sql) | Pagination with deterministic ordering | any database |
| [distribution-functions](../examples/distribution-functions.sql) | Distribution and percentile ranking | any database |
| [null-predicates](../examples/null-predicates.sql) | NULL predicates | any database |

## Review status

All files have received static review and passed the SQLFluff T-SQL parser. None is marked as execution-tested in SQL Server. `catalog.json` provides the same inventory in a structured format.

DMV queries show a snapshot or cumulative counters, with visibility depending on permissions. An empty result does not prove health, absence of access or lack of usage.
