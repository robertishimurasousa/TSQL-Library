-- TSQL Library: Global Trace Flags
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2019 (upstream suite; not execution-tested).
-- Mode: metadata reads; diagnostic procedure/DBCC calls
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. Review diagnostic calls and their additional permissions before execution.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2019.sql#L231-L258
-- Upstream last modified: August 12, 2025; original query 5.
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

-- Returns a list of all global trace flags that are enabled (Query 5) (Global Trace Flags)
DBCC TRACESTATUS (-1);
------

-- If no global trace flags are enabled, no results will be returned.
-- It is very useful to know what global trace flags are currently enabled as part of the diagnostic process.

-- Common trace flags that should be enabled in most cases
-- TF 3226 - Suppresses logging of successful database backup messages to the SQL Server Error Log
--           https://bit.ly/38zDNAK

-- TF 6534 - Enables use of native code to improve performance with spatial data. This is a startup trace flag only
--           https://bit.ly/2HrQUpU

-- TF 7745 - Prevents Query Store data from being written to disk in case of a failover or shutdown command
--           https://bit.ly/2GU69Km

-- TF 8121 - Fixes a system-wide low memory issue that occurs when SQL Server commits memory above the maximum server memory under the memory model with the Lock Pages In Memory (added in CU15)
--           https://learn.microsoft.com/en-US/troubleshoot/sql/releases/sqlserver-2019/cumulativeupdate15#bkmk_14421838




-- DBCC TRACEON - Trace Flags (Transact-SQL)
-- https://bit.ly/2FuSvPg
