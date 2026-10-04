# Handoff: synthesize the model research and draft models.md

You are one of two independent synthesizers, each a model from a different
vendor. Don't coordinate with the other. Today is {{TODAY}}.

## Inputs

All in `{{CASE_DIR}}`:

- `research-*.md`: independent research reports, each by the model in its
  filename. Ignore `research-brief-*.md`, the briefs they followed.
- `drift-report.md`: the candidate roster and what changed since
  {{BASELINE_DATE}}, with detail in `drift-models-*.md`.
- `user-decisions.md`, if present: binding.

The file being replaced is `{{MODELS_MD_PATH}}`. Read it only after you've
formed a view from the research.

## Rules for the draft

- Rate on these axes only: {{AXES}}. No notes on honesty, evaluation gaming,
  outages, or silent substitution.
- Re-rate every row. Ratings are relative across the whole table. Decide which
  candidates earn a row at all (a model dominated by another from its own vendor
  may not) and say why in the synthesis.
- Weigh evidence by quality (independence, recency, authority), not by how many
  reports repeat it. Several reports citing one page are one source. Mark any
  judgment a researcher made about itself or its own vendor.
- Make every scale self-explanatory. If an axis uses words rather than numbers,
  state their order in the file.
- Be sparing with superlatives ("fastest", "cheapest") and ratios ("half the
  cost"). They are the claims most often overstated. Use one only where the
  evidence clearly supports it, and otherwise prefer a plain comparison.
- Keep every comparison's conditions: the workload, the effort level, and what
  was measured. "Faster" or "cheaper" can reverse with any of them.
- Write for a delegator who has never seen the research: no shorthand or jargon
  that needs the reports to understand.
- Write it as the shipped file: the same structure and voice as the current
  file, no research process, no source names, no "this used to say X". Footer:
  "*Table and notes last updated: {{TODAY}}.*" No em-dashes.

## Output

- `{{SYNTHESIS_PATH}}`: convergent findings and what each rests on, real
  disagreements (left unresolved where the evidence doesn't settle them),
  per-model evidence attributed to the reports, every rating change from the
  current file with its reason, and rows dropped and why. State your own model
  ID at the top.
- `{{DRAFT_PATH}}`: the draft.

Write only those two files, and don't commit. You are headless: nobody will
answer questions. Do the work yourself. Don't spawn subagents or background
agents.
