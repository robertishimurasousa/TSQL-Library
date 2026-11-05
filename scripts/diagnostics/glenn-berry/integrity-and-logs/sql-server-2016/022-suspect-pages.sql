-- TSQL Library: Suspect Pages
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2016 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016.sql#L677-L704
-- Upstream last modified: August 4, 2025; original query 22.
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

-- Look at Suspect Pages table (Query 22) (Suspect Pages)
SELECT DB_NAME(sp.database_id) AS [Database Name],
       sp.[file_id], sp.page_id, sp.event_type,
	   sp.error_count, sp.last_update_date,
	   mf.name AS [Logical Name], mf.physical_name AS [File Path]
FROM msdb.dbo.suspect_pages AS sp WITH (NOLOCK)
INNER JOIN sys.master_files AS mf WITH (NOLOCK)
ON mf.database_id = sp.database_id
AND mf.file_id = sp.file_id
ORDER BY sp.database_id OPTION (RECOMPILE);
------

-- event_type value descriptions
-- 1 = 823 error caused by an operating system CRC error
--     or 824 error other than a bad checksum or a torn page (for example, a bad page ID)
-- 2 = Bad checksum
-- 3 = Torn page
-- 4 = Restored (The page was restored after it was marked bad)
-- 5 = Repaired (DBCC repaired the page)
-- 7 = Deallocated by DBCC

-- Ideally, this query returns no results. The table is limited to 1000 rows.
-- If you do get results here, you should do further investigation to determine the root cause

-- Manage the suspect_pages Table
-- https://bit.ly/2Fvr1c9
