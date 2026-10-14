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
lowest, low, medium, medium-high, high, highest. Ratings assume the task and
effort described in each row. Effort can change task cost by an order of
magnitude, so a row rated at `high` is a different proposition at `max`.
Sharing a band doesn't mean equal performance or equal cost on every task.

| tool | model | depth | execution | cost-to-task | notes |
| --- | --- | --- | --- | --- | --- |
| claude | claude-opus-5-5 | 5 | 5 | high | default for hard or ambiguous work, among the strongest on software and agentic knowledge work. Starts at `medium`; `high` is a good default, `xhigh` when a first pass falls short. `max` roughly doubles the cost of `xhigh` for little measurable gain, runs long, and can spend the whole output window thinking and return nothing |
| claude | claude-sonnet-5-5 | 4 | 5 | medium-high, see notes | close to Opus at `max` but a step behind at lower effort, and among the strongest on terminal-heavy loops. Usually cheaper than Opus 5.5 below `max`, but heavy reasoning can erase the saving. `medium`/`high` for routine work, `xhigh` for hard loops; avoid `max` unattended |
| claude | claude-fable-5-1 | 4 | 4 | highest | positioned as the escalation above Opus 5.5 for demanding reasoning and long-horizon work, but doesn't beat Opus 5.5 overall (it leads only in some problem classes) and costs more per task. Reserve for when Opus 5.5 at `xhigh` falls short |
| claude | claude-haiku-5-5 | 2 | 2 | lowest, see notes | inexpensive Claude worker for bounded reading, extraction, summaries, and small checked edits. Start at `medium`, use `high` for longer tool sequences, and name the completion checks. More terminal headroom than Luna, but no consistent lead across workflows. Early evidence supports short tasks, not sustained difficult loops. Cost assumes prompts up to 100K and moderate effort; long prompts and `xhigh`/`max` can erase the saving |
| codex | gpt-6-astra | 5 | 4 | medium-high | OpenAI's flagship, top on figure-out-the-mechanism problems and strong on novel math. Frugal with tokens, so cost-to-task is moderate despite the top sticker price. `medium` is already strong, `high` for hard debugging |
| codex | gpt-6.1-sol | 4 | 5 | low | excellent cost-to-quality: near-Astra depth and top-tier agentic coding at several times less per task than the frontier models. Default executor for well-specified work and parallel fan-out. `xhigh` for coding (matches or beats its own `max` at about half the cost), `medium` for simple work |
| codex | gpt-6-luna | 2 | 2 | lowest | dramatically cheap: classify, extract, transform, summarise, small verifiable code edits. Weak on terminal tasks, so keep it to bounded, checkable work. Often cheaper per task than Haiku 5.5, especially with long prompts, though the winner depends on the workload. `medium` or higher for anything agentic |

## Notes

- Starting choices, not universal winners: `gpt-6.1-sol` for ordinary
  implementation, `claude-opus-5-5` for demanding engineering, `gpt-6-astra`
  for novel mathematical or mechanism-finding problems, `claude-sonnet-5-5` as
  a strong alternative for scoped execution. For small, checkable subtasks,
  start with `claude-haiku-5-5` at `medium` or `gpt-6-luna`.
- Effort (`--effort` / `model_reasoning_effort`) is a lever comparable to model
  choice, and `max` is seldom worth it. Try raising effort before switching to
  a stronger model, and lowering it before switching to a cheaper one. For
  difficult Haiku work, compare Sonnet or Sol before buying `xhigh`/`max`.
  Opus 5.5, Sonnet 5.5, and Haiku 5.5 start at `medium` in Claude Code,
  Fable 5.1 at `high`.
- Cost-to-task reflects tokens actually spent, not sticker price. Opus 5.5
  and Sonnet 5.5 can consume several times Astra's output tokens at `max`,
  making Astra cheaper per task despite its higher sticker price. Haiku 5.5
  and Luna share the short-prompt rate, but Haiku can spend much more on
  thinking and tool turns. Fast token output doesn't guarantee fast completion.
- Sticker prices per million input/output tokens, for reference: Fable 5.1 and
  Astra $10/$50, Opus 5.5 $4/$20, Sonnet 5.5 and 6.1 Sol $2/$10, Haiku 5.5
  and 6 Luna $0.10/$0.50 at their short-prompt rates. Sonnet 5.5 cache reads
  cost $0.10 per million tokens, which helps loops that reuse large prefixes.
- Long inputs: Haiku 5.5 bills the whole request at $0.50/$2.50 once the
  prompt exceeds 100K tokens, five times its short-prompt rates. Its 1M window
  doesn't mean flat pricing. The codex models bill the whole request at 2x
  input and cache rates and 1.5x output once input passes 272K tokens.
  Luna's input/output rates above that threshold are $0.20/$0.75, still below
  Haiku's long-prompt rates. Opus 5.5, Sonnet 5.5, and Fable 5.1 bill flat
  across 1M. Compare actual token counts and task cost before routing large
  contexts by vendor.
- Not listed: the previous generation (Opus 5, Opus 4.8, Fable 5, Sonnet 5,
  Haiku 4.5, GPT-6 Sol, GPT-5.6 Sol/Terra/Luna). Each is superseded by a listed
  model from the same vendor that is better, cheaper, or both.

*Table and notes last updated: 2026-10-08.*
