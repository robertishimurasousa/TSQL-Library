/*
TSQL Library — Propriedades das estatísticas
Contexto: banco a inspecionar
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Permissão para consultar metadados e estatísticas dos objetos; ver referência.
Observações: NULL pode representar estatística sem blob ou falta de visibilidade; idade sozinha não determina necessidade de atualização.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-db-stats-properties-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT sc.name AS schema_name, t.name AS table_name,
       st.stats_id, st.name AS statistics_name,
       st.auto_created, st.user_created, st.no_recompute, st.has_filter,
       props.last_updated, props.rows, props.rows_sampled,
       props.steps, props.unfiltered_rows, props.modification_counter
FROM sys.tables AS t
JOIN sys.schemas AS sc ON sc.schema_id = t.schema_id
JOIN sys.stats AS st ON st.object_id = t.object_id
OUTER APPLY sys.dm_db_stats_properties(st.object_id, st.stats_id) AS props
WHERE t.is_ms_shipped = 0
ORDER BY sc.name, t.name, st.stats_id;
