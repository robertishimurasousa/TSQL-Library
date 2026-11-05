-- TSQL Library: IO Warnings
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2014 (upstream suite; not execution-tested).
-- Mode: metadata reads with local temporary tables; diagnostic procedure/DBCC calls
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. Uses and drops named local temporary tables; run in a fresh dedicated session. Review diagnostic calls and their additional permissions before execution.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2014.sql#L789-L824
-- Upstream last modified: August 4, 2025; original query 30.
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

-- Look for I/O requests taking longer than 15 seconds in the six most recent SQL Server Error Logs (Query 30) (IO Warnings)
CREATE TABLE #IOWarningResults(LogDate datetime, ProcessInfo sysname, LogText nvarchar(1000));

	INSERT INTO #IOWarningResults
	EXEC xp_readerrorlog 0, 1, N'taking longer than 15 seconds';

	INSERT INTO #IOWarningResults
	EXEC xp_readerrorlog 1, 1, N'taking longer than 15 seconds';

	INSERT INTO #IOWarningResults
	EXEC xp_readerrorlog 2, 1, N'taking longer than 15 seconds';

	INSERT INTO #IOWarningResults
	EXEC xp_readerrorlog 3, 1, N'taking longer than 15 seconds';

	INSERT INTO #IOWarningResults
	EXEC xp_readerrorlog 4, 1, N'taking longer than 15 seconds';

	INSERT INTO #IOWarningResults
	EXEC xp_readerrorlog 5, 1, N'taking longer than 15 seconds';

SELECT LogDate, ProcessInfo, LogText
FROM #IOWarningResults
ORDER BY LogDate DESC;

DROP TABLE #IOWarningResults;
------

-- Finding 15 second I/O warnings in the SQL Server Error Log is useful evidence of
-- poor I/O performance (which might have many different causes)
-- Look to see if you see any patterns in the results (same files, same drives, same time of day, etc.)

-- Diagnostics in SQL Server help detect stalled and stuck I/O operations
-- https://bit.ly/2qtaw73
