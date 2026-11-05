-- TSQL Library: SP Avg Elapsed Time
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2016 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016.sql#L1581-L1604
-- Upstream last modified: August 4, 2025; original query 56.
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

-- Top Cached SPs By Avg Elapsed Time (Query 56) (SP Avg Elapsed Time)
SELECT TOP(25) CONCAT(SCHEMA_NAME(p.schema_id), '.', p.name) AS [SP Name], qs.min_elapsed_time, qs.total_elapsed_time/qs.execution_count AS [avg_elapsed_time],
qs.max_elapsed_time, qs.last_elapsed_time, qs.total_elapsed_time, qs.execution_count,
ISNULL(qs.execution_count/DATEDIFF(Minute, qs.cached_time, GETDATE()), 0) AS [Calls/Minute],
qs.total_worker_time/qs.execution_count AS [AvgWorkerTime],
qs.total_worker_time AS [TotalWorkerTime],
CASE WHEN CONVERT(nvarchar(max), qp.query_plan) COLLATE Latin1_General_BIN2 LIKE N'%<MissingIndexes>%' THEN 1 ELSE 0 END AS [Has Missing Index],
CONVERT(nvarchar(25), qs.last_execution_time, 20) AS [Last Execution Time],
CONVERT(nvarchar(25), qs.cached_time, 20) AS [Plan Cached Time]
-- ,qp.query_plan AS [Query Plan] -- Uncomment if you want the Query Plan
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
WHERE qs.database_id = DB_ID()
AND DATEDIFF(Minute, qs.cached_time, GETDATE()) > 0
ORDER BY avg_elapsed_time DESC OPTION (RECOMPILE);
------

-- This helps you find high average elapsed time cached stored procedures that
-- may be easy to optimize with standard query tuning techniques
