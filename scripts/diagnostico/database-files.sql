/*
TSQL Library — Arquivos e crescimento dos bancos
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: Visibilidade dos metadados consultados; resultados podem ser parciais.
Observações: Tamanho alocado, não espaço efetivamente ocupado; FILESTREAM exige medição específica.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-master-files-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT d.name AS database_name,
       f.name AS logical_name,
       f.type_desc,
       f.physical_name,
       CAST(CONVERT(bigint, f.size) / 128.0 AS decimal(19,2)) AS allocated_mb,
       f.max_size AS max_size_pages,
       f.growth AS growth_raw,
       CASE WHEN f.is_percent_growth = 1 THEN N'percent' ELSE N'8 KB pages' END AS growth_unit,
       d.state_desc
FROM sys.master_files AS f
JOIN sys.databases AS d ON d.database_id = f.database_id
ORDER BY d.name, f.file_id;
