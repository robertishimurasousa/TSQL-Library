/*
TSQL Library — Statistics properties
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Permission to query object metadata and statistics; see the reference.
Notes: NULL may indicate a missing statistics blob or insufficient visibility; age alone does not determine whether an update is needed.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-db-stats-properties-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
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
