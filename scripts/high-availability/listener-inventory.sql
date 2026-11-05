/*
TSQL Library — Availability group listeners and endpoint configuration
Context: master on an Always On instance
Target platform: SQL Server 2016+; see Validation for the tested build and platform limitations.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+). Endpoint metadata also requires VIEW SERVER SECURITY STATE on SQL Server 2022+.
Notes: Returns configured listener/endpoint names and ports, not a connectivity or SPN test. Network names and optional addresses are environment data; do not publish results unchanged.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-availability-group-listeners-transact-sql
Validation: Empty-state execution only on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @IncludeAddresses bit = 0;
SELECT ag.name AS availability_group_name, l.dns_name AS listener_dns_name,
       l.port AS listener_port, l.is_conformant, ip.state_desc,
       CASE WHEN @IncludeAddresses = 1 THEN ip.ip_address END AS optional_ip_address
FROM sys.availability_groups AS ag
JOIN sys.availability_group_listeners AS l ON l.group_id = ag.group_id
LEFT JOIN sys.availability_group_listener_ip_addresses AS ip ON ip.listener_id = l.listener_id
ORDER BY ag.name, l.dns_name;

SELECT e.name AS endpoint_name, e.state_desc, t.port,
       m.role_desc, m.connection_auth_desc, m.encryption_algorithm_desc
FROM sys.database_mirroring_endpoints AS m
JOIN sys.endpoints AS e ON e.endpoint_id = m.endpoint_id
JOIN sys.tcp_endpoints AS t ON t.endpoint_id = m.endpoint_id
ORDER BY e.name;
