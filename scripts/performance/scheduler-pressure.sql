/*
TSQL Library — Filas dos schedulers
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Snapshot dos schedulers visíveis e online; analisar amostras antes de concluir saturação.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-schedulers-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT scheduler_id, cpu_id, parent_node_id,
       current_tasks_count, runnable_tasks_count,
       current_workers_count, active_workers_count,
       work_queue_count, pending_disk_io_count
FROM sys.dm_os_schedulers
WHERE status = N'VISIBLE ONLINE'
ORDER BY runnable_tasks_count DESC, scheduler_id;
