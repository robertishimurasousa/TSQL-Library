/*
TSQL Library — Estatísticas de procedures em cache
Contexto: banco a inspecionar
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Uma linha por plano em cache. Reinícios, recompilações e expulsão do cache mudam a janela dos contadores.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-procedure-stats-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
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
