/*
TSQL Library — Informações da instância
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Versão e uptime são informativos, sem julgamento automático de configuração.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-sys-info-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT SERVERPROPERTY('ServerName') AS server_name,
       SERVERPROPERTY('ProductVersion') AS product_version,
       SERVERPROPERTY('ProductLevel') AS product_level,
       SERVERPROPERTY('Edition') AS edition,
       SERVERPROPERTY('IsHadrEnabled') AS is_hadr_enabled,
       osi.sqlserver_start_time,
       osi.cpu_count,
       osi.scheduler_count,
       CAST(osi.physical_memory_kb / 1024.0 AS decimal(19,2)) AS physical_memory_mb
FROM sys.dm_os_sys_info AS osi;
