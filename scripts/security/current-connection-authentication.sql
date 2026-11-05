/*
TSQL Library — Authentication of the current connection
Context: any database
Target platform: SQL Server 2016+; see Validation for the tested build and platform limitations.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Permission to inspect the current session in sys.dm_exec_connections; VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Reports this connection only. KERBEROS here does not validate another application connection or prove that every SPN is correct. Login names and network addresses are not selected.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-connections-transact-sql
Validation: Synthetic runtime scenarios passed on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

SELECT session_id, net_transport, protocol_type, auth_scheme,
       encrypt_option, connect_time
FROM sys.dm_exec_connections
WHERE session_id = @@SPID;
