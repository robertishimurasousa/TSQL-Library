/*
TSQL Library — Locks no banco selecionado
Contexto: banco a inspecionar
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Mantém IDs de recursos sem presumir que todo lock seja um HoBT. IDs negativos de sessão são preservados.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-locks-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

DECLARE @SessionId int = NULL;
SELECT request_session_id AS session_id,
       DB_NAME(resource_database_id) AS database_name,
       resource_type, resource_subtype,
       resource_associated_entity_id,
       resource_description,
       request_mode, request_status, request_owner_type
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID()
  AND (@SessionId IS NULL OR request_session_id = @SessionId)
ORDER BY request_session_id, resource_type, request_mode;
