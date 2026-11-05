-- TSQL Library: SQL Server Agent Alerts
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2008 R2 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008R2.sql#L171-L181
-- Upstream last modified: January 1, 2025; original query 5.
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

-- Get SQL Server Agent Alert Information (Query 5) (SQL Server Agent Alerts)
SELECT name, event_source, message_id, severity, [enabled], has_notification,
       delay_between_responses, occurrence_count, last_occurrence_date, last_occurrence_time
FROM msdb.dbo.sysalerts WITH (NOLOCK)
ORDER BY name OPTION (RECOMPILE);
------

-- Gives you some basic information about your SQL Server Agent Alerts (which are different from SQL Server Agent jobs)
-- Read more about Agent Alerts here: https://bit.ly/2v5YR37
