/*
TSQL Library — Job completion history
Context: instance with SQL Server Agent
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: SELECT on the queried msdb tables; request specific access from your DBA.
Notes: Duration is calculated numerically, including runs longer than 24 hours. Dates use local times recorded by Agent; error messages are not included.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobhistory-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @JobName sysname = NULL;
SELECT TOP (100) j.name AS job_name,
       h.instance_id,
       h.run_date AS run_date_yyyymmdd,
       h.run_time AS run_time_hhmmss,
       CASE h.run_status WHEN 0 THEN N'Failed' WHEN 1 THEN N'Succeeded'
            WHEN 2 THEN N'Retry' WHEN 3 THEN N'Canceled' WHEN 4 THEN N'In progress'
            ELSE N'Unknown' END AS run_status,
       (h.run_duration / 10000) * 3600
           + ((h.run_duration % 10000) / 100) * 60
           + (h.run_duration % 100) AS duration_seconds
FROM msdb.dbo.sysjobhistory AS h
JOIN msdb.dbo.sysjobs AS j ON j.job_id = h.job_id
WHERE h.step_id = 0
  AND (@JobName IS NULL OR j.name = @JobName)
ORDER BY h.instance_id DESC;
