/*
TSQL Library — Estado e última conclusão dos jobs
Contexto: instância com SQL Server Agent
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: SELECT nas tabelas de msdb consultadas; solicitar acesso específico ao DBA.
Observações: Atividade vem da sessão mais recente do Agent; não comprova que o serviço está ativo neste instante.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobactivity-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT j.name AS job_name, j.enabled,
       a.run_requested_date, a.start_execution_date, a.stop_execution_date,
       CASE WHEN a.start_execution_date IS NOT NULL AND a.stop_execution_date IS NULL
            THEN 1 ELSE 0 END AS appears_running,
       a.next_scheduled_run_date,
       h.run_status AS last_completed_run_status,
       h.run_date AS last_completed_run_date_yyyymmdd,
       h.run_time AS last_completed_run_time_hhmmss,
       (h.run_duration / 10000) * 3600
           + ((h.run_duration % 10000) / 100) * 60
           + (h.run_duration % 100) AS last_completed_duration_seconds
FROM msdb.dbo.sysjobs AS j
LEFT JOIN msdb.dbo.sysjobactivity AS a
  ON a.job_id = j.job_id
 AND a.session_id = (SELECT MAX(session_id) FROM msdb.dbo.syssessions)
OUTER APPLY (
    SELECT TOP (1) hist.run_status, hist.run_date, hist.run_time, hist.run_duration
    FROM msdb.dbo.sysjobhistory AS hist
    WHERE hist.job_id = j.job_id AND hist.step_id = 0 AND hist.run_status IN (0, 1, 3)
    ORDER BY hist.instance_id DESC
) AS h
ORDER BY j.name;
