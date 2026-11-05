-- TSQL Library: Fixed Drives
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L843-L856
-- Upstream last modified: August 12, 2025; original query 29.
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

-- Drive information for all fixed drives visible to the operating system (Query 29) (Fixed Drives)
SELECT fixed_drive_path, drive_type_desc,
CONVERT(DECIMAL(18,2), free_space_in_bytes/1073741824.0) AS [Available Space (GB)]
FROM sys.dm_os_enumerate_fixed_drives WITH (NOLOCK) OPTION (RECOMPILE);
------

-- This shows all of your drives, not just LUNs with SQL Server database files
-- New in SQL Server 2017

-- sys.dm_os_enumerate_fixed_drives (Transact-SQL)
-- https://bit.ly/2EZoHLj
