# WP1 vendor bridge script report

## What was built

`bridge.sh` replaces `fix-claude.sh`. It is a POSIX `sh` script with the fixed
interface `bridge.sh [options] <claude|codex|all> [directory]`. It scaffolds
`.agents/skills` and `.agents/agents.md`, creates the two Claude links, and
creates the appropriate project or home Codex instruction link. Codex home
detection compares physical paths, custom `CODEX_HOME` is supported, existing
paths are never replaced, and an override file produces a warning without
changing a successful exit status.

`tests/bridge-test.sh` uses only POSIX shell utilities and coreutils-backed
commands. Run it from the repository root with:

```sh
sh tests/bridge-test.sh
```

## Output format

New scaffold paths use `created <path>`. New links use
`linked <link> -> <target>`, and matching links use
`ok <link> -> <target>`. Occupied link paths use one of:

```text
exists <path> (regular file)
exists <path> (directory)
exists <path> (symlink -> <other>)
exists <path> (dangling symlink -> <other>)
```

An override produces
`warning: <path> exists; Codex will ignore AGENTS.md there`. A fully successful
run ends with `Done. <directory>/.agents`. Any occupied intended link makes the
final status 1 after all applicable paths have been processed, and suppresses
the `Done` line. Errors use `error: <text>` on standard error.

Already-existing scaffold directories and the scaffold file are intentionally
silent because the specified output vocabulary defines `created` only for new
scaffold paths. Every intended link always produces exactly one status line.

## Test coverage

The test covers fresh `all`, an unchanged idempotent rerun, regular-file,
directory, foreign-symlink, and dangling-symlink collisions, override warning
behavior, default and custom Codex homes, an equivalent absolute home link,
vendor isolation, an unknown vendor, and a missing directory. It checks link
targets, preserved collision contents, output categories, exit statuses, and
the complete tree before and after the rerun.

Final output:

```text
PASS: bridge.sh vendor bridge tests
```

ShellCheck also passes for both scripts with the POSIX shell dialect.

## Deviation and documentation note

The minimum-coverage list says a fresh `all` run creates four links. The fixed
interface defines only three: `.claude/skills`, `.claude/CLAUDE.md`, and the
project `AGENTS.md`. The implementation and test follow the interface. At the
home directory, the Codex project link is replaced by the Codex-home link, so
an `all` home run likewise creates three links. Documentation should not claim
that Codex gets a skill link or that `all` creates four links.
