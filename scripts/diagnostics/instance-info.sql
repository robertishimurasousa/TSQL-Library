/*
TSQL Library — Instance information
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Version and uptime are informational; no automatic configuration assessment is made.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-sys-info-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
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
