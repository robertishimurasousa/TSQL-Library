/*
TSQL Library — Database files and growth settings
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Visibility of the queried metadata; results may be partial.
Notes: Shows allocated size, not actual space used; FILESTREAM requires separate measurement.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-master-files-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT d.name AS database_name,
       f.name AS logical_name,
       f.type_desc,
       f.physical_name,
       CAST(CONVERT(bigint, f.size) / 128.0 AS decimal(19,2)) AS allocated_mb,
       f.max_size AS max_size_pages,
       f.growth AS growth_raw,
       CASE WHEN f.is_percent_growth = 1 THEN N'percent' ELSE N'8 KB pages' END AS growth_unit,
       d.state_desc
FROM sys.master_files AS f
JOIN sys.databases AS d ON d.database_id = f.database_id
ORDER BY d.name, f.file_id;
