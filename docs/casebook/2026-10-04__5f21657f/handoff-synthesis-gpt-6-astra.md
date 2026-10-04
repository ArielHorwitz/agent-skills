# Handoff: synthesize the model research and draft models.md

You are one of two independent synthesizers (different vendors). Don't
coordinate. Today is 2026-10-04.

## Inputs (all in /mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/)

- `research-*.md` (six independent research reports, each by the model in its
  filename; ignore `research-brief-*.md`, those are the briefs they followed)
- `drift-report.md` (the candidate roster of 15 models and what changed since
  2026-08-05), with detail in `drift-models-*.md`
- `user-decisions.md`: binding
- The file being replaced: `/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/skills/delegate/models.md`. Read it only after
  you've formed a view from the research.

## Rules for the draft

- Axes are **depth, execution, cost-to-task** only. No fidelity column, no notes
  on honesty, gaming, outages, substitution, or availability (user decisions).
- Re-rate every row; ratings are relative across the whole table. Decide which
  of the 15 candidates belong in the table at all (a dominated legacy model may
  not earn a row) and say why in the synthesis.
- Weigh evidence by quality (independence, recency, authority), not by how many
  reports repeat it. Several reports citing one page are one source. Mark any
  judgment a researcher made about its own vendor or itself.
- Write the draft as the shipped file: same structure and voice as the current
  models.md, no research process, no source names, no "this used to say X".
  Footer: "*Table and notes last updated: 2026-10-04.*" No em-dashes.

## Output

- `/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/synthesis-gpt-6-astra.md`: convergent findings and what each rests on; real
  disagreements, left unresolved where the evidence doesn't settle them;
  per-model evidence attributed to the reports; every rating change from the
  current file with its reason; rows dropped and why.
- `/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/models-draft-gpt-6-astra.md`: the draft.

Write only those two files. Don't commit. Do the work yourself, no subagents.
State your model ID at the top of the synthesis.
