-- TSQL Library: Version Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2016 SP2 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016SP2.sql#L61-L148
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

-- SQL Server 2016 fell out of Mainstream Support on Jul 13, 2021
-- SQL Server 2016 will fall out of Extended Support on Jul 14, 2026


-- SQL Server 2016 Builds
-- Build			Description					Release Date	URL to KB Article
-- 13.0.5026.0		SP2 RTM						4/24/2018		https://bit.ly/2FEvN2q
-- 13.0.5149.0		SP2 CU1						5/30/2018		https://support.microsoft.com/en-us/help/4135048/cumulative-update-1-for-sql-server-2016-sp2
-- 13.0.5153.0		SP2 CU2						7/16/2018		https://support.microsoft.com/en-us/help/4340355
-- 13.0.5216.0		SP2 CU3						9/20/2018		https://support.microsoft.com/en-us/help/4458871
-- 13.0.5233.0		SP2 CU4						11/13/2018		https://support.microsoft.com/en-us/help/4464106/cumulative-update-4-for-sql-server-2016-sp2
-- 13.0.5264.1		SP2 CU5						1/23/2019	    https://support.microsoft.com/en-us/help/4475776/cumulative-update-5-for-sql-server-2016-sp2
-- 13.0.5292.0		SP2 CU6						3/19/2019		https://support.microsoft.com/en-us/help/4488536/cumulative-update-6-for-sql-server-2016-sp2
-- 13.0.5337.0		SP2 CU7						5/22/2019		https://support.microsoft.com/en-us/help/4495256/cumulative-update-7-for-sql-server-2016-sp2
-- 13.0.5366.0		SP2 CU7 + Security Update	7/9/2019		https://support.microsoft.com/en-us/help/4505222/security-update-for-sql-server-2016-sp2-cu7-gdr-july-9-2019
-- 13.0.5426.0		SP2 CU8						7/31/2019		https://support.microsoft.com/en-us/help/4505830/cumulative-update-8-for-sql-server-2016-sp2
-- 13.0.5470.0		SP2 CU9						9/30/2019		https://support.microsoft.com/en-us/help/4515435/cumulative-update-9-for-sql-server-2016-sp2
-- 13.0.5492.2		SP2 CU10				    10/8/2019		https://support.microsoft.com/en-us/help/4524334/cumulative-update-10-for-sql-server-2016-sp2
-- 13.0.5598.27		SP2 CU11					12/9/2019		https://support.microsoft.com/en-us/help/4527378/cumulative-update-11-for-sql-server-2016-sp2
-- 13.0.5622.0		SP2 CU11 + Security Update	2/11/2010		https://support.microsoft.com/en-us/help/4535706/description-of-the-security-update-for-sql-server-2016-sp2-cu11-februa
-- 13.0.5698.0		SP2 CU12					2/25/2020		https://support.microsoft.com/en-us/help/4536648/cumulative-update-12-for-sql-server-2016-sp2
-- 13.0.5820.21		SP2 CU13					5/38/2020		https://support.microsoft.com/en-us/help/4549825/cumulative-update-13-for-sql-server-2016-sp2
-- 13.0.5830.85     SP2 CU14			         8/6/2020		https://support.microsoft.com/en-us/help/4564903/cumulative-update-14-for-sql-server-2016-sp2
-- 13.0.5850.14		SP2 CU15					9/28/2020		https://support.microsoft.com/en-us/help/4577775/cumulative-update-15-for-sql-server-2016-sp2
-- 13.0.5865.1		SP2 CU15 + Security Update	1/12/2021		https://support.microsoft.com/en-us/help/4583461/kb4583461-security-update-for-sql-server-2016-sp2-cu15
-- 13.0.5882.1		SP2 CU16					2/11/2021		https://support.microsoft.com/en-us/office/kb5000645-cumulative-update-16-for-sql-server-2016-sp2-a3997fa9-ec49-4df0-bcc3-12dd58b78265
-- 13.0.5888.11		SP2 CU17					3/29/2021		https://support.microsoft.com/en-us/topic/kb5001092-cumulative-update-17-for-sql-server-2016-sp2-5876a4d6-59ac-484a-93dc-4be456cd87d1

-- SP3 Builds
-- 13.0.6300.2		SP3 RTM						9/15/2021		https://support.microsoft.com/en-us/topic/kb5003279-sql-server-2016-service-pack-3-release-information-46ab9543-5cf9-464d-bd63-796279591c31
-- 13.0.6404.1		SP3 Hotfix					10/28/2021		https://support.microsoft.com/en-us/topic/kb5006943-on-demand-hotfix-update-package-for-sql-server-2016-sp3-94de2975-cd7d-47ed-b003-5d7daf4e2caf
-- 13.0.6419.1		SP3 + GDR					6/14/2022		https://support.microsoft.com/en-us/topic/kb5014355-description-of-the-security-update-for-sql-server-2016-sp3-gdr-june-14-2022-bb5097a0-f8f1-4d2c-bfe1-af069ca3cc59
-- 13.0.6430.49		SP3 + GDR					3/2/2023		https://support.microsoft.com/en-us/topic/kb5021129-description-of-the-security-update-for-sql-server-2016-sp3-gdr-february-14-2023-1a592815-9dc4-434b-9fb2-119339251317
-- 13.0.6435.1		SP3 + GDR					10/10/2023		https://support.microsoft.com/en-us/topic/kb5029186-description-of-the-security-update-for-sql-server-2016-sp3-gdr-october-10-2023-618b034a-d575-48e0-804a-7b481ba2e600
-- 13.0.6441.1		SP3 + GDR					7/9/2024		https://support.microsoft.com/en-us/topic/kb5040946-description-of-the-security-update-for-sql-server-2016-sp3-gdr-july-9-2024-e943f6a8-7a97-41b4-804c-c52ca775f5dd
-- 13.0.6445.1		SP3 + GDR					9/10/2024		https://support.microsoft.com/en-us/topic/kb5042207-description-of-the-security-update-for-sql-server-2016-sp3-gdr-september-10-2024-e27a41df-009d-4a50-85e7-dc8f06b9a5a5
-- 13.0.6450.1		SP3 + GDR					10/8/2024		https://support.microsoft.com/en-us/topic/kb5046063-description-of-the-security-update-for-sql-server-2016-sp3-gdr-october-8-2024-87f6091b-a0c0-48e7-8de4-b10381559ba7
-- 13.0.6455.2		SP3 + GDR					11/12/2024		https://support.microsoft.com/en-us/topic/kb5046855-description-of-the-security-update-for-sql-server-2016-sp3-gdr-november-12-2024-736b0a32-912d-4ea5-baf8-50d046cbfa1a
-- 13.0.6465.1		SP3 + GDR					8/12/2025		https://support.microsoft.com/en-us/topic/kb5063762-description-of-the-security-update-for-sql-server-2016-sp3-gdr-august-12-2025-c7c25df6-577c-49b3-9ca9-b7e9812b9344



-- Azure Connect Pack Builds
-- 13.0.7000.253	Azure Connect Pack			5/19/2022		https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2016/servicepack3-azureconnect
-- 13.0.7016.1		Azure Connect Pack + GDR	6/14/2022		https://support.microsoft.com/en-us/topic/kb5015371-description-of-the-security-update-for-sql-server-2016-sp3-azure-connect-feature-pack-june-14-2022-d809657e-15a9-48fe-bd19-a8864ac5d3a4
-- 13.0.7024.30		Azure Connect Pack + GDR	2/14/2023		https://support.microsoft.com/en-us/topic/kb5021128-description-of-the-security-update-for-sql-server-2016-sp3-azure-connect-feature-pack-february-14-2023-89e54794-460a-41bd-981f-998290e7d46e
-- 13.0.7029.3		Azure Connect Pack + GDR	10/10/2023		https://support.microsoft.com/en-us/topic/kb5029187-description-of-the-security-update-for-sql-server-2016-sp3-azure-connect-feature-pack-october-10-2023-e5541468-f243-4000-872c-ac782cfad99f
-- 13.0.7037.1		Azure Connect Pack + GDR	7/9/2024		https://support.microsoft.com/en-us/topic/kb5040944-description-of-the-security-update-for-sql-server-2016-sp3-azure-connect-feature-pack-july-9-2024-72b636c9-0619-4c44-b263-f3d7478bcd75
-- 13.0.7040.1		Azure Connect Pack + GDR	9/10/2024		https://support.microsoft.com/en-us/topic/kb5042207-description-of-the-security-update-for-sql-server-2016-sp3-gdr-september-10-2024-e27a41df-009d-4a50-85e7-dc8f06b9a5a5
-- 13.0.7045.2		Azure Connect Pack + GDR	10/8/2024		https://support.microsoft.com/en-us/topic/kb5046062-description-of-the-security-update-for-sql-server-2016-sp3-azure-connect-feature-pack-october-8-2024-fb7d9289-bbef-4d1f-bd71-fb3e036d81ae
-- 13.0.7050.2		Azure Connect Pack + GDR	11/12/2024		https://support.microsoft.com/en-us/topic/kb5046856-description-of-the-security-update-for-sql-server-2016-sp3-azure-connect-feature-pack-november-12-2024-b180cac0-187e-48eb-b6c6-3d48d0a00902
-- 13.0.7060.1		Azure Connect Pack + GDR	8/12/2025		https://support.microsoft.com/en-us/topic/kb5063761-description-of-the-security-update-for-sql-server-2016-sp3-azure-connect-feature-pack-august-12-2025-78088dab-76e7-4a0d-8392-9ebb3f7dfefe


-- How to determine the version, edition and update level of SQL Server and its components
-- https://bit.ly/2oAjKgW

-- How to obtain the latest Service Pack for SQL Server 2016
-- https://bit.ly/2egtfzK

-- SQL Server 2016 build versions
-- https://bit.ly/2epkTDT

-- Recommended updates and configuration options for SQL Server 2017 and 2016 with high-performance workloads
-- https://bit.ly/2JsReue

-- Where to find information about the latest SQL Server builds
-- https://bit.ly/2IGHbfY

-- Performance and Stability Related Fixes in Post-SQL Server 2016 SP2 Builds
-- https://bit.ly/2K3LoPf

-- Update Center for Microsoft SQL Server
-- https://bit.ly/2pZptuQ

-- Download SQL Server Management Studio (SSMS)
-- https://bit.ly/1OcupT9

-- SQL Server 2016 Configuration Manager is SQLServerManager13.msc

-- SQL Server troubleshooting (Microsoft documentation resources)
-- http://bit.ly/2YY0pb1
