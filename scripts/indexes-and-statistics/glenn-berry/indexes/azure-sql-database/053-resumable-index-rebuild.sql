-- TSQL Library: Resumable Index Rebuild
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L1194-L1204
-- Upstream last modified: January 1, 2025; original query 53.
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

-- Get any resumable index rebuild operation information (Query 53) (Resumable Index Rebuild)
SELECT OBJECT_NAME(iro.object_id) AS [Object Name], iro.index_id, iro.name AS [Index Name],
       iro.sql_text, iro.last_max_dop_used, iro.partition_number, iro.state_desc, iro.start_time, iro.percent_complete
FROM  sys.index_resumable_operations AS iro WITH (NOLOCK)
OPTION (RECOMPILE);
------

-- index_resumable_operations (Transact-SQL)
-- https://bit.ly/2pYSWqq
