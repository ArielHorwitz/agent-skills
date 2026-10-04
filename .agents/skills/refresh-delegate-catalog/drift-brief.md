# Handoff: model drift since {{BASELINE_DATE}}

You are one of two independent researchers, each a model from a different
vendor. Don't coordinate with the other. Today is {{TODAY}}.

Use live web search. If web search doesn't work for you, say so at the top of
your report and stop.

## Scope

{{VENDORS}} models usable through the {{CLIS}} CLIs.

The baseline roster, as of {{BASELINE_DATE}}:

{{BASELINE_ROSTER}}

What the CLIs' own model listings show today:

{{CLI_MODEL_LISTINGS}}

## Your task

Find, for every vendor in scope, everything released, renamed, repriced,
deprecated, or retired since {{BASELINE_DATE}}, from vendor docs, changelogs,
model pages, and pricing pages. For every current model (baseline and new),
give:

- the exact model ID as the CLI accepts it
- release date
- vendor positioning (flagship, mid tier, cheap tier)
- current per-token pricing, with the date you read it
- context window
- supported effort or reasoning levels
- deprecation or retirement status and dates

Don't assess capability. That is a later phase.

## Rules

- Cite every claim with a URL and date, and distinguish vendor docs from
  secondhand reports.
- State your own model ID at the top of your report.
- You are headless: nobody will answer questions. Do what you can and state
  plainly what you couldn't.
- Do the work yourself. Don't spawn subagents or background agents.
- Write your report to `{{OUTPUT_PATH}}`. Don't modify or create anything else,
  and don't commit.
- No em-dashes.
