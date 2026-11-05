# Glenn Berry queries: SQL Server 2012

[Collection guide](README.md) · [Browse by purpose](by-purpose.md)

Source: [`2012.sql`](https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2012.sql). Last modified upstream: August 4, 2025.

Choose a query and read its context, permissions, mode and notes before running it. Version labels identify the upstream suite, not tested compatibility.

| Original query | Purpose | Query | Context | Execution mode |
|---|---|---|---|---|
| 1 | diagnostics / instance | [Version Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/001-version-info.sql) | master on the target instance | metadata reads |
| 2 | performance / cpu | [Core Counts](../../scripts/performance/glenn-berry/cpu/sql-server-2012/002-core-counts.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 3 | diagnostics / instance | [Server Properties](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/003-server-properties.sql) | master on the target instance | metadata reads |
| 4 | diagnostics / instance | [Configuration Values](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/004-configuration-values.sql) | master on the target instance | metadata reads |
| 5 | diagnostics / instance | [Global Trace Flags](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/005-global-trace-flags.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 6 | diagnostics / instance | [IFI Status](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/006-ifi-status.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 7 | performance / memory | [Process Memory](../../scripts/performance/glenn-berry/memory/sql-server-2012/007-process-memory.sql) | master on the target instance | metadata reads |
| 8 | diagnostics / instance | [SQL Server Services Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/008-sql-server-services-info.sql) | master on the target instance | metadata reads |
| 9 | backup-and-restore / backups | [Last Backup By Database](../../scripts/backup-and-restore/glenn-berry/backups/sql-server-2012/009-last-backup-by-database.sql) | master on the target instance | metadata reads |
| 10 | sql-agent / jobs-and-alerts | [SQL Server Agent Jobs](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2012/010-sql-server-agent-jobs.sql) | master on the target instance | metadata reads |
| 11 | sql-agent / jobs-and-alerts | [SQL Server Agent Alerts](../../scripts/sql-agent/glenn-berry/jobs-and-alerts/sql-server-2012/011-sql-server-agent-alerts.sql) | master on the target instance | metadata reads |
| 12 | diagnostics / instance | [Windows Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/012-windows-info.sql) | master on the target instance | metadata reads |
| 13 | performance / cpu | [SQL Server NUMA Info](../../scripts/performance/glenn-berry/cpu/sql-server-2012/013-sql-server-numa-info.sql) | master on the target instance | metadata reads |
| 14 | performance / memory | [System Memory](../../scripts/performance/glenn-berry/memory/sql-server-2012/014-system-memory.sql) | master on the target instance | metadata reads |
| 15 | high-availability / replication-and-clustering | [Cluster Node Properties](../../scripts/high-availability/glenn-berry/replication-and-clustering/sql-server-2012/015-cluster-node-properties.sql) | master on the target instance | metadata reads |
| 16 | high-availability / replication-and-clustering | [AlwaysOn AG Cluster](../../scripts/high-availability/glenn-berry/replication-and-clustering/sql-server-2012/016-alwayson-ag-cluster.sql) | master on the target instance | metadata reads |
| 17 | high-availability / replication-and-clustering | [AG Status](../../scripts/high-availability/glenn-berry/replication-and-clustering/sql-server-2012/017-ag-status.sql) | master on the target instance | metadata reads |
| 18 | diagnostics / instance | [Hardware Info](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/018-hardware-info.sql) | master on the target instance | metadata reads |
| 19 | diagnostics / instance | [System Manufacturer](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/019-system-manufacturer.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 20 | diagnostics / instance | [BIOS Date](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/020-bios-date.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 21 | diagnostics / instance | [Processor Description](../../scripts/diagnostics/glenn-berry/instance/sql-server-2012/021-processor-description.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 22 | diagnostics / integrity-and-logs | [Memory Dump Info](../../scripts/diagnostics/glenn-berry/integrity-and-logs/sql-server-2012/022-memory-dump-info.sql) | master on the target instance | metadata reads |
| 23 | diagnostics / integrity-and-logs | [Suspect Pages](../../scripts/diagnostics/glenn-berry/integrity-and-logs/sql-server-2012/023-suspect-pages.sql) | master on the target instance | metadata reads |
| 24 | diagnostics / tempdb | [Tempdb Data Files](../../scripts/diagnostics/glenn-berry/tempdb/sql-server-2012/024-tempdb-data-files.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 25 | diagnostics / tempdb | [Tempdb Data File Sizes](../../scripts/diagnostics/glenn-berry/tempdb/sql-server-2012/025-tempdb-data-file-sizes.sql) | master on the target instance | metadata reads; diagnostic procedure/DBCC calls |
| 26 | diagnostics / databases | [Database Filenames and Paths](../../scripts/diagnostics/glenn-berry/databases/sql-server-2012/026-database-filenames-and-paths.sql) | master on the target instance | metadata reads |
| 27 | performance / io | [Volume Info](../../scripts/performance/glenn-berry/io/sql-server-2012/027-volume-info.sql) | master on the target instance | metadata reads |
| 28 | performance / io | [Drive Level Latency](../../scripts/performance/glenn-berry/io/sql-server-2012/028-drive-level-latency.sql) | master on the target instance | metadata reads |
| 29 | performance / io | [IO Latency by File](../../scripts/performance/glenn-berry/io/sql-server-2012/029-io-latency-by-file.sql) | master on the target instance | metadata reads |
| 30 | performance / io | [IO Warnings](../../scripts/performance/glenn-berry/io/sql-server-2012/030-io-warnings.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 31 | performance / resource-governance | [RG Resource Pools](../../scripts/performance/glenn-berry/resource-governance/sql-server-2012/031-rg-resource-pools.sql) | master on the target instance | metadata reads |
| 32 | diagnostics / databases | [Database Properties](../../scripts/diagnostics/glenn-berry/databases/sql-server-2012/032-database-properties.sql) | master on the target instance | metadata reads |
| 33 | indexes-and-statistics / indexes | [Missing Indexes All Databases](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/033-missing-indexes-all-databases.sql) | master on the target instance | metadata reads |
| 34 | diagnostics / databases | [VLF Counts](../../scripts/diagnostics/glenn-berry/databases/sql-server-2012/034-vlf-counts.sql) | master on the target instance | metadata reads with local temporary tables; diagnostic procedure/DBCC calls |
| 35 | performance / cpu | [CPU Usage by Database](../../scripts/performance/glenn-berry/cpu/sql-server-2012/035-cpu-usage-by-database.sql) | master on the target instance | metadata reads |
| 36 | performance / io | [IO Usage By Database](../../scripts/performance/glenn-berry/io/sql-server-2012/036-io-usage-by-database.sql) | master on the target instance | metadata reads |
| 37 | performance / memory | [Total Buffer Usage by Database](../../scripts/performance/glenn-berry/memory/sql-server-2012/037-total-buffer-usage-by-database.sql) | master on the target instance | metadata reads |
| 38 | performance / waits | [Top Waits](../../scripts/performance/glenn-berry/waits/sql-server-2012/038-top-waits.sql) | master on the target instance | metadata reads |
| 39 | diagnostics / sessions-and-blocking | [Connection Counts by IP Address](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2012/039-connection-counts-by-ip-address.sql) | master on the target instance | metadata reads |
| 40 | performance / cpu | [Avg Task Counts](../../scripts/performance/glenn-berry/cpu/sql-server-2012/040-avg-task-counts.sql) | master on the target instance | metadata reads |
| 41 | diagnostics / sessions-and-blocking | [Detect Blocking](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/sql-server-2012/041-detect-blocking.sql) | master on the target instance | metadata reads |
| 42 | performance / cpu | [CPU Utilization History](../../scripts/performance/glenn-berry/cpu/sql-server-2012/042-cpu-utilization-history.sql) | master on the target instance | metadata reads |
| 43 | performance / query-statistics | [Top Worker Time Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/043-top-worker-time-queries.sql) | master on the target instance | metadata reads |
| 44 | performance / memory | [PLE by NUMA Node](../../scripts/performance/glenn-berry/memory/sql-server-2012/044-ple-by-numa-node.sql) | master on the target instance | metadata reads |
| 45 | performance / memory | [Memory Grants Pending](../../scripts/performance/glenn-berry/memory/sql-server-2012/045-memory-grants-pending.sql) | master on the target instance | metadata reads |
| 46 | performance / memory | [Memory Clerk Usage](../../scripts/performance/glenn-berry/memory/sql-server-2012/046-memory-clerk-usage.sql) | master on the target instance | metadata reads |
| 47 | performance / query-statistics | [Ad hoc Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/047-ad-hoc-queries.sql) | master on the target instance | metadata reads |
| 48 | performance / query-statistics | [Top Logical Reads Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/048-top-logical-reads-queries.sql) | master on the target instance | metadata reads |
| 49 | performance / query-statistics | [Top Avg Elapsed Time Queries](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/049-top-avg-elapsed-time-queries.sql) | master on the target instance | metadata reads |
| 50 | diagnostics / databases | [File Sizes and Space](../../scripts/diagnostics/glenn-berry/databases/sql-server-2012/050-file-sizes-and-space.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 51 | performance / io | [IO Stats By File](../../scripts/performance/glenn-berry/io/sql-server-2012/051-io-stats-by-file.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 52 | performance / query-statistics | [Query Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/052-query-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 53 | performance / query-statistics | [SP Execution Counts](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/053-sp-execution-counts.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 54 | performance / query-statistics | [SP Avg Elapsed Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/054-sp-avg-elapsed-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 55 | performance / query-statistics | [SP Worker Time](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/055-sp-worker-time.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 56 | performance / query-statistics | [SP Logical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/056-sp-logical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 57 | performance / query-statistics | [SP Physical Reads](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/057-sp-physical-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 58 | performance / query-statistics | [SP Logical Writes](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/058-sp-logical-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 59 | performance / query-statistics | [Top IO Statements](../../scripts/performance/glenn-berry/query-statistics/sql-server-2012/059-top-io-statements.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 60 | indexes-and-statistics / indexes | [Bad NC Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/060-bad-nc-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 61 | indexes-and-statistics / indexes | [Missing Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/061-missing-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 62 | indexes-and-statistics / indexes | [Missing Index Warnings](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/062-missing-index-warnings.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 63 | performance / memory | [Buffer Usage](../../scripts/performance/glenn-berry/memory/sql-server-2012/063-buffer-usage.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 64 | indexes-and-statistics / indexes | [Table Sizes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/064-table-sizes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 65 | indexes-and-statistics / indexes | [Table Properties](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/065-table-properties.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 66 | indexes-and-statistics / indexes | [Statistics Update](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/066-statistics-update.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 67 | indexes-and-statistics / indexes | [Volatile Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/067-volatile-indexes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 68 | indexes-and-statistics / indexes | [Index Fragmentation](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/068-index-fragmentation.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 69 | indexes-and-statistics / indexes | [Overall Index Usage - Reads](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/069-overall-index-usage-reads.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 70 | indexes-and-statistics / indexes | [Overall Index Usage - Writes](../../scripts/indexes-and-statistics/glenn-berry/indexes/sql-server-2012/070-overall-index-usage-writes.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 71 | performance / waits | [Lock Waits](../../scripts/performance/glenn-berry/waits/sql-server-2012/071-lock-waits.sql) | user database to inspect; select it in the client before execution | metadata reads |
| 72 | backup-and-restore / backups | [Recent Full Backups](../../scripts/backup-and-restore/glenn-berry/backups/sql-server-2012/072-recent-full-backups.sql) | user database to inspect; select it in the client before execution | metadata reads |
