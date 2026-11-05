-- TSQL Library: Server Properties
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2016 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016.sql#L148-L187
-- Upstream last modified: August 4, 2025; original query 3.
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

-- Get selected server properties (Query 3) (Server Properties)
SELECT SERVERPROPERTY('MachineName') AS [MachineName],
SERVERPROPERTY('ServerName') AS [ServerName],
SERVERPROPERTY('InstanceName') AS [Instance],
SERVERPROPERTY('IsClustered') AS [IsClustered],
SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS [ComputerNamePhysicalNetBIOS],
SERVERPROPERTY('Edition') AS [Edition],
SERVERPROPERTY('ProductLevel') AS [ProductLevel],				-- What servicing branch (RTM/SP/CU)
SERVERPROPERTY('ProductUpdateLevel') AS [ProductUpdateLevel],	-- Within a servicing branch, what CU# is applied
SERVERPROPERTY('ProductVersion') AS [ProductVersion],
SERVERPROPERTY('ProductMajorVersion') AS [ProductMajorVersion],
SERVERPROPERTY('ProductMinorVersion') AS [ProductMinorVersion],
SERVERPROPERTY('ProductBuild') AS [ProductBuild],
SERVERPROPERTY('ProductBuildType') AS [ProductBuildType],			  -- Is this a GDR or OD hotfix (NULL if on a CU build)
SERVERPROPERTY('ProductUpdateReference') AS [ProductUpdateReference], -- KB article number that is applicable for this build
SERVERPROPERTY('ProcessID') AS [ProcessID],
SERVERPROPERTY('Collation') AS [Collation],
SERVERPROPERTY('IsFullTextInstalled') AS [IsFullTextInstalled],
SERVERPROPERTY('IsIntegratedSecurityOnly') AS [IsIntegratedSecurityOnly],
SERVERPROPERTY('FilestreamConfiguredLevel') AS [FilestreamConfiguredLevel],
SERVERPROPERTY('IsHadrEnabled') AS [IsHadrEnabled],
SERVERPROPERTY('HadrManagerStatus') AS [HadrManagerStatus],
SERVERPROPERTY('InstanceDefaultDataPath') AS [InstanceDefaultDataPath],
SERVERPROPERTY('InstanceDefaultLogPath') AS [InstanceDefaultLogPath],
SERVERPROPERTY('ErrorLogFileName') AS [ErrorLogFileName],
SERVERPROPERTY('BuildClrVersion') AS [Build CLR Version],
SERVERPROPERTY('IsXTPSupported') AS [IsXTPSupported],
SERVERPROPERTY('IsPolybaseInstalled') AS [IsPolybaseInstalled],				-- New for SQL Server 2016
SERVERPROPERTY('IsAdvancedAnalyticsInstalled') AS [IsRServicesInstalled];	-- New for SQL Server 2016
------

-- This gives you a lot of useful information about your instance of SQL Server,
-- such as the ProcessID for SQL Server and your collation
-- Note: Some columns will be NULL on older SQL Server builds

-- SERVERPROPERTY (Transact-SQL)
-- https://bit.ly/2eeaXeI
