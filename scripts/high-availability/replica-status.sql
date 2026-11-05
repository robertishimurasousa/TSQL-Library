/*
TSQL Library — Database replica status
Context: instance with Always On enabled
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Visibility on a secondary replica is mainly local; an empty result does not prove health. Queue sizes are in KB and rates in KB/s.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-hadr-database-replica-states-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT ag.name AS availability_group_name,
       ar.replica_server_name,
       adc.database_name,
       drs.is_local, drs.is_primary_replica,
       ar.availability_mode_desc,
       drs.synchronization_state_desc, drs.synchronization_health_desc,
       drs.is_suspended, drs.suspend_reason_desc,
       drs.log_send_queue_size AS log_send_queue_kb,
       drs.log_send_rate AS log_send_kb_per_sec,
       drs.redo_queue_size AS redo_queue_kb,
       drs.redo_rate AS redo_kb_per_sec,
       drs.last_commit_time
FROM sys.dm_hadr_database_replica_states AS drs
JOIN sys.availability_groups AS ag ON ag.group_id = drs.group_id
JOIN sys.availability_replicas AS ar
  ON ar.group_id = drs.group_id AND ar.replica_id = drs.replica_id
JOIN sys.availability_databases_cluster AS adc
  ON adc.group_id = drs.group_id AND adc.group_database_id = drs.group_database_id
ORDER BY ag.name, adc.database_name, ar.replica_server_name;
