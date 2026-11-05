# Glenn Berry queries: SQL Server 2005

[Collection guide](README.md) · [Browse by purpose](by-purpose.md)

Source: [`2005.sql`](https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2005.sql). Last modified upstream: January 1, 2025.

Choose a query and read its context, permissions, mode and notes before running it. Version labels identify the upstream suite, not tested compatibility.

| Original query | Purpose | Query | Context | Execution mode |
|---|---|---|---|---|
| 1 | diagnostics / instance | [Version Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2005/001-version-info.sql) | master on the target instance | metadata reads |
| 2 | diagnostics / instance | [SQL Server Install Date](../../scripts/diagnostics/glenn-berry/instance/sql-server-2005/002-sql-server-install-date.sql) | master on the target instance | metadata reads |
| 3 | diagnostics / instance | [Server Properties](../../scripts/diagnostics/glenn-berry/instance/sql-server-2005/003-server-properties.sql) | master on the target instance | metadata reads |
| 4 | sql-agent / jobs-and-alerts | [SQL Server Agent Jobs](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2005/004-sql-server-agent-jobs.sql) | master on the target instance | metadata reads |
| 5 | sql-agent / jobs-and-alerts | [SQL Server Agent Alerts](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2005/005-sql-server-agent-alerts.sql) | master on the target instance | metadata reads |
| 6 | diagnostics / instance | [Global Trace Flags](../../scripts/diagnostics/glenn-berry/instance/sql-server-2005/006-global-trace-flags.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 7 | diagnostics / instance | [Hardware Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2005/007-hardware-info.sql) | master on the target instance | metadata reads |
| 8 | diagnostics / instance | [System Manufacturer](../../scripts/diagnostics/glenn-berry/instance/sql-server-2005/008-system-manufacturer.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 9 | diagnostics / instance | [Processor Description](../../scripts/diagnostics/glenn-berry/instance/sql-server-2005/009-processor-description.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 10 | diagnostics / instance | [Configuration Values](../../scripts/diagnostics/glenn-berry/instance/sql-server-2005/010-configuration-values.sql) | master on the target instance | metadata reads |
| 11 | diagnostics / databases | [Database Filenames and Paths](../../scripts/diagnostics/glenn-berry/databases/sql-server-2005/011-database-filenames-and-paths.sql) | master on the target instance | metadata reads |
| 12 | performance / io | [IO Warnings](../../scripts/performance/glenn-berry/io/sql-server-2005/012-io-warnings.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 13 | performance / io | [Drive Level Latency](../../scripts/performance/glenn-berry/io/sql-server-2005/013-drive-level-latency.sql) | master on the target instance | metadata reads |
| 14 | performance / io | [IO Stalls by File](../../scripts/performance/glenn-berry/io/sql-server-2005/014-io-stalls-by-file.sql) | master on the target instance | metadata reads |
| 15 | diagnostics / databases | [Database Properties](../../scripts/diagnostics/glenn-berry/databases/sql-server-2005/015-database-properties.sql) | master on the target instance | metadata reads |
| 16 | indexes-and-statistics / indexes | [Missing Indexes All Databases](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/016-missing-indexes-all-databases.sql) | master on the target instance | metadata reads |
| 17 | diagnostics / databases | [VLF Counts](../../scripts/diagnostics/glenn-berry/databases/sql-server-2005/017-vlf-counts.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 18 | performance / cpu | [CPU Usage by Database](../../scripts/performance/glenn-berry/cpu/sql-server-2005/018-cpu-usage-by-database.sql) | master on the target instance | metadata reads |
| 19 | performance / io | [IO Usage By Database](../../scripts/performance/glenn-berry/io/sql-server-2005/019-io-usage-by-database.sql) | master on the target instance | metadata reads |
| 20 | performance / memory | [Total Buffer Usage by Database](../../scripts/performance/glenn-berry/memory/sql-server-2005/020-total-buffer-usage-by-database.sql) | master on the target instance | metadata reads |
| 21 | performance / waits | [Top Waits](../../scripts/performance/glenn-berry/waits/sql-server-2005/021-top-waits.sql) | master on the target instance | metadata reads |
| 22 | performance / waits | [Signal Waits](../../scripts/performance/glenn-berry/waits/sql-server-2005/022-signal-waits.sql) | master on the target instance | metadata reads |
| 23 | diagnostics / sessions-and-blocking | [Connection Counts](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2005/023-connection-counts.sql) | master on the target instance | metadata reads |
| 24 | diagnostics / sessions-and-blocking | [Connection Counts by IP Address](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2005/024-connection-counts-by-ip-address.sql) | master on the target instance | metadata reads |
| 25 | performance / cpu | [Avg Task Counts](../../scripts/performance/glenn-berry/cpu/sql-server-2005/025-avg-task-counts.sql) | master on the target instance | metadata reads |
| 26 | performance / cpu | [CPU Utilization History](../../scripts/performance/glenn-berry/cpu/sql-server-2005/026-cpu-utilization-history.sql) | master on the target instance | metadata reads |
| 27 | performance / memory | [PLE by NUMA Node](../../scripts/performance/glenn-berry/memory/sql-server-2005/027-ple-by-numa-node.sql) | master on the target instance | metadata reads |
| 28 | performance / memory | [Memory Grants Pending](../../scripts/performance/glenn-berry/memory/sql-server-2005/028-memory-grants-pending.sql) | master on the target instance | metadata reads |
| 29 | performance / memory | [Memory Clerk Usage](../../scripts/performance/glenn-berry/memory/sql-server-2005/029-memory-clerk-usage.sql) | master on the target instance | metadata reads |
| 30 | performance / query-statistics | [Ad hoc Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2005/030-ad-hoc-queries.sql) | master on the target instance | metadata reads |
| 31 | diagnostics / databases | [File Sizes and Space](../../scripts/diagnostics/glenn-berry/databases/sql-server-2005/031-file-sizes-and-space.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 32 | performance / io | [IO Stats By File](../../scripts/performance/glenn-berry/io/sql-server-2005/032-io-stats-by-file.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 33 | performance / query-statistics | [SP Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2005/033-sp-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 34 | performance / query-statistics | [SP Avg Elapsed Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2005/034-sp-avg-elapsed-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 35 | performance / query-statistics | [SP Worker Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2005/035-sp-worker-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 36 | performance / query-statistics | [SP Logical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2005/036-sp-logical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 37 | performance / query-statistics | [SP Physical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2005/037-sp-physical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 38 | performance / query-statistics | [SP Logical Writes](../../scripts/performance/glenn-berry/query-statistics/sql-server-2005/038-sp-logical-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 39 | performance / query-statistics | [Top IO Statements](../../scripts/performance/glenn-berry/query-statistics/sql-server-2005/039-top-io-statements.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 40 | indexes-and-statistics / indexes | [Bad NC Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/040-bad-nc-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 41 | indexes-and-statistics / indexes | [Missing Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/041-missing-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 42 | indexes-and-statistics / indexes | [Missing Index Warnings](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/042-missing-index-warnings.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 43 | performance / memory | [Buffer Usage](../../scripts/performance/glenn-berry/memory/sql-server-2005/043-buffer-usage.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 44 | indexes-and-statistics / indexes | [Table Sizes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/044-table-sizes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 45 | diagnostics / sessions-and-blocking | [Detect Blocking](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2005/045-detect-blocking.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 46 | indexes-and-statistics / indexes | [Statistics Update](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/046-statistics-update.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 47 | indexes-and-statistics / indexes | [Index Fragmentation](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/047-index-fragmentation.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 48 | indexes-and-statistics / indexes | [Overall Index Usage - Reads](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/048-overall-index-usage-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 49 | indexes-and-statistics / indexes | [Overall Index Usage - Writes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2005/049-overall-index-usage-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 50 | performance / waits | [Lock Waits](../../scripts/performance/glenn-berry/waits/sql-server-2005/050-lock-waits.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 51 | backup-and-restore / backups | [Recent Full Backups](../../scripts/backup-and-restore/glenn-berry/backups/sql-server-2005/051-recent-full-backups.sql) | user database to inspect; select it in the client before execution | metadata reads |
