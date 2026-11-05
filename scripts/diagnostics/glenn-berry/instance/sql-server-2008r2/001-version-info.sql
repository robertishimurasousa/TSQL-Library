-- TSQL Library: Version Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2008 R2 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008R2.sql#L47-L115
-- Upstream last modified: January 1, 2025; original query 1.
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

-- SQL and OS Version information for current instance  (Query 1) (Version Info)
SELECT SERVERPROPERTY ('MachineName') AS [Server Name], @@VERSION AS [SQL Server and OS Version Info];
------

-- SQL Server 2008 R2 is out of both mainstream and extended support from Microsoft


-- SQL Server 2008 R2 Builds				SQL Server 2008 R2 SP1 Builds			SQL Server 2008 R2 SP2 Builds							SQL Server 2008 R2 SP3 Builds
-- Build			Description				Build		Description					Build		Description									Build		Description
-- 10.50.1092		August 2009 CTP2
-- 10.50.1352		November 2009 CTP3
-- 10.50.1450		Release Candidate
-- 10.50.1600		RTM
-- 10.50.1702		RTM CU1
-- 10.50.1720		RTM CU2
-- 10.50.1734		RTM CU3
-- 10.50.1746		RTM CU4
-- 10.50.1753		RTM CU5
-- 10.50.1765		RTM CU6	 --->			10.50.2500	SP1 RTM
-- 10.50.1777		RTM CU7
-- 10.50.1797		RTM CU8	 --->			10.50.2769  SP1 CU1
-- 10.50.1804       RTM CU9  --->			10.50.2772  SP1 CU2
-- 10.50.1807		RTM CU10 --->           10.50.2789  SP1 CU3
-- 10.50.1809       RTM CU11 --->			10.50.2796  SP1 CU4
-- 10.50.1810		RTM CU12 --->			10.50.2806	SP1 CU5		--->			10.50.4000	SP2 RTM
-- 10.50.1815		RTM CU13 --->           10.50.2811  SP1 CU6
-- 10.50.1817		RTM CU14 --->			10.50.2817  SP1 CU7		--->			10.50.4260	SP2 CU1			         7/24/2012
-- RTM Branch Retired        --->			10.50.2822  SP1 CU8     --->			10.50.4263  SP2 CU2                  8/31/2012
--											10.50.2866  SP1 CU9     --->			10.50.4266  SP2 CU3					10/15/2012
--                                          10.50.2868  SP1 CU10    --->			10.50.4270  SP2 CU4					12/17/2012
--                                          10.50.2869  SP1 CU11    --->            10.50.4276  SP2 CU5				     2/18/2013
--                                          10.50.2874  SP1 CU12    --->            10.50.4279  SP2 CU6                  4/15/2013
--                                          10.50.2876  SP1 CU13    --->            10.50.4286  SP2 CU7					 6/17/2013
--                                          10.50.2881  SP1 CU14    --->            10.50.4290  SP2 CU8                  8/22/2013
--                                                                                  10.50.4295  SP2 CU9                 10/28/2013
--                                                                                  10.50.4297  SP2 CU10                12/16/2013
--                                                                                  10.50.4302  SP2 CU11                 2/17/2014
--                                                                                  10.50.4305	SP2 CU12                 4/21/2014
--                                                                                  10.50.4319  SP2 CU13                 6/30/2014
--																																			10.50.6000	SP3 RTM		9/26/2014
--                                                                                                                                          10.50.6525  SP3 + HF     2/9/2015      http://support.microsoft.com/kb/3033860
-- Security Update for SQL Server 2008 R2 SP3 (KB4057113) https://www.microsoft.com/en-us/download/details.aspx?id=56415					10.50.6560	SP3 + HF	 1/5/2018	   Hot fix for Spectre/Meltdown


-- SQL Server 2008 R2 SP3 RTM plus an on-demand hotfix (Build 10.50.6525) is the final public build of SQL Server 2008 R2, barring any later security fixes.

-- SQL Server 2008 R2 RTM was considered an "unsupported service pack" as of July 12, 2012
-- SQL Server 2008 R2 SP1 was considered an "unsupported service pack" as of August 8, 2013

-- The SQL Server 2008 R2 builds that were released after SQL Server 2008 R2 was released
-- http://support.microsoft.com/kb/981356

-- The SQL Server 2008 R2 builds that were released after SQL Server 2008 R2 Service Pack 1 was released
-- http://support.microsoft.com/kb/2567616

-- The SQL Server 2008 R2 builds that were released after SQL Server 2008 R2 Service Pack 2 was released
-- http://support.microsoft.com/kb/2730301

-- SQL Server 2008 R2 SP2 CU13 is the final cumulative update for SQL Server 2008 R2 SP2

-- SQL Server 2008 R2 SP3 Release information
-- http://support2.microsoft.com/kb/2979597

-- Download SQL Server Management Studio (SSMS)
-- https://msdn.microsoft.com/en-us/library/mt238290.aspx

-- SQL Server 2008 R2 Configuration Manager is SQLServerManager10.msc
