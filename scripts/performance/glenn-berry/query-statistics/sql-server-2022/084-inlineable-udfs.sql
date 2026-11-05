-- TSQL Library: Inlineable UDFs
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L2273-L2290
-- Upstream last modified: August 12, 2025; original query 84.
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

-- Determine which scalar UDFs are in-lineable (Query 84) (Inlineable UDFs)
SELECT OBJECT_NAME(m.object_id) AS [Function Name], m.is_inlineable, m.inline_type,
       efs.total_worker_time
FROM sys.sql_modules AS m WITH (NOLOCK)
LEFT OUTER JOIN sys.dm_exec_function_stats AS efs WITH (NOLOCK)
ON  m.object_id = efs.object_id
WHERE efs.type_desc = N'SQL_SCALAR_FUNCTION'
ORDER BY efs.total_worker_time DESC
OPTION (RECOMPILE);
------

-- Scalar UDF Inlining
-- https://bit.ly/2JU971M

-- sys.sql_modules (Transact-SQL)
-- https://bit.ly/2Qt216S
