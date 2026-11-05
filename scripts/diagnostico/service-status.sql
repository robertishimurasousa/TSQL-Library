/*
TSQL Library — Estado dos serviços
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER SECURITY STATE (2022+).
Observações: A saída contém contas de serviço e caminhos do servidor consultado.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-server-services-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT servicename, startup_type_desc, status_desc, last_startup_time,
       service_account, is_clustered, cluster_nodename, filename, process_id
FROM sys.dm_server_services
ORDER BY servicename;
