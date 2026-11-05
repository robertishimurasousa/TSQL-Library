-- TSQL Library: Configuration Values
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L182-L217
-- Upstream last modified: August 12, 2025; original query 4.
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
-- backup compression algorithm
-- backup compression default (should be 1 in most cases)
-- clr enabled (only enable if it is needed)
-- cost threshold for parallelism (depends on your workload)
-- lightweight pooling (should be zero)
-- max degree of parallelism (depends on your workload and hardware)
-- max server memory (MB) (set to an appropriate value, not the default)
-- optimize for ad hoc workloads (should be 1)
-- priority boost (should be zero)
-- remote admin connections (should be 1)
-- tempdb metadata memory-optimized (0 by default, some workloads may benefit by enabling)

-- sys.configurations (Transact-SQL)
-- https://bit.ly/2HsyDZI

-- New in SQL Server 2022 *********************************************************************************************************
-- ADR Cleaner Thread Count						Max number of threads ADR cleaner can assign
-- backup compression algorithm					Configure backup compression algorithm
-- Data processed daily limit in TB				SQL On-demand data processed daily limit in TB
-- Data processed monthly limit in TB			SQL On-demand data processed monthly limit in TB
-- Data processed weekly limit in TB			SQL On-demand data processed weekly limit in TB
-- hardware offload config						Offload processing to specialized hardware
-- max RPC request params (KB)					Maximum memory for RPC request parameters (kBytes) (added in CU13)
-- openrowset auto_create_statistics			Enable or disable auto create statistics for openrowset sources.
-- suppress recovery model errors				Return warning instead of error for unsupported ALTER DATABASE SET RECOVERY command
