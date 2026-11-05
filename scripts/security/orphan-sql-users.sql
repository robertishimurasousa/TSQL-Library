/*
TSQL Library — Potential orphaned SQL users
Context: user database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Full visibility of SQL Server logins and database users.
Notes: Includes only INSTANCE authentication, not contained users. Partial login visibility may cause false positives.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-principals-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT dp.name AS database_user, dp.type_desc, dp.authentication_type_desc,
       dp.create_date, dp.modify_date
FROM sys.database_principals AS dp
LEFT JOIN sys.server_principals AS sp ON sp.sid = dp.sid
WHERE dp.type = 'S'
  AND dp.authentication_type_desc = N'INSTANCE'
  AND dp.principal_id > 4
  AND sp.principal_id IS NULL
ORDER BY dp.name;
