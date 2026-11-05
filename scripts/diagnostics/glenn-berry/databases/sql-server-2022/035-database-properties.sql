-- TSQL Library: Database Properties
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L1004-L1072
-- Upstream last modified: August 12, 2025; original query 35.
-- Validation: source integrity and static checks only; see docs/glenn-berry/README.md.
-- License: Glenn Berry terms below; this file is NOT covered by the root MIT license.

--*   Copyright (C) 2025 Glenn Berry
--*   All rights reserved.
--*
--*
--*   You may alter this code for your own *non-commercial* purposes. You may
--*   republish altered code as long as you include this copyright and give due credit.
--*
--*
--*   THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF
--*   ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
--*   TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
--*   PARTICULAR PURPOSE.
--*

-- Recovery model, log reuse wait description, log file size, log usage size  (Query 35) (Database Properties)
-- and compatibility level for all databases on instance
SELECT db.[name] AS [Database Name], SUSER_SNAME(db.owner_sid) AS [Database Owner],
db.[compatibility_level] AS [DB Compatibility Level],
db.recovery_model_desc AS [Recovery Model],
db.log_reuse_wait_desc AS [Log Reuse Wait Description],
CONVERT(DECIMAL(18,2), ds.cntr_value/1024.0) AS [Total Data File Size on Disk (MB)],
CONVERT(DECIMAL(18,2), ls.cntr_value/1024.0) AS [Total Log File Size on Disk (MB)],
CONVERT(DECIMAL(18,2), lu.cntr_value/1024.0) AS [Log File Used (MB)],
CAST(CAST(lu.cntr_value AS FLOAT) / CAST(ls.cntr_value AS FLOAT)AS DECIMAL(18,2)) * 100 AS [Log Used %],
db.page_verify_option_desc AS [Page Verify Option], db.user_access_desc, db.state_desc, db.containment_desc,
db.is_mixed_page_allocation_on,
db.is_auto_create_stats_on, db.is_auto_update_stats_on, db.is_auto_update_stats_async_on, db.is_parameterization_forced,
db.snapshot_isolation_state_desc, db.is_read_committed_snapshot_on, db.is_auto_close_on, db.is_auto_shrink_on,
db.target_recovery_time_in_seconds, db.is_cdc_enabled, db.is_published, db.is_distributor, db.is_sync_with_backup,
db.group_database_id, db.replica_id, db.is_memory_optimized_enabled, db.is_memory_optimized_elevate_to_snapshot_on,
db.delayed_durability_desc, db.is_query_store_on,
db.is_temporal_history_retention_enabled, db.is_accelerated_database_recovery_on,
db.is_data_retention_enabled, db.is_ledger_on, db.is_change_feed_enabled,
db.is_master_key_encrypted_by_server, db.is_encrypted, de.encryption_state, de.percent_complete, de.key_algorithm, de.key_length
FROM sys.databases AS db WITH (NOLOCK)
LEFT OUTER JOIN sys.dm_os_performance_counters AS lu WITH (NOLOCK)
ON db.name = lu.instance_name
LEFT OUTER JOIN sys.dm_os_performance_counters AS ls WITH (NOLOCK)
ON db.name = ls.instance_name
LEFT OUTER JOIN sys.dm_os_performance_counters AS ds WITH (NOLOCK)
ON db.name = ds.instance_name
LEFT OUTER JOIN sys.dm_database_encryption_keys AS de WITH (NOLOCK)
ON db.database_id = de.database_id
WHERE lu.counter_name LIKE N'Log File(s) Used Size (KB)%'
AND ls.counter_name LIKE N'Log File(s) Size (KB)%'
AND ds.counter_name LIKE N'Data File(s) Size (KB)%'
AND ls.cntr_value > 0
ORDER BY db.[name] OPTION (RECOMPILE);
------

-- sys.databases (Transact-SQL)
-- https://bit.ly/2G5wqaX

-- sys.dm_os_performance_counters (Transact-SQL)
-- https://bit.ly/3kEO2JR

-- sys.dm_database_encryption_keys (Transact-SQL)
-- https://bit.ly/3mE7kkx


-- Things to look at:
-- How many databases are on the instance?
-- What recovery models are they using?
-- What is the log reuse wait description?
-- How full are the transaction logs?
-- What compatibility level are the databases on?
-- What is the Page Verify Option? (should be CHECKSUM)
-- Is Auto Update Statistics Asynchronously enabled?
-- What is target_recovery_time_in_seconds? (should be 60 for user databases)
-- Is Delayed Durability enabled?
-- Make sure auto_shrink and auto_close are not enabled!

-- is_mixed_page_allocation_on is a new property for SQL Server 2016. Equivalent to TF 1118 for a user database
-- SQL Server 2016: Changes in default behavior for autogrow and allocations for tempdb and user databases
-- https://bit.ly/2evRZSR

-- A non-zero value for target_recovery_time_in_seconds means that indirect checkpoint is enabled
-- If the setting has a zero value it indicates that automatic checkpoint is enabled

-- Changes in SQL Server 2016 Checkpoint Behavior
-- https://bit.ly/2pdggk3
