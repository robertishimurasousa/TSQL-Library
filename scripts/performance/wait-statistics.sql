/*
TSQL Library — Cumulative instance wait statistics
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Does not clear counters or exclude categories heuristically. Background waits may dominate the ranking.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT TOP (50) wait_type, waiting_tasks_count, wait_time_ms, signal_wait_time_ms,
       wait_time_ms - signal_wait_time_ms AS resource_wait_ms,
       CAST(wait_time_ms * 1.0 / NULLIF(waiting_tasks_count, 0) AS decimal(19,2)) AS avg_wait_ms
FROM sys.dm_os_wait_stats
WHERE waiting_tasks_count > 0
ORDER BY wait_time_ms DESC, wait_type;
