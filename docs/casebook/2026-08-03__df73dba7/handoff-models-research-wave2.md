# Handoff: research model capabilities for a delegation skill

You've been spawned as one of several independent research agents working in
parallel on the same brief, each a different model. Don't coordinate with the
others — just do your own best independent work.

## Context

A repo has a skill (`delegate`) that lets an agent spawn another agent — a
different model, via a CLI tool — to carry out a task headlessly, then get a
result back. It needs a reference document describing which models are
available and how to choose among them for a given task. Your research feeds
into that document; someone else does the final write-up. (How to actually
invoke each tool is handled elsewhere — don't research or write about CLI
invocation syntax.)

Scope: Anthropic's Claude models and OpenAI's Codex/GPT models only, for now.
Don't research other vendors.

## Your task

Research current, real, publicly known Claude and Codex/GPT models, along
with independent opinion on their relative capability, speed, and
cost-to-accomplish-a-task — not just what each vendor claims about its own
models. When judging capability, weigh independent sources (community
discussion, independent benchmarks, third-party comparisons) at least as
heavily as vendor-published claims and vendor-self-reported benchmark
numbers — a vendor has an obvious incentive to present its own models
favorably. If you can't find good independent signal for a claim, say so
explicitly rather than defaulting to the vendor's framing.

If you have live web search available, use it — verify current model names,
releases, and community sentiment rather than relying solely on training
data. If you don't have live web access, rely on your best current knowledge,
but say so plainly and flag anything that might be stale or uncertain — don't
present a guess as a verified fact.

On cost: don't present raw price-per-token as a stand-in for cost. Token
efficiency — how many tokens a model actually needs to get a comparable task
done — varies significantly across vendors and models, so a lower sticker
price per million tokens doesn't necessarily mean cheaper in practice, and a
higher one doesn't necessarily mean more expensive. Think in terms of
realistic cost to accomplish a representative task, and say so explicitly if
you can't find good signal on token efficiency to back that up.

Then write up your findings: what you found about each model's capability,
speed, and cost-to-accomplish-a-task, and how you'd recommend choosing
between them for a given task. Several independent reports like yours will
be considered together when the final reference file gets written — that's
a separate step, done by someone else, afterward — so focus on the substance
of your research and reasoning rather than polishing a finished, ready-to-
ship document.

As part of that, feel free to propose how this information should best be
organized — a table, a score per model, subsections, a decision tree,
whatever you think communicates it best. A single blended "capability" score
is one option but not the only one worth considering — for example, you
might score each model along a handful of task-oriented domains (e.g.
coding, architecture, orchestration, research, quick mechanical work)
instead of one number. If you go that route, pick your own axes and count —
don't assume any particular list, or that more axes is better; a small
number of genuinely distinct axes will likely serve better than a long list
of overlapping ones. Treat this as a recommendation to whoever finalizes the
file, not something you need to fully build out yourself.

Ground everything in real, current information. Don't invent model names,
benchmark numbers, or opinions.

## Output

Write up your findings and recommendations to the exact path given in your
prompt. Don't modify any other file, and don't write anything else outside
that path.
