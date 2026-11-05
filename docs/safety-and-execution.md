# Safety and execution

## Permissions

Use a test account with the permissions required by the script. Do not grant `sysadmin` as the default response to access errors. Metadata may be silently omitted when an account lacks sufficient visibility.

| Object family | SQL Server 2016–2019 | SQL Server 2022+ |
|---|---|---|
| Many instance performance DMVs | `VIEW SERVER STATE` | `VIEW SERVER PERFORMANCE STATE` |
| Services and database encryption keys | `VIEW SERVER STATE` | `VIEW SERVER SECURITY STATE` |
| `sys.dm_db_partition_stats` | `VIEW DATABASE STATE` and `VIEW DEFINITION` | `VIEW DATABASE PERFORMANCE STATE` and `VIEW SECURITY DEFINITION` in the database |
| Catalogs | Object/principal visibility | Object/principal visibility |
| History in `msdb` | Access to the queried tables | Access to the queried tables |

This table does not replace the requirements for each object. Consult the script's reference links and the [DMV documentation](https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-objects/system-dynamic-management-objects). For example, `statistics-properties.sql` requires visibility of object statistics. Permission queries show explicit grants; the sysadmin query lists direct members and does not expand Windows groups.

## Context and output

Database-scoped queries use the connection's current database; they do not automatically iterate through all databases. `tempdb-space.sql` stops the batch if the connection is not using `tempdb`. Examples use CTEs and `VALUES`, without creating tables.

Queries may expose identities, paths, objects, topology and command text. The library's source contains no environment data, but execution results contain information from the queried server. Review results before sharing them.

Cache DMVs and counters may reset, lose rows or provide partial visibility. `latest-backups.sql` shows local history recorded in `msdb`; it does not prove recoverability or consolidate backups from all replicas. `replica-status.sql` depends on Always On and the queried replica. `job-status.sql` shows the latest recorded Agent session; it is not a service availability monitor.

## Secrets and history

Gitleaks uses its default rules and additional rules for literal passwords, T-SQL hashes and credentials in `cmdkey`. Contextual SQL checks also look for UNC paths, email addresses and literal IPv4 addresses. A clean result does not replace human review.

If a secret enters Git, identify its owner, revoke or rotate the credential, and assess the need to clean the history. Removing the line from the latest commit does not remove earlier copies. See [GitHub's removal procedure](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository).
