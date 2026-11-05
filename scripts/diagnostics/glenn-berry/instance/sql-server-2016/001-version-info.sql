-- TSQL Library: Version Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2016 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016.sql#L55-L134
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

-- SQL Server 2016 is out of mainstream from Microsoft


-- SQL Server 2016 RTM Branch Builds								-- SQL Server 2016 SP1 Branch Builds                     -- SQL Server 2016 SP2 Branch Builds
-- Build			Description			Release Date				Build			Description			Release Date	     Build			Description			Release Date
-- 13.0.200.172		CTP 2.0				5/26/2015
-- 13.0.300.44		CTP 2.1				6/14/2015
-- 13.0.407.1		CTP 2.2				7/28/2015
-- 13.0.500.53		CTP 2.3				9/4/2015
-- 13.0.600.65		CTP 2.4				9/30/2015
-- 13.0.700.242		CTP 3.0				10/29/2015
-- 13.0.900.73		CTP 3.2				12/12/2015
-- 13.0.1000.276	CTP 3.3				1/27/2016
-- 13.0.1100.288	RC0					3/2/2016
-- 13.0.1200.242	RC1					3/18/2016
-- 13.0.1300.275	RC2					3/28/2016
-- 13.0.1400.361	RC3					4/11/2016
-- 13.0.1601.5		RTM					6/1/2016
-- 13.0.1708.0		RTM-GDR				6/12/2016
-- 13.0.2149.0		RTM CU1				7/25/2016
-- 13.0.2164.0		RTM CU2				9/22/2016
-- 13.0.2186.0		RTM CU3				11/16/2016	---->			13.0.4001.0		SP1 RTM				 11/16/2016
-- 13.0.2193.0		RTM CU4				1/18/2017   ---->			13.0.4411.0		SP1 CU1				 1/18/2017
-- 13.0.2197.0		RTM CU5				3/20/2017   ---->			13.0.4422.0		SP1 CU2				 3/20/2017
-- 13.0.2204.0		RTM CU6				5/15/2017   ---->			13.0.4435.0		SP1 CU3				 5/15/2017
-- 13.0.2210.0		RTM CU7				8/8/2017    ---->			13.0.4446.0		SP1 CU4				  8/8/2017
-- 13.0.2213.0		RTM CU8				9/18/2017   ---->           13.0.4451.0		SP1 CU5				 9/18/2017
-- 13.0.2216.0		RTM CU9				11/21/2017  ---->			13.0.4457.0		SP1 CU6				 11/21/2017
--																	13.0.4466.4		SP1 CU7				  1/4/2018
--																	13.0.4474.0		SP1 CU8				  3/20/2018	---->	13.0.5026.0		SP2 RTM				4/24/2018
--                                                                  13.0.4502.0		SP1 CU9				  5/30/2018 ---->   13.0.5149.0		SP2 CU1				5/30/2018
--                                                                  13.0.4514.0     SP1 CU10			  7/16/2018 ---->   13.0.5153.0     SP2 CU2				7/16/2018
--																	13.0.4528.0		SP1 CU11			  9/17/2018	---->	13.0.5216.0		SP2 CU3				9/20/2018
--																	13.0.4541.0		SP1 CU12			 11/13/2018	---->	13.0.5233.0		SP2 CU4			   11/13/2018
--																	13.0.4550.1     SP1 CU13			  1/23/2019 ---->   13.0.5264.1     SP2 CU5				1/23/2019
--																	13.0.4560.0		SP1 CU14			  3/19/2019 ---->	13.0.5292.0		SP2 CU6				3/19/2019
--																	13.0.4574.0		SP1 CU15			  5/16/2019 ---->   13.0.5337.0		SP2 CU7				5/22/2019
--																															13.0.5426.0		SP2 CU8				7/31/2019
--																															13.0.5470.0		SP2 CU9				9/30/2019
--																															13.0.5492.2		SP2 CU10			10/8/2019
--																															13.0.5598.27	SP2 CU11			12/9/2019
--																															13.0.5698.0		SP2 CU12			2/25/2020
--																															13.0.5820.21	SP2 CU13            5/28/2020
--																															13.0.5830.85    SP2 CU14			 8/6/2020
--																															13.0.5850.14	SP2 CU15			9/28/2020

-- How to determine the version, edition and update level of SQL Server and its components
-- https://bit.ly/2oAjKgW

-- How to obtain the latest Service Pack for SQL Server 2016
-- https://bit.ly/2egtfzK

-- SQL Server 2016 build versions
-- https://bit.ly/2epkTDT

-- Recommended updates and configuration options for SQL Server 2017 and 2016 with high-performance workloads
-- https://bit.ly/2JsReue

-- Performance and Stability Related Fixes in Post-SQL Server 2016 SP1 Builds
-- https://bit.ly/2gr7k9L

-- Performance and Stability Related Fixes in Post-SQL Server 2016 SP2 Builds
-- https://bit.ly/2K3LoPf

-- Update Center for Microsoft SQL Server
-- https://bit.ly/2pZptuQ

-- Download SQL Server Management Studio (SSMS)
-- https://bit.ly/1OcupT9

-- SQL Server 2016 Configuration Manager is SQLServerManager13.msc

-- SQL Server troubleshooting (Microsoft documentation resources)
-- http://bit.ly/2YY0pb1
