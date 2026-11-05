-- TSQL Library: Recent Resource Usage
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L432-L448
-- Upstream last modified: January 1, 2025; original query 22.
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

-- Get recent resource usage (Query 22) (Recent Resource Usage)
SELECT end_time, dtu_limit, cpu_limit, avg_cpu_percent, avg_memory_usage_percent,
       avg_data_io_percent, avg_log_write_percent,  xtp_storage_percent,
       max_worker_percent, max_session_percent,  avg_login_rate_percent,
	   avg_instance_cpu_percent, avg_instance_memory_percent
FROM sys.dm_db_resource_stats WITH (NOLOCK)
ORDER BY end_time DESC OPTION (RECOMPILE);
------

-- Returns a row of usage metrics every 15 seconds, going back 64 minutes
-- The end_time column is UTC time

-- sys.dm_db_resource_stats (Azure SQL Database)
-- https://bit.ly/2HaSpKn
