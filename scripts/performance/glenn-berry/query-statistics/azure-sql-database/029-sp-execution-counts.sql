-- TSQL Library: SP Execution Counts
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L645-L667
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

-- Top Cached SPs By Execution Count (Query 29) (SP Execution Counts)
SELECT TOP(100) p.name AS [SP Name], qs.execution_count AS [Execution Count],
ISNULL(qs.execution_count/DATEDIFF(Minute, qs.cached_time, GETDATE()), 0) AS [Calls/Minute],
qs.total_elapsed_time/qs.execution_count AS [Avg Elapsed Time],
qs.total_worker_time/qs.execution_count AS [Avg Worker Time],
qs.total_logical_reads/qs.execution_count AS [Avg Logical Reads],
CASE WHEN CONVERT(nvarchar(max), qp.query_plan) LIKE N'%<MissingIndexes>%' THEN 1 ELSE 0 END AS [Has Missing Index],
FORMAT(qs.last_execution_time, 'yyyy-MM-dd HH:mm:ss', 'en-US') AS [Last Execution Time],
FORMAT(qs.cached_time, 'yyyy-MM-dd HH:mm:ss', 'en-US') AS [Plan Cached Time]
 --,qp.query_plan AS [Query Plan] -- Uncomment if you want the Query Plan
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
WHERE qs.database_id = DB_ID()
AND DATEDIFF(Minute, qs.cached_time, GETDATE()) > 0
ORDER BY qs.execution_count DESC OPTION (RECOMPILE);
------

-- Tells you which cached stored procedures are called the most often
-- This helps you characterize and baseline your workload
