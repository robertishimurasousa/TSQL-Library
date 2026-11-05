/*
TSQL Library — Latest backups by type
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: SELECT on the queried msdb tables; request specific access from your DBA.
Notes: Local history may have been removed or may exist on another replica. Does not prove recoverability or log chain coverage.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/backupset-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

WITH ranked AS (
    SELECT database_name, type, backup_start_date, backup_finish_date,
           is_copy_only, backup_size, compressed_backup_size,
           ROW_NUMBER() OVER (
               PARTITION BY database_name, type, is_copy_only
               ORDER BY backup_finish_date DESC, backup_set_id DESC
           ) AS position
    FROM msdb.dbo.backupset
    WHERE type IN ('D', 'I', 'L') AND backup_finish_date IS NOT NULL
)
SELECT database_name,
       CASE type WHEN 'D' THEN N'Full' WHEN 'I' THEN N'Differential' WHEN 'L' THEN N'Log' END AS backup_type,
       is_copy_only, backup_start_date, backup_finish_date,
       CAST(backup_size / 1048576.0 AS decimal(19,2)) AS backup_mb,
       CAST(compressed_backup_size / 1048576.0 AS decimal(19,2)) AS compressed_mb
FROM ranked
WHERE position = 1
ORDER BY database_name, type, is_copy_only;
