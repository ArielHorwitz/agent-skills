# Handoff: review the `refresh-delegate-catalog` skill draft

Repo: `/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog`.
You are one of two independent reviewers (different vendors). Read only; do
not modify any file.

## Read

- The draft: `.agents/skills/refresh-delegate-catalog/` (all files).
- What it was built from: `docs/casebook/2026-10-04__5f21657f/skill-design-brief.md`
  and the author's `author-report-skill-draft.md`.
- What it refreshes: `skills/delegate/` (SKILL.md, README.md, models.md, tools.md).
- Prior art as needed: `docs/casebook/2026-08-03__df73dba7/` (original
  multi-model research), `docs/casebook/2026-08-04__cf504f22/` (tools.md
  verification, "guidance over enumeration").

## Judge

The skill will be run by a lead agent that delegates the heavy phases, then
used again months later by a different session with no memory of this one.
Would it produce a trustworthy, current models.md and tools.md? Look for:

- Steps that would fail or mislead in practice (wrong assumptions about CLIs,
  sandboxes, web access, model availability, what a delegate can do).
- Bias or contamination the process doesn't control for.
- Overbuilt parts that cost more than they return, and missing parts.
- Ambiguity a fresh session would trip on.
- The author's open points ("For the lead to decide"): your view on each.

## Output

Your final message is the review: findings ranked most important first, each
with a concrete failure scenario and a suggested fix. Be direct; skip praise.
