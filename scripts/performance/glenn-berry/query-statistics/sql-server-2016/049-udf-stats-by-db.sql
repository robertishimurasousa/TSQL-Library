-- TSQL Library: UDF Stats by DB
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2016 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016.sql#L1431-L1446
-- Upstream last modified: August 4, 2025; original query 49.
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

-- Look at UDF execution statistics (Query 49) (UDF Stats by DB)
SELECT TOP (25) DB_NAME(database_id) AS [Database Name],
		   OBJECT_NAME(object_id, database_id) AS [Function Name],
		   total_worker_time, execution_count, total_elapsed_time,
           total_elapsed_time/execution_count AS [avg_elapsed_time],
           last_elapsed_time, last_execution_time, cached_time, [type_desc]
FROM sys.dm_exec_function_stats WITH (NOLOCK)
ORDER BY total_worker_time DESC OPTION (RECOMPILE);
------

-- sys.dm_exec_function_stats (Transact-SQL)
-- https://bit.ly/2q1Q6BM

-- Showplan Enhancements for UDFs
-- https://bit.ly/2LVqiQ1
