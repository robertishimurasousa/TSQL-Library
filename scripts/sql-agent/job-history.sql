/*
TSQL Library — Histórico de conclusões dos jobs
Contexto: instância com SQL Server Agent
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: SELECT nas tabelas de msdb consultadas; solicitar acesso específico ao DBA.
Observações: Duração calculada numericamente, inclusive acima de 24 horas. Datas são horários locais registrados pelo Agent; não há mensagens de erro no resultado.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobhistory-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

DECLARE @JobName sysname = NULL;
SELECT TOP (100) j.name AS job_name,
       h.instance_id,
       h.run_date AS run_date_yyyymmdd,
       h.run_time AS run_time_hhmmss,
       CASE h.run_status WHEN 0 THEN N'Failed' WHEN 1 THEN N'Succeeded'
            WHEN 2 THEN N'Retry' WHEN 3 THEN N'Canceled' WHEN 4 THEN N'In progress'
            ELSE N'Unknown' END AS run_status,
       (h.run_duration / 10000) * 3600
           + ((h.run_duration % 10000) / 100) * 60
           + (h.run_duration % 100) AS duration_seconds
FROM msdb.dbo.sysjobhistory AS h
JOIN msdb.dbo.sysjobs AS j ON j.job_id = h.job_id
WHERE h.step_id = 0
  AND (@JobName IS NULL OR j.name = @JobName)
ORDER BY h.instance_id DESC;
