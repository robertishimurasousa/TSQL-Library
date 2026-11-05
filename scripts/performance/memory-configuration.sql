/*
TSQL Library — Configuração e estado da memória
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Não calcula um valor ideal nem executa reconfiguração. Há consumidores de memória fora do limite max server memory.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-process-memory-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
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
