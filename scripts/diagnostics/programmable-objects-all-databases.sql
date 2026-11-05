/*
TSQL Library — Programmable objects across visible databases
Context: master; fresh session with no open transaction
Target platform: SQL Server 2016+; execution against a server remains unvalidated.
Mode: metadata reads with session-local temporary tables and parameterized dynamic SQL; no persistent changes.
Permissions: VIEW ANY DATABASE and metadata visibility in each database; VIEW DEFINITION for definitions; server trigger metadata permissions. Partial visibility remains possible.
Notes: Includes triggers, procedures and functions without executing discovered objects. Set ObjectCategory to TRIGGER for a trigger inventory. Reports skipped databases and errors separately. Definitions are hidden by default; owners and modification dates do not identify the creator or last execution.
Reference: https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-triggers-transact-sql
Validation: static checks only; see docs/validation.md.
*/
SET NOCOUNT ON;

DECLARE @DatabaseFilter sysname = NULL;
DECLARE @ObjectCategory nvarchar(10) = NULL; -- NULL, TRIGGER, PROCEDURE or FUNCTION.
DECLARE @IncludeSystemDatabases bit = 1;
DECLARE @IncludeDefinitions bit = 0;
IF DB_NAME() <> N'master' OR @@TRANCOUNT <> 0
    THROW 50001, 'Use master in a fresh session without an open transaction.', 1;
IF @ObjectCategory IS NOT NULL AND @ObjectCategory NOT IN (N'TRIGGER', N'PROCEDURE', N'FUNCTION')
    THROW 50002, 'ObjectCategory must be NULL, TRIGGER, PROCEDURE or FUNCTION.', 1;
IF OBJECT_ID(N'tempdb..#LibraryObjects') IS NOT NULL OR OBJECT_ID(N'tempdb..#LibraryCollectionStatus') IS NOT NULL
    THROW 50003, 'Temporary object names already exist; open a fresh session.', 1;

CREATE TABLE #LibraryObjects (
    database_name sysname COLLATE DATABASE_DEFAULT NULL,
    object_category nvarchar(10) COLLATE DATABASE_DEFAULT NOT NULL,
    object_scope nvarchar(12) COLLATE DATABASE_DEFAULT NOT NULL,
    schema_name sysname COLLATE DATABASE_DEFAULT NULL,
    parent_object_name sysname COLLATE DATABASE_DEFAULT NULL,
    object_name sysname COLLATE DATABASE_DEFAULT NOT NULL,
    type_description nvarchar(60) COLLATE DATABASE_DEFAULT NULL,
    create_date datetime NULL, modify_date datetime NULL, is_disabled bit NULL,
    optional_definition nvarchar(max) COLLATE DATABASE_DEFAULT NULL
);
CREATE TABLE #LibraryCollectionStatus (
    database_name sysname COLLATE DATABASE_DEFAULT NULL,
    collection_status nvarchar(40) COLLATE DATABASE_DEFAULT NOT NULL,
    error_number int NULL
);
DECLARE @LastDatabaseId int = 0;
DECLARE @DatabaseId int;
DECLARE @DatabaseName sysname;
DECLARE @DatabaseState tinyint;
DECLARE @HasAccess int;
DECLARE @Sql nvarchar(max);

SELECT @DatabaseId = MIN(database_id) FROM sys.databases
WHERE database_id > @LastDatabaseId AND (@IncludeSystemDatabases = 1 OR database_id > 4)
  AND (@DatabaseFilter IS NULL OR name = @DatabaseFilter);
WHILE @DatabaseId IS NOT NULL
BEGIN
    SELECT @DatabaseName = NULL, @DatabaseState = NULL, @HasAccess = NULL;
    SELECT @DatabaseName = name, @DatabaseState = state, @HasAccess = HAS_DBACCESS(name)
    FROM sys.databases WHERE database_id = @DatabaseId;
    IF @DatabaseState = 0 AND @HasAccess = 1
    BEGIN
        BEGIN TRY
            -- Only the catalog-derived database identifier is concatenated, through QUOTENAME.
            SELECT @Sql = N'USE ' + QUOTENAME(@DatabaseName) + N';
INSERT INTO #LibraryObjects
SELECT DB_NAME(),
       CASE WHEN o.type IN (''TR'', ''TA'') THEN N''TRIGGER''
            WHEN o.type IN (''P'', ''PC'') THEN N''PROCEDURE'' ELSE N''FUNCTION'' END,
       N''OBJECT'', SCHEMA_NAME(o.schema_id), parent_object.name, o.name, o.type_desc,
       o.create_date, o.modify_date, t.is_disabled,
       CASE WHEN @ShowDefinitions = 1 THEN m.[definition] END
FROM sys.objects AS o
LEFT JOIN sys.objects AS parent_object ON parent_object.object_id = o.parent_object_id
LEFT JOIN sys.triggers AS t ON t.object_id = o.object_id
LEFT JOIN sys.sql_modules AS m ON m.object_id = o.object_id
WHERE o.is_ms_shipped = 0
  AND o.type IN (''TR'', ''TA'', ''P'', ''PC'', ''FN'', ''IF'', ''TF'', ''FS'', ''FT'', ''AF'')
  AND (@Category IS NULL
       OR (@Category = N''TRIGGER'' AND o.type IN (''TR'', ''TA''))
       OR (@Category = N''PROCEDURE'' AND o.type IN (''P'', ''PC''))
       OR (@Category = N''FUNCTION'' AND o.type IN (''FN'', ''IF'', ''TF'', ''FS'', ''FT'', ''AF'')))
UNION ALL
SELECT DB_NAME(), N''TRIGGER'', N''DATABASE'', NULL, NULL, t.name, t.type_desc,
       t.create_date, t.modify_date, t.is_disabled,
       CASE WHEN @ShowDefinitions = 1 THEN m.[definition] END
FROM sys.triggers AS t
LEFT JOIN sys.sql_modules AS m ON m.object_id = t.object_id
WHERE t.parent_class = 0 AND t.is_ms_shipped = 0
  AND (@Category IS NULL OR @Category = N''TRIGGER'');';
            EXEC sys.sp_executesql @Sql, N'@Category nvarchar(10), @ShowDefinitions bit',
                 @Category = @ObjectCategory, @ShowDefinitions = @IncludeDefinitions;
            INSERT INTO #LibraryCollectionStatus VALUES (@DatabaseName, N'QUERIED; VISIBILITY MAY BE PARTIAL', NULL);
        END TRY
        BEGIN CATCH
            INSERT INTO #LibraryCollectionStatus VALUES (@DatabaseName, N'ERROR; RESULTS MAY BE PARTIAL', ERROR_NUMBER());
        END CATCH;
    END
    ELSE
        INSERT INTO #LibraryCollectionStatus VALUES (@DatabaseName, N'SKIPPED: OFFLINE OR NO ACCESS', NULL);
    SELECT @LastDatabaseId = @DatabaseId;
    SELECT @DatabaseId = MIN(database_id) FROM sys.databases
    WHERE database_id > @LastDatabaseId AND (@IncludeSystemDatabases = 1 OR database_id > 4)
      AND (@DatabaseFilter IS NULL OR name = @DatabaseFilter);
END;

-- A database filter excludes server-scoped triggers, which do not belong to a database.
IF @DatabaseFilter IS NULL AND (@ObjectCategory IS NULL OR @ObjectCategory = N'TRIGGER')
BEGIN
    BEGIN TRY
        INSERT INTO #LibraryObjects
        SELECT NULL, N'TRIGGER', N'SERVER', NULL, NULL, t.name, t.type_desc,
               t.create_date, t.modify_date, t.is_disabled,
               CASE WHEN @IncludeDefinitions = 1 THEN m.[definition] END
        FROM sys.server_triggers AS t
        LEFT JOIN sys.server_sql_modules AS m ON m.object_id = t.object_id
        WHERE t.is_ms_shipped = 0;
        INSERT INTO #LibraryCollectionStatus VALUES (NULL, N'SERVER TRIGGERS QUERIED', NULL);
    END TRY
    BEGIN CATCH
        INSERT INTO #LibraryCollectionStatus VALUES (NULL, N'SERVER TRIGGER QUERY ERROR', ERROR_NUMBER());
    END CATCH;
END;

SELECT database_name, object_category, object_scope, schema_name, parent_object_name,
       object_name, type_description, create_date, modify_date, is_disabled, optional_definition
FROM #LibraryObjects
ORDER BY database_name, object_category, schema_name, object_name;
SELECT database_name, collection_status, error_number
FROM #LibraryCollectionStatus ORDER BY database_name;
DROP TABLE #LibraryObjects;
DROP TABLE #LibraryCollectionStatus;
