# TSQL Library

A collection of T-SQL queries for SQL Server diagnostics and examples using synthetic data. This initial selection contains **34 scripts**, organized by topic, with context, permissions and limitations documented in each header.

The files have passed static review, T-SQL parsing and secret scanning. **Execution and compatibility in SQL Server have not yet been validated.** SQL Server 2016+ is the target platform, not a list of tested versions. Azure SQL Database, Managed Instance and Fabric require separate evaluation.

## Find a query

- [Complete catalog](docs/catalog.md)
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

This selection queries metadata and uses only synthetic values in its examples. It does not install jobs, procedures or tables, reconfigure the instance, or perform repairs. Queries can consume resources, acquire read locks and return names, paths or other data from the connected environment. Review results before publishing them. Scripts that can return SQL text leave that option disabled by default.

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

The workflow checks syntax, the catalog, file types, read-only rules and secrets in both files and history. It does not execute the scripts against a database. See [validation](docs/validation.md), [safety and execution](docs/safety-and-execution.md) and [contributing](CONTRIBUTING.md).

## Sources and license

A curated and rewritten selection of administration queries and generic examples. Each script links to the relevant Microsoft documentation. Complete third-party tools are listed in [references](docs/references.md), under their own licenses, and are not bundled with this collection.

The code in this library is distributed under the [MIT license](LICENSE).
