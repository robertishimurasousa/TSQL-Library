-- TSQL Library: Version Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2008 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008.sql#L44-L117
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
SELECT @@SERVERNAME AS [Server Name], @@VERSION AS [SQL Server and OS Version Info];
------

-- SQL Server 2008 is out of both mainstream and extended support from Microsoft


-- SQL Server 2008 RTM Builds       SQL Server 2008 SP1 Builds       SQL Server 2008 SP2 Builds		      SQL Server 2008 SP3 Builds						SQL Server 2008 SP4 Builds
-- Build           Description      Build          Description		 Build     Description			      Build		    Description							Build		Description
-- 10.0.1600        Gold RTM
-- 10.0.1763        RTM CU1
-- 10.0.1779        RTM CU2
-- 10.0.1787        RTM CU3    -->	10.0.2531		SP1 RTM
-- 10.0.1798        RTM CU4    -->	10.0.2710       SP1 CU1
-- 10.0.1806        RTM CU5    -->	10.0.2714       SP1 CU2
-- 10.0.1812		RTM CU6    -->	10.0.2723       SP1 CU3
-- 10.0.1818        RTM CU7    -->	10.0.2734       SP1 CU4
-- 10.0.1823        RTM CU8    -->	10.0.2746		SP1 CU5
-- 10.0.1828		RTM CU9    -->	10.0.2757		SP1 CU6
-- 10.0.1835	    RTM CU10   -->	10.0.2766		SP1 CU7
-- RTM Branch Retired          -->	10.0.2775		SP1 CU8		-->  10.0.4000	   SP2 RTM
--								    10.0.2789		SP1 CU9
--								    10.0.2799		SP1 CU10
--								    10.0.2804		SP1 CU11	-->  10.0.4266     SP2 CU1
--								    10.0.2808		SP1 CU12	-->  10.0.4272	   SP2 CU2
--								    10.0.2816	    SP1 CU13    -->  10.0.4279     SP2 CU3
--								    10.0.2821		SP1 CU14	-->  10.0.4285	   SP2 CU4	-->				10.0.5500		SP3 RTM
--								    10.0.2847		SP1 CU15	-->  10.0.4316	   SP2 CU5
--								    10.0.2850		SP1 CU16	-->  10.0.4321	   SP2 CU6	-->				10.0.5766		SP3 CU1	      10/17/2011
--                                  SP1 Branch Retired          -->  10.0.4323     SP2 CU7  -->             10.0.5768       SP3 CU2       11/21/2011
--                                                                   10.0.4326	   SP2 CU8  -->             10.0.5770		SP3 CU3       1/16/2012
--														             10.0.4330	   SP2 CU9  -->				10.0.5775		SP3 CU4       3/19/2012
--															         10.0.4332	   SP2 CU10 -->             10.0.5785       SP3 CU5		  5/21/2012
--															         10.0.4333     SP2 CU11 -->			    10.0.5788       SP3 CU6		  7/16/2012
--															         SP2 Branch Retired					    10.0.5794       SP3 CU7		  9/17/2012
--																								            10.0.5828       SP3 CU8		  11/19/2012
--																								            10.0.5829       SP3 CU9       1/21/2013
--																								            10.0.5835       SP3 CU10      3/19/2013
--                                                                                                          10.0.5841       SP3 CU11      5/20/2013
--                                                                                                          10.0.5844       SP3 CU12      7/15/2013
--                                                                                                          10.0.5846       SP3 CU13      9/16/2013
--                                                                                                          10.0.5848       SP3 CU14      11/18/2013
--                                                                                                          10.0.5850		SP3 CU15      1/20/2014
--                                                                                                          10.0.5852       SP3 CU16      3/17/2014
--                                                                                                          10.0.5861       SP3 CU17      5/19/2014
--                                                                                                          10.0.5867       SP3 CU17+					  10.0.6000		SP4 RTM		9/30/2014
--                                                                                                                                                        10.0.6526     SP4 + HF    2/9/2015
-- Security Update for SQL Server 2008 SP4 (KB4057114)  https://www.microsoft.com/en-us/download/details.aspx?id=56418                                    10.0.6556		SP4 + HF	1/5/2018
--
-- SQL Server 2008 RTM is considered an "unsupported service pack" as of April 13, 2010
-- SQL Server 2008 SP1 is considered an "unsupported service pack" as of September 19, 2011
-- SQL Server 2008 SP2 is considered an "unsupported service pack" as of September 17, 2012
-- Any build older than 10.0.5500 is on an "unsupported service pack"

-- SQL Server 2008 fell out of Mainstream Support on July 8, 2014

-- The SQL Server 2008 builds that were released after SQL Server 2008 was released
-- http://support.microsoft.com/kb/956909
--
-- The SQL Server 2008 builds that were released after SQL Server 2008 Service Pack 1 was released
-- http://support.microsoft.com/kb/970365
--
-- The SQL Server 2008 builds that were released after SQL Server 2008 Service Pack 2 was released
-- http://support.microsoft.com/kb/2402659
--
-- The SQL Server 2008 builds that were released after SQL Server 2008 Service Pack 3 was released
-- http://support.microsoft.com/kb/2629969

-- Download SQL Server Management Studio (SSMS)
-- https://msdn.microsoft.com/en-us/library/mt238290.aspx

-- SQL Server 2008 Configuration Manager is SQLServerManager10.msc
