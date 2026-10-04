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

Ratings are coarse and relative, not benchmark scores. Cost-to-task runs
lowest, low, medium, medium-high, high, highest. They assume the effort
level named in the row's notes: effort moves cost-to-task roughly 4x to 18x
within a single model, so a row rated at `high` is a different proposition at
`max`.

| tool | model | depth | execution | cost-to-task | notes |
| --- | --- | --- | --- | --- | --- |
| claude | claude-opus-5-5 | 5 | 5 | high | default for hard or ambiguous work, among the strongest on software and agentic knowledge work. Starts at `medium`; `high` is a good default, `xhigh` when a first pass falls short. `max` roughly doubles the cost of `xhigh` for little measurable gain, runs long, and can spend the whole output window thinking and return nothing |
| claude | claude-sonnet-5-5 | 4 | 5 | medium-high, see notes | close to Opus at `max` but a step behind at lower effort, and among the strongest on terminal-heavy loops. Cheaper than Opus 5.5 below `max`, more expensive at `max`, so it isn't the budget Claude either. `medium`/`high` for routine work, `xhigh` for hard loops; avoid `max` unattended |
| claude | claude-fable-5-1 | 4 | 4 | highest | positioned as the escalation above Opus 5.5 for demanding reasoning and long-horizon work, but doesn't beat Opus 5.5 overall (it leads only in some problem classes) and costs more per task. Reserve for when Opus 5.5 at `xhigh` falls short |
| claude | claude-haiku-4-5 | 1 | 1 | low | cheap for Claude-only pipelines: simple parsing, classification, copy. Scores near zero on terminal tasks, so keep it off shell work. If the vendor doesn't matter, GPT-6 Luna does more for less |
| codex | gpt-6-astra | 5 | 4 | medium-high | OpenAI's flagship, top on figure-out-the-mechanism problems and strong on novel math. Frugal with tokens, so cost-to-task is moderate despite the top sticker price. `medium` is already strong, `high` for hard debugging |
| codex | gpt-6.1-sol | 4 | 5 | low | excellent cost-to-quality: near-Astra depth and top-tier agentic coding at several times less per task than the frontier models. Default executor for well-specified work and parallel fan-out. `xhigh` for coding (matches or beats its own `max` at about half the cost), `medium` for simple work |
| codex | gpt-6-luna | 2 | 2 | lowest | dramatically cheap: classify, extract, transform, summarise, small verifiable code edits. Weak on terminal tasks, so keep it to bounded, checkable work. `medium` or higher for anything agentic |

## Notes

- Starting choices, not universal winners: `gpt-6.1-sol` for ordinary
  implementation, `claude-opus-5-5` for demanding engineering, `gpt-6-astra`
  for novel mathematical or mechanism-finding problems, `claude-sonnet-5-5` as
  a strong alternative for scoped execution.
- Effort (`--effort` / `model_reasoning_effort`) is a lever comparable to model
  choice, and `max` is seldom worth it. Try raising effort before switching to
  a stronger model, and lowering it before switching to a cheaper one. Opus 5.5
  and Sonnet 5.5 start at `medium` in Claude Code, Fable 5.1 at `high`.
- Cost-to-task reflects tokens actually spent, not sticker price. At `max` the
  Claude 5.5 models emit roughly four to ten times Astra's output tokens, so
  Sonnet 5.5 at $2/$10 costs more per task than Opus 5.5 at $4/$20, and Astra
  at $10/$50 costs less than either.
- Sticker prices per million input/output tokens, for reference: Fable 5.1 and
  Astra $10/$50, Opus 5.5 $4/$20, Sonnet 5.5 and 6.1 Sol $2/$10, Haiku 4.5
  $1/$5, 6 Luna $0.10/$0.50.
- Long inputs: the codex models bill the whole request at 2x input and 1.5x
  output once input passes 272K tokens. Claude bills flat across its 1M
  window, so very large contexts favor claude on cost.
- Not listed: the still-callable previous generation (Opus 5, Opus 4.8,
  Fable 5, Sonnet 5, GPT-6 Sol, GPT-5.6 Sol/Terra/Luna). Each is superseded by
  a listed model from the same vendor that is better, cheaper, or both.

*Table and notes last updated: 2026-10-04.*
