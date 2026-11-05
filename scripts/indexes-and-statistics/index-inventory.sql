/*
TSQL Library — Index and data space inventory
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Visibility of the queried metadata; results may be partial.
Notes: A data space can be a filegroup or partition scheme; the query does not associate every file in a filegroup with an index.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-indexes-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
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
