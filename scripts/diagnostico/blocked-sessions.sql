/*
TSQL Library — Sessões bloqueadas e bloqueadores
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Inclui bloqueadores sem request ativo. IDs negativos têm significado especial; não representam logins comuns.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
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
