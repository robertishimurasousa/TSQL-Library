/*
TSQL Library — Generate an enable or disable command for one trigger
Context: database containing the trigger
Target platform: SQL Server 2016+; see Validation for the tested build and platform limitations.
Mode: generator only; returns command text and never executes it.
Permissions: Metadata visibility in the selected database; VIEW DEFINITION for complete visible definitions. Generated commands require ALTER on the parent object or the applicable DDL-trigger permission.
Notes: Set trigger scope and exact name; set schema for object-scoped triggers. Default action is DISABLE. No DROP commands are generated. Parent objects are quoted independently; database/server scopes are not interchangeable.
Reference: https://learn.microsoft.com/en-us/sql/t-sql/statements/disable-trigger-transact-sql
Validation: Synthetic runtime scenarios passed on SQL Server 2022 build 16.0.4305.5, Linux amd64 emulated on Apple Silicon; see docs/runtime-validation.md. Other versions remain untested.
*/
SET NOCOUNT ON;

DECLARE @TriggerName sysname = NULL;
DECLARE @SchemaName sysname = NULL;
DECLARE @Scope nvarchar(10) = N'OBJECT'; -- OBJECT or DATABASE; server triggers are excluded.
DECLARE @Action nvarchar(7) = N'DISABLE'; -- DISABLE or ENABLE.
SELECT DB_NAME() AS database_name, t.name AS trigger_name,
       t.is_disabled AS currently_disabled,
       CAST(N'USE ' AS nvarchar(max)) + QUOTENAME(DB_NAME()) + N'; '
       + @Action + N' TRIGGER '
       + CASE WHEN t.parent_class = 0 THEN QUOTENAME(t.name)
              ELSE QUOTENAME(s.name) + N'.' + QUOTENAME(t.name) END
       + N' ON '
       + CASE WHEN t.parent_class = 0 THEN N'DATABASE'
              ELSE QUOTENAME(s.name) + N'.' + QUOTENAME(o.name) END
       + N';' AS generated_command
FROM sys.triggers AS t
LEFT JOIN sys.objects AS o ON o.object_id = t.parent_id AND t.parent_class = 1
LEFT JOIN sys.schemas AS s ON s.schema_id = o.schema_id
WHERE @TriggerName IS NOT NULL AND t.name = @TriggerName
  AND @Action IN (N'DISABLE', N'ENABLE') AND t.is_ms_shipped = 0
  AND ((@Scope = N'DATABASE' AND t.parent_class = 0)
       OR (@Scope = N'OBJECT' AND t.parent_class = 1 AND s.name = @SchemaName));
