/*
TSQL Library — NULL predicates
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Database connection; uses synthetic values only.
Notes: Uses IS NULL and IS NOT NULL; does not disable ANSI_NULLS or require a sample database table.
Reference: https://learn.microsoft.com/en-us/sql/t-sql/queries/is-null-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

WITH sample AS (
    SELECT id, optional_value FROM (VALUES
        (1, CAST(NULL AS int)), (2, 10), (3, 20)
    ) AS v(id, optional_value)
)
SELECT id, optional_value,
       CASE WHEN optional_value IS NULL THEN N'Missing' ELSE N'Present' END AS value_state
FROM sample
ORDER BY id;
