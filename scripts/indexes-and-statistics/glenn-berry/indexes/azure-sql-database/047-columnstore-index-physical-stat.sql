-- TSQL Library: Columnstore Index Physical Stat
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L1056-L1074
-- Upstream last modified: January 1, 2025; original query 47.
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

-- Look at Columnstore index physical statistics (Query 47) (Columnstore Index Physical Stat)
SELECT OBJECT_NAME(ps.object_id) AS [TableName],
	i.[name] AS [IndexName], ps.index_id, ps.partition_number,
	ps.delta_store_hobt_id, ps.state_desc, ps.total_rows, ps.size_in_bytes,
	ps.trim_reason_desc, ps.generation, ps.transition_to_compressed_state_desc,
	ps.has_vertipaq_optimization, ps.deleted_rows,
	100 * (ISNULL(ps.deleted_rows, 0))/ps.total_rows AS [Fragmentation]
FROM sys.dm_db_column_store_row_group_physical_stats AS ps WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON ps.object_id = i.object_id
AND ps.index_id = i.index_id
ORDER BY ps.object_id, ps.partition_number, ps.row_group_id OPTION (RECOMPILE);
------

-- sys.dm_db_column_store_row_group_physical_stats (Transact-SQL)
-- https://bit.ly/2q276XQ
