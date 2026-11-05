/*
TSQL Library — Pagination with deterministic ordering
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Database connection; uses synthetic values only.
Notes: A tie-breaker avoids ambiguous ordering. Concurrent production data requires its own consistency strategy.
Reference: https://learn.microsoft.com/en-us/sql/t-sql/queries/select-order-by-clause-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @Offset int = 2;
DECLARE @PageSize int = 2;
IF @Offset < 0 OR @PageSize < 1
    THROW 50002, N'Offset must be nonnegative and PageSize must be positive.', 1;

WITH sample AS (
    SELECT id, category FROM (VALUES
        (1, N'A'), (2, N'A'), (3, N'B'), (4, N'B'), (5, N'C')
    ) AS v(id, category)
)
SELECT id, category
FROM sample
ORDER BY category, id
OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
