/*
TSQL Library — I/O acumulado por arquivo
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: Contadores acumulados, sem amostragem por intervalo. Média não descreve a distribuição de latências.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-io-virtual-file-stats-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT DB_NAME(io.database_id) AS database_name,
       f.name AS logical_file_name, f.type_desc,
       io.num_of_reads, io.num_of_writes,
       CAST(io.num_of_bytes_read / 1048576.0 AS decimal(19,2)) AS read_mb,
       CAST(io.num_of_bytes_written / 1048576.0 AS decimal(19,2)) AS written_mb,
       CAST(io.io_stall_read_ms * 1.0 / NULLIF(io.num_of_reads, 0) AS decimal(19,2)) AS avg_read_ms,
       CAST(io.io_stall_write_ms * 1.0 / NULLIF(io.num_of_writes, 0) AS decimal(19,2)) AS avg_write_ms,
       io.sample_ms
FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS io
JOIN sys.master_files AS f ON f.database_id = io.database_id AND f.file_id = io.file_id
ORDER BY io.io_stall DESC, io.database_id, io.file_id;
