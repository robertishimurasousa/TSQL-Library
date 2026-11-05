-- TSQL Library: High Aggregate Duration Queries
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L1132-L1174
-- Upstream last modified: January 1, 2025; original query 51.
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

-- Get highest aggregate duration queries over last hour (Query 51) (High Aggregate Duration Queries)
WITH AggregatedDurationLastHour
AS
(SELECT q.query_id, SUM(count_executions * avg_duration) AS total_duration,
   COUNT (distinct p.plan_id) AS number_of_plans
   FROM sys.query_store_query_text AS qt WITH (NOLOCK)
   INNER JOIN sys.query_store_query AS q WITH (NOLOCK)
   ON qt.query_text_id = q.query_text_id
   INNER JOIN sys.query_store_plan AS p WITH (NOLOCK)
   ON q.query_id = p.query_id
   INNER JOIN sys.query_store_runtime_stats AS rs WITH (NOLOCK)
   ON rs.plan_id = p.plan_id
   INNER JOIN sys.query_store_runtime_stats_interval AS rsi WITH (NOLOCK)
   ON rsi.runtime_stats_interval_id = rs.runtime_stats_interval_id
   WHERE rsi.start_time >= DATEADD(hour, -1, GETUTCDATE())
   AND rs.execution_type_desc = N'Regular'
   GROUP BY q.query_id),
OrderedDuration AS
(SELECT query_id, total_duration, number_of_plans,
 ROW_NUMBER () OVER (ORDER BY total_duration DESC, query_id) AS RN
 FROM AggregatedDurationLastHour)
SELECT OBJECT_NAME(q.object_id) AS [Containing Object], qt.query_sql_text,
od.total_duration AS [Total Duration (microsecs)],
od.number_of_plans AS [Plan Count],
p.is_forced_plan, p.is_parallel_plan, p.is_trivial_plan,
q.query_parameterization_type_desc, p.[compatibility_level],
p.last_compile_start_time, q.last_execution_time,
CONVERT(xml, p.query_plan) AS query_plan_xml
FROM OrderedDuration AS od
INNER JOIN sys.query_store_query AS q WITH (NOLOCK)
ON q.query_id  = od.query_id
INNER JOIN sys.query_store_query_text AS qt WITH (NOLOCK)
ON q.query_text_id = qt.query_text_id
INNER JOIN sys.query_store_plan AS p WITH (NOLOCK)
ON q.query_id = p.query_id
WHERE od.RN <= 50
ORDER BY total_duration DESC OPTION (RECOMPILE);
------

-- New for SQL Server 2016
-- Requires that QueryStore is enabled for this database
