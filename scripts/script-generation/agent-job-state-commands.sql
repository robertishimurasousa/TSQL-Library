/*
TSQL Library — Generate a SQL Agent job state command
Context: msdb on the source instance
Target platform: SQL Server 2016+; see Validation for the tested build and platform limitations.
Mode: generator only; returns command text and never executes it.
Permissions: Visibility of the selected msdb job; generated commands require permission to update the destination job.
Notes: Set one exact job name and desired state. Job must already exist on the destination. Enabling does not enable schedules or check primary-replica ownership; review duplicate execution risk. Names are escaped as Unicode literals.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-update-job-transact-sql
Validation: Synthetic runtime scenarios passed on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @JobName sysname = NULL;
DECLARE @DesiredEnabled bit = 0;
SELECT j.name AS source_job_name, j.enabled AS current_source_state,
       @DesiredEnabled AS desired_destination_state,
       CAST(N'EXEC msdb.dbo.sp_update_job @job_name = N''' AS nvarchar(max))
       + REPLACE(j.name, N'''', N'''''')
       + N''', @enabled = ' + CONVERT(nvarchar(1), @DesiredEnabled) + N';' AS generated_command
FROM msdb.dbo.sysjobs AS j
WHERE @JobName IS NOT NULL AND j.name = @JobName;
