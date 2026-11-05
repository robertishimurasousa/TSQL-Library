/*
TSQL Library — Locks in the selected database
Context: database to inspect
Target platform: SQL Server 2016+; server execution has not yet been validated.
Mode: read-only; SET/DECLARE affect only the session or batch.
Permissions: VIEW SERVER STATE (2016–2019); VIEW SERVER PERFORMANCE STATE (2022+).
Notes: Preserves resource IDs without assuming every lock represents a HoBT. Negative session IDs are preserved.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-locks-transact-sql
Validation: static review and T-SQL parsing; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @SessionId int = NULL;
SELECT request_session_id AS session_id,
       DB_NAME(resource_database_id) AS database_name,
       resource_type, resource_subtype,
       resource_associated_entity_id,
       resource_description,
       request_mode, request_status, request_owner_type
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID()
  AND (@SessionId IS NULL OR request_session_id = @SessionId)
ORDER BY request_session_id, resource_type, request_mode;
