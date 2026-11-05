/*
TSQL Library — Scheduler queues
Context: any database
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Snapshot of visible online schedulers; review multiple samples before concluding that they are saturated.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-schedulers-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT scheduler_id, cpu_id, parent_node_id,
       current_tasks_count, runnable_tasks_count,
       current_workers_count, active_workers_count,
       work_queue_count, pending_disk_io_count
FROM sys.dm_os_schedulers
WHERE status = N'VISIBLE ONLINE'
ORDER BY runnable_tasks_count DESC, scheduler_id;
