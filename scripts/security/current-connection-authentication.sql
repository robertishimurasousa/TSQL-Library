/*
TSQL Library — Authentication of the current connection
Context: any database
Target platform: SQL Server 2016+; execution against a server remains unvalidated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: Permission to inspect the current session in sys.dm_exec_connections; VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Reports this connection only. KERBEROS here does not validate another application connection or prove that every SPN is correct. Login names and network addresses are not selected.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-connections-transact-sql
Validation: static checks only; see docs/validation.md.
*/
SET NOCOUNT ON;

SELECT session_id, net_transport, protocol_type, auth_scheme,
       encrypt_option, connect_time
FROM sys.dm_exec_connections
WHERE session_id = @@SPID;
