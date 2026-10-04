# Tools re-verification (phase 6), 2026-10-04

Lead-run probes, claude 2.1.286 (claude-haiku-4-5) and codex 0.159.3
(gpt-6-luna), each in a disposable git repo under /tmp, natural task prompts
(no posture named). Help snapshots in `help/`; every flag tools.md documents is
still present.

## claude

| probe | result |
| --- | --- |
| no `--permission-mode`, create a file | denied, returned in 4s ("I need your permission"), 1 denial. No hang. |
| `acceptEdits`, create a file in cwd | created |
| `acceptEdits`, write outside cwd | denied, returned |
| `acceptEdits --add-dir <dir>`, write there | written |
| `--allowedTools "WebSearch WebFetch"`, web question | answered with live result (codex 0.160.0 on npm) |
| no web tools granted, web question | WebSearch denied, returned |
| `--resume <id>` | recalled the earlier session's file |

**Gotcha:** `--add-dir` and `--allowedTools` are variadic and swallow a
positional prompt after them ("Input must be provided either through stdin or
as a prompt argument"). Passing the prompt on stdin, as tools.md shows, avoids
it. Worth one line in tools.md.

## codex

| probe | result |
| --- | --- |
| no `-s`, create a file (real config and isolated `CODEX_HOME`) | sandbox read-only, refused, returned |
| `-s read-only` (real and isolated) | refused, returned |
| `-s workspace-write`, create in cwd | created. Header: `workspace-write [workdir, /tmp, $TMPDIR]` |
| `-s workspace-write`, write under `$HOME` outside cwd | refused ("outside the writable workspace") |
| `-s workspace-write`, write under /tmp outside cwd | **written** (/tmp is a writable root) |
| `-s workspace-write --add-dir <dir>`, write there | written; dir appears in the header |
| `--search`, web question | live answer |
| **no `--search`**, web question (real and isolated config) | **still searched** (web_search events, live answer 0.160.0, newer than installed) |
| `codex exec resume <id> "<prompt>"` | recalled the earlier session's file |

Changes vs tools.md:

- Web search is available without `--search` at this version; `--search` is no
  longer what grants it. Whether it is live or cached without the flag is not
  established. Keep `--search` in the default (harmless, explicit) and soften
  the wording.
- workspace-write also covers /tmp and `$TMPDIR` (shown in the sandbox header).
  tools.md already says to read the header; worth naming.

## Side effect (lesson)

Running `codex exec -s workspace-write` in a directory **adds a
`trust_level = "trusted"` entry for it to `~/.codex/config.toml`**. Six probe
dirs got entries; the lead removed them (backup at
/tmp/codex-config.backup.toml). The skill's "never modify the real
configuration" can't be honored by the lead alone: codex does it. Skill should
say to clean trust entries for probe dirs afterward, or run real-config probes
in fewer dirs.
