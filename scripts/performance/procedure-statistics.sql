/*
TSQL Library — Cached procedure statistics
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: One row per cached plan. Restarts, recompilation and cache eviction change the counter window.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-procedure-stats-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT TOP (50) OBJECT_SCHEMA_NAME(p.object_id, p.database_id) AS schema_name,
       OBJECT_NAME(p.object_id, p.database_id) AS procedure_name,
       p.cached_time, p.last_execution_time, p.execution_count,
       CAST(p.total_elapsed_time / 1000.0 / NULLIF(p.execution_count, 0) AS decimal(19,2)) AS avg_elapsed_ms,
       CAST(p.total_worker_time / 1000.0 / NULLIF(p.execution_count, 0) AS decimal(19,2)) AS avg_cpu_ms,
       CAST(p.last_elapsed_time / 1000.0 AS decimal(19,2)) AS last_elapsed_ms,
       p.plan_handle
FROM sys.dm_exec_procedure_stats AS p
WHERE p.database_id = DB_ID()
ORDER BY p.total_worker_time DESC, p.object_id;
