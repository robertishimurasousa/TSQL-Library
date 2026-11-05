-- TSQL Library: Ad hoc Queries
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2012 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2012.sql#L1266-L1286
-- Upstream last modified: August 4, 2025; original query 47.
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

-- Find single-use, ad-hoc and prepared queries that are bloating the plan cache  (Query 47) (Ad hoc Queries)
SELECT TOP(50) DB_NAME(t.[dbid]) AS [Database Name], t.[text] AS [Query Text],
cp.objtype AS [Object Type], cp.cacheobjtype AS [Cache Object Type],
cp.size_in_bytes/1024 AS [Plan Size in KB]
FROM sys.dm_exec_cached_plans AS cp WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS t
WHERE cp.cacheobjtype = N'Compiled Plan'
AND cp.objtype IN (N'Adhoc', N'Prepared')
AND cp.usecounts = 1
ORDER BY cp.size_in_bytes DESC, DB_NAME(t.[dbid]) OPTION (RECOMPILE);
------

-- Gives you the text, type and size of single-use ad-hoc and prepared queries that waste space in the plan cache
-- Enabling 'optimize for ad hoc workloads' for the instance can help (SQL Server 2008 and above only)
-- Running DBCC FREESYSTEMCACHE ('SQL Plans') periodically may be required to better control this
-- Enabling forced parameterization for the database can help, but test first!

-- Plan cache, adhoc workloads and clearing the single-use plan cache bloat
-- https://bit.ly/2EfYOkl
