# Delegate — available agents

## Tools

### claude

Non-interactive invocation, prompt over stdin:

    claude -p --model <model> --output-format json --permission-mode bypassPermissions

`--permission-mode bypassPermissions` avoids a headless call blocking on an
approval prompt no one is present to answer. Add `--effort
<low|medium|high|xhigh|max>` (default `high`) to trade cost against depth
without changing model.

#### Identification

Add `-n <name>` to name the session — shown in `/resume` and searchable in
its transcript, so it can be found again later. The result JSON's
`session_id` field also resumes it directly via `claude --resume <id>`.

### codex

Non-interactive invocation, prompt over stdin, result written to a file:

    codex exec --model <model> -s danger-full-access -o <output-file>

`-s` is codex's sandbox/approval policy (`read-only`, `workspace-write`,
`danger-full-access`) — `danger-full-access` is used here so a headless call
never blocks on an approval prompt no one is present to answer. Add `-c
model_reasoning_effort=<level>` to trade cost against depth without changing
model.

Codex model IDs use dots, not dashes — e.g. `gpt-5.6-sol`, not
`gpt-5-6-sol`.

#### Identification

Identified by the session id it prints at the start of a run (`session id:
...`); resume it with `codex resume <id>`.

## Models

Four axes rather than one blended score — these models trade places
depending on task shape, and a single number would hide that:

- **Depth** — can it crack a hard, ambiguous, or novel problem?
- **Execution** — can it drive a long agentic/terminal loop through
  well-specified work efficiently?
- **Cost-to-task** — realistic cost to get a representative task *done*,
  not price per token.
- **Fidelity** — does it do what was asked and report honestly,
  unsupervised? "Untested" means no evidence either way, not a neutral
  default.

Ratings are coarse and relative, not benchmark scores.

| tool | model | depth | execution | cost-to-task | fidelity | notes |
| --- | --- | --- | --- | --- | --- | --- |
| claude | claude-opus-5 | 5 | 4 | high | no flags found | current flagship; complex code, architecture, orchestration. Peaks around medium/high effort — `xhigh`/`max` mostly buys tokens, not quality |
| claude | claude-opus-4-8 | 4 | 4 | high | no flags found | previous-gen flagship, same price as Opus 5; not clearly worse for real work despite being positioned as superseded |
| claude | claude-fable-5 | 5 | 3 | highest | fallback risk — see notes | highest ceiling on paper, but doesn't clearly beat Opus 5 in practice at ~2× the cost. Reserve for the hardest, longest-horizon work, after Opus 5 |
| claude | claude-sonnet-5 | 3 | 4 | high — see notes | no flags found | general-purpose default; verbose at high/max effort and can cost more per finished task than Opus despite the lower price — use low/medium effort |
| claude | claude-haiku-4-5 | 1 | 2 | low | untested | fast, cheap; simple parsing, classification, copy |
| codex | gpt-5.6-sol | 4 | 5 | medium | flagged — see notes | OpenAI's coding/agentic flagship, strong at terminal and browsing tasks |
| codex | gpt-5.6-terra | 3 | 3 | low-medium | untested | everyday codex workhorse; often dominated by Luna or Sol on cost/capability — confirm locally before defaulting to it |
| codex | gpt-5.6-luna | 2 | 3 | lowest | untested | dramatically cheap and genuinely agentic, not just copy/parsing — good default for well-specified, verifiable, high-volume work |

## Notes

- Effort/reasoning level (`--effort` / `model_reasoning_effort`) trades cost
  against depth without switching models — try that before escalating.
- `gpt-5.6-sol` has been caught gaming evaluations (exploiting bugs, hiding
  it) under pressure — don't treat a clean-looking result as trustworthy by
  default.
- `claude-fable-5` can silently run as Opus 4.8 instead on certain sensitive
  prompts, and has been fully unavailable before (a multi-week export-control
  suspension) — don't assume a Fable 5 request always runs as requested.
- Cost-to-task reflects actual usage, not sticker price — `claude-sonnet-5`
  is priced low but can cost more per finished task than Opus at high effort.
