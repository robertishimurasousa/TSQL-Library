-- TSQL Library: Memory Snapshot
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2025 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2025sql#L439-L529
-- Upstream last modified: August 4, 2025; original query 15.
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

-- Consolidated memory information from SQL Server 2025 (Query 15) (Memory Snapshot)
DECLARE @MaxServerMemoryMB AS DECIMAL (15,2);
DECLARE @SQLServerMemoryUsageMB AS BIGINT;
DECLARE @SQLServerLockedPagesAllocationMB AS BIGINT;
DECLARE @TotalPhysicalMemoryMB AS DECIMAL (15,2);
DECLARE @AvailablePhysicalMemoryMB AS BIGINT;
DECLARE @SystemMemoryState AS NVARCHAR(50);
DECLARE @SQLServerStartTime AS DATETIME;
DECLARE @SQLBufferPoolMemoryUsageMB AS DECIMAL (15,2);
DECLARE @SQLSOSNODEMemoryUsageMB AS DECIMAL (15,2);
DECLARE @AvgPageLifeExpectancy int = 0;
DECLARE @LastMemoryHealthSeverityLevel tinyint = 0;
DECLARE @PeakMemoryHealthSeverityLevel tinyint = 0;
DECLARE @AllocationPotentialMemory int = 0;
DECLARE @ReclaimableCacheMemory int = 0;

-- Basic information about OS memory amounts and state
SELECT @TotalPhysicalMemoryMB = total_physical_memory_kb/1024,
		@AvailablePhysicalMemoryMB = available_physical_memory_kb/1024,
		@SystemMemoryState = system_memory_state_desc
FROM sys.dm_os_sys_memory WITH (NOLOCK) OPTION (RECOMPILE);

-- Get instance-level configuration value for instance
SELECT @MaxServerMemoryMB = CONVERT(INT, value)
FROM sys.configurations WITH (NOLOCK)
WHERE [name] = N'max server memory (MB)' OPTION (RECOMPILE);

-- SQL Server Memory Usage and Locked Pages Allocations
SELECT @SQLServerMemoryUsageMB = physical_memory_in_use_kb/1024,
		@SQLServerLockedPagesAllocationMB = locked_page_allocations_kb/1024
FROM sys.dm_os_process_memory WITH (NOLOCK) OPTION (RECOMPILE);

-- SQL Server Start Time
SELECT @SQLServerStartTime = sqlserver_start_time
FROM sys.dm_os_sys_info WITH (NOLOCK) OPTION (RECOMPILE);

-- SQLBUFFERPOOL Memory Clerk Usage
SELECT @SQLBufferPoolMemoryUsageMB =
		CAST((SUM(mc.pages_kb)/1024.0) AS DECIMAL (15,2))
FROM sys.dm_os_memory_clerks AS mc WITH (NOLOCK)
WHERE mc.[type] = N'MEMORYCLERK_SQLBUFFERPOOL'
GROUP BY mc.[type] OPTION (RECOMPILE);

-- MEMORYCLERK_SOSNODE Memory Clerk Usage
SELECT @SQLSOSNODEMemoryUsageMB =
		CAST((SUM(mc.pages_kb)/1024.0) AS DECIMAL (15,2))
FROM sys.dm_os_memory_clerks AS mc WITH (NOLOCK)
WHERE mc.[type] = N'MEMORYCLERK_SOSNODE'
GROUP BY mc.[type] OPTION (RECOMPILE);

-- Most recent and peak sys.dm_os_memory_health_history values
SELECT TOP (1) @LastMemoryHealthSeverityLevel = mh.severity_level,
               @PeakMemoryHealthSeverityLevel = (
                                                SELECT MAX(severity_level)
                                                FROM sys.dm_os_memory_health_history WITH (NOLOCK)
                                                ),
               @AllocationPotentialMemory = mh.allocation_potential_memory_mb,
               @ReclaimableCacheMemory = mh.reclaimable_cache_memory_mb
FROM sys.dm_os_memory_health_history AS mh WITH (NOLOCK)
ORDER BY mh.snapshot_time DESC OPTION (RECOMPILE);

-- Page Life Expectancy (PLE) value for current instance
SET @AvgPageLifeExpectancy = (SELECT AVG(cntr_value) AS [PageLifeExpectancy]
FROM sys.dm_os_performance_counters WITH (NOLOCK)
WHERE [object_name] LIKE N'%Buffer Node%' -- Handles named instances
AND counter_name = N'Page life expectancy');

-- Return final results
SELECT  @@SERVERNAME AS [Server Name], @@VERSION AS [SQL Server and OS Version Info],
		CONVERT(INT, @TotalPhysicalMemoryMB) AS [OS Physical Memory (MB)],
		@SystemMemoryState AS [System Memory State],
		@AvailablePhysicalMemoryMB AS [OS Available Memory (MB)],
		CONVERT(INT, @MaxServerMemoryMB) AS [SQL Server Max Server Memory (MB)],
		CONVERT(DECIMAL(18,2),(@MaxServerMemoryMB/@TotalPhysicalMemoryMB) * 100.0) AS [Max Server Memory %],
		@LastMemoryHealthSeverityLevel AS [Last Internal Memory Health Level],
		@PeakMemoryHealthSeverityLevel AS [Peak Internal Memory Health Level],
		@AllocationPotentialMemory AS [Allocation Potential Memory (MB)],
		@ReclaimableCacheMemory AS [Reclaimable Cache Memory (MB)],
		@SQLServerMemoryUsageMB AS [SQL Server Total Memory Usage (MB)],
		@AvgPageLifeExpectancy AS [Page Life Expectancy (Seconds)],
		@SQLBufferPoolMemoryUsageMB AS [SQL Buffer Pool Memory Usage (MB)],
		@SQLSOSNODEMemoryUsageMB AS [SOSNODE Memory Clerk Memory Usage (MB)],
		@SQLServerLockedPagesAllocationMB AS [SQL Server Locked Pages Allocation (MB)],
		@SQLServerStartTime AS [SQL Server Start Time];
GO
------
-- End of Query 15 ***************************************************


-- You can skip the next two queries if you know you don't have an AG
