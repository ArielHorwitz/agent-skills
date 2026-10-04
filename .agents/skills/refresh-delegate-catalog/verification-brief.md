# Handoff: verify the claims in a draft model reference

You are one of several independent verifiers checking the same draft in
parallel, each a different model. Don't coordinate with the others.

## Context

A repo has a skill (`delegate`) that lets an agent spawn another agent through a
CLI. Its reference file on which models to pick has been redrafted from several
research reports. Every delegate spawn will read it as settled fact, so each
claim in it has to hold. Today is {{TODAY}}.

The draft: `{{DRAFT_PATH}}`

## Your task

Check every factual claim in the draft against live sources, using web search. If
web search doesn't work for you, say so at the top of your report and stop. (If
search works but fetching some pages fails, carry on and say so.)

1. List every checkable claim: model IDs (current, not retired or renamed),
   pricing and cost comparisons, effort-level notes, positioning
   ("previous-gen", "flagship"), and anything else stated as fact. Verify facts
   only. For advice (e.g. "avoid the top effort level unattended"), check only
   that the reason it gives holds. Skip references to files in the repo itself.
2. For each, give a verdict:
   - **HOLDS**: a source supports it.
   - **FAILS**: a source contradicts it. Give the correction.
   - **UNSUPPORTED**: you found nothing either way.
   - **STALE**: true once, no longer.
3. Cite the source for each verdict (URL, publication date, independent or
   vendor). Prefer independent sources, and say when only the vendor's word
   supports a claim, or when several verdicts rest on one source.

The ratings are judgments, not facts. Don't verdict them, but flag any rating
that your evidence makes look clearly wrong, and why.

Also flag anything in the draft that describes how it was researched (source
names, "this used to say X", mentions of a study by name), and any note on
honesty, evaluation gaming, outages, or silent substitution. The shipped file
should carry none of that.

## Rules

- State your own model ID at the top of your report.
- You are headless: nobody will answer questions. Do what you can and state
  plainly what you couldn't.
- Do the work yourself. Don't spawn subagents or background agents.
- Don't edit the draft. Write your report to `{{OUTPUT_PATH}}`, don't modify
  or create anything else, and don't commit.
- Start the report with a table of claim, verdict, and source, then details for
  anything not HOLDS. No em-dashes.
