# Delegate: tools

How to invoke each CLI headless and compose a posture from its knobs. The *why*,
including the up-front posture, the bounds, and verifying what you chose, is in
`SKILL.md`. Models are in `models.md`. Adding a tool is in the README.

`--help` is authoritative and worth one read per tool per session (`claude --help`,
`codex --help`, `codex exec --help`). Treat what's below as orientation: flags and
their effects shift across versions, so **confirm the posture you pick from what a
run reports** (denials, the sandbox header, what actually landed on disk) rather
than trusting a description.

## claude

    echo "follow <handoff>.md" | claude -p --model <model> --output-format json \
      --permission-mode acceptEdits --allowedTools "WebSearch WebFetch"

Prompt on stdin (as above) or as a positional arg after `-p`. Prefer stdin:
`--allowedTools` and `--add-dir` take several values and swallow a positional
prompt placed after them. The working dir is wherever you run it (`cd` there
first). `-n <name>` names the session. The result JSON's `session_id` resumes it
via `--resume <id>`. `--output-format json` returns structured output, including
the `permission_denials` that tell you what your posture blocked.
`--effort <low|medium|high|xhigh|max>` trades cost against depth (the default
varies by model).

Compose the posture:

- **`--permission-mode`** is the baseline for how much the delegate may change. The
  default here (`acceptEdits`) lets it edit within the working directory. Omit or
  lower it to keep it from changing things. `bypassPermissions` is unrestricted
  (needs an unrestricted delegator, see `SKILL.md`).
- **`--allowedTools "<tools>"`** pre-approves specific tools on top of the
  baseline: `WebSearch WebFetch` for web research (in the default), or the reads a
  constrained reviewer needs (`Read Grep Glob`, plus scoped shell like
  `Bash(git:*)`).
- **`--add-dir <path>`** (repeatable) grants a specific directory when the task
  reaches outside the working dir.

## codex

    echo "follow <handoff>.md" | codex --search exec --model <model> \
      -s workspace-write -o <output-file>

Prompt on stdin or as a positional arg. Set the working dir with `-C <dir>` (or run
from it); add `--skip-git-repo-check` to run outside a git repo. The session id
prints at the start. Resume it headless with `codex exec resume <id> "<prompt>"`
(plain `codex resume` is the interactive TUI). `-o <file>` writes the final
message. `-c model_reasoning_effort=<level>` trades cost against depth. Model IDs
use dots (`gpt-6.1-sol`, not `gpt-6-1-sol`).

Compose the posture:

- **`-s`/`--sandbox`** sets the baseline: `workspace-write` to edit the working dir
  (in the default; temp dirs are writable too, and the sandbox header lists every
  writable root), `read-only` to keep it from writing, `danger-full-access` for
  unrestricted (needs an unrestricted delegator, see `SKILL.md`). Pass it
  explicitly rather than relying on the default, which depends on the directory
  and on whether codex has marked it trusted in your config (running there can
  do that).
- **`--search`** (top-level, before `exec`) enables live web research via the
  native `web_search` tool (in the default). Recent versions may search without
  it, so leaving it out doesn't keep a delegate off the web.
- **`--add-dir <path>`** makes a specific directory writable alongside the
  workspace.

*Orientation observed with claude 2.1.286, codex 0.159.3. Confirm current behavior
via `--help` and what a run reports.*
