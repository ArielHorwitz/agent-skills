# Delegate: models

Which models are available and how to pick one for a task. Tool *invocations*
and their permission flags live in `tools.md`. The permission *doctrine*
(posture and the bounds) lives in `SKILL.md`.

## Models

Three axes rather than one blended score, because these models trade places
depending on task shape and a single number would hide that:

- **Depth**: can it crack a hard, ambiguous, or novel problem?
- **Execution**: can it drive a long agentic/terminal loop through
  well-specified work efficiently?
- **Cost-to-task**: realistic cost to get a representative task *done*,
  not price per token.

Ratings are coarse and relative, not benchmark scores. They assume the effort
level named in the row's notes: effort moves cost-to-task 5x to 18x within a
single model, so a row rated at `high` is a different proposition at `max`.

| tool | model | depth | execution | cost-to-task | notes |
| --- | --- | --- | --- | --- | --- |
| claude | claude-opus-5-5 | 5 | 5 | high | default for hard or ambiguous work, strongest on software and agentic knowledge work. Starts at `medium`; `high` is the sweet spot, `xhigh` when a first pass falls short. `max` roughly doubles cost for a point or two, can run for hours, and can spend the whole output window thinking and return nothing. Slow: two to three times Astra's wall clock |
| claude | claude-sonnet-5-5 | 4 | 5 | high, see notes | Opus-class quality on most work and the best terminal-loop scores of any model, but not the budget Claude: its token appetite puts cost-to-task at Opus level, and above it at `max`. `medium`/`high` for routine work, `xhigh` for hard loops. Never `max` unattended |
| claude | claude-fable-5-1 | 4 | 4 | highest | positioned as the escalation above Opus 5.5 for demanding reasoning and long-horizon work, but doesn't measurably beat Opus 5.5 on hard problems, and is the slowest and most expensive model per task. Reserve for when Opus 5.5 at `xhigh` falls short. Edges: knowledge recall, competitive coding, fewer tokens per coding task than Opus 5.5 |
| claude | claude-haiku-4-5 | 1 | 1 | low | fast and cheap for Claude-only pipelines: simple parsing, classification, copy. Not for shell work. If the vendor doesn't matter, GPT-6 Luna does more for less |
| codex | gpt-6-astra | 5 | 4 | medium-high | strongest on novel math, science, and figure-out-the-mechanism problems; fastest frontier model and frugal with tokens, so cost-to-task is moderate despite the top sticker price. `medium` (default) is already strong, `high` for hard debugging. Trails the Claude 5.5 pair on terminal-heavy loops and can overthink small tasks |
| codex | gpt-6.1-sol | 4 | 5 | low | best cost-to-quality of any model: near-Astra depth and top-tier agentic coding at a fifth to a tenth of the frontier cost per task, and fast. Default executor for well-specified work and parallel fan-out. `xhigh` is the sweet spot for coding and beats its own `max`; `medium` for simple work. Trails Opus/Sonnet 5.5 on terminal-heavy loops |
| codex | gpt-6-luna | 2 | 2 | lowest | dramatically cheap: classify, extract, transform, summarise, small verifiable code edits. Weak at terminal loops, so don't let it drive a shell unsupervised. `medium` or higher for anything agentic |

## Notes

- Effort (`--effort` / `model_reasoning_effort`) is a bigger lever than model
  choice: the same model spans 5x to 18x in cost-to-task across its range, and
  `max` is rarely the best setting (6.1 Sol at `xhigh` beats its own `max` on
  agentic coding at two-thirds the cost). Raise effort before switching to a
  stronger model, and lower it before switching to a cheaper one. Defaults:
  Opus 5.5 and Sonnet 5.5 start at `medium` in Claude Code, Fable 5.1 at
  `high`, and the codex models at `medium`.
- Cost-to-task reflects tokens actually spent, not sticker price. Per task the
  Claude 5.5 models emit four to seven times Astra's output tokens, so at
  `max` Sonnet 5.5 at $2/$10 costs more per finished task than Opus 5.5 at
  $4/$20, and Astra at $10/$50 costs less than either.
- Sticker prices per million input/output tokens, for reference: Fable 5.1 and
  Astra $10/$50, Opus 5.5 $4/$20, Sonnet 5.5 and 6.1 Sol $2/$10, Haiku 4.5
  $1/$5, 6 Luna $0.10/$0.50.
- Wall clock: the Claude flagships take two to three times as long as Astra or
  6.1 Sol on the same work. When time matters, go codex.
- Long inputs: the codex models bill the whole request at 2x input and 1.5x
  output once input passes 272K tokens. Claude bills flat across its 1M
  window. Route very large contexts to claude unless speed is the point.
- Not listed: the still-callable previous generation (Opus 5, Opus 4.8,
  Fable 5, Sonnet 5, GPT-6 Sol, GPT-5.6 Sol/Terra/Luna). Each is beaten on
  both quality and cost-to-task by a listed model from the same vendor.

*Table and notes last updated: 2026-10-04.*
