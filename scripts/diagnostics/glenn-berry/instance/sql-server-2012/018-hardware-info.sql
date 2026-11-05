-- TSQL Library: Hardware Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2012 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2012.sql#L554-L577
-- Upstream last modified: August 4, 2025; original query 18.
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

-- Hardware information from SQL Server 2012  (Query 18) (Hardware Info)
SELECT cpu_count AS [Logical CPU Count], scheduler_count,
       hyperthread_ratio AS [Hyperthread Ratio],
       cpu_count/hyperthread_ratio AS [Physical CPU Count],
       physical_memory_kb/1024 AS [Physical Memory (MB)],
	   committed_kb/1024 AS [Committed Memory (MB)],
       committed_target_kb/1024 AS [Committed Target Memory (MB)],
       max_workers_count AS [Max Workers Count],
	   affinity_type_desc AS [Affinity Type],
       sqlserver_start_time AS [SQL Server Start Time],
	   DATEDIFF(hour, sqlserver_start_time, GETDATE()) AS [SQL Server Up Time (hrs)],
	   virtual_machine_type_desc AS [Virtual Machine Type]
FROM sys.dm_os_sys_info WITH (NOLOCK) OPTION (RECOMPILE);
------

-- Gives you some good basic hardware information about your database server
-- Cannot distinguish between HT and multi-core
-- Note: virtual_machine_type_desc of HYPERVISOR does not automatically mean you are running SQL Server inside of a VM
-- It merely indicates that you have a hypervisor running on your host

-- sys.dm_os_sys_info (Transact-SQL)
-- https://bit.ly/2pczOYs
