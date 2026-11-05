# Glenn Berry queries: SQL Server 2008

[Collection guide](README.md) · [Browse by purpose](by-purpose.md)

Source: [`2008.sql`](https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008.sql). Last modified upstream: January 1, 2025.

Choose a query and read its context, permissions, mode and notes before running it. Version labels identify the upstream suite, not tested compatibility.

| Original query | Purpose | Query | Context | Execution mode |
|---|---|---|---|---|
| 1 | diagnostics / instance | [Version Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008/001-version-info.sql) | master on the target instance | metadata reads |
| 2 | diagnostics / instance | [SQL Server Install Date](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008/002-sql-server-install-date.sql) | master on the target instance | metadata reads |
| 3 | diagnostics / instance | [Server Properties](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008/003-server-properties.sql) | master on the target instance | metadata reads |
| 4 | sql-agent / jobs-and-alerts | [SQL Server Agent Jobs](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2008/004-sql-server-agent-jobs.sql) | master on the target instance | metadata reads |
| 5 | sql-agent / jobs-and-alerts | [SQL Server Agent Alerts](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2008/005-sql-server-agent-alerts.sql) | master on the target instance | metadata reads |
| 6 | diagnostics / instance | [Global Trace Flags](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008/006-global-trace-flags.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 7 | performance / cpu | [SQL Server NUMA Info](../../scripts/performance/glenn-berry/cpu/sql-server-2008/007-sql-server-numa-info.sql) | master on the target instance | metadata reads |
| 8 | diagnostics / instance | [Hardware Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008/008-hardware-info.sql) | master on the target instance | metadata reads |
| 9 | diagnostics / instance | [System Manufacturer](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008/009-system-manufacturer.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 10 | diagnostics / instance | [Processor Description](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008/010-processor-description.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 11 | high-availability / replication-and-clustering | [Cluster Node Properties](../../scripts/high-availability/glenn-berry/replication-and-clustering/sql-server-2008/011-cluster-node-properties.sql) | master on the target instance | metadata reads |
| 12 | diagnostics / instance | [Configuration Values](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008/012-configuration-values.sql) | master on the target instance | metadata reads |
| 13 | diagnostics / databases | [Database Filenames and Paths](../../scripts/diagnostics/glenn-berry/databases/sql-server-2008/013-database-filenames-and-paths.sql) | master on the target instance | metadata reads |
| 14 | performance / io | [IO Warnings](../../scripts/performance/glenn-berry/io/sql-server-2008/014-io-warnings.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 15 | performance / io | [Drive Level Latency](../../scripts/performance/glenn-berry/io/sql-server-2008/015-drive-level-latency.sql) | master on the target instance | metadata reads |
| 16 | performance / io | [IO Stalls by File](../../scripts/performance/glenn-berry/io/sql-server-2008/016-io-stalls-by-file.sql) | master on the target instance | metadata reads |
| 17 | diagnostics / databases | [Database Properties](../../scripts/diagnostics/glenn-berry/databases/sql-server-2008/017-database-properties.sql) | master on the target instance | metadata reads |
| 18 | indexes-and-statistics / indexes | [Missing Indexes All Databases](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/018-missing-indexes-all-databases.sql) | master on the target instance | metadata reads |
| 19 | diagnostics / databases | [VLF Counts](../../scripts/diagnostics/glenn-berry/databases/sql-server-2008/019-vlf-counts.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 20 | performance / cpu | [CPU Usage by Database](../../scripts/performance/glenn-berry/cpu/sql-server-2008/020-cpu-usage-by-database.sql) | master on the target instance | metadata reads |
| 21 | performance / io | [IO Usage By Database](../../scripts/performance/glenn-berry/io/sql-server-2008/021-io-usage-by-database.sql) | master on the target instance | metadata reads |
| 22 | performance / memory | [Total Buffer Usage by Database](../../scripts/performance/glenn-berry/memory/sql-server-2008/022-total-buffer-usage-by-database.sql) | master on the target instance | metadata reads |
| 23 | performance / waits | [Top Waits](../../scripts/performance/glenn-berry/waits/sql-server-2008/023-top-waits.sql) | master on the target instance | metadata reads |
| 24 | performance / waits | [Signal Waits](../../scripts/performance/glenn-berry/waits/sql-server-2008/024-signal-waits.sql) | master on the target instance | metadata reads |
| 25 | diagnostics / sessions-and-blocking | [Connection Counts](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2008/025-connection-counts.sql) | master on the target instance | metadata reads |
| 26 | diagnostics / sessions-and-blocking | [Connection Counts by IP Address](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2008/026-connection-counts-by-ip-address.sql) | master on the target instance | metadata reads |
| 27 | performance / cpu | [Avg Task Counts](../../scripts/performance/glenn-berry/cpu/sql-server-2008/027-avg-task-counts.sql) | master on the target instance | metadata reads |
| 28 | performance / cpu | [CPU Utilization History](../../scripts/performance/glenn-berry/cpu/sql-server-2008/028-cpu-utilization-history.sql) | master on the target instance | metadata reads |
| 29 | performance / query-statistics | [Top Worker Time Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/029-top-worker-time-queries.sql) | master on the target instance | metadata reads |
| 30 | performance / memory | [System Memory](../../scripts/performance/glenn-berry/memory/sql-server-2008/030-system-memory.sql) | master on the target instance | metadata reads |
| 31 | performance / memory | [Process Memory](../../scripts/performance/glenn-berry/memory/sql-server-2008/031-process-memory.sql) | master on the target instance | metadata reads |
| 32 | performance / memory | [PLE by NUMA Node](../../scripts/performance/glenn-berry/memory/sql-server-2008/032-ple-by-numa-node.sql) | master on the target instance | metadata reads |
| 33 | performance / memory | [Memory Grants Pending](../../scripts/performance/glenn-berry/memory/sql-server-2008/033-memory-grants-pending.sql) | master on the target instance | metadata reads |
| 34 | performance / memory | [Memory Clerk Usage](../../scripts/performance/glenn-berry/memory/sql-server-2008/034-memory-clerk-usage.sql) | master on the target instance | metadata reads |
| 35 | performance / query-statistics | [Ad hoc Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/035-ad-hoc-queries.sql) | master on the target instance | metadata reads |
| 36 | diagnostics / databases | [File Sizes and Space](../../scripts/diagnostics/glenn-berry/databases/sql-server-2008/036-file-sizes-and-space.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 37 | performance / io | [IO Stats By File](../../scripts/performance/glenn-berry/io/sql-server-2008/037-io-stats-by-file.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 38 | performance / query-statistics | [Query Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/038-query-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 39 | performance / query-statistics | [SP Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/039-sp-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 40 | performance / query-statistics | [SP Avg Elapsed Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/040-sp-avg-elapsed-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 41 | performance / query-statistics | [SP Avg Elapsed Variable Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/041-sp-avg-elapsed-variable-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 42 | performance / query-statistics | [SP Worker Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/042-sp-worker-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 43 | performance / query-statistics | [SP Logical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/043-sp-logical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 44 | performance / query-statistics | [SP Physical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/044-sp-physical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 45 | performance / query-statistics | [SP Logical Writes](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/045-sp-logical-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 46 | performance / query-statistics | [Top IO Statements](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008/046-top-io-statements.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 47 | indexes-and-statistics / indexes | [Bad NC Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/047-bad-nc-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 48 | indexes-and-statistics / indexes | [Missing Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/048-missing-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 49 | indexes-and-statistics / indexes | [Missing Index Warnings](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/049-missing-index-warnings.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 50 | performance / memory | [Buffer Usage](../../scripts/performance/glenn-berry/memory/sql-server-2008/050-buffer-usage.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 51 | indexes-and-statistics / indexes | [Table Sizes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/051-table-sizes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 52 | indexes-and-statistics / indexes | [Table Properties](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/052-table-properties.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 53 | diagnostics / sessions-and-blocking | [Detect Blocking](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2008/053-detect-blocking.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 54 | indexes-and-statistics / indexes | [Statistics Update](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/054-statistics-update.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 55 | indexes-and-statistics / indexes | [Index Fragmentation](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/055-index-fragmentation.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 56 | indexes-and-statistics / indexes | [Overall Index Usage - Reads](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/056-overall-index-usage-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 57 | indexes-and-statistics / indexes | [Overall Index Usage - Writes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008/057-overall-index-usage-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 58 | performance / waits | [Lock Waits](../../scripts/performance/glenn-berry/waits/sql-server-2008/058-lock-waits.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 59 | backup-and-restore / backups | [Recent Full Backups](../../scripts/backup-and-restore/glenn-berry/backups/sql-server-2008/059-recent-full-backups.sql) | user database to inspect; select it in the client before execution | metadata reads |
