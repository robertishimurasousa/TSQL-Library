-- TSQL Library: Version Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2012 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2012.sql#L55-L161
-- Upstream last modified: August 4, 2025; original query 1.
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
SELECT @@SERVERNAME AS [Server Name], @@VERSION AS [SQL Server and OS Version Info];
------

-- SQL Server 2012 is out of both mainstream and extended support from Microsoft


-- SQL Server 2012 RTM Branch Builds						SQL Server 2012 SP1 Branch Builds					SQL Server 2012 SP2 Branch Builds						SQL Server 2012 SP3 Branch Builds					SQL Server 2012 SP4 Branch Builds
-- Build			Description			Release Date		Build			Description		Release Date		Build			Description		    Release Date        Build			Description		    Release Date	Build			Description		    Release Date
-- 11.0.2100		RTM					  3/6/2012
-- 11.0.2316		RTM CU1				 4/12/2012
-- 11.0.2325        RTM CU2				 6/18/2012 -->		11.0.3000		SP1 RTM			11/7/2012
-- 11.0.2332		RTM CU3				 8/31/2012
-- 11.0.2376	    RTM CU3 + QFE	     10/9/2012
-- 11.0.2383	    RTM CU4			    10/15/2012 -->		11.0.3321		SP1 CU1			11/20/2012
-- 11.0.2395		RTM CU5				12/17/2012 -->      11.0.3339		SP1 CU2			1/21/2013
-- 11.0.2401        RTM CU6              2/18/2013 -->      11.0.3349       SP1 CU3			3/18/2013
-- 11.0.2405        RTM CU7              4/15/2013 -->      11.0 3368       SP1 CU4         5/30/2013
-- 11.0.2410        RTM CU8              6/17/2013 -->      11.0.3373       SP1 CU5         7/15/2013
-- 11.0.2419        RTM CU9              8/20/2013 -->      11.0.3381		SP1 CU6			9/16/2013
-- 11.0.2420        RTM CU10            10/21/2013 -->		11.0.3393       SP1 CU7         11/18/2013
-- 11.0.2424        RTM CU11            12/16/2003 -->      11.0.3401       SP1 CU8         1/20/2014
--                                                          11.0.3412       SP1 CU9         3/17/2014 -->		11.0.5058		SP2 RTM			    6/10/2014
--                                                          11.0.3431       SP1 CU10        5/19/2014
--                                                          11.0.3449       SP1 CU11        7/21/2014 -->		11.0.5532		SP2 CU1			    7/23/2014
--                                                          11.0.3470       SP1 CU12        9/15/2014 -->       11.0.5548       SP2 CU2             9/15/2014
--                                                          11.0.3482		SP1 CU13        11/17/2014-->       11.0.5556		SP2 CU3            11/17/2014
--                                                          11.0.3486       SP1 CU14        1/19/2015 -->       11.0.5569       SP2 CU4             1/19/2015
--                                                                                                              11.0.5571       SP2 CU4 + COD HF     2/4/2015
--                                                          11.0.3487		SP1 CU15		3/16/2015 -->       11.0.5582       SP2 CU5             3/16/2015
--															11.0.3492       SP1 CU16        5/18/2015 -->       11.0.5592		SP2 CU6				5/18/2015
--                                                                                                              11.0.5623       SP2 CU7				7/20/2015
--                                                                                                              11.0.5634		SP2 CU8				9/21/2015
--																												11.0.5641		SP2 CU9			   11/16/2015   ---->  11.0.6020		SP3 RTM			11/21/2015
--																												11.0.5644		SP2 CU10			1/18/2016   ---->  11.0.6518		SP3 CU1			 1/18/2016
--																												11.0.5646		SP2 CU11			3/21/2016	---->  11.0.6523		SP3 CU2			 3/21/2016
--																												11.0.5649		SP2 CU12			5/16/2016	---->  11.0.6537		SP3 CU3			 5/16/2016
--																												11.0.5655		SP2 CU13			7/18/2016	---->  11.0.6540		SP3 CU4			 7/18/2016
--																												11.0.5657		SP2 CU14		    9/19/2016   ---->  11.0.6544		SP3 CU5			 9/20/2016
--																												11.0.5676		SP2 CU15 		   11/16/2016   ---->  11.0.6567		SP3 CU6 		11/16/2016
--																												11.0.5678		SP2 CU16			1/17/2017   ---->  11.0.6579		SP3 CU7			 1/17/2017
--																																									   11.0.6594		SP3 CU8			 3/20/2017
--																																									   11.0.6598		SP3 CU9			 5/15/2017
--																																									   11.0.6607		SP3 CU10		  8/8/2017
--																																																							11.0.7001		SP4 RTM				10/3/2017
--																																																							11.0.7462	    Security Update		1/12/2018  (Security Update for SQL Server 2012 SP4 (KB4057116))
--                                                                                                                                                                                                                          11.0.7493.4		Security Update		2/11/2020  (Security Update for SQL Server 2012 SP4 (KB4532098))
--																																																							11.0.7507.2		Security Update		1/12/2021  (Security Update for SQL Server 2012 SP4 (KB4583465))
--
--
-- KB4583465 - Description of the security update for SQL Server 2012 SP4 GDR: January 12, 2021
-- https://support.microsoft.com/en-us/help/4583465/kb4583465-description-of-the-security-update-for-sql-server-2012-sp4-g

-- Security Update for SQL Server 2012 SP4 (KB4532098)
-- https://support.microsoft.com/en-us/help/4532098/security-update-for-sql-server-2012-sp4-gdr

-- Security Update for SQL Server 2012 SP4 (KB4057116)
-- https://bit.ly/2F33Sc4

-- SQL Server 2012 Service Pack 4 (SP4) Released!
-- https://bit.ly/2qN8kr3

-- How to determine the version, edition and update level of SQL Server and its components
-- https://bit.ly/2oAjKgW

-- SQL Server 2012 SP3 build versions
-- https://bit.ly/2HFjAzA

-- SQL Server 2012 SP2 build versions
-- https://bit.ly/2qLqqcS

-- The SQL Server 2012 builds that were released after SQL Server 2012 Service Pack 1 was released
-- https://bit.ly/2HG21za

-- The SQL Server 2012 builds that were released after SQL Server 2012 was released
-- https://bit.ly/2K1xZnX

-- Where to find information about the latest SQL Server builds
-- https://bit.ly/2IGHbfY

-- Recommended updates and configuration options for SQL Server 2012 and SQL Server 2014 used with high-performance workloads
-- https://bit.ly/2Hy3zIZ

-- Performance and Stability Related Fixes in Post-SQL Server 2012 SP3 Builds
-- https://bit.ly/2woDJ4Z

-- Performance and Stability Related Fixes in Post-SQL Server 2012 SP2 Builds
-- https://bit.ly/2vuKZzp

-- Performance and Stability Related Fixes in Post-SQL Server 2012 SP1 Builds
-- https://bit.ly/2vBt1LC

-- Performance Related Fixes in Post-SQL Server 2012 RTM Builds
-- https://bit.ly/2vuIQn4

-- Update Center for Microsoft SQL Server
-- https://bit.ly/2pZptuQ

-- Download SQL Server Management Studio (SSMS)
-- https://bit.ly/1OcupT9

-- SQL Server 2012 Configuration Manager is SQLServerManager11.msc

-- SQL Server troubleshooting (Microsoft documentation resources)
-- http://bit.ly/2YY0pb1
