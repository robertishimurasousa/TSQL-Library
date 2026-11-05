-- TSQL Library: Server Resource Stats
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: Azure SQL Managed Instance (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/managed.sql#L199-L226
-- Upstream last modified: February 13, 2025; original query 7.
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

-- Server Resource Statistics (Query 7) (Server Resource Stats)
SELECT TOP(250) resource_type, resource_name, sku AS [Service Tier],
hardware_generation, virtual_core_count, avg_cpu_percent, io_requests,
CONVERT(DECIMAL(18,2), io_bytes_read/1048576.0) AS [MB Read],
CONVERT(DECIMAL(18,2), io_bytes_read * 1./(io_bytes_read + io_bytes_written) * 100.) AS [Read Percentage],
CONVERT(DECIMAL(18,2), io_bytes_written/1048576.0) AS [MB Written],
CONVERT(DECIMAL(18,2), io_bytes_written * 1./(io_bytes_read + io_bytes_written) * 100.) AS [Write Percentage],
CONVERT(DECIMAL(18,2), (io_bytes_read + io_bytes_written)/1048576.0) AS [MB Total IO],
start_time, end_time
FROM master.sys.server_resource_stats WITH (NOLOCK)
WHERE io_bytes_read > 0 AND io_bytes_written > 0
ORDER BY end_time DESC OPTION (RECOMPILE);
------

-- Shows recent resource usage, in 15-second slices

-- sys.server_resource_stats (Azure SQL Database)
-- https://bit.ly/3qUgHiz

-- Overview of Azure SQL Managed Instance resource limits
-- https://bit.ly/3pACjkl

-- SQL Managed Instance Pricing
-- https://bit.ly/2XlEE2u
