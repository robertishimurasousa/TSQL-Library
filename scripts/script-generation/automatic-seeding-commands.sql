/*
TSQL Library — Generate automatic seeding commands for an existing replica
Context: master on the current primary replica
Target platform: SQL Server 2017+ on Windows/WSFC; see Validation for the tested build and platform limitations.
Mode: generator only; returns command text and never executes it.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+). Generated commands require availability group administration permissions.
Notes: Requires exact group and existing target-replica names. Does not add replicas, change endpoints or select synchronous mode. Review capacity, paths, database containment settings, endpoint connectivity and target identity before separately executing either output.
Reference: https://learn.microsoft.com/en-us/sql/database-engine/availability-groups/windows/automatic-seeding-secondary-replicas
Validation: Empty-state execution only on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @AvailabilityGroupName sysname = NULL;
DECLARE @TargetReplicaName sysname = NULL;
SELECT ag.name AS availability_group_name, target.replica_server_name AS target_replica,
       CAST(N'ALTER AVAILABILITY GROUP ' AS nvarchar(max)) + QUOTENAME(ag.name)
       + N' MODIFY REPLICA ON N''' + REPLACE(target.replica_server_name, N'''', N'''''')
       + N''' WITH (SEEDING_MODE = AUTOMATIC);' AS command_for_current_primary,
       CAST(N'-- Run only on the named target; joining and seeding create database state.' AS nvarchar(max))
       + NCHAR(13) + NCHAR(10)
       + N'IF NOT EXISTS (SELECT 1 FROM sys.availability_groups AS g '
       + N'JOIN sys.dm_hadr_availability_replica_states AS r ON r.group_id = g.group_id '
       + N'WHERE r.is_local = 1 AND g.name = N''' + REPLACE(ag.name, N'''', N'''''') + N''') '
       + N'BEGIN ALTER AVAILABILITY GROUP ' + QUOTENAME(ag.name) + N' JOIN; END; '
       + N'ALTER AVAILABILITY GROUP ' + QUOTENAME(ag.name)
       + N' GRANT CREATE ANY DATABASE;' AS command_for_named_target
FROM sys.availability_groups AS ag
JOIN sys.dm_hadr_availability_replica_states AS local_state
  ON local_state.group_id = ag.group_id AND local_state.is_local = 1
JOIN sys.availability_replicas AS target ON target.group_id = ag.group_id
WHERE @AvailabilityGroupName IS NOT NULL AND @TargetReplicaName IS NOT NULL
  AND ag.name = @AvailabilityGroupName AND target.replica_server_name = @TargetReplicaName
  AND target.replica_id <> local_state.replica_id
  AND local_state.role_desc = N'PRIMARY' AND ag.is_distributed = 0 AND ag.cluster_type = 0;
