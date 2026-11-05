-- TSQL Library: Version Store Space Usage
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: Azure SQL Managed Instance (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/managed.sql#L620-L636
-- Upstream last modified: February 13, 2025; original query 22.
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

-- Get tempdb version store space usage by database (Query 22) (Version Store Space Usage)
SELECT DB_NAME(database_id) AS [Database Name],
       reserved_page_count AS [Version Store Reserved Page Count],
	   reserved_space_kb/1024 AS [Version Store Reserved Space (MB)]
FROM sys.dm_tran_version_store_space_usage WITH (NOLOCK)
ORDER BY reserved_space_kb/1024 DESC OPTION (RECOMPILE);
------

-- sys.dm_tran_version_store_space_usage (Transact-SQL)
-- https://bit.ly/2vh3Bmk




-- Clear Wait Stats with this command
-- DBCC SQLPERF('sys.dm_os_wait_stats', CLEAR);
