-- TSQL Library: RG Resource Pools
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2016 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016.sql#L878-L893
-- Upstream last modified: August 4, 2025; original query 30.
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

-- Resource Governor Resource Pool information (Query 30) (RG Resource Pools)
SELECT pool_id, [Name], statistics_start_time,
       min_memory_percent, max_memory_percent,
       max_memory_kb/1024 AS [max_memory_mb],
       used_memory_kb/1024 AS [used_memory_mb],
       target_memory_kb/1024 AS [target_memory_mb],
	   min_iops_per_volume, max_iops_per_volume
FROM sys.dm_resource_governor_resource_pools WITH (NOLOCK)
OPTION (RECOMPILE);
------

-- sys.dm_resource_governor_resource_pools (Transact-SQL)
-- https://bit.ly/2MVU0Vy
