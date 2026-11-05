-- TSQL Library: VLF Counts
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2005 (upstream suite; not execution-tested).
-- Mode: metadata reads with local temporary tables; diagnostic procedure/DBCC calls
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. Uses and drops named local temporary tables; run in a fresh dedicated session. Review diagnostic calls and their additional permissions before execution. Uses undocumented sp_MSforeachdb and dynamic SQL across databases; names containing quotes can fail. Prefer a newer version-specific VLF query where supported.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2005.sql#L404-L437
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

-- Get VLF Counts for all databases on the instance (Query 17) (VLF Counts)
-- (adapted from Michelle Ufford)
CREATE TABLE #VLFInfo (FileID  int,
					   FileSize bigint, StartOffset bigint,
					   FSeqNo      bigint, [Status]    bigint,
					   Parity      bigint, CreateLSN   numeric(38));

CREATE TABLE #VLFCountResults(DatabaseName sysname, VLFCount int);

EXEC sp_MSforeachdb N'Use [?];

				INSERT INTO #VLFInfo
				EXEC sp_executesql N''DBCC LOGINFO([?])'';

				INSERT INTO #VLFCountResults
				SELECT DB_NAME(), COUNT(*)
				FROM #VLFInfo;

				TRUNCATE TABLE #VLFInfo;'

SELECT DatabaseName, VLFCount
FROM #VLFCountResults
ORDER BY VLFCount DESC;

DROP TABLE #VLFInfo;
DROP TABLE #VLFCountResults;
------

-- High VLF counts can affect write performance
-- and they can make full database restores and crash recovery take much longer
-- Try to keep your VLF counts under 200 in most cases
