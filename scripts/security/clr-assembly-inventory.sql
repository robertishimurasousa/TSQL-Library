/*
TSQL Library — CLR assemblies and bound modules
Context: database to inspect
Target platform: SQL Server 2016+; execution against a server remains unvalidated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Metadata visibility in the selected database; VIEW DEFINITION for complete visible definitions.
Notes: Does not execute CLR, export DLLs or classify assemblies as malicious. Permission set is a declared property, not proof of safety. Names and optional hashes are environment-specific; current owner is not the creator.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-assemblies-transact-sql
Validation: static checks only; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @IncludeFileHashes bit = 0;
SELECT DB_NAME() AS database_name, a.assembly_id, a.name AS assembly_name,
       a.permission_set_desc, a.is_user_defined, a.create_date, a.modify_date,
       f.file_id, DATALENGTH(f.content) AS file_bytes,
       CASE WHEN @IncludeFileHashes = 1
            THEN CONVERT(varchar(64), HASHBYTES('SHA2_256', f.content), 2)
       END AS optional_sha256
FROM sys.assemblies AS a
LEFT JOIN sys.assembly_files AS f ON f.assembly_id = a.assembly_id
WHERE a.is_user_defined = 1
ORDER BY a.name, f.file_id;

SELECT DB_NAME() AS database_name, SCHEMA_NAME(o.schema_id) AS schema_name,
       o.name AS object_name, o.type_desc, o.create_date, o.modify_date,
       a.name AS assembly_name, am.assembly_class, am.assembly_method
FROM sys.assembly_modules AS am
JOIN sys.objects AS o ON o.object_id = am.object_id
JOIN sys.assemblies AS a ON a.assembly_id = am.assembly_id
WHERE o.is_ms_shipped = 0
ORDER BY a.name, schema_name, object_name;

-- Database DDL triggers are not necessarily represented in sys.objects.
SELECT DB_NAME() AS database_name, t.name AS ddl_trigger_name,
       t.is_disabled, t.create_date, t.modify_date,
       a.name AS assembly_name, am.assembly_class, am.assembly_method
FROM sys.triggers AS t
JOIN sys.assembly_modules AS am ON am.object_id = t.object_id
JOIN sys.assemblies AS a ON a.assembly_id = am.assembly_id
WHERE t.parent_class = 0 AND t.is_ms_shipped = 0
ORDER BY t.name;

SELECT DB_NAME() AS database_name, SCHEMA_NAME(t.schema_id) AS schema_name,
       t.name AS type_name, a.name AS assembly_name, t.assembly_class
FROM sys.assembly_types AS t
JOIN sys.assemblies AS a ON a.assembly_id = t.assembly_id
WHERE t.is_user_defined = 1
ORDER BY schema_name, type_name;
