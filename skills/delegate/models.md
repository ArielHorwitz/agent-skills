# Delegate — models

Which models are available and how to pick one for a task. Tool *invocations*
and their permission flags live in `tools.md`; the permission *doctrine* (posture
and the bounds) lives in `SKILL.md`.

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

*Table and notes last updated: August 2026.*
