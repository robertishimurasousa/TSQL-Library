/*
TSQL Library — Últimos backups de cada tipo
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: SELECT nas tabelas de msdb consultadas; solicitar acesso específico ao DBA.
Observações: Histórico local pode ter sido removido ou estar em outra réplica. Não comprova restauração nem cobertura da cadeia de logs.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/backupset-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

WITH ranked AS (
    SELECT database_name, type, backup_start_date, backup_finish_date,
           is_copy_only, backup_size, compressed_backup_size,
           ROW_NUMBER() OVER (
               PARTITION BY database_name, type, is_copy_only
               ORDER BY backup_finish_date DESC, backup_set_id DESC
           ) AS position
    FROM msdb.dbo.backupset
    WHERE type IN ('D', 'I', 'L') AND backup_finish_date IS NOT NULL
)
SELECT database_name,
       CASE type WHEN 'D' THEN N'Full' WHEN 'I' THEN N'Differential' WHEN 'L' THEN N'Log' END AS backup_type,
       is_copy_only, backup_start_date, backup_finish_date,
       CAST(backup_size / 1048576.0 AS decimal(19,2)) AS backup_mb,
       CAST(compressed_backup_size / 1048576.0 AS decimal(19,2)) AS compressed_mb
FROM ranked
WHERE position = 1
ORDER BY database_name, type, is_copy_only;
