-- TSQL Library: Version Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L55-L121
-- Upstream last modified: August 12, 2025; original query 1.
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

-- SQL Server 2022 will fall out of Mainstream Support on Jan 11, 2028
-- SQL Server 2022 will fall out of Extended Support on Jan 11, 2033

-- SQL Server 2022 Builds
-- Build			Description							Release Date	URL to KB Article
-- 16.0.600.9		CTP 2.0								5/20/2022
-- 16.0.700.4		CTP 2.1								7/27/2022
-- 16.0.900.6		RC0									8/23/2022
-- 16.0.950.9		RC1									9/22/2022
-- 16.0.1000.6		RTM									11/16/2022
-- 16.0.1050.5		RTM GDR								2/14/2023		https://support.microsoft.com/en-us/topic/kb5021522-description-of-the-security-update-for-sql-server-2022-gdr-february-14-2023-7a5a84ed-e99c-4537-b064-fa4499549c8e
-- 16.0.4003.1		CU1									2/16/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate1
-- 16.0.4015.1		CU2									3/15/2023		https://learn.microsoft.com/en-US/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate2
-- 16.0.4025.1		CU3									4/13/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate3
-- 16.0.4035.4		CU4									5/11/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate4
-- 16.0.4045.3		CU5									6/15/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate5
-- 16.0.4055.4		CU6									7/13/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate6
-- 16.0.4065.3		CU7									8/10/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate7
-- 16.0.4075.1		CU8									9/14/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate8
-- 16.0.4080.1		CU8 + GDR							10/10/2023		https://support.microsoft.com/en-us/topic/kb5029503-description-of-the-security-update-for-sql-server-2022-cu8-october-10-2023-c9c267e2-adb6-47f1-b7e9-d99d3c9fb081
-- 16.0.4085.2		CU9									10/12/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate9
-- 16.0.4095.4		CU10								11/16/2023		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate10
-- 16.0.4100.1		CU10 + GDR							 1/9/2024		https://support.microsoft.com/en-us/topic/kb5033592-description-of-the-security-update-for-sql-server-2022-cu10-january-9-2024-0d807f8e-fa6a-4d42-88d3-71b101e71d18
-- 16.0.4105.2		CU11								1/11/2024		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate11
-- 16.0.4115.5		CU12								3/14/2024		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate12
-- 16.0.4120.1		CU12 + GDR							 4/9/2024		https://support.microsoft.com/en-us/topic/kb5036343-description-of-the-security-update-for-sql-server-2022-cu12-april-9-2024-e11a0715-435f-42be-89ff-4b3d8f9734fc
-- 16.0.4125.3		CU13								5/16/2024		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate13
-- 16.0.4131.2		CU13 + GDR							7/9/2024		https://support.microsoft.com/en-us/topic/kb5040939-description-of-the-security-update-for-sql-server-2022-cu13-july-9-2024-16a61a81-926c-46a5-b6c0-edbca541f2f6
-- 16.0.4135.4		CU14								7/23/2024		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate14
-- 16.0.4140.3		CU14 + GDR							9/10/2024		https://support.microsoft.com/en-us/topic/kb5042578-description-of-the-security-update-for-sql-server-2022-cu14-september-10-2024-560e6e4c-1f49-4c18-9eb7-054e9fdee3c7
-- 16.0.4145.4		CU15								9/25/2024		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate15
-- 16.0.4150.1		CU15 + GDR							10/8/2024		https://support.microsoft.com/en-us/topic/kb5046059-description-of-the-security-update-for-sql-server-2022-cu15-october-8-2024-b592d86f-3351-4f9f-9c80-ef495a0137c1
-- 16.0.4155.4		CU15 + GDR							11/12/2024		https://support.microsoft.com/en-us/topic/kb5046862-description-of-the-security-update-for-sql-server-2022-cu15-november-12-2024-ab9f3a55-8264-44e9-9a40-0b32bcd83df0
-- 16.0.4165.4		CU16								11/14/2024		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate16
-- 16.0.4175.1		CU17								1/16/2025		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate17
-- 16.0.4185.3		CU18								3/13/2025		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate18
-- 16.0.4195.2		CU19								5/15/2025		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate19
-- 16.0.4200.1		CU19 + GDR							7/8/2025		https://support.microsoft.com/en-us/topic/kb5058721-description-of-the-security-update-for-sql-server-2022-cu19-july-8-2025-fcf14446-c16b-46b1-a096-f1b775dd45be
-- 16.0.4205.1		CU20								7/10/2025		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate20
-- 16.0.4210.1		CU20 + GDR							8/12/2025		https://support.microsoft.com/en-us/topic/kb5063814-description-of-the-security-update-for-sql-server-2022-cu20-august-12-2025-8744624f-a95c-4902-a191-5a25079d7f37


-- What's new in SQL Server 2022 (16.x)
-- https://bit.ly/3MJEjR1

-- How to determine the version, edition and update level of SQL Server and its components
-- https://bit.ly/2oAjKgW

-- Announcing the Modern Servicing Model for SQL Server
-- https://bit.ly/2KtJ8SS

-- Update Center for Microsoft SQL Server
-- https://bit.ly/2pZptuQ

-- Download SQL Server Management Studio (SSMS)
-- https://bit.ly/1OcupT9

-- SQL Server 2022 Configuration Manager is SQLServerManager16.msc

-- SQL Server troubleshooting (Microsoft documentation resources)
-- http://bit.ly/2YY0pb1
