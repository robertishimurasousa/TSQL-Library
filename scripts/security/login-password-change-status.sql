/*
TSQL Library — Current SQL login password-change metadata
Context: master
Target platform: SQL Server 2016+; execution against a server remains unvalidated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Visibility of the selected login and permissions required by LOGINPROPERTY.
Notes: Requires an explicit login name. Does not select passwords, hashes or SIDs. PasswordLastSetTime is current-state metadata; it does not identify the person who changed a password or recover prior changes.
Reference: https://learn.microsoft.com/en-us/sql/t-sql/functions/loginproperty-transact-sql
Validation: static checks only; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @LoginName sysname = NULL;
SELECT name AS login_name, is_disabled, create_date, modify_date,
       LOGINPROPERTY(name, 'PasswordLastSetTime') AS password_last_set_time,
       LOGINPROPERTY(name, 'IsLocked') AS is_locked,
       is_policy_checked, is_expiration_checked
FROM sys.sql_logins
WHERE @LoginName IS NOT NULL AND name = @LoginName;
