-- TSQL Library: Avg-Max Resource Usage
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L449-L461
-- Upstream last modified: January 1, 2025; original query 23.
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

-- Get avg-max resource usage (Query 23) (Avg-Max Resource Usage)
SELECT CAST(AVG(avg_cpu_percent) AS DECIMAL(10,2)) AS [Average CPU Utilization In Percent],
       CAST(MAX(avg_cpu_percent) AS DECIMAL(10,2)) AS [Maximum CPU Utilization In Percent],
       CAST(AVG(avg_data_io_percent) AS DECIMAL(10,2)) AS [Average Data IO In Percent],
       CAST(MAX(avg_data_io_percent) AS DECIMAL(10,2)) AS [Maximum Data IO In Percent],
       CAST(AVG(avg_log_write_percent) AS DECIMAL(10,2)) AS [Average Log Write Utilization In Percent],
       CAST(MAX(avg_log_write_percent) AS DECIMAL(10,2)) AS [Maximum Log Write Utilization In Percent],
       CAST(AVG(avg_memory_usage_percent) AS DECIMAL(10,2)) AS [Average Memory Usage In Percent],
       CAST(MAX(avg_memory_usage_percent) AS DECIMAL(10,2)) AS [Maximum Memory Usage In Percent]
FROM sys.dm_db_resource_stats WITH (NOLOCK) OPTION (RECOMPILE);
------
