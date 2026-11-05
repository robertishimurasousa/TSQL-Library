-- TSQL Library: SP Avg Elapsed Time
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2005 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2005.sql#L797-L813
-- Upstream last modified: January 1, 2025; original query 34.
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

-- Top Cached SPs By Avg Elapsed Time (SQL 2005)  (Query 34) (SP Avg Elapsed Time)
SELECT TOP(25) OBJECT_NAME(objectid, dbid) AS [SP Name], qt.[text] AS [SP Text],
ISNULL(qs.total_elapsed_time/qs.execution_count, 0) AS [AvgElapsedTime],
qs.execution_count AS [Execution Count], qs.total_worker_time AS [TotalWorkerTime],
qs.total_worker_time/qs.execution_count AS [AvgWorkerTime],
ISNULL(qs.execution_count/DATEDIFF(Minute, qs.creation_time, GETDATE()), 0) AS [Calls/Minute],
qs.max_logical_reads, qs.max_logical_writes,
DATEDIFF(Minute, qs.creation_time, GETDATE()) AS [Age in Cache]
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(qs.[sql_handle]) AS qt
WHERE qt.[dbid] = DB_ID()
ORDER BY qs.total_elapsed_time/qs.execution_count DESC OPTION (RECOMPILE);
------

-- This helps you find long-running cached stored procedures that
-- may be easy to optimize with standard query tuning techniques
