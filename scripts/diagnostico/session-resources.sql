/*
TSQL Library — Recursos por sessão
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Contadores acumulados da sessão; memory_usage é memória associada à sessão, não memória total das consultas.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
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
