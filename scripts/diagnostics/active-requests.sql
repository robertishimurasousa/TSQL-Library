/*
TSQL Library — Active requests
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: SQL text is optional and may contain personal data or secrets. Percent complete is available only for certain operations.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @IncludeSqlText bit = 0;
SELECT r.session_id,
       DB_NAME(r.database_id) AS database_name,
       s.login_name, s.host_name, s.program_name,
       r.status, r.command, r.start_time,
       r.cpu_time AS cpu_ms,
       r.total_elapsed_time AS elapsed_ms,
       r.logical_reads, r.reads, r.writes,
       r.blocking_session_id, r.wait_type, r.wait_time AS wait_ms,
       r.percent_complete,
       CASE WHEN @IncludeSqlText = 1 THEN txt.text END AS batch_text
FROM sys.dm_exec_requests AS r
JOIN sys.dm_exec_sessions AS s ON s.session_id = r.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) AS txt
WHERE s.is_user_process = 1 AND r.session_id <> @@SPID
ORDER BY r.total_elapsed_time DESC, r.session_id;
