/*
TSQL Library — Páginas suspeitas registradas
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: SELECT nas tabelas de msdb consultadas; solicitar acesso específico ao DBA.
Observações: Ausência de registros não comprova integridade; não executa DBCC nem reparos.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/manage-the-suspect-pages-table-sql-server
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT sp.database_id, DB_NAME(sp.database_id) AS database_name,
       sp.file_id, f.name AS logical_file_name,
       sp.page_id, sp.event_type,
       CASE sp.event_type
           WHEN 1 THEN N'823 or 824 error'
           WHEN 2 THEN N'Bad checksum'
           WHEN 3 THEN N'Torn page'
           WHEN 4 THEN N'Restored'
           WHEN 5 THEN N'Repaired'
           WHEN 7 THEN N'Deallocated'
           ELSE N'Unknown'
       END AS event_description,
       sp.error_count, sp.last_update_date
FROM msdb.dbo.suspect_pages AS sp
LEFT JOIN sys.master_files AS f
  ON f.database_id = sp.database_id AND f.file_id = sp.file_id
ORDER BY sp.last_update_date DESC, sp.database_id, sp.file_id, sp.page_id;
