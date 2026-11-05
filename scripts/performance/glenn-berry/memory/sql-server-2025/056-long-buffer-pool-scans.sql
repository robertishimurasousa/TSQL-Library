-- TSQL Library: Long Buffer Pool Scans
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2025 (upstream suite; not execution-tested).
-- Mode: metadata reads; diagnostic procedure/DBCC calls
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. Review diagnostic calls and their additional permissions before execution.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2025sql#L1583-L1594
-- Upstream last modified: August 4, 2025; original query 56.
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

-- Look for long duration buffer pool scans (Query 56) (Long Buffer Pool Scans)
EXEC sys.xp_readerrorlog 0, 1, N'Buffer pool scan took';
------

-- Finds buffer pool scans that took more than 10 seconds in the current SQL Server Error log
-- This should happen much less often in SQL Server 2022

-- Operations that trigger buffer pool scan may run slowly on large-memory computers - SQL Server | Microsoft Docs
-- https://bit.ly/3QrFC81
