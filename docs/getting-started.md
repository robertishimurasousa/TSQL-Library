# Getting started

Use TSQL Library to find and run one diagnostic query at a time. You need a SQL Server or Azure SQL test environment, a login authorized to inspect it, and a client such as SQL Server Management Studio (SSMS). Python and Gitleaks are only needed to develop or validate the repository; they are not required to run its SQL files.

## 1. Get the files

Clone the public repository:

```sh
git clone https://github.com/robertishimurasousa/TSQL-Library.git
cd TSQL-Library
```

Alternatively, use **Code → Download ZIP** on the repository page and extract it. Nothing is installed in the database by downloading these files.

## 2. Choose the collection and platform

| Starting point | When to use it |
|---|---|
| [Curated catalog](catalog.md) | You want a smaller collection of metadata queries or synthetic T-SQL examples targeting SQL Server 2016+ |
| [Glenn Berry purpose index](glenn-berry/by-purpose.md) | You want a specific diagnostic topic and a version-specific upstream implementation |
| [Glenn Berry platform index](glenn-berry/README.md#choose-a-platform) | You want to browse all queries provided for your SQL Server version or Azure platform |

For example, use the [curated instance information query](../scripts/diagnostics/instance-info.sql) to inspect instance properties, or the [Glenn Berry CPU section](glenn-berry/by-purpose.md#performance--cpu) to choose a CPU diagnostic for a specific platform.

Check the engine version, edition, compatibility level and relevant features before selecting a variant. An Azure SQL Database query is not interchangeable with a Managed Instance or on-premises SQL Server query. SQL Agent, availability groups and Windows registry readers depend on the corresponding feature or host platform.

## 3. Read the file header

| Header field | What it tells you |
|---|---|
| Context | Which database or instance the connection must target |
| Target platform | The intended version or original upstream suite; not proof of tested compatibility |
| Mode | Whether the file uses metadata reads, local temporary tables or diagnostic calls |
| Permissions | Required access or the documentation needed to determine it |
| Notes | Limitations, workload cost, possible sensitive output and prerequisites |
| Reference | Microsoft documentation or the exact upstream source |
| Validation | What has been checked and what remains untested |

Imported files also preserve the author's explanations and licensing notice. Historical build lists and tuning advice are source commentary, not automatically current recommendations.

## 4. Run one file in a test environment

1. Open the `.sql` file in your client and connect to a test instance.
2. Select the database specified by **Context**. For a database-scoped query, choose the database you want to inspect before execution.
3. Review any declared parameters and examples. Do not paste credentials or customer values into a file you will commit.
4. If the file uses temporary tables, open a fresh dedicated session. The script may drop a same-named local temporary table already present in that session.
5. Execute the complete selected file so declarations and dependent statements stay together. A client must recognize `GO` where used.
6. Read the results alongside the query comments. Save output outside the repository and sanitize it before sharing.

Do not run a whole directory as a batch or uncomment maintenance/configuration examples while exploring diagnostics. Some imported queries return query text, plans, logs, addresses and login names by default. See [execution modes and permissions](glenn-berry/README.md#permissions-and-execution-modes).

## 5. Interpret common outcomes

| Outcome | What to check |
|---|---|
| No rows | Workload activity, cache resets, feature availability and metadata visibility; empty results are not proof of health |
| Permission error | The exact object's documented permissions and the account's visibility; do not default to granting `sysadmin` |
| Unknown object or column | The selected platform, build and database context; static parsing cannot detect every version mismatch |
| Query takes longer than expected | Metadata/cache/log size and workload pressure; evaluate expensive diagnostics on a test instance first |
| Different results between runs | Counter windows, cache eviction, restarts, workload changes and replica context |

The [validation guide](validation.md) explains the completed checks and pending execution scenarios. For a reproducible problem, report the script path, platform/build, sanitized error and a synthetic reproduction in a [GitHub issue](https://github.com/robertishimurasousa/TSQL-Library/issues). Never attach raw customer query results or credentials.

## Licensing

The curated scripts and library tooling use the [MIT license](../LICENSE). Glenn Berry files retain the [original author's terms](../THIRD_PARTY_NOTICES.md), including the non-commercial alteration condition. Public availability does not relicense them under MIT.

[Browse all documentation](README.md).
