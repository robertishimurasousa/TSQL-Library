-- TSQL Library: UDF Statistics
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2025 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2025sql#L2210-L2229
-- Upstream last modified: August 4, 2025; original query 83.
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

-- Look at UDF execution statistics (Query 83) (UDF Statistics)
SELECT OBJECT_NAME(object_id) AS [Function Name], execution_count,
	   total_worker_time, total_worker_time/execution_count AS [avg_worker_time],
	   total_logical_reads, total_physical_reads, total_elapsed_time,
	   total_elapsed_time/execution_count AS [avg_elapsed_time],
	   CONVERT(nvarchar(25), last_execution_time, 20) AS [Last Execution Time],
	   CONVERT(nvarchar(25), cached_time, 20) AS [Plan Cached Time]
FROM sys.dm_exec_function_stats WITH (NOLOCK)
WHERE database_id = DB_ID()
ORDER BY total_worker_time DESC OPTION (RECOMPILE);
------

-- New for SQL Server 2016
-- Helps you investigate scalar UDF performance issues
-- Does not return information for table valued functions

-- sys.dm_exec_function_stats (Transact-SQL)
-- https://bit.ly/2q1Q6BM
