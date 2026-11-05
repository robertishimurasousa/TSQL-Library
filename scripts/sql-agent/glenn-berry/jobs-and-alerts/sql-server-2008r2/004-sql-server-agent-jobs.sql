-- TSQL Library: SQL Server Agent Jobs
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2008 R2 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008R2.sql#L141-L170
-- Upstream last modified: January 1, 2025; original query 4.
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

-- Get SQL Server Agent jobs and Category information (Query 4) (SQL Server Agent Jobs)
SELECT sj.name AS [Job Name], sj.[description] AS [Job Description],
sc.name AS [CategoryName], SUSER_SNAME(sj.owner_sid) AS [Job Owner],
sj.date_created AS [Date Created], sj.[enabled] AS [Job Enabled],
sj.notify_email_operator_id, sj.notify_level_email, h.run_status,
RIGHT(STUFF(STUFF(REPLACE(STR(h.run_duration, 7, 0), ' ', '0'), 4, 0, ':'), 7, 0, ':'),8) AS [Last Duration - HHMMSS],
CONVERT(DATETIME, RTRIM(h.run_date) + ' ' + STUFF(STUFF(REPLACE(STR(RTRIM(h.run_time),6,0),' ','0'),3,0,':'),6,0,':')) AS [Last Start Date]
FROM msdb.dbo.sysjobs AS sj WITH (NOLOCK)
LEFT OUTER JOIN
    (SELECT job_id, instance_id = MAX(instance_id)
     FROM msdb.dbo.sysjobhistory WITH (NOLOCK)
     GROUP BY job_id) AS l
ON sj.job_id = l.job_id
LEFT OUTER JOIN msdb.dbo.syscategories AS sc WITH (NOLOCK)
ON sj.category_id = sc.category_id
LEFT OUTER JOIN msdb.dbo.sysjobhistory AS h WITH (NOLOCK)
ON h.job_id = l.job_id
AND h.instance_id = l.instance_id
ORDER BY CONVERT(INT, h.run_duration) DESC, [Last Start Date] DESC OPTION (RECOMPILE);
------

-- Gives you some basic information about your SQL Server Agent jobs, who owns them and how they are configured
-- Look for Agent jobs that are not owned by sa
-- Look for jobs that have a notify_email_operator_id set to 0 (meaning no operator)
-- Look for jobs that have a notify_level_email set to 0 (meaning no e-mail is ever sent)
--
-- MSDN sysjobs documentation
-- http://msdn.microsoft.com/en-us/library/ms189817.aspx
