-- TSQL Library: Query Execution Counts
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2008 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008.sql#L888-L902
-- Upstream last modified: January 1, 2025; original query 38.
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

-- Top cached queries by Execution Count (SQL Server 2008)  (Query 38) (Query Execution Counts)
SELECT TOP (100) qs.execution_count, qs.total_worker_time, qs.total_logical_reads, qs.total_elapsed_time,
SUBSTRING(qt.TEXT,qs.statement_start_offset/2 +1,
(CASE WHEN qs.statement_end_offset = -1
			THEN LEN(CONVERT(NVARCHAR(MAX), qt.TEXT)) * 2
	  ELSE qs.statement_end_offset END - qs.statement_start_offset)/2) AS query_text
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
ORDER BY qs.execution_count DESC OPTION (RECOMPILE);
------


-- Look at non-stored procedure queries
