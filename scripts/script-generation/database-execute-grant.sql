/*
TSQL Library — Generate a scoped EXECUTE grant
Context: database to configure
Target platform: SQL Server 2016+; execution against a server remains unvalidated.
Mode: generator only; returns command text and never executes it.
Permissions: Metadata visibility in the selected database; VIEW DEFINITION for complete visible definitions. Executing the generated GRANT requires grant authority on the chosen securable.
Notes: Requires an existing principal and an explicit object/schema/database scope. Object is the default. Schema/database grants include future executable objects; no users or roles are created and no server-wide EXECUTE grant is assumed.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/stored-procedures/grant-permissions-on-a-stored-procedure
Validation: static checks only; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @PrincipalName sysname = NULL;
DECLARE @Scope nvarchar(10) = N'OBJECT'; -- OBJECT, SCHEMA or DATABASE.
DECLARE @SchemaName sysname = NULL;
DECLARE @ObjectName sysname = NULL;

SELECT DB_NAME() AS database_name, p.name AS principal_name, @Scope AS grant_scope,
       CAST(N'USE ' AS nvarchar(max)) + QUOTENAME(DB_NAME()) + N'; GRANT EXECUTE'
       + CASE @Scope
           WHEN N'OBJECT' THEN N' ON OBJECT::' + QUOTENAME(s.name) + N'.' + QUOTENAME(o.name)
           WHEN N'SCHEMA' THEN N' ON SCHEMA::' + QUOTENAME(s.name)
           WHEN N'DATABASE' THEN N''
         END
       + N' TO ' + QUOTENAME(p.name) + N';' AS generated_command
FROM sys.database_principals AS p
LEFT JOIN sys.schemas AS s ON s.name = @SchemaName
LEFT JOIN sys.objects AS o ON o.schema_id = s.schema_id AND o.name = @ObjectName
WHERE @PrincipalName IS NOT NULL AND p.name = @PrincipalName
  AND p.principal_id > 4 AND p.type IN ('S', 'U', 'G', 'R', 'E', 'X')
  AND ((@Scope = N'OBJECT' AND o.type IN ('P', 'PC', 'FN', 'FS') AND o.is_ms_shipped = 0)
       OR (@Scope = N'SCHEMA' AND s.schema_id IS NOT NULL)
       OR @Scope = N'DATABASE');
