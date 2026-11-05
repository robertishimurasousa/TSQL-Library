/*
TSQL Library — Uso dos arquivos de dados de tempdb
Contexto: tempdb
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Observações: A conexão deve selecionar tempdb. Valores reservados não equivalem a bytes usados por registros.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-db-file-space-usage-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

IF DB_NAME() <> N'tempdb'
    THROW 50001, N'Selecione tempdb antes de executar este script.', 1;

SELECT f.name AS logical_file_name,
       CAST(u.total_page_count / 128.0 AS decimal(19,2)) AS total_mb,
       CAST(u.unallocated_extent_page_count / 128.0 AS decimal(19,2)) AS free_extent_mb,
       CAST(u.user_object_reserved_page_count / 128.0 AS decimal(19,2)) AS user_object_mb,
       CAST(u.internal_object_reserved_page_count / 128.0 AS decimal(19,2)) AS internal_object_mb,
       CAST(u.version_store_reserved_page_count / 128.0 AS decimal(19,2)) AS version_store_mb,
       CAST(u.mixed_extent_page_count / 128.0 AS decimal(19,2)) AS mixed_extent_mb
FROM sys.dm_db_file_space_usage AS u
JOIN sys.database_files AS f ON f.file_id = u.file_id
ORDER BY u.file_id;
