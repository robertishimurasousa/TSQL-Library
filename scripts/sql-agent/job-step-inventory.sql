/*
TSQL Library — SQL Agent job and step metadata
Context: msdb
Target platform: SQL Server 2016+; see Validation for the tested build and platform limitations.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Appropriate SQL Agent role and visibility of msdb job metadata.
Notes: Does not run or change jobs. Step commands and output paths are hidden by default and may contain credentials when enabled. Job ownership is not creation authorship.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobsteps-transact-sql
Validation: Synthetic runtime scenarios passed on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @JobName sysname = NULL;
DECLARE @IncludeCommandText bit = 0;
DECLARE @IncludeOutputPaths bit = 0;
SELECT j.name AS job_name, j.enabled AS job_enabled,
       j.date_created, j.date_modified, s.step_id, s.step_name,
       s.subsystem, s.database_name, s.retry_attempts, s.retry_interval,
       s.on_success_action, s.on_fail_action,
       CASE WHEN @IncludeCommandText = 1 THEN s.command END AS optional_command,
       CASE WHEN @IncludeOutputPaths = 1 THEN s.output_file_name END AS optional_output_file
FROM msdb.dbo.sysjobs AS j
LEFT JOIN msdb.dbo.sysjobsteps AS s ON s.job_id = j.job_id
WHERE @JobName IS NULL OR j.name = @JobName
ORDER BY j.name, s.step_id;
