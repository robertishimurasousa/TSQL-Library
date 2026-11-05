/*
TSQL Library — Cached trigger statistics
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Does not inventory triggers absent from the cache; no trigger is executed.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-trigger-stats-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT TOP (50) t.object_id,
       OBJECT_SCHEMA_NAME(t.object_id, t.database_id) AS schema_name,
       OBJECT_NAME(t.object_id, t.database_id) AS trigger_name,
       t.cached_time, t.last_execution_time, t.execution_count,
       CAST(t.total_elapsed_time / 1000.0 / NULLIF(t.execution_count, 0) AS decimal(19,2)) AS avg_elapsed_ms,
       CAST(t.total_worker_time / 1000.0 / NULLIF(t.execution_count, 0) AS decimal(19,2)) AS avg_cpu_ms,
       t.plan_handle
FROM sys.dm_exec_trigger_stats AS t
WHERE t.database_id = DB_ID()
ORDER BY t.total_worker_time DESC, t.object_id;
