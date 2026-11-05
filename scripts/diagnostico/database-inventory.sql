/*
TSQL Library — Inventário dos bancos
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Visibilidade dos metadados consultados; resultados podem ser parciais.
Observações: Recovery model, owner e compatibilidade exigem avaliação do contexto; não são classificados como bons ou ruins.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT d.name AS database_name,
       d.state_desc,
       d.recovery_model_desc,
       d.compatibility_level,
       SUSER_SNAME(d.owner_sid) AS owner_name,
       d.is_read_only,
       d.page_verify_option_desc,
       d.snapshot_isolation_state_desc,
       d.is_read_committed_snapshot_on,
       d.log_reuse_wait_desc
FROM sys.databases AS d
ORDER BY d.name;
