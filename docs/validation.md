# Validation

Review date: November 5, 2026.

| Check | Result |
|---|---|
| Static review of selected scripts | 34 files reviewed |
| SQLFluff 4.5.0 parser, T-SQL dialect | 34 files, zero errors |
| Catalog, encoding, file types and read-only policy | Passed local checks |
| Validator regression tests | 8 tests passed |
| Additional secret rules | 3 synthetic cases detected by Gitleaks |
| Gitleaks 8.30.1, default and additional rules | Zero findings in the prepared files |
| Execution in SQL Server | Pending |
| Minimum permissions and version compatibility | Pending |
| Curated Git history | Rebuilt from the selection; CI continues to scan all references |
| GitHub workflow execution | See the run for the relevant commit in the Actions tab |

Syntax checking does not resolve column names against a server or test permissions, performance, the availability of SQL Agent/Always On, or actual results. The parser and scanner do not replace contextual review.

## Planned execution tests

Use a disposable instance, a test database and synthetic data. Record the version/build and permissions without exporting private data to Git.

- Inventory, files, services and security: compare results with the test environment's catalogs; include an account with restricted visibility.
- Tables and indexes: create a table with multiple indexes and partitions; confirm that approximate row counts are not multiplied by secondary indexes.
- Blocking: open two test sessions and a controlled transaction; verify that the blocker is identified even when it has no active request.
- Cache and counters: run a small, known workload and observe the counter window; do not require rows to remain after cache eviction or a restart.
- SQL Agent: cover a job that has never run, failures, successes and runs longer than 24 hours; verify duration in seconds and activity from the latest Agent session.
- Backup: generate FULL, DIFF, LOG and COPY_ONLY backups in the test environment; confirm that types are reported separately. The query does not validate restores.
- Always On: requires a test environment with an availability group; record primary and secondary replica behavior and visibility limits.
- Examples: default pagination should return IDs 3 and 4; the NULL example should mark only ID 1 as `Missing`; the two scores of 20 in group A should have the same rank and distribution values.

Update catalog status only when there is evidence for the completed step. Do not use the term "validated" without specifying whether it means static review or execution testing.

## Updating older clones

After a history rewrite, use a fresh clone. Do not merge branches or clones from before the cleanup: this can reintroduce removed commits. Keep private recovery copies outside the repository and without a publication remote.

CI scans current files and all reachable history in separate steps. Python bytecode generation is disabled so that synthetic test credentials are not embedded in cache files; source files remain subject to scanning.
