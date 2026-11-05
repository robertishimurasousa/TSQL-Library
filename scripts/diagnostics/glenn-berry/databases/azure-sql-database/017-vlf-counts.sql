-- TSQL Library: VLF Counts
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L333-L351
-- Upstream last modified: January 1, 2025; original query 17.
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

-- Get VLF Count for current database (Query 17) (VLF Counts)
SELECT [name] AS [Database Name], [VLF Count]
FROM sys.databases AS db WITH (NOLOCK)
CROSS APPLY (SELECT file_id, COUNT(*) AS [VLF Count]
		     FROM sys.dm_db_log_info(db.database_id)
			 GROUP BY file_id) AS li
WHERE [name] <> N'master'
ORDER BY [VLF Count] DESC OPTION (RECOMPILE);
------

-- High VLF counts can affect write performance to the log file
-- and they can make full database restores and crash recovery take much longer
-- Try to keep your VLF counts under 200 in most cases (depending on log file size)

-- Important change to VLF creation algorithm in SQL Server 2014
-- https://bit.ly/2Hsjbg4
