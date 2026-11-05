/*
TSQL Library — Modules matching a review term
Context: database to inspect
Target platform: SQL Server 2016+; execution against a server remains unvalidated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Metadata visibility in the selected database; VIEW DEFINITION for complete visible definitions.
Notes: Set an exact text fragment before use. Matches include comments and are review candidates, not proof of malicious behavior. Definitions stay hidden unless explicitly enabled and may contain secrets. Encrypted or invisible definitions cannot be searched.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-sql-modules-transact-sql
Validation: static checks only; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @SearchText nvarchar(128) = NULL;
DECLARE @IncludeDefinitions bit = 0;
SELECT DB_NAME() AS database_name, o.object_id,
       SCHEMA_NAME(o.schema_id) AS schema_name, o.name AS object_name,
       o.type_desc, o.create_date, o.modify_date,
       CASE WHEN @IncludeDefinitions = 1 THEN m.[definition] END AS optional_definition
FROM sys.objects AS o
JOIN sys.sql_modules AS m ON m.object_id = o.object_id
WHERE o.is_ms_shipped = 0
  AND NULLIF(@SearchText, N'') IS NOT NULL
  AND CHARINDEX(@SearchText, m.[definition]) > 0
ORDER BY schema_name, object_name;

-- Report visibility limitations separately; NULL does not prove encryption.
SELECT COUNT_BIG(*) AS modules_with_unavailable_definition
FROM sys.sql_modules WHERE [definition] IS NULL;
