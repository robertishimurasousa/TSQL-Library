# Glenn Berry queries: SQL Server 2008 R2

[Collection guide](README.md) · [Browse by purpose](by-purpose.md)

Source: [`2008R2.sql`](https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008R2.sql). Last modified upstream: January 1, 2025.

Choose a query and read its context, permissions, mode and notes before running it. Version labels identify the upstream suite, not tested compatibility.

| Original query | Purpose | Query | Context | Execution mode |
|---|---|---|---|---|
| 1 | diagnostics / instance | [Version Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/001-version-info.sql) | master on the target instance | metadata reads |
| 2 | diagnostics / instance | [SQL Server Install Date](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/002-sql-server-install-date.sql) | master on the target instance | metadata reads |
| 3 | diagnostics / instance | [Server Properties](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/003-server-properties.sql) | master on the target instance | metadata reads |
| 4 | sql-agent / jobs-and-alerts | [SQL Server Agent Jobs](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2008r2/004-sql-server-agent-jobs.sql) | master on the target instance | metadata reads |
| 5 | sql-agent / jobs-and-alerts | [SQL Server Agent Alerts](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2008r2/005-sql-server-agent-alerts.sql) | master on the target instance | metadata reads |
| 6 | diagnostics / instance | [Global Trace Flags](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/006-global-trace-flags.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 7 | diagnostics / instance | [Windows Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/007-windows-info.sql) | master on the target instance | metadata reads |
| 8 | diagnostics / instance | [SQL Server Services Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/008-sql-server-services-info.sql) | master on the target instance | metadata reads |
| 9 | performance / cpu | [SQL Server NUMA Info](../../scripts/performance/glenn-berry/cpu/sql-server-2008r2/009-sql-server-numa-info.sql) | master on the target instance | metadata reads |
| 10 | diagnostics / instance | [Hardware Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/010-hardware-info.sql) | master on the target instance | metadata reads |
| 11 | diagnostics / instance | [System Manufacturer](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/011-system-manufacturer.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 12 | diagnostics / instance | [Processor Description](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/012-processor-description.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 13 | high-availability / replication-and-clustering | [Cluster Node Properties](../../scripts/high-availability/glenn-berry/replication-and-clustering/sql-server-2008r2/013-cluster-node-properties.sql) | master on the target instance | metadata reads |
| 14 | diagnostics / instance | [Configuration Values](../../scripts/diagnostics/glenn-berry/instance/sql-server-2008r2/014-configuration-values.sql) | master on the target instance | metadata reads |
| 15 | diagnostics / integrity-and-logs | [Memory Dump Info](../../scripts/diagnostics/glenn-berry/integrity-and-logs/sql-server-2008r2/015-memory-dump-info.sql) | master on the target instance | metadata reads |
| 16 | diagnostics / databases | [Database Filenames and Paths](../../scripts/diagnostics/glenn-berry/databases/sql-server-2008r2/016-database-filenames-and-paths.sql) | master on the target instance | metadata reads |
| 17 | performance / io | [Volume Info](../../scripts/performance/glenn-berry/io/sql-server-2008r2/017-volume-info.sql) | master on the target instance | metadata reads |
| 18 | performance / io | [IO Warnings](../../scripts/performance/glenn-berry/io/sql-server-2008r2/018-io-warnings.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 19 | performance / io | [Drive Level Latency](../../scripts/performance/glenn-berry/io/sql-server-2008r2/019-drive-level-latency.sql) | master on the target instance | metadata reads |
| 20 | performance / io | [IO Stalls by File](../../scripts/performance/glenn-berry/io/sql-server-2008r2/020-io-stalls-by-file.sql) | master on the target instance | metadata reads |
| 21 | diagnostics / databases | [Database Properties](../../scripts/diagnostics/glenn-berry/databases/sql-server-2008r2/021-database-properties.sql) | master on the target instance | metadata reads |
| 22 | indexes-and-statistics / indexes | [Missing Indexes All Databases](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/022-missing-indexes-all-databases.sql) | master on the target instance | metadata reads |
| 23 | diagnostics / databases | [VLF Counts](../../scripts/diagnostics/glenn-berry/databases/sql-server-2008r2/023-vlf-counts.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 24 | performance / cpu | [CPU Usage by Database](../../scripts/performance/glenn-berry/cpu/sql-server-2008r2/024-cpu-usage-by-database.sql) | master on the target instance | metadata reads |
| 25 | performance / io | [IO Usage By Database](../../scripts/performance/glenn-berry/io/sql-server-2008r2/025-io-usage-by-database.sql) | master on the target instance | metadata reads |
| 26 | performance / memory | [Total Buffer Usage by Database](../../scripts/performance/glenn-berry/memory/sql-server-2008r2/026-total-buffer-usage-by-database.sql) | master on the target instance | metadata reads |
| 27 | performance / waits | [Top Waits](../../scripts/performance/glenn-berry/waits/sql-server-2008r2/027-top-waits.sql) | master on the target instance | metadata reads |
| 28 | performance / waits | [Signal Waits](../../scripts/performance/glenn-berry/waits/sql-server-2008r2/028-signal-waits.sql) | master on the target instance | metadata reads |
| 29 | diagnostics / sessions-and-blocking | [Connection Counts](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2008r2/029-connection-counts.sql) | master on the target instance | metadata reads |
| 30 | diagnostics / sessions-and-blocking | [Connection Counts by IP Address](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2008r2/030-connection-counts-by-ip-address.sql) | master on the target instance | metadata reads |
| 31 | performance / cpu | [Avg Task Counts](../../scripts/performance/glenn-berry/cpu/sql-server-2008r2/031-avg-task-counts.sql) | master on the target instance | metadata reads |
| 32 | performance / cpu | [CPU Utilization History](../../scripts/performance/glenn-berry/cpu/sql-server-2008r2/032-cpu-utilization-history.sql) | master on the target instance | metadata reads |
| 33 | performance / query-statistics | [Top Worker Time Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/033-top-worker-time-queries.sql) | master on the target instance | metadata reads |
| 34 | performance / memory | [System Memory](../../scripts/performance/glenn-berry/memory/sql-server-2008r2/034-system-memory.sql) | master on the target instance | metadata reads |
| 35 | performance / memory | [Process Memory](../../scripts/performance/glenn-berry/memory/sql-server-2008r2/035-process-memory.sql) | master on the target instance | metadata reads |
| 36 | performance / memory | [PLE by NUMA Node](../../scripts/performance/glenn-berry/memory/sql-server-2008r2/036-ple-by-numa-node.sql) | master on the target instance | metadata reads |
| 37 | performance / memory | [Memory Grants Pending](../../scripts/performance/glenn-berry/memory/sql-server-2008r2/037-memory-grants-pending.sql) | master on the target instance | metadata reads |
| 38 | performance / memory | [Memory Clerk Usage](../../scripts/performance/glenn-berry/memory/sql-server-2008r2/038-memory-clerk-usage.sql) | master on the target instance | metadata reads |
| 39 | performance / query-statistics | [Ad hoc Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/039-ad-hoc-queries.sql) | master on the target instance | metadata reads |
| 40 | diagnostics / databases | [File Sizes and Space](../../scripts/diagnostics/glenn-berry/databases/sql-server-2008r2/040-file-sizes-and-space.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 41 | performance / io | [IO Stats By File](../../scripts/performance/glenn-berry/io/sql-server-2008r2/041-io-stats-by-file.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 42 | performance / query-statistics | [Query Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/042-query-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 43 | performance / query-statistics | [SP Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/043-sp-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 44 | performance / query-statistics | [SP Avg Elapsed Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/044-sp-avg-elapsed-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 45 | performance / query-statistics | [SP Avg Elapsed Variable Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/045-sp-avg-elapsed-variable-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 46 | performance / query-statistics | [SP Worker Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/046-sp-worker-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 47 | performance / query-statistics | [SP Logical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/047-sp-logical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 48 | performance / query-statistics | [SP Physical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/048-sp-physical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 49 | performance / query-statistics | [SP Logical Writes](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/049-sp-logical-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 50 | performance / query-statistics | [Top IO Statements](../../scripts/performance/glenn-berry/query-statistics/sql-server-2008r2/050-top-io-statements.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 51 | indexes-and-statistics / indexes | [Bad NC Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/051-bad-nc-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 52 | indexes-and-statistics / indexes | [Missing Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/052-missing-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 53 | indexes-and-statistics / indexes | [Missing Index Warnings](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/053-missing-index-warnings.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 54 | performance / memory | [Buffer Usage](../../scripts/performance/glenn-berry/memory/sql-server-2008r2/054-buffer-usage.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 55 | indexes-and-statistics / indexes | [Table Sizes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/055-table-sizes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 56 | indexes-and-statistics / indexes | [Table Properties](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/056-table-properties.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 57 | diagnostics / sessions-and-blocking | [Detect Blocking](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2008r2/057-detect-blocking.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 58 | indexes-and-statistics / indexes | [Statistics Update](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/058-statistics-update.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 59 | indexes-and-statistics / indexes | [Volatile Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/059-volatile-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 60 | indexes-and-statistics / indexes | [Index Fragmentation](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/060-index-fragmentation.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 61 | indexes-and-statistics / indexes | [Overall Index Usage - Reads](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/061-overall-index-usage-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 62 | indexes-and-statistics / indexes | [Overall Index Usage - Writes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2008r2/062-overall-index-usage-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 63 | performance / waits | [Lock Waits](../../scripts/performance/glenn-berry/waits/sql-server-2008r2/063-lock-waits.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 64 | backup-and-restore / backups | [Recent Full Backups](../../scripts/backup-and-restore/glenn-berry/backups/sql-server-2008r2/064-recent-full-backups.sql) | user database to inspect; select it in the client before execution | metadata reads |
