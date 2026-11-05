/*
TSQL Library — Object events in existing default trace files
Context: master
Target platform: SQL Server 2016+; see Validation for the tested build and platform limitations.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: ALTER TRACE; visibility of sys.traces.
Notes: Legacy trace reader; does not enable tracing. Set a database and start time in server-local time. Rollover retention is limited and timestamps do not identify a person. Identity fields are opt-in; SQL text is never selected.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-functions/sys-fn-trace-gettable-transact-sql
Validation: Synthetic runtime scenarios passed on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @DatabaseName sysname = NULL;
DECLARE @StartTime datetime = NULL;
DECLARE @EndTime datetime = NULL; -- Exclusive upper bound, in server-local time.
DECLARE @IncludeIdentityFields bit = 0;
DECLARE @TracePath nvarchar(260) = (SELECT path FROM sys.traces WHERE is_default = 1);

SELECT CASE WHEN @TracePath IS NULL THEN N'No visible default trace'
            WHEN @DatabaseName IS NULL OR @StartTime IS NULL THEN N'Set DatabaseName and StartTime'
            ELSE N'Ready to read retained trace files' END AS collection_status;

-- Report the available time window; the active file is not a complete archive.
IF @TracePath IS NOT NULL AND @DatabaseName IS NOT NULL AND @StartTime IS NOT NULL
    SELECT MIN(StartTime) AS first_retained_event_time,
           MAX(StartTime) AS last_retained_event_time,
           COUNT_BIG(*) AS retained_event_count
    FROM sys.fn_trace_gettable(@TracePath, DEFAULT);

IF @TracePath IS NOT NULL AND @DatabaseName IS NOT NULL AND @StartTime IS NOT NULL
    SELECT t.StartTime AS event_time, t.EventClass AS event_class,
           CASE t.EventClass WHEN 46 THEN N'CREATE' WHEN 47 THEN N'DROP'
                WHEN 164 THEN N'ALTER' END AS operation,
           CASE t.EventSubClass WHEN 0 THEN N'BEGIN' WHEN 1 THEN N'COMMIT'
                WHEN 2 THEN N'ROLLBACK' ELSE N'UNKNOWN' END AS event_phase,
           t.DatabaseName AS database_name, t.ObjectName AS object_name,
           t.ObjectID AS object_id, t.EventSequence AS event_sequence,
           CASE WHEN @IncludeIdentityFields = 1 THEN t.LoginName END AS optional_execution_login,
           CASE WHEN @IncludeIdentityFields = 1 THEN t.SessionLoginName END AS optional_session_login,
           CASE WHEN @IncludeIdentityFields = 1 THEN t.HostName END AS optional_client_host,
           CASE WHEN @IncludeIdentityFields = 1 THEN t.ApplicationName END AS optional_application
    FROM sys.fn_trace_gettable(@TracePath, DEFAULT) AS t
    WHERE t.DatabaseName = @DatabaseName
      AND t.StartTime >= @StartTime
      AND (@EndTime IS NULL OR t.StartTime < @EndTime)
      AND t.EventClass IN (46, 47, 164)
    ORDER BY t.StartTime, t.EventSequence;
