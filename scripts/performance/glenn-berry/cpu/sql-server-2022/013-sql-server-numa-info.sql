-- TSQL Library: SQL Server NUMA Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L438-L464
-- Upstream last modified: August 12, 2025; original query 13.
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

-- SQL Server NUMA Node information  (Query 13) (SQL Server NUMA Info)
SELECT osn.node_id, osn.node_state_desc, osn.memory_node_id, osn.processor_group, osn.cpu_count, osn.online_scheduler_count,
       osn.idle_scheduler_count, osn.active_worker_count,
	   osmn.pages_kb/1024 AS [Committed Memory (MB)],
	   osmn.locked_page_allocations_kb/1024 AS [Locked Physical (MB)],
	   CONVERT(DECIMAL(18,2), osmn.foreign_committed_kb/1024.0) AS [Foreign Commited (MB)],
	   osmn.target_kb/1024 AS [Target Memory Goal (MB)],
	   osn.avg_load_balance, osn.resource_monitor_state
FROM sys.dm_os_nodes AS osn WITH (NOLOCK)
INNER JOIN sys.dm_os_memory_nodes AS osmn WITH (NOLOCK)
ON osn.memory_node_id = osmn.memory_node_id
WHERE osn.node_state_desc <> N'ONLINE DAC' OPTION (RECOMPILE);
------

-- Gives you some useful information about the composition and relative load on your NUMA nodes
-- You want to see an equal number of schedulers on each NUMA node
-- Watch out if SQL Server 2022 Standard Edition has been installed
-- on a physical or virtual machine with more than four sockets or more than 24 physical cores

-- sys.dm_os_nodes (Transact-SQL)
-- https://bit.ly/2pn5Mw8

-- How to Balance SQL Server Core Licenses Across NUMA Nodes
-- https://bit.ly/3i4TyVR
