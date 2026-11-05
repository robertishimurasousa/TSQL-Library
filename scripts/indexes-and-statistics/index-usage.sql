/*
TSQL Library — Index usage counters
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: NULL means there is no DMV record, not that an index is unnecessary. Counters can reset and do not measure modified rows.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-db-index-usage-stats-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
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
