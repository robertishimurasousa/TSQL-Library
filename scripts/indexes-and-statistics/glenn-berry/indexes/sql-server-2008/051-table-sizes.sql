-- TSQL Library: Table Sizes
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2008 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008.sql#L1126-L1149
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

-- Get Table names, row counts, and compression status for clustered index or heap  (Query 51) (Table Sizes)
SELECT SCHEMA_NAME(o.Schema_ID) AS [Schema Name], OBJECT_NAME(p.object_id) AS [ObjectName],
SUM(p.Rows) AS [RowCount], data_compression_desc AS [CompressionType]
FROM sys.partitions AS p WITH (NOLOCK)
INNER JOIN sys.objects AS o WITH (NOLOCK)
ON p.object_id = o.object_id
WHERE index_id < 2 --ignore the partitions from the non-clustered index if any
AND OBJECT_NAME(p.object_id) NOT LIKE N'sys%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'spt_%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'queue_%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'filestream_tombstone%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'fulltext%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'ifts_comp_fragment%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'filetable_updates%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'xml_index_nodes%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'sqlagent_job%'
AND OBJECT_NAME(p.object_id) NOT LIKE N'plan_persist%'
GROUP BY  SCHEMA_NAME(o.Schema_ID), p.object_id, data_compression_desc
ORDER BY SUM(p.Rows) DESC OPTION (RECOMPILE);
------

-- Gives you an idea of table sizes, and possible data compression opportunities
