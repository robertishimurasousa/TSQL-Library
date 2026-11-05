# TSQL Library

[![Validate library](https://github.com/robertishimurasousa/TSQL-Library/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/robertishimurasousa/TSQL-Library/actions/workflows/validate.yml)

A collection of T-SQL queries for SQL Server diagnostics and examples using synthetic data: **50 curated scripts** and **951 Glenn Berry diagnostic queries**, organized by purpose and platform, with English documentation.

Use it to investigate instance health, CPU and memory pressure, I/O latency, blocking, index usage, backup history and availability, or generate scoped administration commands for review. Each script is standalone; the library does not install persistent database objects or run a suite automatically.

The files have passed static checks, T-SQL parsing and secret scanning. **The 16 administration workflows have limited synthetic execution coverage on SQL Server 2022; the other scripts remain static-only.** See the [runtime coverage and platform limits](docs/runtime-validation.md). Most curated scripts target SQL Server 2016+; the WSFC command generators require SQL Server 2017+. Glenn Berry's imported suites cover SQL Server 2005 through 2025, Azure SQL Database and Managed Instance, with separate implementations and upstream terms. Platform labels are not a list of tested versions.

## Start here

1. Follow the [getting started guide](docs/getting-started.md) to choose a collection and run one query.
2. Browse the [query catalogs](#find-a-query) by purpose or platform.
3. Use the [documentation index](docs/README.md) for permissions, validation, source provenance and contribution instructions.

| Collection | Contents | Target platforms | Terms |
|---|---|---|---|
| Curated library | 50 diagnostic queries, command generators and synthetic examples | SQL Server 2016+; WSFC command generators 2017+ | [MIT](LICENSE) |
| Glenn Berry diagnostics | 951 queries from 13 upstream suites | SQL Server 2005–2025, Azure SQL Database and Managed Instance | [Original author terms](THIRD_PARTY_NOTICES.md) |

## Find a query

- [Glenn Berry queries by purpose](docs/glenn-berry/by-purpose.md) and [platform, usage and provenance guide](docs/glenn-berry/README.md).
- [Curated script catalog](docs/catalog.md) and [complete machine-readable catalog](catalog.json).

| Purpose | What you can inspect |
|---|---|
| [Diagnostics](scripts/diagnostics/) | Instances, databases, files, blocking, sessions, logs and tempdb |
| [Performance](scripts/performance/) | CPU, memory, I/O, waits, cache, query statistics and resource governance |
| [Indexes and statistics](scripts/indexes-and-statistics/) | Inventory, space, usage, fragmentation and optimizer estimates |
| [Backup and restore](scripts/backup-and-restore/) | Recorded backup history; these queries do not restore or verify recovery |
| [High availability](scripts/high-availability/) | Replica, cluster and replication status where supported |
| [Security](scripts/security/) | Permissions, encryption status and SQL user mappings |
| [SQL Agent](scripts/sql-agent/) | Jobs, alerts and execution history |
| [Script generation](scripts/script-generation/) | Generate job/trigger state changes, EXECUTE grants, planned failover and automatic seeding commands without executing them |
| [Examples](examples/) | Pagination, distribution functions and NULL predicates using synthetic values |

## Usage

1. Choose a query from the catalog and read its header.
2. Open a connection to a test instance and select the database indicated under **Context**.
3. Review the permissions and declared parameters. Run the file individually in SSMS or an equivalent T-SQL client.
4. Interpret the results in light of the documented limitations.

The curated selection queries metadata, generates command text and uses synthetic examples. One reviewed cross-database collector uses session-local temporary tables and parameterized dynamic catalog reads. It does not execute the objects it discovers. Generators do not execute their output. Optional definitions, identity fields, paths and job commands are disabled by default in the new administration workflows. Imported Glenn Berry scripts have their own execution modes: some create local temporary tables, call diagnostic procedures or return SQL text and logs by default. Read the [collection guide](docs/glenn-berry/README.md) before using them.

Queries can consume resources, acquire read locks and return names, paths, SQL literals or other sensitive information from the connected environment. Review results before publishing them; do not commit results to this repository.

## Repository layout

```text
scripts/<category>/                         Curated scripts and imported collections
scripts/<category>/glenn-berry/
  <purpose>/<platform>/<number>-<name>.sql   One version-specific imported query
examples/                                  Synthetic T-SQL examples
docs/                                      Usage guides, catalogs and validation notes
catalog.json                               Metadata for every SQL file
tools/                                     Static validator and reproducible importer
tests/                                     Validator and importer regression tests
```

See [how to navigate the repository](docs/README.md#repository-conventions) for naming and catalog conventions.

## Development and validation

Python 3.10+ and Gitleaks 8.30.1 are development tools; they are not required to run the SQL files.

```sh
python3 -m venv .venv
. .venv/bin/activate
export PYTHONDONTWRITEBYTECODE=1
python -m pip install -r requirements-dev.txt
python tools/validate.py
python -m unittest discover -s tests -v
gitleaks dir . --redact=100 --ignore-gitleaks-allow
gitleaks git . --log-opts="--all" --redact=100 --ignore-gitleaks-allow
```

The workflow checks syntax, catalog coverage, file types, the ordinary curated read-only policy, exact reviewed collector/import exceptions, and secrets in both files and history. It does not execute SQL against a database. See [validation](docs/validation.md), [safety and execution](docs/safety-and-execution.md) and [contributing](CONTRIBUTING.md).

## Contributing and reporting issues

Read [CONTRIBUTING.md](CONTRIBUTING.md) before adding or changing a query. Use English for filenames, comments, documentation and pull requests. Include a synthetic reproduction and the relevant SQL Server/Azure platform when [reporting an issue](https://github.com/robertishimurasousa/TSQL-Library/issues); remove credentials, customer identifiers, query literals and environment-specific output first.

## Sources and license

A curated and rewritten selection of administration queries and generic examples, plus attributed adaptations of Glenn Berry's diagnostic suites. Other third-party tools are linked in [references](docs/references.md).

The original curated scripts and library tooling use the [MIT license](LICENSE). Files under `scripts/*/glenn-berry/` retain **Glenn Berry's separate terms**, including the non-commercial alteration condition; they are not MIT-licensed. See [third-party notices](THIRD_PARTY_NOTICES.md).
