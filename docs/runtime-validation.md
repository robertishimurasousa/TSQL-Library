# Synthetic SQL Server runtime validation

Review date: November 5, 2026. Scope: the 16 scripts in the `administration-workflows` collection. These results do not apply to the other curated scripts or the Glenn Berry import.

## Environment and limits

- SQL Server 2022 Developer, build `16.0.4305.5`, Linux x64.
- Official image `mcr.microsoft.com/mssql/server`, pinned to digest `sha256:cf8f0ab2ebe61feec2eed2629061a07d247f791c2a8ddda74a4ac9f06a291718`.
- Docker Desktop on Apple Silicon, using amd64 emulation. Microsoft supports SQL Server containers on Linux x86-64 hosts; [emulation is not a supported configuration](https://learn.microsoft.com/en-us/sql/linux/install-upgrade/quickstart-install-docker?view=sql-server-linux-ver16).
- One isolated instance, two CPUs, a 4 GiB container limit and a 2 GiB SQL Server memory limit. Internal Docker network, no published ports, dedicated volume, no production connections.
- Synthetic data only. Random credentials stayed outside the repository. No database files, DLLs, raw query results or container credentials are published here.
- Most scenarios ran as the disposable instance administrator. The collector also ran under a restricted synthetic login. This is not a least-privilege certification for every script.

All 16 scripts executed with default parameters. The complete local suite passed **36 scenarios** after the collector fixes below. Eleven scripts have positive synthetic behavior coverage; five availability-group scripts have only empty-state and, where applicable, missing-target coverage. Runtime scenarios are a local lab suite, not part of the repository's static CI workflow.

## Coverage

| Script | Observed behavior | Remaining limits |
|---|---|---|
| `programmable-objects-all-databases.sql` | Inventoried procedures, functions and object/database/server triggers; handled different database collations, an offline database, restricted visibility and quoted database names; category filters and definition opt-in passed; rejected wrong context, open transactions, invalid categories and temporary-table collisions; did not execute discovered objects | Other versions and concurrent database removal were not tested |
| `clr-assembly-inventory.sql` | Returned an inert SAFE assembly, bound scalar function and database DDL trigger; file hash hidden by default and correct when enabled | CLR code was not executed; no user-defined CLR type fixture |
| `module-review-candidates.sql` | Found an exact synthetic review marker; hid definition text by default; returned text on opt-in; encrypted module stayed unavailable | Does not classify code as malicious |
| `audit-and-event-sources.sql` | Returned synthetic server audit/specification and Extended Events configuration; paths hidden by default and visible on opt-in | Audit payloads and historical collection were not tested |
| `login-password-change-status.sql` | Returned current metadata for an explicitly selected synthetic SQL login; NULL target returned no login | No historical attribution or minimum-permission coverage |
| `default-trace-object-events.sql` | Read retained synthetic object events and a retention window; identity fields hidden by default and returned on opt-in; SQL text not selected | Missing/expired files and rollover edge cases remain untested |
| `current-connection-authentication.sql` | Returned the current SQL-authenticated connection | Kerberos, SPNs and other connections were not tested |
| `job-step-inventory.sql` | Returned an unscheduled synthetic job/step; command text and output path hidden by default and visible on opt-in | No job execution or service-availability certification |
| `agent-job-state-commands.sql` | NULL target returned no command; generated enable/disable commands for a name containing an apostrophe and closing bracket; separately executed commands changed only the synthetic job's enabled flag | Job remained unscheduled; schedules and replica ownership were not tested |
| `trigger-state-commands.sql` | Generated and separately executed ENABLE/DISABLE commands for object and database DDL triggers with quoted identifiers; rejected unsupported action and NULL target | Server trigger state changes are outside this generator's scope |
| `database-execute-grant.sql` | Generated and separately executed OBJECT, SCHEMA and DATABASE EXECUTE grants for a synthetic role; permission class verified; NULL and built-in principal targets returned no commands | Effective execution by every principal type was not tested |
| `automatic-seeding-status.sql` | Earlier projection executed successfully without an availability group | No actual seeding attempt or transfer; the expanded physical transfer projection added November 9, 2026 has static validation only |
| `failover-readiness.sql` | Executed successfully without an availability group | No real primary/secondary state, quorum or readiness transition |
| `listener-inventory.sql` | Executed successfully without a listener or mirroring endpoint | No configured listener, DNS, endpoint connectivity or authentication |
| `planned-failover-command.sql` | NULL and nonexistent group targets returned no command | No WSFC topology, generated positive command or failover execution |
| `automatic-seeding-commands.sql` | NULL and nonexistent group/replica targets returned no command | No WSFC topology, generated positive command or seeding execution |

## Defects found and corrected

The first 34-scenario run passed 30 scenarios. Four failures traced to two collector defects:

1. Category comparisons inside dynamic SQL could raise error 468 when a database's collation differed from `master`. The parameter comparisons now use `COLLATE DATABASE_DEFAULT` in the target database.
2. A pre-existing same-named temporary table with a different schema could cause error 213 during compilation, before the intended collision guard ran. Constant temporary-table statements now bind through `sp_executesql` after the guard. The corrected collector returns error 50003 and preserves the existing table.

No general EXEC or DDL allowance was added to the curated validator. The collector remains bound to one reviewed checksum. Regression tests parse its four actual dynamic SQL bodies, in addition to verifying exception isolation. Temporary writes and cleanup remain limited to the two session-local collector tables.

## Completing topology validation

Use a disposable Windows x86-64 WSFC lab with two SQL Server replicas and synthetic databases. Verify a synchronized synchronous-commit secondary, then separately exercise the planned-failover generator and its output. Test missing/unjoined/suspended databases and asynchronous/disconnected replicas as negative cases. Run seeding diagnostics and generated setup commands against an existing target replica, then inspect actual transfer success and failure states. Add a listener and mirroring endpoint to cover configured metadata.

These topology cases are **pending**. Empty result sets on a standalone instance do not establish that an Always On operation works. Other SQL Server versions, native x86-64 execution and broader permission coverage also remain pending.
