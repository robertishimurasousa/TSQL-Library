-- TSQL Library: CPU Vectorization Level
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads with local temporary tables; diagnostic procedure/DBCC calls
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. Uses and drops named local temporary tables; run in a fresh dedicated session. Review diagnostic calls and their additional permissions before execution.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L669-L719
-- Upstream last modified: August 12, 2025; original query 22.
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

-- Get CPU vectorization level from SQL Server Error log (Query 22) (CPU Vectorization Level)
IF EXISTS (SELECT * WHERE CONVERT(VARCHAR(2), SERVERPROPERTY('ProductMajorVersion')) = '16')
	BEGIN
		-- Get CPU Description from Registry (only works on Windows)
		DROP TABLE IF EXISTS #ProcessorDesc;
			CREATE TABLE #ProcessorDesc
			(RegValue NVARCHAR(50), RegKey NVARCHAR(100));

		INSERT INTO #ProcessorDesc (RegValue, RegKey)
		EXEC sys.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'HARDWARE\DESCRIPTION\System\CentralProcessor\0', N'ProcessorNameString';
		DECLARE @ProcessorDesc NVARCHAR(100) = (SELECT RegKey FROM #ProcessorDesc);

		-- Get CPU Vectorization Level from SQL Server Error Log
		DROP TABLE IF EXISTS #CPUVectorizationLevel;
			CREATE TABLE #CPUVectorizationLevel
			(LogDateTime DATETIME, ProcessInfo NVARCHAR(12), LogText NVARCHAR(200));

		INSERT INTO #CPUVectorizationLevel (LogDateTime, ProcessInfo, LogText)
		EXEC sys.xp_readerrorlog 0, 1, N'CPU vectorization level';
		DECLARE @CPUVectorizationLevel NVARCHAR(200) = (SELECT LogText FROM #CPUVectorizationLevel);

		-- Get TF15097 Status
		DROP TABLE IF EXISTS #TraceFlagStatus;
			CREATE TABLE #TraceFlagStatus
			(TraceFlag smallint, TFStatus tinyint, TFGlobal tinyint, TFSession tinyint);

		INSERT INTO #TraceFlagStatus (TraceFlag, TFStatus, TFGlobal, TFSession)
		EXEC ('DBCC TRACESTATUS (15097, -1) WITH NO_INFOMSGS');
		DECLARE @TraceStatus tinyint = (SELECT TFStatus FROM #TraceFlagStatus);

		-- Return relevant results
		SELECT SERVERPROPERTY('ProductVersion') AS [Product Build], SERVERPROPERTY('Edition') AS [Edition],
		       @ProcessorDesc AS [Processor Description],
		       @CPUVectorizationLevel AS [CPU Vectorization Level], @TraceStatus AS [TF 15097 Status];

		DROP TABLE IF EXISTS #ProcessorDesc;
		DROP TABLE IF EXISTS #CPUVectorizationLevel;
		DROP TABLE IF EXISTS #TraceFlagStatus;
	END
------

-- Note: TF 15097 enables AVX-512 support for SQL Server 2022 (16.x) Preview and later (if your CPU supports it)
-- If you see AVX-512 in the CPU vectorization level results, you should consider enabling TF 15097
-- AVX-512 support only works in Enterprise Edition

-- Here are some CPU families that have good AVX-512 support:
-- Intel Ice Lake and later
-- AMD EYPC Genoa and later
