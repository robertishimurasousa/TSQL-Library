-- TSQL Library: Accelerator Status
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2025 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2025sql#L274-L290
-- Upstream last modified: August 4, 2025; original query 9.
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

-- Get detailed accelerator status information (Query 9) (Accelerator Status)
SELECT accelerator, accelerator_desc, config, config_in_use , mode, mode_desc,
       mode_reason, mode_reason_desc, accelerator_hardware_detected,
	   accelerator_library_version, accelerator_driver_version
FROM sys.dm_server_accelerator_status WITH (NOLOCK) OPTION (RECOMPILE);
------

-- This shows which accelerators are present and their detailed status information

-- sys.dm_server_accelerator_status (Transact-SQL)
-- https://bit.ly/3B6Fczw

-- How to Enable Intel QAT Backup Compression in SQL Server 2022
-- https://bit.ly/3Cudwpy
