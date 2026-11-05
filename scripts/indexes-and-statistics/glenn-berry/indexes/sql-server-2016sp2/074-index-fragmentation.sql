-- TSQL Library: Index Fragmentation
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2016 SP2 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. May scan large metadata/cache/log sets; evaluate resource cost on a test instance first.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016SP2.sql#L1970-L1990
-- Upstream last modified: August 12, 2025; original query 74.
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

-- Get fragmentation info for all indexes above a certain size in the current database  (Query 74) (Index Fragmentation)
-- Note: This query could take some time on a very large database
SELECT DB_NAME(ps.database_id) AS [Database Name], SCHEMA_NAME(o.[schema_id]) AS [Schema Name],
OBJECT_NAME(ps.object_id) AS [Object Name], i.[name] AS [Index Name], ps.index_id, ps.index_type_desc,
CAST(ps.avg_fragmentation_in_percent AS DECIMAL (15,3)) AS [Avg Fragmentation in Pct],
ps.fragment_count, ps.page_count, i.fill_factor, i.has_filter, i.filter_definition, i.[allow_page_locks]
FROM sys.dm_db_index_physical_stats(DB_ID(),NULL, NULL, NULL , N'LIMITED') AS ps
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON ps.[object_id] = i.[object_id]
AND ps.index_id = i.index_id
INNER JOIN sys.objects AS o WITH (NOLOCK)
ON i.[object_id] = o.[object_id]
WHERE ps.database_id = DB_ID()
AND ps.page_count > 2500
ORDER BY ps.avg_fragmentation_in_percent DESC OPTION (RECOMPILE);
------

-- Helps determine whether you have framentation in your relational indexes
-- and how effective your index maintenance strategy is
