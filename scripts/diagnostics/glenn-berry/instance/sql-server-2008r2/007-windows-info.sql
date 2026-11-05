-- TSQL Library: Windows Info
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2008 R2 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008R2.sql#L205-L233
-- Upstream last modified: January 1, 2025; original query 7.
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

-- Windows information (SQL Server 2008 R2 SP1 or greater)  (Query 7) (Windows Info)
SELECT windows_release, windows_service_pack_level,
       windows_sku, os_language_version
FROM sys.dm_os_windows_info WITH (NOLOCK) OPTION (RECOMPILE);
------

-- Gives you major OS version, Service Pack, Edition, and language info for the operating system
-- 6.3 is either Windows 8.1 or Windows Server 2012 R2
-- 6.2 is either Windows 8 or Windows Server 2012
-- 6.1 is either Windows 7 or Windows Server 2008 R2
-- 6.0 is either Windows Vista or Windows Server 2008
-- 5.2 is either Windows XP or Windows Server 2003

-- Windows SKU codes
-- 4 is Enterprise Edition
-- 7 is Standard Server Edition
-- 8 is Datacenter Server Edition
-- 10 is Enterprise Server Edition
-- 48 is Professional Edition

-- 1033 for os_language_version is US-English

-- Hardware and Software Requirements for Installing SQL Server 2008 R2
-- http://msdn.microsoft.com/en-us/library/ms143506(v=sql.105).aspx

-- Using SQL Server in Windows 8, Windows 8.1, Windows Server 2012 and Windows Server 2012 R2 environments
-- http://support.microsoft.com/kb/2681562
