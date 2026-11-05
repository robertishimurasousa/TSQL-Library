-- TSQL Library: Azure SQL DB Properties
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: target Azure SQL user database
-- Target platform: Azure SQL Database (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/azure.sql#L1227-L1246
-- Upstream last modified: January 1, 2025; original query 56.
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

-- Retrieve some Azure SQL Database properties (Query 56) (Azure SQL DB Properties)
SELECT DATABASEPROPERTYEX (DB_NAME(DB_ID()), 'Edition') AS [Database Edition],
	   DATABASEPROPERTYEX (DB_NAME(DB_ID()), 'ServiceObjective') AS [Service Objective],
	   DATABASEPROPERTYEX (DB_NAME(DB_ID()), 'MaxSizeInBytes') AS [Max Size In Bytes],
	   DATABASEPROPERTYEX (DB_NAME(DB_ID()), 'IsXTPSupported') AS [Is XTP Supported]
	   OPTION (RECOMPILE);
------

-- DATABASEPROPERTYEX (Transact-SQL)
-- https://bit.ly/2ItexPg


-- Microsoft Visual Studio Dev Essentials
-- https://bit.ly/2qjNRxi

-- Microsoft Azure Learn
-- https://bit.ly/2O0Hacc
