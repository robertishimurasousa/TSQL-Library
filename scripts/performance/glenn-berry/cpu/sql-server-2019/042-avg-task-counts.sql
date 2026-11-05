-- TSQL Library: Avg Task Counts
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2019 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2019.sql#L1280-L1301
-- Upstream last modified: August 12, 2025; original query 42.
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

-- Get Average Task Counts (run multiple times)  (Query 42) (Avg Task Counts)
SELECT AVG(current_tasks_count) AS [Avg Task Count],
AVG(work_queue_count) AS [Avg Work Queue Count],
AVG(runnable_tasks_count) AS [Avg Runnable Task Count],
AVG(pending_disk_io_count) AS [Avg Pending DiskIO Count],
GETDATE() AS [System Time]
FROM sys.dm_os_schedulers WITH (NOLOCK)
WHERE scheduler_id < 255 OPTION (RECOMPILE);
------

-- Sustained values above 10 suggest further investigation in that area
-- High Avg Task Counts are often caused by blocking/deadlocking or other resource contention

-- Sustained values above 1 suggest further investigation in that area
-- High Avg Runnable Task Counts are a good sign of CPU pressure
-- High Avg Pending DiskIO Counts are a sign of disk pressure

-- How to Do Some Very Basic SQL Server Monitoring
-- https://bit.ly/30IRla0
