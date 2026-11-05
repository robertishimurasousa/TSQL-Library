-- TSQL Library: SQL Server Services Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L267-L282
-- Upstream last modified: August 12, 2025; original query 7.
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

-- SQL Server Services information (Query 7) (SQL Server Services Info)
SELECT servicename, process_id, startup_type_desc, status_desc,
last_startup_time, service_account, is_clustered, cluster_nodename, [filename],
instant_file_initialization_enabled
FROM sys.dm_server_services WITH (NOLOCK) OPTION (RECOMPILE);
------

-- Tells you the account being used for the SQL Server Service and the SQL Agent Service
-- Shows the process_id, when they were last started, and their current status
-- Also shows whether you are running on a failover cluster instance, and what node you are running on
-- Also shows whether IFI is enabled

-- sys.dm_server_services (Transact-SQL)
-- https://bit.ly/2oKa1Un
