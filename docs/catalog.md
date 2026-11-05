# Curated script catalog

For the 951 imported diagnostic queries, use the [Glenn Berry purpose index](glenn-berry/by-purpose.md) or [platform guide](glenn-berry/README.md). [catalog.json](../catalog.json) covers all 1,001 SQL files.

50 curated scripts, command generators and synthetic examples. Most target SQL Server 2016+; WSFC command generators require SQL Server 2017+. Read each header. Runtime coverage is limited to [16 administration workflows on one SQL Server 2022 lab](runtime-validation.md); other versions and scripts remain untested.

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

All files have received static review and passed the SQLFluff T-SQL parser. The [runtime report](runtime-validation.md) distinguishes positive synthetic coverage from empty-state checks for the 16 administration workflows; other scripts remain static-only. `catalog.json` provides the same inventory in a structured format.

DMV queries show a snapshot or cumulative counters, with visibility depending on permissions. An empty result does not prove health, absence of access or lack of usage.

## Administration workflows and command generators

These scripts use generic, unset parameters and contain no captured query results or environment-specific incident data. Most inspect metadata. The five command generators return T-SQL text only; executing their output is a separate administrative action.

| Script | Purpose | Context |
|---|---|---|
| [clr-assembly-inventory](../scripts/security/clr-assembly-inventory.sql) | CLR assemblies and bound modules | database to inspect |
| [module-review-candidates](../scripts/security/module-review-candidates.sql) | Modules matching a review term | database to inspect |
| [audit-and-event-sources](../scripts/security/audit-and-event-sources.sql) | Existing audit, trace and Extended Events sources | master |
| [login-password-change-status](../scripts/security/login-password-change-status.sql) | Current SQL login password-change metadata | master |
| [default-trace-object-events](../scripts/security/default-trace-object-events.sql) | Object events in existing default trace files | master |
| [current-connection-authentication](../scripts/security/current-connection-authentication.sql) | Authentication of the current connection | any database |
| [job-step-inventory](../scripts/sql-agent/job-step-inventory.sql) | SQL Agent job and step metadata | msdb |
| [automatic-seeding-status](../scripts/high-availability/automatic-seeding-status.sql) | Automatic seeding attempts and transfer progress | master on each replica |
| [failover-readiness](../scripts/high-availability/failover-readiness.sql) | Local replica and database failover indicators | master on the intended WSFC secondary replica |
| [listener-inventory](../scripts/high-availability/listener-inventory.sql) | Availability group listeners and endpoint configuration | master on an Always On instance |
| [agent-job-state-commands](../scripts/script-generation/agent-job-state-commands.sql) | Generate a SQL Agent job state command | msdb on the source instance |
| [trigger-state-commands](../scripts/script-generation/trigger-state-commands.sql) | Generate an enable or disable command for one trigger | database containing the trigger |
| [database-execute-grant](../scripts/script-generation/database-execute-grant.sql) | Generate a scoped EXECUTE grant | database to configure |
| [planned-failover-command](../scripts/script-generation/planned-failover-command.sql) | Generate a planned WSFC availability group failover command | master on the intended secondary replica |
| [automatic-seeding-commands](../scripts/script-generation/automatic-seeding-commands.sql) | Generate automatic seeding commands for an existing replica | master on the current primary replica |
| [programmable-objects-all-databases](../scripts/diagnostics/programmable-objects-all-databases.sql) | Programmable objects across visible databases | master; fresh session with no open transaction |

For all-database trigger discovery, open `programmable-objects-all-databases.sql` and set `@ObjectCategory = N'TRIGGER'`. Leave it NULL to include procedures and functions. The second result set reports databases skipped or queried with errors; metadata visibility can still make a successful query incomplete. Definitions stay hidden by default.

For command generation, provide exact object/group/job names rather than widening the scope. Review destination context, permissions and current state before executing any generated command. See the [workflow guide](getting-started.md#administration-workflows) and [execution boundaries](safety-and-execution.md#command-generators-and-cross-database-collection).
