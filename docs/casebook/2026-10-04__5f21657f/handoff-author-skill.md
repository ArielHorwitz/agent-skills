# Handoff: author the `refresh-delegate-catalog` skill

You are drafting a repo-local maintainer skill in this repo
(`/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog`, a git
worktree; work only here).

## Read first

- `docs/casebook/2026-10-04__5f21657f/skill-design-brief.md`: the lead's design
  decisions. Follow them; push back in your report where you disagree.
- `skills/delegate/` (SKILL.md, README.md, models.md, tools.md): what the skill
  refreshes, and the README's "Adding a tool" method.
- Prior art in `docs/casebook/`: the delegate design case (`2026-08-03__df73dba7`,
  esp. `handoff-models-research-wave2.md`, `wave2-synthesis.md`,
  `design-decisions.md`), the permission-posture case (`2026-08-04__cf504f22`,
  esp. `claim-verification-report.md`, `overview.md`'s reconciliation section),
  and the vendor compatibility case (find it with `ls docs/casebook`; it covers
  `.agents/` layout and explicit-only invocation conventions incl. Codex sidecars).
- Existing skills under `skills/` for house style (frontmatter, tone, length).

## Do

- Create `.agents/skills/refresh-delegate-catalog/` with `SKILL.md` and the
  minimal set of bundled templates the brief calls for.
- Match house style. No em-dashes anywhere in the files you write.
- Do NOT run the skill, research models, or edit `skills/delegate/`. Do not
  spawn other agents.
- Commit your work in this worktree (conventional-commit message, ending with
  the line `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`).

## Report

Write `docs/casebook/2026-10-04__5f21657f/author-report-skill-draft.md`: what you
built, every place you deviated from or resolved an open point in the brief and
why, and anything you think the lead should decide. Commit it too.
