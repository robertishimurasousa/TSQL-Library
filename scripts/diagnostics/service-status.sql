/*
TSQL Library — Service status
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER SECURITY STATE (2022+).
Notes: Output includes service accounts and paths from the queried server.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-server-services-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT servicename, startup_type_desc, status_desc, last_startup_time,
       service_account, is_clustered, cluster_nodename, filename, process_id
FROM sys.dm_server_services
ORDER BY servicename;
