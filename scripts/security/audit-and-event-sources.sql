/*
TSQL Library — Existing audit, trace and Extended Events sources
Context: master
Target platform: SQL Server 2016+; see Validation for the tested build and platform limitations.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Server audit metadata visibility, ALTER TRACE for traces, and VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Inventories existing sources without enabling collection. Current configuration cannot establish what was captured previously. Paths are hidden by default. Does not read event payloads or credentials.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-server-audits-transact-sql
Validation: Synthetic runtime scenarios passed on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @IncludePaths bit = 0;
SELECT a.name AS audit_name, a.type_desc AS target_type, a.is_state_enabled,
       CASE WHEN @IncludePaths = 1 THEN f.log_file_path END AS optional_file_path,
       s.name AS specification_name, s.is_state_enabled AS specification_enabled,
       d.audit_action_name, d.audited_result
FROM sys.server_audits AS a
LEFT JOIN sys.server_file_audits AS f ON f.audit_id = a.audit_id
LEFT JOIN sys.server_audit_specifications AS s ON s.audit_guid = a.audit_guid
LEFT JOIN sys.server_audit_specification_details AS d
  ON d.server_specification_id = s.server_specification_id
ORDER BY a.name, s.name, d.audit_action_name;

SELECT id AS trace_id, is_default, status,
       CASE WHEN @IncludePaths = 1 THEN path END AS optional_trace_path
FROM sys.traces ORDER BY id;

SELECT s.name AS event_session_name, e.package, e.name AS event_name
FROM sys.server_event_sessions AS s
LEFT JOIN sys.server_event_session_events AS e ON e.event_session_id = s.event_session_id
ORDER BY s.name, e.name;

SELECT s.name AS event_session_name, t.name AS target_type,
       CASE WHEN @IncludePaths = 1 THEN CONVERT(nvarchar(4000), f.value) END AS optional_file_path
FROM sys.server_event_sessions AS s
JOIN sys.server_event_session_targets AS t ON t.event_session_id = s.event_session_id
LEFT JOIN sys.server_event_session_fields AS f
  ON f.event_session_id = t.event_session_id AND f.object_id = t.target_id
 AND f.name = N'filename'
ORDER BY s.name, t.name;
