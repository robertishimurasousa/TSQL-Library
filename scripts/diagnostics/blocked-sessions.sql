/*
TSQL Library — Blocked sessions and their blockers
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Includes blockers without an active request. Negative IDs have special meanings and do not represent ordinary logins.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT r.session_id AS blocked_session_id,
       r.blocking_session_id,
       DB_NAME(r.database_id) AS database_name,
       r.status AS request_status,
       r.wait_type,
       r.wait_time AS wait_time_ms,
       r.wait_resource,
       blocked.login_name AS blocked_login,
       blocker.login_name AS blocker_login,
       blocker.status AS blocker_session_status,
       blocker.open_transaction_count AS blocker_open_transactions
FROM sys.dm_exec_requests AS r
LEFT JOIN sys.dm_exec_sessions AS blocked ON blocked.session_id = r.session_id
LEFT JOIN sys.dm_exec_sessions AS blocker ON blocker.session_id = r.blocking_session_id
WHERE r.blocking_session_id <> 0
  AND r.session_id <> @@SPID
ORDER BY r.wait_time DESC, r.session_id;
