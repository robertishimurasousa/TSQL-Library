-- TSQL Library: Process Memory
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2016 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016.sql#L261-L286
-- Upstream last modified: August 4, 2025; original query 6.
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

-- SQL Server Process Address space info  (Query 6) (Process Memory)
-- (shows whether locked pages is enabled, among other things)
SELECT physical_memory_in_use_kb/1024 AS [SQL Server Memory Usage (MB)],
	   locked_page_allocations_kb/1024 AS [SQL Server Locked Pages Allocation (MB)],
       large_page_allocations_kb/1024 AS [SQL Server Large Pages Allocation (MB)],
	   page_fault_count, memory_utilization_percentage, available_commit_limit_kb,
	   process_physical_memory_low, process_virtual_memory_low
FROM sys.dm_os_process_memory WITH (NOLOCK) OPTION (RECOMPILE);
------

-- You want to see 0 for process_physical_memory_low
-- You want to see 0 for process_virtual_memory_low
-- This indicates that you are not under internal memory pressure
-- If locked_page_allocations_kb > 0, then LPIM is enabled

-- sys.dm_os_process_memory (Transact-SQL)
-- https://bit.ly/3iUgQgC

-- How to enable the "locked pages" feature in SQL Server 2012
-- https://bit.ly/2F5UjOA

-- Memory Management Architecture Guide
-- https://bit.ly/2JKkadC
