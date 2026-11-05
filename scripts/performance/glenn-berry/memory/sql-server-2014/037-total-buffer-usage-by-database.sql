-- TSQL Library: Total Buffer Usage by Database
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2014 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. May scan large metadata/cache/log sets; evaluate resource cost on a test instance first.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2014.sql#L1001-L1025
-- Upstream last modified: August 4, 2025; original query 37.
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

-- Get total buffer usage by database for current instance  (Query 37) (Total Buffer Usage by Database)
-- This may take some time to run on a busy instance with lots of RAM
WITH AggregateBufferPoolUsage
AS
(SELECT DB_NAME(database_id) AS [Database Name],
CAST(COUNT_BIG(*) * 8/1024.0 AS DECIMAL (15,2))  AS [CachedSize]
FROM sys.dm_os_buffer_descriptors WITH (NOLOCK)
WHERE database_id <> 32767 -- ResourceDB
GROUP BY DB_NAME(database_id))
SELECT ROW_NUMBER() OVER(ORDER BY CachedSize DESC) AS [Buffer Pool Rank], [Database Name], CachedSize AS [Cached Size (MB)],
       CAST(CachedSize / SUM(CachedSize) OVER() * 100.0 AS DECIMAL(5,2)) AS [Buffer Pool Percent]
FROM AggregateBufferPoolUsage
ORDER BY [Buffer Pool Rank] OPTION (RECOMPILE);
------

-- Tells you how much memory (in the buffer pool)
-- is being used by each database on the instance

-- sys.dm_os_buffer_descriptors (Transact-SQL)
-- https://bit.ly/36s7aFo


-- Clear Wait Stats with this command
-- DBCC SQLPERF('sys.dm_os_wait_stats', CLEAR);
