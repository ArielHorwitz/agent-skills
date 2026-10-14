# Handoff: research a newly released model for a delegation skill

You are one of several independent research agents working on this same brief
in parallel, each a different model. Don't coordinate with the others. Do your
own best independent work.

## Context

A repo has a skill (`delegate`) that lets an agent spawn another agent (a
different model, through a CLI tool) to carry out a task headlessly and return a
result. It has a reference document on which models are available and how to
choose among them. It was fully researched on 2026-10-04. Since then a new
model shipped, and your research decides where it fits. Someone else updates
the document afterward, from several reports like yours. CLI invocation syntax
is handled elsewhere, so don't research or write about it.

Scope: Anthropic Claude and OpenAI GPT models only. Today is 2026-10-08.

## Models

- New, the focus: `claude-haiku-5-5` (Claude Haiku 5.5).
- Existing models to compare it against (research these only as far as
  needed to place the new one): claude-haiku-4-5, claude-sonnet-5-5,
  claude-opus-5-5, gpt-6-luna, gpt-6.1-sol.

If you find another Anthropic or OpenAI model released since 2026-10-04,
say so and cover it the same way. Don't research other vendors.

## Your task

Research with live web search. The new model is newer than your training
data, so treat anything you can't source live as suspect. If web search
doesn't work for you, say so at the top of your report and stop. (If search
works but fetching some pages fails, carry on with what search gives you and
say so.)

For the new model, find what is known about the following, and for each say
how it compares to the existing models listed above:

- **depth**: can it crack a hard, ambiguous, or novel problem?
- **execution**: can it drive a long agentic or terminal loop through
  well-specified work efficiently?
- **cost-to-task**: the realistic cost to get a representative task done (see
  the cost guidance below)
- pricing, context window, and how effort or reasoning level (if supported)
  changes quality and cost

Leave out honesty, evaluation gaming, outages, and silent substitution. The
reference doesn't cover them.

Weigh independent sources (third-party benchmarks and evaluations, community
experience, comparisons) at least as heavily as vendor-published claims and
vendor-reported benchmarks. A vendor has an obvious incentive to present its
own models favorably. The model is days old, so independent signal may be
thin: say so plainly rather than defaulting to the vendor's framing.

On cost, don't present price per token as cost. Token efficiency (how many
tokens a model needs to finish a comparable task) varies a lot across models
and vendors, so a lower sticker price doesn't mean cheaper in practice. Reason
about the realistic cost of a representative task, and say when you lack
signal on token efficiency.

Then say what the new model is the right pick for, what it is not, and
whether it supersedes any existing model (better, cheaper, or both, from the
same vendor).

## Evidence

- Cite every factual claim with a URL and its publication date, and mark it
  independent or vendor.
- Distinguish what a source shows from what you infer.
- Say when several of your claims rest on one source, so it isn't mistaken
  for corroboration.
- Prefer recent sources and check the date on anything you quote.
- Don't invent model names, numbers, or opinions.

## Rules

- State your own model ID at the top of your report.
- You are headless: nobody will answer questions. Do what you can and state
  plainly what you couldn't.
- Do the work yourself. Don't spawn subagents or background agents. Don't
  commit.
- Write your report to `/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/research-claude-opus-5-5.md`. Don't modify or create anything
  else.
- Focus on substance and reasoning, not a polished document. No em-dashes.
