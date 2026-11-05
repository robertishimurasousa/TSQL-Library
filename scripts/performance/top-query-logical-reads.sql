/*
TSQL Library — Cached queries by logical reads
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Counters describe cached plans, not permanent history. SQL text may contain sensitive values and is opt-in.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @IncludeSqlText bit = 0;
SELECT TOP (25) q.query_hash, q.plan_handle,
       q.creation_time, q.last_execution_time, q.execution_count,
       CAST(q.total_worker_time / 1000.0 / NULLIF(q.execution_count, 0) AS decimal(19,2)) AS avg_cpu_ms,
       CAST(q.total_logical_reads * 1.0 / NULLIF(q.execution_count, 0) AS decimal(19,2)) AS avg_logical_reads,
       q.total_worker_time AS total_cpu_us,
       q.total_logical_reads,
       CASE WHEN @IncludeSqlText = 1 THEN
           SUBSTRING(txt.text, q.statement_start_offset / 2 + 1,
               (CASE WHEN q.statement_end_offset = -1 THEN DATALENGTH(txt.text)
                     ELSE q.statement_end_offset END - q.statement_start_offset) / 2 + 1)
       END AS statement_text
FROM sys.dm_exec_query_stats AS q
OUTER APPLY sys.dm_exec_sql_text(q.sql_handle) AS txt
ORDER BY q.total_logical_reads DESC, q.execution_count DESC;
