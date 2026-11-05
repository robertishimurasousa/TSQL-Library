-- TSQL Library: Optimized Locking
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2025 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2025sql#L2303-L2315
-- Upstream last modified: August 4, 2025; original query 88.
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

-- Is Optimized Locking enabled for the current database? (Query 88) (Optimized Locking)
SELECT DATABASEPROPERTYEX(DB_NAME(), 'IsOptimizedLockingOn') AS [Is Optimized Locking On];
------

-- Result		Description
-- 0			Optimized locking is disabled
-- 1			Optimized locking is enabled
-- NULL			Optimized locking is not available

-- Optimized locking
-- https://learn.microsoft.com/en-us/sql/relational-databases/performance/optimized-locking?view=azuresqldb-current
