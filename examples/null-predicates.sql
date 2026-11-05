/*
TSQL Library — Predicados para valores NULL
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Conexão ao banco; usa apenas valores sintéticos.
Observações: Usa IS NULL e IS NOT NULL; não desativa ANSI_NULLS nem depende de tabela de demonstração.
Referência: https://learn.microsoft.com/en-us/sql/t-sql/queries/is-null-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
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
