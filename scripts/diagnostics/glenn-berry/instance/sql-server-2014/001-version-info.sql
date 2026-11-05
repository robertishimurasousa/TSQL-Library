-- TSQL Library: Version Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2014 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2014.sql#L55-L155
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

-- SQL Server 2014 is out of both mainstream and extended support from Microsoft


-- SQL Server 2014 RTM Branch Builds						SQL Server 2014 SP1 Branch Builds						SQL Server 2014 SP2 Branch Builds					SQL Server 2014 SP23 Branch Builds
-- Build			Description			Release Date		Build			Description		Release Date			Build			Description		Release Date		Build			Description		Release Date
-- 11.0.9120        CTP1				6/2/2013
-- 12.0.1524		CTP2				10/15/2013
-- 12.0.2000        RTM					4/1/2014
-- 12.0.2342        CU1                 4/21/2014
-- 12.0.2370        CU2                 6/27/2014
-- 12.0.2402		CU3					8/18/2014
-- 12.0.2430        CU4					10/21/2014
-- 12.0.2456		CU5					12/17/2014	---->	12.0.4100		SP1 RTM			5/4/2015
-- 12.0.2474		CU5 + COD HF		2/3/2015
-- 12.0.2480		CU6					2/16/2015
-- 12.0.2495        CU7                 4/20/2015
-- 12.0.2546		CU8					6/19/2015			12.0.4416		SP1 CU1			6/19/2015
-- 12.0.2553		CU9					8/17/2015			12.0.4422		SP1 CU2			8/17/2015
-- 12.0.2556		CU10				10/19/2015          12.0.4427		SP1 CU3			10/19/2015
-- 12.0.2560		CU11				12/21/2015			12.0.4436		SP1 CU4			12/21/2015
-- 12.0.2564		CU12				2/22/2016			12.0.4439		SP1 CU5			2/22/2016
-- 12.0.2568		CU13				4/18/2016			12.0.4449		SP1 CU6			4/18/2016 (Deprecated)
--															12.0.4457		SP1 CU6 		5/30/2016 (Re-release)
-- 12.0.2569		CU14				6/20/2016			12.0.4459		SP1 CU7			6/20/2016 ----------->	12.0.5000		SP2 RTM			 7/11/2016
--															12.0.4468		SP1 CU8			8/15/2016				12.0.5511		SP2 CU1			 8/25/2016
--                                                          12.0.4474		SP1 CU9		    10/17/2016				12.0.5522		SP2 CU2			10/17/2016
--															12.0.4487		SP1 CU9 + HF	11/8/2016				12.0.5532		SP2 CU2 + HF     11/8/2016
--                                                          12.0.4491       SP1 CU10		12/28/2016				12.0.5537		SP2 CU3			12/28/2016
--															12.0.4502		SP1 CU11		2/21/2017				12.0.5540		SP2 CU4			 2/21/2017
--															12.0.4511		SP1 CU12        4/17/2017				12.0.5546		SP2 CU5			 4/17/2017
--															12.0.4522		SP1	CU13		7/17/2017				12.0.5552		SP2 CU6			 7/17/2017
--																													12.0.5556		SP2 CU7			 8/28/2017
--																													12.0.5557		SP2 CU8			10/16/2017
--																													12.0.5563		SP2 CU9			12/18/2017
--																													12.0.5571		SP2 CU10		 1/16/2018
--                                                                                                                  12.0.5579		SP2 CU11		 3/19/2018
--																													12.0.5589		SP2 CU12		 6/18/2018
--																													12.0.5590		SP2 CU13		 8/27/2018
--																													12.0.5600		SP2 CU14	    10/15/2018
--																																										12.0.6024	 SP3 RTM					10/30/2018
--																													12.0.5605		SP2 CU15		12/12/2018 ---->	12.0.6205	 SP3 CU1					12/12/2018
--																													12.0.5626		SP2 CU16		 2/19/2019 ---->    12.0.6214	 SP3 CU2					2/19/2019
--																													12.0.5632		SP2 CU17		 4/16/2019 ---->    12.0.6259    SP3 CU3					4/16/2019
--																													12.0.5687		SP2 CU18		 7/29/2019 ---->	12.0.6329	 SP3 CU4					7/29/2019
--																																										12.0.6372.1	 SP3 CU4 + GDR				2/11/2020
--																																										12.0.6433.1	 SP3 CU4 + GDR				1/12/2021
--																																										12.0.6439.10 SP3 CU4 + GDR				6/14/2022
--																																										12.0.6444.4	 SP3 CU4 + GDR				2/14/2023
--                                                                                                                                                                      12.0.6449.1  SP3 CU4 + GDR				10/10/2023


-- KB5021045 - Description of the security update for SQL Server 2014 SP3 CU4: February 14, 2023
-- https://support.microsoft.com/en-us/topic/kb5021045-description-of-the-security-update-for-sql-server-2014-sp3-cu4-february-14-2023-6c769b6c-beb7-4b65-ae22-29f3bbc2dd31

-- KB5014164 - Description of the security update for SQL Server 2014 SP3 CU4: June 14, 2022
-- https://support.microsoft.com/en-us/topic/kb5014164-description-of-the-security-update-for-sql-server-2014-sp3-cu4-june-14-2022-f3400be9-b2d3-4873-ae58-15e6e0cc686e

-- KB4583462 - Description of the security update for SQL Server 2014 SP3 CU4: January 12, 2021
-- https://support.microsoft.com/en-us/help/4583462/kb4583462-security-update-for-sql-server-2014-sp3-cu4

-- Security Update for SQL Server 2016 SP3 CU4   February 11, 2020
-- https://support.microsoft.com/en-us/help/4535288/description-of-the-security-update-for-sql-server-2014-sp3-cu4-feb

-- How to determine the version, edition and update level of SQL Server and its components
-- https://bit.ly/2oAjKgW

-- SQL Server 2014 build versions
-- https://bit.ly/2HpmYOG

-- Recommended updates and configuration options for SQL Server 2012 and SQL Server 2014 used with high-performance workloads
-- https://bit.ly/2Hy3zIZ

-- Performance and Stability Related Fixes in Post-SQL Server 2014 RTM Builds
-- https://bit.ly/2Hx50HU

-- Performance and Stability Related Fixes in Post-SQL Server 2014 SP1 Builds
-- https://bit.ly/2GWLx6a

-- Performance and Stability Related Fixes in Post-SQL Server 2014 SP2 Builds
-- https://bit.ly/2iJ9G4N

-- Performance and Stability Related Fixes in Post-SQL Server 2014 SP3 Builds
-- https://bit.ly/2PRGTWS

-- Update Center for Microsoft SQL Server
-- https://bit.ly/2pZptuQ

-- Download SQL Server Management Studio (SSMS)
-- https://bit.ly/1OcupT9

-- SQL Server 2014 Configuration Manager is SQLServerManager12.msc

-- SQL Server troubleshooting (Microsoft documentation resources)
-- http://bit.ly/2YY0pb1
