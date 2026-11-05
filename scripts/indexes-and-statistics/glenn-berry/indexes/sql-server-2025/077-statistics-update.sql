-- TSQL Library: Statistics Update
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2025 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2025sql#L2067-L2100
-- Upstream last modified: August 4, 2025; original query 77.
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

-- When were Statistics last updated on all indexes?  (Query 77) (Statistics Update)
SELECT SCHEMA_NAME(o.schema_id) + N'.' + o.[name] AS [Object Name], o.[type_desc] AS [Object Type],
      i.[name] AS [Index Name], STATS_DATE(i.[object_id], i.index_id) AS [Statistics Date],
      s.auto_created, s.no_recompute, s.user_created, s.is_incremental, s.is_temporary,
	  s.has_persisted_sample, sp.persisted_sample_percent,
	  (sp.rows_sampled * 100)/sp.rows AS [Actual Sample Percent], sp.modification_counter,
	  st.row_count, st.used_page_count
FROM sys.objects AS o WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON o.[object_id] = i.[object_id]
INNER JOIN sys.stats AS s WITH (NOLOCK)
ON i.[object_id] = s.[object_id]
AND i.index_id = s.stats_id
INNER JOIN sys.dm_db_partition_stats AS st WITH (NOLOCK)
ON o.[object_id] = st.[object_id]
AND i.[index_id] = st.[index_id]
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
WHERE o.[type] IN ('U', 'V')
AND st.row_count > 0
ORDER BY STATS_DATE(i.[object_id], i.index_id) DESC OPTION (RECOMPILE);
------

-- Helps discover possible problems with out-of-date statistics
-- Also gives you an idea which indexes are the most active

-- sys.stats (Transact-SQL)
-- https://bit.ly/2GyAxrn

-- UPDATEs to Statistics (Erin Stellato)
-- https://bit.ly/2vhrYQy
