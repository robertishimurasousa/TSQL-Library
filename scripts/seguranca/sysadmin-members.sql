/*
TSQL Library — Membros diretos de sysadmin
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Visibilidade de server principals e role memberships; ver referência.
Observações: Não expande membros de grupos Windows nem resolve permissões efetivas de cada identidade.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-server-role-members-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT member.name AS member_name, member.type_desc, member.is_disabled,
       member.create_date, member.modify_date
FROM sys.server_role_members AS membership
JOIN sys.server_principals AS role
  ON role.principal_id = membership.role_principal_id
JOIN sys.server_principals AS member
  ON member.principal_id = membership.member_principal_id
WHERE role.name = N'sysadmin'
ORDER BY member.name;
