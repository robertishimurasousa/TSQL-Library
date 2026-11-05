/*
TSQL Library — Estado de criptografia dos bancos
Contexto: qualquer banco
Plataforma-alvo: SQL Server 2016+; execução em servidor ainda não homologada.
Modo: somente leitura; SET/DECLARE afetam apenas a sessão/lote.
Permissões: VIEW SERVER STATE (2016–2019); VIEW SERVER SECURITY STATE (2022+).
Observações: A ausência da chave na DMV é mostrada explicitamente; não exporta chaves, hashes de senha ou certificados.
Referência: https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-database-encryption-keys-transact-sql
Validação: revisão estática e parser T-SQL; consultar docs/validacao.md.
*/
SET NOCOUNT ON;

SELECT d.name AS database_name, d.is_encrypted,
       ek.encryption_state,
       CASE
           WHEN ek.database_id IS NULL THEN N'No key visible in DMV'
           WHEN ek.encryption_state = 0 THEN N'No encryption key'
           WHEN ek.encryption_state = 1 THEN N'Unencrypted'
           WHEN ek.encryption_state = 2 THEN N'Encryption in progress'
           WHEN ek.encryption_state = 3 THEN N'Encrypted'
           WHEN ek.encryption_state = 4 THEN N'Key change in progress'
           WHEN ek.encryption_state = 5 THEN N'Decryption in progress'
           WHEN ek.encryption_state = 6 THEN N'Protection change in progress'
           ELSE N'Unknown'
       END AS encryption_description,
       ek.percent_complete, ek.key_algorithm, ek.key_length
FROM sys.databases AS d
LEFT JOIN sys.dm_database_encryption_keys AS ek ON ek.database_id = d.database_id
ORDER BY d.name;
