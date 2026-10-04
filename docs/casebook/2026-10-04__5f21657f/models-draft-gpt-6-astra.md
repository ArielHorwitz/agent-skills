# Delegate models

Which models to pick for a task. Tool *invocations* and their permission flags
live in `tools.md`. The permission *doctrine* (posture and the bounds) lives in
`SKILL.md`.

## Models

Three axes rather than one blended score. These models trade places depending
on task shape:

- **Depth**: can it crack a hard, ambiguous, or novel problem?
- **Execution**: can it drive a long agentic/terminal loop through
  well-specified work efficiently?
- **Cost-to-task**: realistic cost to get a representative task *done*,
  including failed attempts and repair, not price per token.

Ratings are coarse and relative, not benchmark scores. Depth and execution run
from 1 (limited) to 5 (leading). They describe capability at a suitable effort,
not a promise at every setting. Cost bands reflect task shape and effort.
For small models, low cost assumes bounded work they can finish.

| tool | model | depth | execution | cost-to-task | notes |
| --- | --- | --- | --- | --- | --- |
| claude | claude-opus-5-5 | 5 | 5 | medium-high | demanding engineering, architecture, and professional deliverables. Start medium/high, use xhigh for harder decisions. Max can add substantial time and output |
| claude | claude-sonnet-5-5 | 4 | 5 | medium-high | strong implementation, migrations, and web work. Start medium/high for scoped work, consider xhigh for difficult loops. Max can erase its price advantage over Opus |
| claude | claude-fable-5-1 | 4 | 4 | high | alternative for difficult investigations when another approach stalls. Start high. A different reasoning path, without a general depth advantage over Opus 5.5 or Astra |
| claude | claude-haiku-4-5 | 1 | 2 | low | simple parsing, classification, and copy when the task calls for Claude. Keep work bounded and easy to check |
| codex | gpt-6-astra | 5 | 4 | medium-high | hard novel reasoning, mathematics, and scientific investigations. Start high, consider xhigh/max for the hardest problems. Strong execution, with a substantial premium over Sol |
| codex | gpt-6.1-sol | 4 | 5 | low-medium | economical general executor and capable investigator. Start medium/high, use xhigh for difficult coding. Max need not improve execution |
| codex | gpt-6-luna | 2 | 3 | lowest | extraction, inventories, mechanical transformations, and small verified edits. Start medium for code. Move to Sol when the task needs sustained judgment |

## Notes

- Match effort/reasoning level (`--effort` / `model_reasoning_effort`) to the
  task. More effort can improve depth or reduce wasted actions, but can also
  lengthen a run without improving its result. Maximum is not a default.
- For ordinary implementation, start with `gpt-6.1-sol`. For demanding
  engineering, choose `claude-opus-5-5`. For novel mathematical or scientific
  problems, choose `gpt-6-astra`. `claude-sonnet-5-5` is a strong alternative
  for scoped execution. These are starting choices, not universal winners.
- Cost-to-task reflects the whole run. Sonnet 5.5 can cost less than Opus 5.5
  on scoped work and more at max on other workloads. Astra's higher token
  price can be offset by shorter output. Fable 5.1's cheaper cache reads do
  not guarantee cheaper tasks.
- Task cost also depends on context, caching, and service tier. GPT-6
  requests above 272K input tokens have higher rates for the whole request.
  Token prices alone do not settle which model completes that work cheapest.
- Small models suit work with clear acceptance checks. Their low cost does
  not make them economical substitutes for sustained difficult investigations.

*Table and notes last updated: 2026-10-04.*
