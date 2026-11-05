-- TSQL Library: QueryStore Options
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L1117-L1131
-- Upstream last modified: January 1, 2025; original query 50.
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

-- Get QueryStore Options for this database (Query 50) (QueryStore Options)
SELECT actual_state_desc, desired_state_desc,
       current_storage_size_mb, [max_storage_size_mb],
	   query_capture_mode_desc, size_based_cleanup_mode_desc,
	   wait_stats_capture_mode_desc, [flush_interval_seconds]
FROM sys.database_query_store_options WITH (NOLOCK) OPTION (RECOMPILE);
------

-- Added in SQL Server 2016
-- Requires that QueryStore is enabled for this database

-- Tuning Workload Performance with Query Store
-- https://bit.ly/1kHSl7w
