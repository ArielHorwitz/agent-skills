# WP6 fresh-eyes review findings (codex gpt-5.6-sol, medium effort)

## Finding

1. **High:** [bridge.sh](bridge.sh:134) accepts `.agents/agents.md` when it is a directory or other non-regular path. It creates links to that path and exits successfully, leaving both vendors without readable guidance. Require `-f` after the creation branch, report other path types as occupied, mark guidance unusable, and add a directory-collision test near [bridge-test.sh](tests/bridge-test.sh:78).

WP4 remediation: no findings. Regressions: no findings. Added tests are regression-sensitive. Syntax, ShellCheck, and tests pass.

**Verdict:** merge after fixing the invalid canonical guidance case.
## Lead follow-up

Reproduced. Fixed by requiring a regular file (`-f`, which follows symlinks) for `.agents/agents.md`, with a directory-collision test that fails against the previous script. Severity is overstated (it needs a user-made directory at that path), but the fix was trivial.

Also fixed the known `set -e` abort on an occupied Codex home: it now mirrors the Claude side, reporting `$CODEX_HOME/AGENTS.md` as skipped and returning, with a test.
