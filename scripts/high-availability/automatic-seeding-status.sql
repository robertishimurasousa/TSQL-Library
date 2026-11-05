/*
TSQL Library — Automatic seeding attempts and transfer progress
Context: master on each replica
Target platform: SQL Server 2016+; see Validation for the tested build and platform limitations.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Collect separately on source and destination. Failure descriptions need correlation with existing error logs. Empty transfer rows can mean completed, failed or inactive seeding; they do not prove health.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-hadr-automatic-seeding
Validation: Empty-state execution only on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @AvailabilityGroupName sysname = NULL;
SELECT ag.name AS availability_group_name, adc.database_name,
       ar.replica_server_name AS remote_replica,
       s.operation_id, s.is_source, s.current_state,
       s.start_time, s.completion_time, s.failure_state_desc,
       s.error_code, s.number_of_attempts
FROM sys.dm_hadr_automatic_seeding AS s
LEFT JOIN sys.availability_groups AS ag ON ag.group_id = s.ag_id
LEFT JOIN sys.availability_databases_cluster AS adc
  ON adc.group_id = s.ag_id AND adc.group_database_id = s.ag_db_id
LEFT JOIN sys.availability_replicas AS ar ON ar.replica_id = s.ag_remote_replica_id
WHERE @AvailabilityGroupName IS NULL OR ag.name = @AvailabilityGroupName
ORDER BY s.start_time DESC;

-- This separate result is instance-wide; database names need not identify an AG uniquely.
SELECT local_database_name, role_desc, internal_state_desc,
       transferred_size_bytes, database_size_bytes,
       transfer_rate_bytes_per_second, start_time_utc, end_time_utc
FROM sys.dm_hadr_physical_seeding_stats
ORDER BY start_time_utc DESC;
