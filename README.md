# TSQL Library

A collection of T-SQL queries for SQL Server diagnostics and examples using synthetic data: **34 curated scripts** and **951 Glenn Berry diagnostic queries**, organized by purpose and platform, with English documentation.

The files have passed static checks, T-SQL parsing and secret scanning. **Execution and compatibility in SQL Server have not yet been validated.** The curated scripts target SQL Server 2016+. Glenn Berry's imported suites cover SQL Server 2005 through 2025, Azure SQL Database and Managed Instance, with separate implementations and upstream terms. Platform labels are not a list of tested versions.

## Find a query

- [Glenn Berry queries by purpose](docs/glenn-berry/by-purpose.md) and [platform, usage and provenance guide](docs/glenn-berry/README.md).
- [Curated script catalog](docs/catalog.md) and [complete machine-readable catalog](catalog.json).
- [Diagnostics](scripts/diagnostics/): instances, databases, files, blocking, sessions and tempdb.
- [Performance](scripts/performance/): I/O, schedulers, cache, procedures, triggers, memory and waits.
- [Indexes and statistics](scripts/indexes-and-statistics/): inventory, space, usage and optimizer estimates.
- [Backup and restore](scripts/backup-and-restore/), [Always On](scripts/high-availability/), [security](scripts/security/) and [SQL Agent](scripts/sql-agent/).
- [Examples](examples/): pagination, distribution functions and NULL.

## Usage

1. Choose a query from the catalog and read its header.
2. Open a connection to a test instance and select the database indicated under **Context**.
3. Review the permissions and declared parameters. Run the file individually in SSMS or an equivalent T-SQL client.
4. Interpret the results in light of the documented limitations.

The curated selection queries metadata and uses synthetic values in its examples. It does not install jobs, procedures or tables, reconfigure the instance, or perform repairs; SQL-text output is disabled by default where available. Imported Glenn Berry scripts have their own execution modes: some create local temporary tables, call diagnostic procedures or return SQL text and logs by default. Read the [collection guide](docs/glenn-berry/README.md) before using them.

Queries can consume resources, acquire read locks and return names, paths, SQL literals or other sensitive information from the connected environment. Review results before publishing them; do not commit results to this repository.

## Development and validation

Python 3.10+ and Gitleaks 8.30.1 are development tools; they are not required to run the SQL files.

```sh
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r requirements-dev.txt
python tools/validate.py
python -m unittest discover -s tests -v
gitleaks dir . --redact=100 --ignore-gitleaks-allow
gitleaks git . --log-opts="--all" --redact=100 --ignore-gitleaks-allow
```

The workflow checks syntax, catalog coverage, file types, the curated read-only policy, exact reviewed upstream exceptions, and secrets in both files and history. It does not execute SQL against a database. See [validation](docs/validation.md), [safety and execution](docs/safety-and-execution.md) and [contributing](CONTRIBUTING.md).

## Sources and license

A curated and rewritten selection of administration queries and generic examples, plus attributed adaptations of Glenn Berry's diagnostic suites. Other third-party tools are linked in [references](docs/references.md).

The original curated scripts and library tooling use the [MIT license](LICENSE). Files under `scripts/*/glenn-berry/` retain **Glenn Berry's separate terms**, including the non-commercial alteration condition; they are not MIT-licensed. See [third-party notices](THIRD_PARTY_NOTICES.md).
