# Glenn Berry queries: SQL Server 2017

[Collection guide](README.md) · [Browse by purpose](by-purpose.md)

Source: [`2017.sql`](https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2017.sql). Last modified upstream: August 12, 2025.

Choose a query and read its context, permissions, mode and notes before running it. Version labels identify the upstream suite, not tested compatibility.

| Original query | Purpose | Query | Context | Execution mode |
|---|---|---|---|---|
| 1 | diagnostics / instance | [Version Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/001-version-info.sql) | master on the target instance | metadata reads |
| 2 | performance / cpu | [Core Counts](../../scripts/performance/glenn-berry/cpu/sql-server-2017/002-core-counts.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 3 | diagnostics / instance | [Server Properties](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/003-server-properties.sql) | master on the target instance | metadata reads |
| 4 | diagnostics / instance | [Configuration Values](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/004-configuration-values.sql) | master on the target instance | metadata reads |
| 5 | diagnostics / instance | [Global Trace Flags](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/005-global-trace-flags.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 6 | performance / memory | [Process Memory](../../scripts/performance/glenn-berry/memory/sql-server-2017/006-process-memory.sql) | master on the target instance | metadata reads |
| 7 | diagnostics / instance | [SQL Server Services Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/007-sql-server-services-info.sql) | master on the target instance | metadata reads |
| 8 | backup-and-restore / backups | [Last Backup By Database](../../scripts/backup-and-restore/glenn-berry/backups/sql-server-2017/008-last-backup-by-database.sql) | master on the target instance | metadata reads |
| 9 | sql-agent / jobs-and-alerts | [SQL Server Agent Jobs](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2017/009-sql-server-agent-jobs.sql) | master on the target instance | metadata reads |
| 10 | sql-agent / jobs-and-alerts | [SQL Server Agent Alerts](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2017/010-sql-server-agent-alerts.sql) | master on the target instance | metadata reads |
| 11 | diagnostics / instance | [Host Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/011-host-info.sql) | master on the target instance | metadata reads |
| 12 | performance / cpu | [SQL Server NUMA Info](../../scripts/performance/glenn-berry/cpu/sql-server-2017/012-sql-server-numa-info.sql) | master on the target instance | metadata reads |
| 13 | performance / memory | [System Memory](../../scripts/performance/glenn-berry/memory/sql-server-2017/013-system-memory.sql) | master on the target instance | metadata reads |
| 14 | performance / memory | [Memory Snapshot](../../scripts/performance/glenn-berry/memory/sql-server-2017/014-memory-snapshot.sql) | master on the target instance | metadata reads |
| 15 | high-availability / replication-and-clustering | [AlwaysOn AG Cluster](../../scripts/high-availability/glenn-berry/replication-and-clustering/sql-server-2017/015-alwayson-ag-cluster.sql) | master on the target instance | metadata reads |
| 16 | high-availability / replication-and-clustering | [AG Status](../../scripts/high-availability/glenn-berry/replication-and-clustering/sql-server-2017/016-ag-status.sql) | master on the target instance | metadata reads |
| 17 | diagnostics / instance | [Hardware Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/017-hardware-info.sql) | master on the target instance | metadata reads |
| 18 | diagnostics / instance | [System Manufacturer](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/018-system-manufacturer.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 19 | diagnostics / instance | [BIOS Date](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/019-bios-date.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 20 | diagnostics / instance | [Processor Description](../../scripts/diagnostics/glenn-berry/instance/sql-server-2017/020-processor-description.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 21 | diagnostics / integrity-and-logs | [Memory Dump Info](../../scripts/diagnostics/glenn-berry/integrity-and-logs/sql-server-2017/021-memory-dump-info.sql) | master on the target instance | metadata reads |
| 22 | diagnostics / integrity-and-logs | [Suspect Pages](../../scripts/diagnostics/glenn-berry/integrity-and-logs/sql-server-2017/022-suspect-pages.sql) | master on the target instance | metadata reads |
| 23 | diagnostics / tempdb | [TempDB Data Files](../../scripts/diagnostics/glenn-berry/tempdb/sql-server-2017/023-tempdb-data-files.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 24 | diagnostics / tempdb | [Tempdb Data File Sizes](../../scripts/diagnostics/glenn-berry/tempdb/sql-server-2017/024-tempdb-data-file-sizes.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 25 | diagnostics / databases | [Database Filenames and Paths](../../scripts/diagnostics/glenn-berry/databases/sql-server-2017/025-database-filenames-and-paths.sql) | master on the target instance | metadata reads |
| 26 | performance / io | [Fixed Drives](../../scripts/performance/glenn-berry/io/sql-server-2017/026-fixed-drives.sql) | master on the target instance | metadata reads |
| 27 | performance / io | [Volume Info](../../scripts/performance/glenn-berry/io/sql-server-2017/027-volume-info.sql) | master on the target instance | metadata reads |
| 28 | performance / io | [Drive Level Latency](../../scripts/performance/glenn-berry/io/sql-server-2017/028-drive-level-latency.sql) | master on the target instance | metadata reads |
| 29 | performance / io | [IO Latency by File](../../scripts/performance/glenn-berry/io/sql-server-2017/029-io-latency-by-file.sql) | master on the target instance | metadata reads |
| 30 | performance / io | [IO Warnings](../../scripts/performance/glenn-berry/io/sql-server-2017/030-io-warnings.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 31 | performance / resource-governance | [RG Resource Pools](../../scripts/performance/glenn-berry/resource-governance/sql-server-2017/031-rg-resource-pools.sql) | master on the target instance | metadata reads |
| 32 | diagnostics / databases | [Database Properties](../../scripts/diagnostics/glenn-berry/databases/sql-server-2017/032-database-properties.sql) | master on the target instance | metadata reads |
| 33 | indexes-and-statistics / indexes | [Missing Indexes All Databases](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/033-missing-indexes-all-databases.sql) | master on the target instance | metadata reads |
| 34 | diagnostics / databases | [VLF Counts](../../scripts/diagnostics/glenn-berry/databases/sql-server-2017/034-vlf-counts.sql) | master on the target instance | metadata reads |
| 35 | performance / cpu | [CPU Usage by Database](../../scripts/performance/glenn-berry/cpu/sql-server-2017/035-cpu-usage-by-database.sql) | master on the target instance | metadata reads |
| 36 | performance / io | [IO Usage By Database](../../scripts/performance/glenn-berry/io/sql-server-2017/036-io-usage-by-database.sql) | master on the target instance | metadata reads |
| 37 | performance / memory | [Total Buffer Usage by Database](../../scripts/performance/glenn-berry/memory/sql-server-2017/037-total-buffer-usage-by-database.sql) | master on the target instance | metadata reads |
| 38 | diagnostics / tempdb | [Version Store Space Usage](../../scripts/diagnostics/glenn-berry/tempdb/sql-server-2017/038-version-store-space-usage.sql) | master on the target instance | metadata reads |
| 39 | performance / waits | [Top Waits](../../scripts/performance/glenn-berry/waits/sql-server-2017/039-top-waits.sql) | master on the target instance | metadata reads |
| 40 | diagnostics / sessions-and-blocking | [Connection Counts by IP Address](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2017/040-connection-counts-by-ip-address.sql) | master on the target instance | metadata reads |
| 41 | performance / cpu | [Avg Task Counts](../../scripts/performance/glenn-berry/cpu/sql-server-2017/041-avg-task-counts.sql) | master on the target instance | metadata reads |
| 42 | diagnostics / sessions-and-blocking | [Detect Blocking](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2017/042-detect-blocking.sql) | master on the target instance | metadata reads |
| 43 | performance / cpu | [CPU Utilization History](../../scripts/performance/glenn-berry/cpu/sql-server-2017/043-cpu-utilization-history.sql) | master on the target instance | metadata reads |
| 44 | performance / query-statistics | [Top Worker Time Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/044-top-worker-time-queries.sql) | master on the target instance | metadata reads |
| 45 | performance / memory | [PLE by NUMA Node](../../scripts/performance/glenn-berry/memory/sql-server-2017/045-ple-by-numa-node.sql) | master on the target instance | metadata reads |
| 46 | performance / memory | [Memory Grants Pending](../../scripts/performance/glenn-berry/memory/sql-server-2017/046-memory-grants-pending.sql) | master on the target instance | metadata reads |
| 47 | performance / memory | [Memory Clerk Usage](../../scripts/performance/glenn-berry/memory/sql-server-2017/047-memory-clerk-usage.sql) | master on the target instance | metadata reads |
| 48 | performance / query-statistics | [Ad hoc Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/048-ad-hoc-queries.sql) | master on the target instance | metadata reads |
| 49 | performance / query-statistics | [Top Logical Reads Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/049-top-logical-reads-queries.sql) | master on the target instance | metadata reads |
| 50 | performance / query-statistics | [Top Avg Elapsed Time Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/050-top-avg-elapsed-time-queries.sql) | master on the target instance | metadata reads |
| 51 | performance / query-statistics | [UDF Stats by DB](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/051-udf-stats-by-db.sql) | master on the target instance | metadata reads |
| 52 | performance / memory | [Long Buffer Pool Scans](../../scripts/performance/glenn-berry/memory/sql-server-2017/052-long-buffer-pool-scans.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 53 | diagnostics / databases | [File Sizes and Space](../../scripts/diagnostics/glenn-berry/databases/sql-server-2017/053-file-sizes-and-space.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 54 | diagnostics / databases | [Log Space Usage](../../scripts/diagnostics/glenn-berry/databases/sql-server-2017/054-log-space-usage.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 55 | diagnostics / databases | [Last VLF Status](../../scripts/diagnostics/glenn-berry/databases/sql-server-2017/055-last-vlf-status.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 56 | diagnostics / databases | [Database-scoped Configurations](../../scripts/diagnostics/glenn-berry/databases/sql-server-2017/056-database-scoped-configurations.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 57 | performance / io | [IO Stats By File](../../scripts/performance/glenn-berry/io/sql-server-2017/057-io-stats-by-file.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 58 | performance / query-statistics | [Query Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/058-query-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 59 | performance / query-statistics | [SP Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/059-sp-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 60 | performance / query-statistics | [SP Avg Elapsed Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/060-sp-avg-elapsed-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 61 | performance / query-statistics | [SP Worker Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/061-sp-worker-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 62 | performance / query-statistics | [SP Logical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/062-sp-logical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 63 | performance / query-statistics | [SP Physical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/063-sp-physical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 64 | performance / query-statistics | [SP Logical Writes](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/064-sp-logical-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 65 | indexes-and-statistics / indexes | [SP Missing Index](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/065-sp-missing-index.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 66 | performance / query-statistics | [Top IO Statements](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/066-top-io-statements.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 67 | indexes-and-statistics / indexes | [Bad NC Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/067-bad-nc-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 68 | indexes-and-statistics / indexes | [Missing Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/068-missing-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 69 | indexes-and-statistics / indexes | [Missing Index Warnings](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/069-missing-index-warnings.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 70 | performance / memory | [Buffer Usage](../../scripts/performance/glenn-berry/memory/sql-server-2017/070-buffer-usage.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 71 | indexes-and-statistics / indexes | [Table Sizes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/071-table-sizes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 72 | indexes-and-statistics / indexes | [Table Properties](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/072-table-properties.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 73 | indexes-and-statistics / indexes | [Statistics Update](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/073-statistics-update.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 74 | indexes-and-statistics / indexes | [Volatile Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/074-volatile-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 75 | indexes-and-statistics / indexes | [Index Fragmentation](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/075-index-fragmentation.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 76 | indexes-and-statistics / indexes | [Overall Index Usage - Reads](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/076-overall-index-usage-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 77 | indexes-and-statistics / indexes | [Overall Index Usage - Writes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2017/077-overall-index-usage-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 78 | performance / waits | [Lock Waits](../../scripts/performance/glenn-berry/waits/sql-server-2017/078-lock-waits.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 79 | performance / query-statistics | [UDF Statistics](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/079-udf-statistics.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 80 | performance / query-statistics | [Query Store Options](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/080-query-store-options.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 81 | diagnostics / sessions-and-blocking | [Input Buffer](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2017/081-input-buffer.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 83 | performance / query-statistics | [Automatic Tuning Options](../../scripts/performance/glenn-berry/query-statistics/sql-server-2017/083-automatic-tuning-options.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 84 | backup-and-restore / backups | [Recent Full Backups](../../scripts/backup-and-restore/glenn-berry/backups/sql-server-2017/084-recent-full-backups.sql) | user database to inspect; select it in the client before execution | metadata reads |

Upstream numbering skips 82 and ends at 84; all 83 query blocks are included.
