/*
TSQL Library — Direct sysadmin members
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Visibility of server principals and role memberships; see the reference.
Notes: Does not expand Windows group membership or resolve each identity's effective permissions.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-server-role-members-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT member.name AS member_name, member.type_desc, member.is_disabled,
       member.create_date, member.modify_date
FROM sys.server_role_members AS membership
JOIN sys.server_principals AS role
  ON role.principal_id = membership.role_principal_id
JOIN sys.server_principals AS member
  ON member.principal_id = membership.member_principal_id
WHERE role.name = N'sysadmin'
ORDER BY member.name;
