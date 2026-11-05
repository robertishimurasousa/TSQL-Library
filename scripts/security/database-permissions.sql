/*
TSQL Library — Explicit database permissions
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Visibility of the queried metadata; results may be partial.
Notes: Does not calculate effective permissions or role inheritance. Securable IDs are preserved for every class.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-permissions-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @PrincipalName sysname = NULL;
SELECT grantee.name AS principal_name, grantee.type_desc,
       grantor.name AS grantor_name,
       p.class_desc, p.major_id, p.minor_id,
       CASE WHEN p.class = 1 THEN OBJECT_SCHEMA_NAME(p.major_id) END AS object_schema_name,
       CASE WHEN p.class = 1 THEN OBJECT_NAME(p.major_id) END AS object_name,
       CASE WHEN p.class = 1 AND p.minor_id > 0 THEN COL_NAME(p.major_id, p.minor_id) END AS column_name,
       p.permission_name, p.state_desc
FROM sys.database_permissions AS p
JOIN sys.database_principals AS grantee ON grantee.principal_id = p.grantee_principal_id
LEFT JOIN sys.database_principals AS grantor ON grantor.principal_id = p.grantor_principal_id
WHERE @PrincipalName IS NULL OR grantee.name = @PrincipalName
ORDER BY grantee.name, p.class, p.major_id, p.minor_id, p.permission_name;
