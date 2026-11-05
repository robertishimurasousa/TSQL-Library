-- TSQL Library: Connection Counts by IP Address
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2019 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2019.sql#L1262-L1279
-- Upstream last modified: August 12, 2025; original query 41.
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

-- Get a count of SQL connections by IP address (Query 41) (Connection Counts by IP Address)
SELECT ec.client_net_address, es.[program_name], es.[host_name], es.login_name,
COUNT(ec.session_id) AS [connection count]
FROM sys.dm_exec_sessions AS es WITH (NOLOCK)
INNER JOIN sys.dm_exec_connections AS ec WITH (NOLOCK)
ON es.session_id = ec.session_id
GROUP BY ec.client_net_address, es.[program_name], es.[host_name], es.login_name
ORDER BY ec.client_net_address, es.[program_name] OPTION (RECOMPILE);
------

-- This helps you figure where your database load is coming from
-- and verifies connectivity from other machines

-- Solving Connectivity errors to SQL Server
-- https://bit.ly/2EgzoD0
