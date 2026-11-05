-- TSQL Library: Version Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2005 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2005.sql#L43-L91
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

-- SQL Version information for current instance  (Query 1) (Version Info)
SELECT @@SERVERNAME AS [Server Name], @@VERSION AS [SQL Server and OS Version Info];
------

-- SQL Server 2005 is out of both mainstream and extended support from Microsoft
-- Build 9.0.5266 was the last cumulative update


--   SQL 2005 SP2 Builds             SQL 2005 SP3 Builds            SQL 2005 SP4 Builds
-- Build          Description         Build         Description     Build		   Description
-- 9.0.3042        SP2 RTM			  9.0.4035        SP3 RTM
-- 9.0.3161        SP2 CU1			  9.0.4207        SP3 CU1
-- 9.0.3175        SP2 CU2			  9.0.4211        SP3 CU2
-- 9.0.3186        SP2 CU3			  9.0.4220       SP3 CU3
-- 9.0.3200        SP2 CU4			  9.0.4226        SP3 CU4
-- 9.0.3215        SP2 CU5			  9.0.4230		  SP3 CU5
-- 9.0.3228		   SP2 CU6			  9.0.4266        SP3 CU6
-- 9.0.3239        SP2 CU7			  9.0.4273		  SP3 CU7
-- 9.0.3257        SP2 CU8			  9.0.4285        SP3 CU8
-- 9.0.3282        SP2 CU9			  9.0.4294		  SP3 CU9
-- 9.0.3294		   SP2 CU10			  9.0.4305        SP3 CU10
-- 9.0.3301		   SP2 CU11			  9.0.4309		  SP3 CU11  ---> 9.0.5000		SP4 RTM
-- 9.0.3315        SP2 CU12           9.0.4311        SP3 CU12  ---> 9.0.5254       SP4 CU1		12/22/2010
-- 9.0.3325		   SP2 CU13			  9.0.4315		  SP3 CU13
-- 9.0.3328        SP2 CU14			  9.0.4317		  SP3 CU14	---> 9.0.5259		SP4 CU2		 2/21/2011
-- 9.0.3330        SP2 CU15			  9.0.4325		  SP3 CU15	---> 9.0.5266		SP4 CU3      3/21/2011
-- 9.0.3355        SP2 CU16
-- 9.0.3356		   SP2 CU17



-- The SQL Server 2005 builds that were released after SQL Server 2005 Service Pack 2 was released
-- http://support.microsoft.com/kb/937137

-- The SQL Server 2005 builds that were released after SQL Server 2005 Service Pack 3 was released
-- http://support.microsoft.com/kb/960598

-- The SQL Server 2005 builds that were released after SQL Server 2005 Service Pack 4 was released
-- http://support.microsoft.com/kb/2485757

-- SQL Server 2005 fell out of Mainsteam Support on April 12, 2011
-- This means no more Service Packs or Cumulative Updates
-- SQL Server 2005 ended Extended Support on April 12, 2016

-- SQL Server 2005 Service Pack 4
-- https://www.catalog.update.microsoft.com/search.aspx?q=kb2463332
