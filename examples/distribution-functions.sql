/*
TSQL Library — Distribuição e posição percentual
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Conexão ao banco; usa apenas valores sintéticos.
Observações: PERCENT_RANK e CUME_DIST têm comportamentos distintos em empates; nenhuma tabela permanente é criada.
Referência: https://learn.microsoft.com/en-us/sql/t-sql/functions/cume-dist-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
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
