/*
TSQL Library — Candidatos a usuários SQL órfãos
Contexto: banco de usuário
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Visibilidade completa dos logins de SQL Server e dos usuários do banco.
Observações: Somente autenticação INSTANCE; não inclui usuários contidos. Visibilidade parcial de logins pode gerar falsos positivos.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-principals-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
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
