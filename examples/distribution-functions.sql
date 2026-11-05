/*
TSQL Library — Distribution and percentile ranking
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Database connection; uses synthetic values only.
Notes: PERCENT_RANK and CUME_DIST handle ties differently; no permanent table is created.
Reference: https://learn.microsoft.com/en-us/sql/t-sql/functions/cume-dist-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

WITH sample AS (
    SELECT group_name, score FROM (VALUES
        (N'A', 10), (N'A', 20), (N'A', 20), (N'A', 40),
        (N'B', 15), (N'B', 30)
    ) AS v(group_name, score)
)
SELECT group_name, score,
       PERCENT_RANK() OVER (PARTITION BY group_name ORDER BY score) AS percent_rank_value,
       CUME_DIST() OVER (PARTITION BY group_name ORDER BY score) AS cumulative_distribution
FROM sample
ORDER BY group_name, score;
