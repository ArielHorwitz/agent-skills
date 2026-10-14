# Handoff: place a newly released model and update models.md

You are one of two independent synthesizers (different vendors). Don't
coordinate. Today is 2026-10-08.

The reference was fully researched and re-rated on 2026-10-04. Since then
Claude Haiku 5.5 shipped (and possibly others, see the drift reports). This is
an incremental update: place the new model(s), then revisit every existing row
in light of them, since ratings are relative.

## Inputs

New, in /mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/:

- `research-*.md`: three independent reports on the new model(s), each by
  the model in its filename (ignore `research-brief-*.md`, the briefs).
- `drift-report.md`: what was released or changed since 2026-10-04, with
  detail in `drift-models-*.md`.
- `run-log.md`, phase 1 and 2: smoke results, which IDs ran on the user's account.

Previous run, in /mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/ (evidence for the existing rows):

- `research-*.md` (six reports), `synthesis-*.md`, and
  `rating-reconciliation.md` (including a binding user correction on cost
  bands), `user-decisions.md` (binding).

The file being updated: `/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/skills/delegate/models.md`. Read it only after
you've formed a view on the new model(s) from the research.

## Rules for the draft

- Axes are **depth, execution, cost-to-task** only. No notes on honesty,
  gaming, outages, substitution, or availability.
- Ratings are relative across the whole table. Place the new model, then say
  for every existing row whether it moves and why. Don't move an existing
  rating without evidence from the new or previous research.
- Decide whether the new model earns a row and whether it supersedes an
  existing row (the file lists only models not dominated by a same-vendor
  sibling; superseded ones go in the "Not listed" note). Update the notes
  (starting choices, sticker prices, effort defaults) to match.
- Weigh evidence by quality (independence, recency, authority), not by how
  many reports repeat it. Several reports citing one page are one source. A
  days-old model has thin independent signal: rate it on what is known and
  keep its notes honest about that without naming sources. Mark any judgment
  a researcher made about its own vendor or itself.
- Write the draft as the shipped file: same structure and voice as the
  current models.md, no research process, no source names, no "this used to
  say X". Footer: "*Table and notes last updated: 2026-10-08.*" No em-dashes.

## Output

- `/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/synthesis-gpt-6-astra.md`: convergent findings and what each rests on;
  real disagreements, left unresolved where the evidence doesn't settle them;
  every rating or note change from the current file with its reason; rows
  added or dropped and why.
- `/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/models-draft-gpt-6-astra.md`: the draft.

Write only those two files. Don't commit. Do the work yourself, no
subagents, no background agents. State your model ID at the top of the
synthesis.
