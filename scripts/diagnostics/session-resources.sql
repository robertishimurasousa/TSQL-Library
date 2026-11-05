/*
TSQL Library — Resources by session
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Counters accumulate over the session; memory_usage describes session memory, not total query memory.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT session_id, login_name, host_name, program_name, status,
       login_time, last_request_start_time, last_request_end_time,
       cpu_time AS cpu_ms,
       total_elapsed_time AS elapsed_ms,
       CONVERT(bigint, memory_usage) * 8 AS session_memory_kb,
       logical_reads, reads, writes, open_transaction_count
FROM sys.dm_exec_sessions
WHERE is_user_process = 1 AND session_id <> @@SPID
ORDER BY cpu_time DESC, session_id;
