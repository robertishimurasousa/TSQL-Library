# Contributing

The curated collection accepts metadata queries, nonexecuting command generators and synthetic examples. Scripts that modify persistent state require a separate proposal covering scope and validation. One exact-hash-reviewed cross-database collector uses local temporary tables and parameterized dynamic catalog reads. The Glenn Berry import separately retains reviewed diagnostic calls, local temporary tables and session control flow, bound to exact source and output hashes. Neither exception widens the ordinary curated SQL policy.

- Write filenames, comments, documentation, issues and pull requests in English. Use UTF-8 without a BOM and `kebab-case.sql` filenames, with one purpose per file.
- Document context, target platform, permissions, limitations, sources and validation evidence in the header. Update `catalog.json` and `docs/catalog.md`.
- Use nullable parameters or synthetic examples. Do not include passwords, login hashes, tokens, archives, dumps, query results, customer names, endpoints or paths from real environments.
- Review comments, filenames and commits as well. Do not bypass the scanner with broad exceptions or suppression comments.
- Preserve attribution and verify the license for the version of any reused code. Prefer official links for complete third-party tools.
- Run the checks described in the README. To claim compatibility, record execution in a test environment, including version/build, permissions, scenario and results without private data.

`tools/validate.py` uses a restricted policy for statement types and operational keywords. It is an additional review gate, not a sandbox or proof that every accepted query is harmless. Changes to this policy require regression cases.

Command generators must require explicit targets, quote identifiers with `QUOTENAME`, escape Unicode string literals and return text without executing it. Document the permissions and effects of executing that text separately. Changes to the reviewed collector require source review and a new exact checksum; never add a directory-wide EXEC or DDL exemption. Do not import private conversations, customer-specific indicators, execution logs or attachments as provenance.

For Glenn Berry files, follow the [reproducible import procedure](docs/glenn-berry/README.md#validation-and-updates). Preserve the original copyright and non-commercial terms. Update the generator and source lock deliberately rather than hand-editing generated SQL. Review changes to individual checksum-bound exception receipts; never add a folder-wide exclusion or exempt credentials or parser failures.
