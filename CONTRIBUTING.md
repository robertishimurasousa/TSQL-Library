# Contributing

This initial collection accepts read-only queries and synthetic examples. Scripts that modify state require a separate proposal covering scope and validation before this policy changes.

- Use UTF-8 without a BOM and `kebab-case.sql` filenames, with one purpose per file.
- Document context, target platform, permissions, limitations, sources and validation evidence in the header. Update `catalog.json` and `docs/catalog.md`.
- Use nullable parameters or synthetic examples. Do not include passwords, login hashes, tokens, archives, dumps, query results, customer names, endpoints or paths from real environments.
- Review comments, filenames and commits as well. Do not bypass the scanner with broad exceptions or suppression comments.
- Preserve attribution and verify the license for the version of any reused code. Prefer official links for complete third-party tools.
- Run the checks described in the README. To claim compatibility, record execution in a test environment, including version/build, permissions, scenario and results without private data.

`tools/validate.py` uses a restricted policy for statement types and operational keywords. It is an additional review gate, not a sandbox or proof that every accepted query is harmless. Changes to this policy require regression cases.
