/*
TSQL Library — Disk-based table space
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW DATABASE STATE and VIEW DEFINITION (2016–2019); VIEW DATABASE PERFORMANCE STATE and VIEW SECURITY DEFINITION (2022+).
Notes: Approximate rows are counted only for heaps and clustered indexes; space includes indexes. Excludes memory-optimized table memory and external FILESTREAM files.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-db-partition-stats-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT s.name AS schema_name, t.name AS table_name,
       SUM(CASE WHEN p.index_id IN (0, 1) THEN p.row_count ELSE CONVERT(bigint, 0) END) AS approximate_rows,
       CAST(SUM(p.reserved_page_count) / 128.0 AS decimal(19,2)) AS reserved_mb,
       CAST(SUM(p.used_page_count) / 128.0 AS decimal(19,2)) AS used_mb,
       CAST(SUM(p.reserved_page_count - p.used_page_count) / 128.0 AS decimal(19,2)) AS unused_mb
FROM sys.tables AS t
JOIN sys.schemas AS s ON s.schema_id = t.schema_id
JOIN sys.dm_db_partition_stats AS p ON p.object_id = t.object_id
WHERE t.is_ms_shipped = 0 AND t.is_memory_optimized = 0
GROUP BY s.name, t.name
ORDER BY reserved_mb DESC, s.name, t.name;
