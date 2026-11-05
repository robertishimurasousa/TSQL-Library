-- TSQL Library: Page Contention
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L1391-L1413
-- Upstream last modified: August 12, 2025; original query 46.
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

-- Show page level contention (Query 46) (Page Contention)
SELECT er.session_id, er.wait_type, er.wait_resource,
OBJECT_NAME(pinfo.[object_id], pinfo.database_id) AS [object_name],
er.blocking_session_id, er.command,
          SUBSTRING(st.text, (er.statement_start_offset/2)+1,
          ((CASE er.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.text)
              ELSE er.statement_end_offset
              END - er.statement_start_offset)/2) + 1) AS statement_text,
DB_NAME(pinfo.database_id) AS [Database Name],
pinfo.[file_id], pinfo.page_id, pinfo.[object_id], pinfo.index_id, pinfo.page_type_desc
FROM sys.dm_exec_requests AS er WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) AS st
CROSS APPLY sys.fn_PageResCracker(er.page_resource) AS r
CROSS APPLY sys.dm_db_page_info(r.[db_id], r.[file_id], r.page_id, N'DETAILED') AS pinfo
WHERE  er.wait_type LIKE N'%page%' OPTION (RECOMPILE);
------

-- sys.fn_PageResCracker (Transact-SQL)
-- https://bit.ly/3sgwp9B
