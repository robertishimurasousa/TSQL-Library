/*
TSQL Library — Generate a planned WSFC availability group failover command
Context: master on the intended secondary replica
Target platform: SQL Server 2017+ on Windows/WSFC; see Validation for the tested build and platform limitations.
Mode: generator only; returns command text and never executes it.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+). Executing generated text requires ALTER AVAILABILITY GROUP or equivalent authority.
Notes: Requires one exact group and passing visible local database indicators. Recheck both replicas, synchronous mode, quorum and all databases immediately before execution. Snapshot can become stale; no forced/data-loss failover is generated.
Reference: https://learn.microsoft.com/en-us/sql/database-engine/availability-groups/windows/perform-a-planned-manual-failover-of-an-availability-group-sql-server
Validation: Empty-state execution only on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @AvailabilityGroupName sysname = NULL;
SELECT ag.name AS availability_group_name, ar.replica_server_name AS destination_replica,
       CAST(N'-- Recheck source and destination health immediately before execution.' AS nvarchar(max))
       + NCHAR(13) + NCHAR(10) + N'ALTER AVAILABILITY GROUP '
       + QUOTENAME(ag.name) + N' FAILOVER;' AS generated_command
FROM sys.availability_groups AS ag
JOIN sys.availability_replicas AS ar ON ar.group_id = ag.group_id
JOIN sys.dm_hadr_availability_replica_states AS rs
  ON rs.replica_id = ar.replica_id AND rs.is_local = 1
WHERE @AvailabilityGroupName IS NOT NULL AND ag.name = @AvailabilityGroupName
  AND ag.is_distributed = 0 AND ag.cluster_type = 0
  AND rs.role_desc = N'SECONDARY' AND ar.availability_mode_desc = N'SYNCHRONOUS_COMMIT'
  AND rs.connected_state_desc = N'CONNECTED' AND rs.synchronization_health_desc = N'HEALTHY'
  AND EXISTS (SELECT 1 FROM sys.availability_databases_cluster AS d WHERE d.group_id = ag.group_id)
  AND NOT EXISTS (
      SELECT 1
      FROM sys.availability_databases_cluster AS d
      LEFT JOIN sys.dm_hadr_database_replica_cluster_states AS cs
        ON cs.group_database_id = d.group_database_id AND cs.replica_id = ar.replica_id
      LEFT JOIN sys.dm_hadr_database_replica_states AS ds
        ON ds.group_database_id = d.group_database_id AND ds.replica_id = ar.replica_id AND ds.is_local = 1
      WHERE d.group_id = ag.group_id
        AND (ISNULL(cs.is_database_joined, 0) <> 1 OR ISNULL(cs.is_failover_ready, 0) <> 1
             OR ISNULL(ds.synchronization_state_desc, N'UNKNOWN') <> N'SYNCHRONIZED'
             OR ISNULL(ds.database_state_desc, N'UNKNOWN') <> N'ONLINE'
             OR ISNULL(ds.is_suspended, 1) <> 0)
  );
