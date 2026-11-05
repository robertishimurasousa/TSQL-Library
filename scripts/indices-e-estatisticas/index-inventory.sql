/*
TSQL Library — Inventário de índices e data spaces
Contexto: banco a inspecionar
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Visibilidade dos metadados consultados; resultados podem ser parciais.
Observações: Data space pode ser filegroup ou partition scheme; não associa todos os arquivos do filegroup a um índice.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-indexes-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT s.name AS schema_name, t.name AS table_name,
       i.index_id, i.name AS index_name, i.type_desc,
       i.is_unique, i.is_primary_key, i.is_disabled, i.is_hypothetical,
       i.fill_factor, i.has_filter,
       ds.name AS data_space_name, ds.type_desc AS data_space_type
FROM sys.tables AS t
JOIN sys.schemas AS s ON s.schema_id = t.schema_id
JOIN sys.indexes AS i ON i.object_id = t.object_id
LEFT JOIN sys.data_spaces AS ds ON ds.data_space_id = i.data_space_id
WHERE t.is_ms_shipped = 0
ORDER BY s.name, t.name, i.index_id;
