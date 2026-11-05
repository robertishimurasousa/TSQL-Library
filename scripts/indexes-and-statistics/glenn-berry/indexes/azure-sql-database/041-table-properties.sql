-- TSQL Library: Table Properties
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L920-L942
-- Upstream last modified: January 1, 2025; original query 41.
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

-- Get some key table properties (Query 41) (Table Properties)
SELECT OBJECT_NAME(t.[object_id]) AS [ObjectName], p.[rows] AS [Table Rows], p.index_id,
       p.data_compression_desc AS [Index Data Compression],
       t.create_date, t.lock_on_bulk_load, t.is_replicated, t.has_replication_filter,
       t.is_tracked_by_cdc, t.lock_escalation_desc, t.is_filetable,
	   t.is_memory_optimized, t.durability_desc,
	   t.temporal_type_desc, t.is_remote_data_archive_enabled, t.is_external -- new for SQL Server 2016
FROM sys.tables AS t WITH (NOLOCK)
INNER JOIN sys.partitions AS p WITH (NOLOCK)
ON t.[object_id] = p.[object_id]
WHERE OBJECT_NAME(t.[object_id]) NOT LIKE N'sys%'
ORDER BY OBJECT_NAME(t.[object_id]), p.index_id OPTION (RECOMPILE);
------

-- Gives you some good information about your tables
-- is_memory_optimized and durability_desc were new in SQL Server 2014
-- temporal_type_desc, is_remote_data_archive_enabled, is_external are new in SQL Server 2016

-- sys.tables (Transact-SQL)
-- https://bit.ly/2Gk7998
