/*
TSQL Library — Recorded suspect pages
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: SELECT on the queried msdb tables; request specific access from your DBA.
Notes: An empty result does not prove database integrity; no DBCC command or repair is performed.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/manage-the-suspect-pages-table-sql-server
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT sp.database_id, DB_NAME(sp.database_id) AS database_name,
       sp.file_id, f.name AS logical_file_name,
       sp.page_id, sp.event_type,
       CASE sp.event_type
           WHEN 1 THEN N'823 or 824 error'
           WHEN 2 THEN N'Bad checksum'
           WHEN 3 THEN N'Torn page'
           WHEN 4 THEN N'Restored'
           WHEN 5 THEN N'Repaired'
           WHEN 7 THEN N'Deallocated'
           ELSE N'Unknown'
       END AS event_description,
       sp.error_count, sp.last_update_date
FROM msdb.dbo.suspect_pages AS sp
LEFT JOIN sys.master_files AS f
  ON f.database_id = sp.database_id AND f.file_id = sp.file_id
ORDER BY sp.last_update_date DESC, sp.database_id, sp.file_id, sp.page_id;
