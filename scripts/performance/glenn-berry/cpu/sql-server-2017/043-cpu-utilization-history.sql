-- TSQL Library: CPU Utilization History
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2017 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2017.sql#L1276-L1300
-- Upstream last modified: August 12, 2025; original query 43.
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

-- Get CPU Utilization History for last 256 minutes (in one minute intervals)  (Query 43) (CPU Utilization History)
DECLARE @ts_now bigint = (SELECT ms_ticks FROM sys.dm_os_sys_info WITH (NOLOCK));

SELECT TOP(256) SQLProcessUtilization AS [SQL Server Process CPU Utilization],
               SystemIdle AS [System Idle Process],
               100 - SystemIdle - SQLProcessUtilization AS [Other Process CPU Utilization],
               DATEADD(ms, -1 * (@ts_now - [timestamp]), GETDATE()) AS [Event Time]
FROM (SELECT record.value('(./Record/@id)[1]', 'int') AS record_id,
              record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int')
                      AS [SystemIdle],
              record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int')
                      AS [SQLProcessUtilization], [timestamp]
         FROM (SELECT [timestamp], CONVERT(xml, record) AS [record]
                      FROM sys.dm_os_ring_buffers WITH (NOLOCK)
                      WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
                      AND record LIKE N'%<SystemHealth>%') AS x) AS y
ORDER BY record_id DESC OPTION (RECOMPILE);
------

-- Look at the trend over the entire period
-- Also look at high sustained 'Other Process' CPU Utilization values
-- Note: This query sometimes gives inaccurate results (negative values)
-- on high core count (> 64 cores) systems
