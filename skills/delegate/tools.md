# Delegate — tools

How to invoke each CLI headless and compose a posture from its knobs. The *why* —
the up-front posture, the bounds, verifying what you chose — is in `SKILL.md`;
models are in `models.md`; adding a tool is in the README.

`--help` is authoritative and worth one read per tool per session (`claude --help`,
`codex --help`, `codex exec --help`). Treat what's below as orientation: flags and
their effects shift across versions, so **confirm the posture you pick from what a
run reports** (denials, the sandbox header, what actually landed on disk) rather
than trusting a description.

## claude

    echo "follow <handoff>.md" | claude -p --model <model> --output-format json \
      --permission-mode acceptEdits --allowedTools "WebSearch WebFetch"

Prompt on stdin (as above) or as a positional arg after `-p`. The working dir is
wherever you run it (`cd` there first). `-n <name>` names the session; the result
JSON's `session_id` resumes it via `--resume <id>`. `--output-format json` returns
structured output — including the `permission_denials` that tell you what your
posture blocked. `--effort <low|medium|high|xhigh|max>` (default `high`) trades
cost against depth.

Compose the posture:

- **`--permission-mode`** — the baseline: how much the delegate may change. The
  default here (`acceptEdits`) lets it edit within the working directory; omit or
  lower it to keep it from changing things; `bypassPermissions` is unrestricted
  (needs an unrestricted delegator — see `SKILL.md`).
- **`--allowedTools "<tools>"`** — pre-approve specific tools on top of the
  baseline: `WebSearch WebFetch` for web research (in the default), or the reads a
  constrained reviewer needs (`Read Grep Glob`, plus scoped shell like
  `Bash(git:*)`).
- **`--add-dir <path>`** (repeatable) — grant a specific directory when the task
  reaches outside the working dir.

## codex

    echo "follow <handoff>.md" | codex --search exec --model <model> \
      -s workspace-write -o <output-file>

Prompt on stdin or as a positional arg. Set the working dir with `-C <dir>` (or run
from it); add `--skip-git-repo-check` to run outside a git repo. The session id
prints at the start; resume it headless with `codex exec resume <id> "<prompt>"`
(plain `codex resume` is the interactive TUI). `-o <file>` writes the final
message. `-c model_reasoning_effort=<level>` trades cost against depth. Model IDs
use dots (`gpt-5.6-sol`, not `gpt-5-6-sol`).

Compose the posture:

- **`-s`/`--sandbox`** — the baseline: `workspace-write` to edit the working dir
  (in the default), `read-only` to keep it from writing, `danger-full-access` for
  unrestricted (needs an unrestricted delegator — see `SKILL.md`). Pass it
  explicitly rather than relying on the default, which depends on the directory.
- **`--search`** (top-level, before `exec`) — web research via the native
  `web_search` tool (in the default).
- **`--add-dir <path>`** — make a specific directory writable alongside the
  workspace.

*Orientation observed with claude 2.1.220, codex 0.147.0; confirm current behavior
via `--help` and what a run reports.*
