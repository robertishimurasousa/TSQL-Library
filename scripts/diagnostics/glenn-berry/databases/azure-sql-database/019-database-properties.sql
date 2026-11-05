-- TSQL Library: Database Properties
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L367-L395
-- Upstream last modified: January 1, 2025; original query 19.
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

-- Important database properties for current database   (Query 19) (Database Properties)
SELECT db.[name] AS [Database Name], db.recovery_model_desc AS [Recovery Model],
db.state_desc, db.containment_desc, db.log_reuse_wait_desc AS [Log Reuse Wait Description],
db.[compatibility_level] AS [DB Compatibility Level],
db.is_mixed_page_allocation_on, db.page_verify_option_desc AS [Page Verify Option],
db.is_auto_create_stats_on, db.is_auto_update_stats_on, db.is_auto_update_stats_async_on, db.is_parameterization_forced,
db.snapshot_isolation_state_desc, db.is_read_committed_snapshot_on, db.is_auto_close_on, db.is_auto_shrink_on,
db.target_recovery_time_in_seconds, db.is_cdc_enabled, db.is_memory_optimized_elevate_to_snapshot_on,
db.delayed_durability_desc, db.is_query_store_on, db.is_temporal_history_retention_enabled,
db.is_accelerated_database_recovery_on, db.is_memory_optimized_enabled
FROM sys.databases AS db WITH (NOLOCK)
WHERE db.[name] <> N'master'
ORDER BY db.[name] OPTION (RECOMPILE);
------

-- sys.databases (Transact-SQL)
-- https://bit.ly/2G5wqaX

-- Things to look at:
-- What recovery model are you using?
-- What is the log reuse wait description?
-- What compatibility level is the database on?
-- What is the Page Verify Option? (should be CHECKSUM)
-- Is Auto Update Statistics Asynchronously enabled?
-- Is Delayed Durability enabled?
