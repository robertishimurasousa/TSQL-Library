/*
TSQL Library — Missing index estimates
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Optimizer suggestions are incomplete and do not justify creating indexes automatically; no DDL is generated.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-db-missing-index-details-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
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
