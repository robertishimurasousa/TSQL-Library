/*
TSQL Library — Memory configuration and status
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Does not calculate an ideal value or reconfigure the instance. Some memory consumers are outside the max server memory limit.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-process-memory-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT name, value AS configured_value, value_in_use, minimum, maximum, is_dynamic
FROM sys.configurations
WHERE name IN (N'min server memory (MB)', N'max server memory (MB)')
ORDER BY name;

SELECT CAST(total_physical_memory_kb / 1024.0 AS decimal(19,2)) AS total_physical_mb,
       CAST(available_physical_memory_kb / 1024.0 AS decimal(19,2)) AS available_physical_mb,
       system_memory_state_desc
FROM sys.dm_os_sys_memory;

SELECT CAST(physical_memory_in_use_kb / 1024.0 AS decimal(19,2)) AS process_physical_mb,
       process_physical_memory_low, process_virtual_memory_low
FROM sys.dm_os_process_memory;
