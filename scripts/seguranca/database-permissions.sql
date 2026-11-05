/*
TSQL Library — Permissões explícitas no banco
Contexto: banco a inspecionar
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Visibilidade dos metadados consultados; resultados podem ser parciais.
Observações: Não calcula permissões efetivas ou herança de roles. IDs de securables são preservados para todas as classes.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-permissions-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

DECLARE @PrincipalName sysname = NULL;
SELECT grantee.name AS principal_name, grantee.type_desc,
       grantor.name AS grantor_name,
       p.class_desc, p.major_id, p.minor_id,
       CASE WHEN p.class = 1 THEN OBJECT_SCHEMA_NAME(p.major_id) END AS object_schema_name,
       CASE WHEN p.class = 1 THEN OBJECT_NAME(p.major_id) END AS object_name,
       CASE WHEN p.class = 1 AND p.minor_id > 0 THEN COL_NAME(p.major_id, p.minor_id) END AS column_name,
       p.permission_name, p.state_desc
FROM sys.database_permissions AS p
JOIN sys.database_principals AS grantee ON grantee.principal_id = p.grantee_principal_id
LEFT JOIN sys.database_principals AS grantor ON grantor.principal_id = p.grantor_principal_id
WHERE @PrincipalName IS NULL OR grantee.name = @PrincipalName
ORDER BY grantee.name, p.class, p.major_id, p.minor_id, p.permission_name;
