-- TSQL Library: Missing Indexes
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2019 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2019.sql#L1910-L1939
-- Upstream last modified: August 12, 2025; original query 70.
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

-- Missing Indexes for current database by Index Advantage  (Query 70) (Missing Indexes)
SELECT CONVERT(decimal(18,2), migs.user_seeks * migs.avg_total_user_cost * (migs.avg_user_impact * 0.01)) AS [Index Advantage],
CONVERT(nvarchar(25), migs.last_user_seek, 20) AS [Last User Seek],
mid.[statement] AS [Database.Schema.Table],
COUNT(1) OVER(PARTITION BY mid.[statement]) AS [missing_indexes_for_table],
COUNT(1) OVER(PARTITION BY mid.[statement], mid.equality_columns) AS [similar_missing_indexes_for_table],
mid.equality_columns, mid.inequality_columns, mid.included_columns, migs.user_seeks,
CONVERT(decimal(18,2), migs.avg_total_user_cost) AS [Avg Total User Cost],
CONVERT(decimal(18,2), migs.avg_user_impact) AS [Avg User Impact],
REPLACE(REPLACE(LEFT(st.[text], 512), CHAR(10),''), CHAR(13),'') AS [Short Query Text],
OBJECT_NAME(mid.[object_id]) AS [Table Name], p.[rows] AS [Table Rows]
FROM sys.dm_db_missing_index_groups AS mig WITH (NOLOCK)
INNER JOIN sys.dm_db_missing_index_group_stats_query AS migs WITH(NOLOCK)
ON mig.index_group_handle = migs.group_handle
CROSS APPLY sys.dm_exec_sql_text(migs.last_sql_handle) AS st
INNER JOIN sys.dm_db_missing_index_details AS mid WITH (NOLOCK)
ON mig.index_handle = mid.index_handle
INNER JOIN sys.partitions AS p WITH (NOLOCK)
ON p.[object_id] = mid.[object_id]
WHERE mid.database_id = DB_ID()
AND p.index_id < 2
ORDER BY [Index Advantage] DESC OPTION (RECOMPILE);
------

-- Look at index advantage, last user seek time, number of user seeks to help determine source and importance
-- SQL Server is overly eager to add included columns, so beware
-- Do not just blindly add indexes that show up from this query!!!
-- Håkan Winther has given me some great suggestions for this query
