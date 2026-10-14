# Overview

## Goal

Incremental refresh of `skills/delegate/models.md` after Claude Haiku 5.5
shipped, four days after the full refresh in case 5f21657f (2026-10-04). The
user asked not to redo the full research, only to consider Haiku 5.5 and any
other model released since that refresh.

## Scope decisions

- Baseline: models.md and tools.md both at `0e21e2c`/`146fb4a`, 2026-10-04.
- tools phase skipped: installed CLIs unchanged (claude 2.1.286, codex 0.159.3).
  Newer versions are published (claude 2.1.293, codex 0.161.0) but upgrading
  is the user's call.
- Research limited to new models, each placed relative to the existing roster.
  The previous case's research reports are reused as the evidence for existing
  rows.

## Outcome

Approved and shipped. `models.md`: `claude-haiku-5-5` added at depth 2,
execution 2, cost-to-task lowest (level with GPT-6 Luna, ahead on terminal
work, dearer per task); Haiku 4.5 moved to "Not listed" as superseded; Sonnet
5.5 at `max` now "about the same" as Opus 5.5 per task after its cache-read
cut; price and long-input notes updated for Haiku 5.5's 5x tier past 100K
tokens. No other rating moved. `tools.md` untouched.

Trail: `drift-report.md`, `research-*.md`, `synthesis-*.md`,
`rating-reconciliation.md`, `verification-summary.md`, `run-log.md` (with
retrospective). Lessons folded into the `refresh-delegate-catalog` skill.

Open for the user: claude CLI 2.1.293+ is needed for Haiku 5.5 to get its
full context window.

## Status

Closed.
