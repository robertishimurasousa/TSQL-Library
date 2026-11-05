# Documentation

TSQL Library contains 50 curated scripts and 951 attributed Glenn Berry diagnostic queries. Start with a purpose and choose the implementation for your platform. All documentation and contribution content use English.

## Run and understand a query

| Guide | Use it to |
|---|---|
| [Getting started](getting-started.md) | Download the library, choose a query and understand its header |
| [Administration workflows](getting-started.md#administration-workflows) | Investigate programmable objects, CLR, audit sources, SQL Agent and Always On; generate scoped commands |
| [Curated catalog](catalog.md) | Browse the 50 curated scripts, command generators and synthetic examples |
| [Glenn Berry queries by purpose](glenn-berry/by-purpose.md) | Find one of 951 imported queries by the problem you want to investigate |
| [Glenn Berry platform guide](glenn-berry/README.md) | Select a version, review execution modes and understand upstream differences |
| [Synthetic runtime results](runtime-validation.md) | Review the tested SQL Server build, 36 local scenarios, collector fixes and pending topology cases |
| [Safety and execution](safety-and-execution.md) | Review permissions, database context and sensitive output |
| [Validation evidence](validation.md) | Distinguish static checks from pending server execution tests |

## Maintain and extend the library

| Reference | Contents |
|---|---|
| [Contributing](../CONTRIBUTING.md) | Scope, English content, metadata and publication checks |
| [Complete catalog](../catalog.json) | Machine-readable metadata for all 1,001 SQL files |
| [Reproduce the Glenn Berry import](glenn-berry/README.md#validation-and-updates) | Source checksums, generation and review procedure |
| [Upstream references](references.md) | Author resources, Microsoft documentation and other tools |
| [MIT license](../LICENSE) and [third-party notices](../THIRD_PARTY_NOTICES.md) | Licensing boundaries between curated code and imported queries |

## Repository conventions

- Curated files live directly under `scripts/<category>/`; synthetic language examples live under `examples/`.
- `scripts/script-generation/` contains T-SQL queries that return administrative command text. Running a generator does not execute its output.
- Imported files live under `scripts/<category>/glenn-berry/<purpose>/<platform>/`. Their three-digit prefix retains the upstream query number, not an execution order for the directory.
- Names use English and `kebab-case.sql`. Each file has one diagnostic purpose, which can require multiple SQL statements.
- Query headers describe context, platform, execution mode, permissions, limitations, sources and validation status. Read the original comments in imported queries as well.
- `catalog.json` contains one entry per SQL file. Imported entries also record author, original source number and line range, platform, hashes and adaptations. Repeated titles across platforms are intentional.
- Generated Glenn Berry SQL and navigation pages are maintained through `tools/import_glenn_berry.py`; do not edit them independently of the generator and source lock.
- Store query results outside the repository. Only source code, documentation, synthetic examples and validation tooling belong here.

## Current validation boundary

The automated workflow parses SQL, checks catalog coverage and publication rules, verifies reviewed import hashes, and scans files and reachable Git history for secrets. It does not connect to a SQL Server or Azure database. Platform labels describe intended targets or upstream suites; runtime behavior, minimum permissions and resource cost still require testing in your environment.

[Return to the project README](../README.md).
