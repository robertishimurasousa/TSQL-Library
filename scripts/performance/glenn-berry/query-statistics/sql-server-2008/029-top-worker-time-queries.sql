-- TSQL Library: Top Worker Time Queries
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2008 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008.sql#L731-L750
-- Upstream last modified: January 1, 2025; original query 29.
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

-- Get top total worker time queries for entire instance (Query 29) (Top Worker Time Queries)
SELECT TOP(50) DB_NAME(t.[dbid]) AS [Database Name], t.[text] AS [Query Text],
qs.total_worker_time AS [Total Worker Time], qs.min_worker_time AS [Min Worker Time],
qs.total_worker_time/qs.execution_count AS [Avg Worker Time],
qs.max_worker_time AS [Max Worker Time], qs.execution_count AS [Execution Count],
qs.total_elapsed_time/qs.execution_count AS [Avg Elapsed Time],
qs.total_logical_reads/qs.execution_count AS [Avg Logical Reads],
qs.total_physical_reads/qs.execution_count AS [Avg Physical Reads], qs.creation_time AS [Creation Time]
, qp.query_plan AS [Query Plan] -- comment out this column if copying results to Excel
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS t
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
ORDER BY qs.total_worker_time DESC OPTION (RECOMPILE);
------


-- Helps you find the most expensive queries from a CPU perspective across the entire instance
