-- TSQL Library: Last VLF Status
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: SQL Server 2022 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2022sql#L1678-L1696
-- Upstream last modified: August 12, 2025; original query 59.
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

-- Status of last VLF for current database  (Query 59) (Last VLF Status)
SELECT TOP(1) DB_NAME(li.database_id) AS [Database Name], li.[file_id],
              li.vlf_size_mb, li.vlf_sequence_number, li.vlf_active, li.vlf_status
FROM sys.dm_db_log_info(DB_ID()) AS li
ORDER BY vlf_sequence_number DESC OPTION (RECOMPILE);
------

-- Determine whether you will be able to shrink the transaction log file

-- vlf_status Values
-- 0 is inactive
-- 1 is initialized but unused
-- 2 is active

-- sys.dm_db_log_info (Transact-SQL)
-- https://bit.ly/2EQUU1v
