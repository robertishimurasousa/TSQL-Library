/*
TSQL Library — Estimativas de índices ausentes
Contexto: banco a inspecionar
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Sugestões do otimizador são incompletas e não justificam criar índices automaticamente; não gera DDL.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-db-missing-index-details-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT TOP (50) OBJECT_SCHEMA_NAME(d.object_id, d.database_id) AS schema_name,
       OBJECT_NAME(d.object_id, d.database_id) AS table_name,
       d.equality_columns, d.inequality_columns, d.included_columns,
       st.user_seeks, st.user_scans, st.last_user_seek, st.last_user_scan,
       st.avg_total_user_cost, st.avg_user_impact,
       (CONVERT(float, st.user_seeks) + CONVERT(float, st.user_scans))
           * st.avg_total_user_cost * st.avg_user_impact / 100.0 AS estimated_benefit
FROM sys.dm_db_missing_index_details AS d
JOIN sys.dm_db_missing_index_groups AS g ON g.index_handle = d.index_handle
JOIN sys.dm_db_missing_index_group_stats AS st ON st.group_handle = g.index_group_handle
WHERE d.database_id = DB_ID()
ORDER BY estimated_benefit DESC, d.index_handle;
