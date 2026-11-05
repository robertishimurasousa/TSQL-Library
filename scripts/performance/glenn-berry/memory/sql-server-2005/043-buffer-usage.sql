-- TSQL Library: Buffer Usage
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2005 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. May scan large metadata/cache/log sets; evaluate resource cost on a test instance first.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2005.sql#L973-L990
-- Upstream last modified: January 1, 2025; original query 43.
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

-- Breaks down buffers used by current database by object (table, index) in the buffer cache  (Query 43) (Buffer Usage)
-- Note: This query could take some time on a busy instance
SELECT OBJECT_NAME(p.[object_id]) AS [ObjectName],
p.index_id, COUNT(*)/128 AS [buffer size(MB)],  COUNT(*) AS [buffer_count]
FROM sys.allocation_units AS a
INNER JOIN sys.dm_os_buffer_descriptors AS b WITH (NOLOCK)
ON a.allocation_unit_id = b.allocation_unit_id
INNER JOIN sys.partitions AS p WITH (NOLOCK)
ON a.container_id = p.hobt_id
WHERE b.database_id = DB_ID()
AND p.[object_id] > 100
GROUP BY p.[object_id], p.index_id
ORDER BY buffer_count DESC OPTION (RECOMPILE);
------

-- Tells you what tables and indexes are using the most memory in the buffer cache
