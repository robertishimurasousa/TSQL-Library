/*
TSQL Library — Database inventory
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Visibility of the queried metadata; results may be partial.
Notes: Recovery model, owner and compatibility require context; they are not automatically classified as good or bad.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT d.name AS database_name,
       d.state_desc,
       d.recovery_model_desc,
       d.compatibility_level,
       SUSER_SNAME(d.owner_sid) AS owner_name,
       d.is_read_only,
       d.page_verify_option_desc,
       d.snapshot_isolation_state_desc,
       d.is_read_committed_snapshot_on,
       d.log_reuse_wait_desc
FROM sys.databases AS d
ORDER BY d.name;
