-- TSQL Library: Error Log Entries
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads with local temporary tables; diagnostic procedure/DBCC calls
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. Uses and drops named local temporary tables; run in a fresh dedicated session. Review diagnostic calls and their additional permissions before execution. May scan large metadata/cache/log sets; evaluate resource cost on a test instance first.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L762-L799
-- Upstream last modified: August 12, 2025; original query 25.
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

-- Read most recent entries from all SQL Server Error Logs (Query 25) (Error Log Entries)
DROP TABLE IF EXISTS #ErrorLogFiles;
	CREATE TABLE #ErrorLogFiles
	([Archive #] INT,[Date] NVARCHAR(25),[Log File Size (Byte)]INT)

INSERT INTO #ErrorLogFiles
([Archive #],[Date],[Log File Size (Byte)])
EXEC master.sys.xp_enumerrorlogs;

DROP TABLE IF EXISTS #SQLErrorLog_AllLogs;
	CREATE TABLE #SQLErrorLog_AllLogs
	(LogDate DATETIME ,ProcessInfo NVARCHAR(12), LogText NVARCHAR(4000))

DECLARE @i INT = 0;
DECLARE @sql NVARCHAR(200) = N'';
DECLARE @logCount INT = (SELECT COUNT(*) FROM #ErrorLogFiles);

WHILE (@i < @logCount)
    BEGIN
        IF(@i in (SELECT [Archive #] FROM #ErrorLogFiles))
            BEGIN
                SET @sql = N'INSERT INTO #SQLErrorLog_AllLogs (LogDate, ProcessInfo, LogText)
                             EXEC master.sys.sp_readerrorlog ' + CAST(@i AS NVARCHAR(2)) + N';'
                EXEC master.sys.sp_executesql @sql;
            END
        SET @i += 1;
    END

SELECT TOP(1000)LogDate, ProcessInfo, LogText
FROM #SQLErrorLog_AllLogs WITH (NOLOCK)
ORDER BY LogDate DESC OPTION (RECOMPILE);

DROP TABLE IF EXISTS #ErrorLogFiles;
DROP TABLE IF EXISTS #SQLErrorLog_AllLogs;
GO
------
