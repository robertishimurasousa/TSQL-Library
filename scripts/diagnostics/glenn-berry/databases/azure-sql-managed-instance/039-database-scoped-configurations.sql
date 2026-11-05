-- TSQL Library: Database-scoped Configurations
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: user database to inspect; select it in the client before execution
-- Target platform: Azure SQL Managed Instance (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/managed.sql#L1055-L1068
-- Upstream last modified: February 13, 2025; original query 39.
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

-- Get database scoped configuration values for current database (Query 39) (Database-scoped Configurations)
SELECT configuration_id, name, [value] AS [value_for_primary]
FROM sys.database_scoped_configurations WITH (NOLOCK) OPTION (RECOMPILE);
------

-- This lets you see the value of these new properties for the current database

-- Clear plan cache for current database
-- ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;

-- ALTER DATABASE SCOPED CONFIGURATION (Transact-SQL)
-- https://bit.ly/2sOH7nb
