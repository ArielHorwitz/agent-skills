# Handoff WP1: unified vendor bridge script and its test

Context: read `landscape-synthesis-and-plan.md` in this directory (the
matrix and WP1 section), then `fix-claude.sh` at the repo root. Skim
`codex-compatibility-report.md` section "Implications for a bridge" and
`claude-compatibility-report.md` section "Implications for fix-claude.sh".

You are headless. Do the work yourself in this session, no subagents.
Do not commit. Do not touch anything under `/home/wiw` outside this
worktree and `/tmp`. Another delegate is editing README and docs in
parallel, so do not edit any `.md` file except your own report.

## Deliverables

1. `bridge.sh` at the repo root, POSIX `sh`, replacing `fix-claude.sh`
   (delete `fix-claude.sh`). Same style as the current script: `set -eu`,
   a `usage`, a `fail`, small helpers, comments at the top explaining what
   it ensures.
2. `tests/bridge-test.sh`, POSIX `sh`, runnable as `sh tests/bridge-test.sh`
   from the repo root, exit 0 on pass, nonzero with a clear message on
   failure. No dependencies beyond coreutils.
3. `wp1-bridge-script-report.md` in this case directory: what you built,
   the exact output format, test coverage, anything you deviated from
   below and why, and anything the docs writer must know.

## Interface (fixed, the docs are being written against it in parallel)

```
bridge.sh [options] <claude|codex|all> [directory]
```

- `directory` defaults to the current directory. It must exist.
- `-h`, `--help` prints usage.
- Always scaffold `<dir>/.agents/skills/` and, if missing, a stub
  `<dir>/.agents/agents.md` containing `# AGENTS.md` (as today).
- `claude`: ensure `<dir>/.claude/skills -> ../.agents/skills` and
  `<dir>/.claude/CLAUDE.md -> ../.agents/agents.md` (as today).
- `codex`:
  - If `<dir>` is not the home directory: ensure
    `<dir>/AGENTS.md -> .agents/agents.md`. If `<dir>/AGENTS.override.md`
    exists, print a warning that Codex will ignore `AGENTS.md` there.
  - If `<dir>` resolves to `$HOME`: do not create `~/AGENTS.md` (Codex
    would read it as a project file on top of the global one). Instead
    ensure `${CODEX_HOME:-$HOME/.codex}/AGENTS.md` links to
    `~/.agents/agents.md`. Use the relative target `../.agents/agents.md`
    when the Codex home is `$HOME/.codex`, otherwise an absolute target.
    Create the Codex home directory if missing. Warn if
    `AGENTS.override.md` exists there.
  - No skill symlinks for Codex. It reads `.agents/skills` natively and a
    second copy would show up as a duplicate skill.
- `all`: `claude` then `codex`.
- Compare paths with the home directory after resolving symlinks
  (`cd -P`), so `bridge.sh codex ~` and `bridge.sh codex /home/wiw/` behave
  the same.

## Reporting and exit status

Every path the script cares about gets exactly one line:

- `created <path>` for the scaffold file or directory.
- `linked <link> -> <target>` when a symlink was created.
- `ok <link> -> <target>` when a symlink already exists and points at the
  intended target (compare the link text, or the resolved path, either is
  fine as long as re-running is a clean `ok`).
- `exists <path> (regular file)` / `(directory)` / `(symlink -> <other>)`
  / `(dangling symlink -> <other>)` when something else occupies the link
  path. Never modify or remove it.
- `warning: <text>` for the `AGENTS.override.md` cases.

Exit 0 when every intended link is in place (`linked` or `ok`). Exit 1 if
any link was skipped because the path was occupied, after printing all
lines, so a caller can notice an incomplete bridge. Warnings alone do not
change the exit status. Print a final `Done. <dir>/.agents` line as today
only on exit 0.

## Test coverage (minimum)

Use `mktemp -d` sandboxes. For the home case, set `HOME` and `CODEX_HOME`
to temp directories for the invocation only. Cover:

1. Fresh directory, `all`: scaffold created, four links created, exit 0.
2. Re-run on the same directory: every link reports `ok`, nothing else
   changes (compare `ls -lR` before and after), exit 0.
3. Existing regular `AGENTS.md`: reported as `exists`, untouched, exit 1.
4. Existing directory at `.claude/skills`: `exists (directory)`, exit 1.
5. Symlink to a different target at `.claude/CLAUDE.md`: reported with
   the other target, untouched, exit 1.
6. Dangling symlink at `AGENTS.md`: reported as dangling, untouched,
   exit 1.
7. `AGENTS.override.md` present: link still created, warning printed,
   exit 0.
8. Home directory with default Codex home: `~/AGENTS.md` not created,
   `~/.codex/AGENTS.md -> ../.agents/agents.md` created, exit 0.
9. Home directory with `CODEX_HOME` elsewhere: absolute target, exit 0.
10. Home directory where `~/.codex/AGENTS.md` already links to
    `/abs/path/.agents/agents.md` (absolute, as a user may have made by
    hand): reported `ok`, exit 0.
11. `claude` only does not create `AGENTS.md`. `codex` only does not
    create `.claude`.
12. Unknown vendor word and missing directory fail with usage or error.

Run the test and paste its final output into your report.
