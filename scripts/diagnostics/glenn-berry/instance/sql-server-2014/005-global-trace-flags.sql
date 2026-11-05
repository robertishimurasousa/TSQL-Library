-- TSQL Library: Global Trace Flags
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2014 (upstream suite; not execution-tested).
-- Mode: metadata reads; diagnostic procedure/DBCC calls
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing. Review diagnostic calls and their additional permissions before execution.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2014.sql#L228-L266
-- Upstream last modified: August 4, 2025; original query 5.
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
-- TF 1117 - When growing a data file, grow all files at the same time so they remain the same size, reducing allocation contention points
--           https://bit.ly/2GY1kOl
--
-- TF 1118 - Helps alleviate allocation contention in tempdb, SQL Server allocates full extents to each database object,
--           thereby eliminating the contention on SGAM pages (more important with older versions of SQL Server)
--           Recommendations to reduce allocation contention in SQL Server tempdb database
--           https://bit.ly/2GY1kOl

-- TF 2371 - Lowers auto update statistics threshold for large tables (on tables with more than 25,000 rows)
--           https://bit.ly/30KO4Hh

-- TF 3226 - Suppresses logging of successful database backup messages to the SQL Server Error Log
--           https://bit.ly/38zDNAK

-- TF 3449 - Enables use of dirty page manager (SQL Server 2014 SP1 CU7 and later)
--			 https://bit.ly/2uj0h5M

-- TF 6533 - Spatial performance improvements in SQL Server 2012 and 2014
--           https://bit.ly/2v7C7ze

-- TF 6534 - Enables use of native code to improve performance with spatial data
--           https://bit.ly/2HrQUpU

-- TF 8079 - Enables automatic soft-NUMA on systems with eight or more physical cores per NUMA node (with SQL Server 2014 SP2)
--           https://bit.ly/29B7oR8

-- DBCC TRACEON - Trace Flags (Transact-SQL)
-- https://bit.ly/2FuSvPg
