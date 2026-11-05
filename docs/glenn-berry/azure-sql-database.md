# Glenn Berry queries: Azure SQL Database

[Collection guide](README.md) · [Browse by purpose](by-purpose.md)

Source: [`azure.sql`](https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql). Last modified upstream: January 1, 2025.

Choose a query and read its context, permissions, mode and notes before running it. Version labels identify the upstream suite, not tested compatibility.

| Original query | Purpose | Query | Context | Execution mode |
|---|---|---|---|---|
| 1 | diagnostics / instance | [Version Info](../../scripts/diagnostics/glenn-berry/instance/azure-sql-database/001-version-info.sql) | target Azure SQL user database | metadata reads |
| 2 | diagnostics / instance | [Configuration Values](../../scripts/diagnostics/glenn-berry/instance/azure-sql-database/002-configuration-values.sql) | target Azure SQL user database | metadata reads |
| 3 | performance / cpu | [SQL Server NUMA Info](../../scripts/performance/glenn-berry/cpu/azure-sql-database/003-sql-server-numa-info.sql) | target Azure SQL user database | metadata reads |
| 4 | performance / io | [IO Stalls by File](../../scripts/performance/glenn-berry/io/azure-sql-database/004-io-stalls-by-file.sql) | target Azure SQL user database | metadata reads |
| 5 | performance / io | [IO Usage By Database](../../scripts/performance/glenn-berry/io/azure-sql-database/005-io-usage-by-database.sql) | target Azure SQL user database | metadata reads |
| 6 | performance / memory | [Total Buffer Usage by Database](../../scripts/performance/glenn-berry/memory/azure-sql-database/006-total-buffer-usage-by-database.sql) | target Azure SQL user database | metadata reads |
| 7 | diagnostics / sessions-and-blocking | [Connection Counts by IP Address](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/azure-sql-database/007-connection-counts-by-ip-address.sql) | target Azure SQL user database | metadata reads |
| 8 | performance / cpu | [Avg Task Counts](../../scripts/performance/glenn-berry/cpu/azure-sql-database/008-avg-task-counts.sql) | target Azure SQL user database | metadata reads |
| 9 | diagnostics / sessions-and-blocking | [Detect Blocking](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/azure-sql-database/009-detect-blocking.sql) | target Azure SQL user database | metadata reads |
| 10 | performance / memory | [PLE by NUMA Node](../../scripts/performance/glenn-berry/memory/azure-sql-database/010-ple-by-numa-node.sql) | target Azure SQL user database | metadata reads |
| 11 | performance / memory | [Memory Grants Pending](../../scripts/performance/glenn-berry/memory/azure-sql-database/011-memory-grants-pending.sql) | target Azure SQL user database | metadata reads |
| 12 | performance / memory | [Memory Clerk Usage](../../scripts/performance/glenn-berry/memory/azure-sql-database/012-memory-clerk-usage.sql) | target Azure SQL user database | metadata reads |
| 13 | performance / query-statistics | [Ad hoc Queries](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/013-ad-hoc-queries.sql) | target Azure SQL user database | metadata reads |
| 14 | diagnostics / databases | [Azure SQL DB Size](../../scripts/diagnostics/glenn-berry/databases/azure-sql-database/014-azure-sql-db-size.sql) | target Azure SQL user database | metadata reads |
| 15 | diagnostics / databases | [File Sizes and Space](../../scripts/diagnostics/glenn-berry/databases/azure-sql-database/015-file-sizes-and-space.sql) | target Azure SQL user database | metadata reads |
| 16 | diagnostics / databases | [Log Space Usage](../../scripts/diagnostics/glenn-berry/databases/azure-sql-database/016-log-space-usage.sql) | target Azure SQL user database | metadata reads |
| 17 | diagnostics / databases | [VLF Counts](../../scripts/diagnostics/glenn-berry/databases/azure-sql-database/017-vlf-counts.sql) | target Azure SQL user database | metadata reads |
| 18 | diagnostics / databases | [Last VLF Status](../../scripts/diagnostics/glenn-berry/databases/azure-sql-database/018-last-vlf-status.sql) | target Azure SQL user database | metadata reads |
| 19 | diagnostics / databases | [Database Properties](../../scripts/diagnostics/glenn-berry/databases/azure-sql-database/019-database-properties.sql) | target Azure SQL user database | metadata reads |
| 20 | diagnostics / databases | [Database-scoped Configurations](../../scripts/diagnostics/glenn-berry/databases/azure-sql-database/020-database-scoped-configurations.sql) | target Azure SQL user database | metadata reads |
| 21 | performance / io | [IO Stats By File](../../scripts/performance/glenn-berry/io/azure-sql-database/021-io-stats-by-file.sql) | target Azure SQL user database | metadata reads |
| 22 | performance / resource-governance | [Recent Resource Usage](../../scripts/performance/glenn-berry/resource-governance/azure-sql-database/022-recent-resource-usage.sql) | target Azure SQL user database | metadata reads |
| 23 | performance / resource-governance | [Avg-Max Resource Usage](../../scripts/performance/glenn-berry/resource-governance/azure-sql-database/023-avg-max-resource-usage.sql) | target Azure SQL user database | metadata reads |
| 24 | performance / waits | [Top DB Waits](../../scripts/performance/glenn-berry/waits/azure-sql-database/024-top-db-waits.sql) | target Azure SQL user database | metadata reads |
| 25 | performance / query-statistics | [Query Execution Counts](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/025-query-execution-counts.sql) | target Azure SQL user database | metadata reads |
| 26 | performance / query-statistics | [Top Worker Time Queries](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/026-top-worker-time-queries.sql) | target Azure SQL user database | metadata reads |
| 27 | performance / query-statistics | [Top Logical Reads Queries](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/027-top-logical-reads-queries.sql) | target Azure SQL user database | metadata reads |
| 28 | performance / query-statistics | [Top Avg Elapsed Time Queries](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/028-top-avg-elapsed-time-queries.sql) | target Azure SQL user database | metadata reads |
| 29 | performance / query-statistics | [SP Execution Counts](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/029-sp-execution-counts.sql) | target Azure SQL user database | metadata reads |
| 30 | performance / query-statistics | [SP Avg Elapsed Time](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/030-sp-avg-elapsed-time.sql) | target Azure SQL user database | metadata reads |
| 31 | performance / query-statistics | [SP Worker Time](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/031-sp-worker-time.sql) | target Azure SQL user database | metadata reads |
| 32 | performance / query-statistics | [SP Logical Reads](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/032-sp-logical-reads.sql) | target Azure SQL user database | metadata reads |
| 33 | performance / query-statistics | [SP Physical Reads](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/033-sp-physical-reads.sql) | target Azure SQL user database | metadata reads |
| 34 | performance / query-statistics | [SP Logical Writes](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/034-sp-logical-writes.sql) | target Azure SQL user database | metadata reads |
| 35 | performance / query-statistics | [Top IO Statements](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/035-top-io-statements.sql) | target Azure SQL user database | metadata reads |
| 36 | indexes-and-statistics / indexes | [Bad NC Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/036-bad-nc-indexes.sql) | target Azure SQL user database | metadata reads |
| 37 | indexes-and-statistics / indexes | [Missing Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/037-missing-indexes.sql) | target Azure SQL user database | metadata reads |
| 38 | indexes-and-statistics / indexes | [Missing Index Warnings](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/038-missing-index-warnings.sql) | target Azure SQL user database | metadata reads |
| 39 | performance / memory | [Buffer Usage](../../scripts/performance/glenn-berry/memory/azure-sql-database/039-buffer-usage.sql) | target Azure SQL user database | metadata reads |
| 40 | indexes-and-statistics / indexes | [Table Sizes](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/040-table-sizes.sql) | target Azure SQL user database | metadata reads |
| 41 | indexes-and-statistics / indexes | [Table Properties](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/041-table-properties.sql) | target Azure SQL user database | metadata reads |
| 42 | indexes-and-statistics / indexes | [Statistics Update](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/042-statistics-update.sql) | target Azure SQL user database | metadata reads |
| 43 | indexes-and-statistics / indexes | [Volatile Indexes](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/043-volatile-indexes.sql) | target Azure SQL user database | metadata reads |
| 44 | indexes-and-statistics / indexes | [Index Fragmentation](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/044-index-fragmentation.sql) | target Azure SQL user database | metadata reads |
| 45 | indexes-and-statistics / indexes | [Overall Index Usage - Reads](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/045-overall-index-usage-reads.sql) | target Azure SQL user database | metadata reads |
| 46 | indexes-and-statistics / indexes | [Overall Index Usage - Writes](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/046-overall-index-usage-writes.sql) | target Azure SQL user database | metadata reads |
| 47 | indexes-and-statistics / indexes | [Columnstore Index Physical Stat](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/047-columnstore-index-physical-stat.sql) | target Azure SQL user database | metadata reads |
| 48 | performance / waits | [Lock Waits](../../scripts/performance/glenn-berry/waits/azure-sql-database/048-lock-waits.sql) | target Azure SQL user database | metadata reads |
| 49 | performance / query-statistics | [UDF Statistics](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/049-udf-statistics.sql) | target Azure SQL user database | metadata reads |
| 50 | performance / query-statistics | [QueryStore Options](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/050-querystore-options.sql) | target Azure SQL user database | metadata reads |
| 51 | performance / query-statistics | [High Aggregate Duration Queries](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/051-high-aggregate-duration-queries.sql) | target Azure SQL user database | metadata reads |
| 52 | diagnostics / sessions-and-blocking | [Input Buffer](../../scripts/diagnostics/glenn-berry/sessions-and-blocking/azure-sql-database/052-input-buffer.sql) | target Azure SQL user database | metadata reads |
| 53 | indexes-and-statistics / indexes | [Resumable Index Rebuild](../../scripts/indexes-and-statistics/glenn-berry/indexes/azure-sql-database/053-resumable-index-rebuild.sql) | target Azure SQL user database | metadata reads |
| 54 | performance / query-statistics | [Automatic Tuning Options](../../scripts/performance/glenn-berry/query-statistics/azure-sql-database/054-automatic-tuning-options.sql) | target Azure SQL user database | metadata reads |
| 55 | high-availability / replication-and-clustering | [Geo-Replication Link Status](../../scripts/high-availability/glenn-berry/replication-and-clustering/azure-sql-database/055-geo-replication-link-status.sql) | target Azure SQL user database | metadata reads |
| 56 | diagnostics / databases | [Azure SQL DB Properties](../../scripts/diagnostics/glenn-berry/databases/azure-sql-database/056-azure-sql-db-properties.sql) | target Azure SQL user database | metadata reads |
