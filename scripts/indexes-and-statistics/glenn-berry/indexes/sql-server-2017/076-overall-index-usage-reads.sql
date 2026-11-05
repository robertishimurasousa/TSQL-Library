-- TSQL Library: Overall Index Usage - Reads
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2017 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2017.sql#L2016-L2037
-- Upstream last modified: August 12, 2025; original query 76.
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

--- Index Read/Write stats (all tables in current DB) ordered by Reads  (Query 76) (Overall Index Usage - Reads)
SELECT SCHEMA_NAME(t.[schema_id]) AS [SchemaName], OBJECT_NAME(i.[object_id]) AS [ObjectName],
       i.[name] AS [IndexName], i.index_id, i.[type_desc] AS [Index Type],
       s.user_seeks, s.user_scans, s.user_lookups,
	   s.user_seeks + s.user_scans + s.user_lookups AS [Total Reads],
	   s.user_updates AS [Writes],
	   i.fill_factor AS [Fill Factor], i.has_filter, i.filter_definition,
	   s.last_user_scan, s.last_user_lookup, s.last_user_seek, i.[allow_page_locks]
FROM sys.indexes AS i WITH (NOLOCK)
LEFT OUTER JOIN sys.dm_db_index_usage_stats AS s WITH (NOLOCK)
ON i.[object_id] = s.[object_id]
AND i.index_id = s.index_id
AND s.database_id = DB_ID()
LEFT OUTER JOIN sys.tables AS t WITH (NOLOCK)
ON t.[object_id] = i.[object_id]
WHERE OBJECTPROPERTY(i.[object_id],'IsUserTable') = 1
ORDER BY s.user_seeks + s.user_scans + s.user_lookups DESC OPTION (RECOMPILE); -- Order by reads
------

-- Show which indexes in the current database are most active for Reads
