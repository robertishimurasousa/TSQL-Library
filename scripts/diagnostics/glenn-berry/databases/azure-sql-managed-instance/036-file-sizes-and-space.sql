-- TSQL Library: File Sizes and Space
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: Azure SQL Managed Instance (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/managed.sql#L995-L1016
-- Upstream last modified: February 13, 2025; original query 36.
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

-- Individual File Sizes and space available for current database  (Query 36) (File Sizes and Space)
SELECT f.name AS [File Name] , f.physical_name AS [Physical Name],
CAST((f.size/128.0) AS DECIMAL(15,2)) AS [Total Size in MB],
CAST(f.size/128.0 - CAST(FILEPROPERTY(f.name, 'SpaceUsed') AS int)/128.0 AS DECIMAL(15,2))
AS [Available Space In MB], f.[file_id], fg.name AS [Filegroup Name],
f.is_percent_growth, f.growth, fg.is_default, fg.is_read_only,
fg.is_autogrow_all_files
FROM sys.database_files AS f WITH (NOLOCK)
LEFT OUTER JOIN sys.filegroups AS fg WITH (NOLOCK)
ON f.data_space_id = fg.data_space_id
ORDER BY f.[file_id] OPTION (RECOMPILE);
------

-- Look at how large and how full the files are and where they are located
-- Make sure the transaction log is not full!!

-- is_autogrow_all_files was new for SQL Server 2016. Equivalent to TF 1117 for user databases

-- SQL Server 2016: Changes in default behavior for autogrow and allocations for tempdb and user databases
-- https://bit.ly/2evRZSR
