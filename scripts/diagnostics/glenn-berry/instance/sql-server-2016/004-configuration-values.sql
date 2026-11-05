-- TSQL Library: Configuration Values
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2016 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2016.sql#L188-L222
-- Upstream last modified: August 4, 2025; original query 4.
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

-- Get instance-level configuration values for instance  (Query 4) (Configuration Values)
SELECT name, value, value_in_use, minimum, maximum, [description], is_dynamic, is_advanced
FROM sys.configurations WITH (NOLOCK)
ORDER BY name OPTION (RECOMPILE);
------

-- Focus on these settings:
-- automatic soft-NUMA disabled (should be 0 in most cases)
-- backup checksum default (should be 1)
-- backup compression default (should be 1 in most cases)
-- clr enabled (only enable if it is needed)
-- cost threshold for parallelism (depends on your workload)
-- lightweight pooling (should be zero)
-- max degree of parallelism (depends on your workload and hardware)
-- max server memory (MB) (set to an appropriate value, not the default)
-- optimize for ad hoc workloads (should be 1)
-- priority boost (should be zero)
-- remote admin connections (should be 1)

-- sys.configurations (Transact-SQL)
-- https://bit.ly/2HsyDZI

-- New configuration options for SQL Server 2016
-- allow polybase export (Allow INSERT into a Hadoop external table)
-- automatic soft-NUMA disabled (Automatic soft-NUMA is enabled by default)
-- external scripts enabled (Allows execution of external scripts, for R Services)
-- hadoop connectivity (Configure SQL Server to connect to external Hadoop or Microsoft Azure storage blob data sources through PolyBase)
-- polybase network encryption (Configure SQL Server to encrypt control and data channels when using PolyBase)
-- remote data archive (Allow the use of the REMOTE_DATA_ARCHIVE data access for Stretch databases)

-- SQLSweet16!, Episode 1: Backup Compression for TDE-enabled Databases
-- https://bit.ly/28Rpb2x
