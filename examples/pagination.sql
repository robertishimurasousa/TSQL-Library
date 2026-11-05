/*
TSQL Library — Paginação com ordenação determinística
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Conexão ao banco; usa apenas valores sintéticos.
Observações: A chave de desempate evita ordenação ambígua. Dados reais concorrentes exigem estratégia própria de consistência.
Referência: https://learn.microsoft.com/en-us/sql/t-sql/queries/select-order-by-clause-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

DECLARE @Offset int = 2;
DECLARE @PageSize int = 2;
IF @Offset < 0 OR @PageSize < 1
    THROW 50002, N'Offset deve ser não negativo e PageSize deve ser positivo.', 1;

WITH sample AS (
    SELECT id, category FROM (VALUES
        (1, N'A'), (2, N'A'), (3, N'B'), (4, N'B'), (5, N'C')
    ) AS v(id, category)
)
SELECT id, category
FROM sample
ORDER BY category, id
OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
