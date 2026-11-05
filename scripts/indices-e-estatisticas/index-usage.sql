/*
TSQL Library — Contadores de uso de índices
Contexto: banco a inspecionar
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: NULL significa ausência de registro na DMV; não é prova de índice inútil. Contadores são reiniciáveis e não medem linhas alteradas.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-db-index-usage-stats-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT s.name AS schema_name, t.name AS table_name,
       i.index_id, i.name AS index_name, i.type_desc,
       CASE WHEN u.index_id IS NULL THEN 0 ELSE 1 END AS has_usage_record,
       u.user_seeks, u.user_scans, u.user_lookups, u.user_updates,
       u.last_user_seek, u.last_user_scan, u.last_user_lookup, u.last_user_update
FROM sys.tables AS t
JOIN sys.schemas AS s ON s.schema_id = t.schema_id
JOIN sys.indexes AS i ON i.object_id = t.object_id
LEFT JOIN sys.dm_db_index_usage_stats AS u
  ON u.database_id = DB_ID() AND u.object_id = i.object_id AND u.index_id = i.index_id
WHERE t.is_ms_shipped = 0 AND i.is_hypothetical = 0
ORDER BY s.name, t.name, i.index_id;
