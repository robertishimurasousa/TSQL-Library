/*
TSQL Library — Local replica and database failover indicators
Context: master on the intended WSFC secondary replica
Target platform: SQL Server 2016+; execution against a server remains unvalidated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Snapshot only, not authorization or a guarantee of safe failover. Missing or NULL database state must not be treated as ready. Check both replicas, quorum and the full database list before any planned operation.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-hadr-database-replica-cluster-states-transact-sql
Validation: static checks only; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @AvailabilityGroupName sysname = NULL;
SELECT ag.name AS availability_group_name, ar.replica_server_name,
       rs.role_desc, ar.availability_mode_desc, rs.connected_state_desc,
       rs.operational_state_desc, rs.synchronization_health_desc,
       adc.database_name, cs.is_database_joined, cs.is_failover_ready,
       drs.synchronization_state_desc, drs.database_state_desc,
       drs.is_suspended, drs.suspend_reason_desc
FROM sys.availability_groups AS ag
JOIN sys.availability_replicas AS ar ON ar.group_id = ag.group_id
JOIN sys.dm_hadr_availability_replica_states AS rs
  ON rs.replica_id = ar.replica_id AND rs.is_local = 1
LEFT JOIN sys.availability_databases_cluster AS adc ON adc.group_id = ag.group_id
LEFT JOIN sys.dm_hadr_database_replica_cluster_states AS cs
  ON cs.replica_id = ar.replica_id AND cs.group_database_id = adc.group_database_id
LEFT JOIN sys.dm_hadr_database_replica_states AS drs
  ON drs.replica_id = ar.replica_id AND drs.group_database_id = adc.group_database_id
 AND drs.is_local = 1
WHERE ag.is_distributed = 0
  AND (@AvailabilityGroupName IS NULL OR ag.name = @AvailabilityGroupName)
ORDER BY ag.name, adc.database_name;
