# Handoff: research and propose a revised `models.md`

You've been spawned as one of several independent research agents (each a
different model) given this same brief, working in parallel. Each of you
proposes your own revised file; the orchestrator will compare all proposals
afterward and pick or merge between them. Don't coordinate with the others —
just do your own best independent work.

## Context

This repo (`agent-skills`) ships a skill called `delegate`
(`skills/delegate/`) that lets an agent spawn another agent — a different CLI
tool, model, or fresh isolated session — to carry out a task headlessly.
`skills/delegate/models.md` is the bundled reference telling a delegating
agent which CLI tools and models are available and how to invoke each one. It
is read directly by an agent as prose — there's no parser and no enforced
schema, but it currently has a `## Tools` section (per-CLI non-interactive
invocation syntax) followed by a single `## Models` table (columns: tool,
model, capability, notes). Its current full content:

```markdown
# Delegate — available agents

## Tools

### claude

Non-interactive invocation, prompt over stdin:

    claude -p --model <model> --output-format json --permission-mode bypassPermissions

### codex

Non-interactive invocation, prompt over stdin, result written to a file:

    codex exec --model <model> -s danger-full-access -o <output-file>

`-s` is codex's sandbox/approval policy (`read-only`, `workspace-write`,
`danger-full-access`) — `danger-full-access` is used here so a headless
call never blocks on an approval prompt no one is present to answer.

## Models

Prefer balancing cost and intelligence when choosing between multiple appropriate models.

| tool | model | capability | notes |
| --- | --- | --- | --- |
| claude | claude-opus-4-8 | 5 | complex code and orchestration |
| claude | claude-fable-5 | 5 | creative or high-context orchestration |
| claude | claude-sonnet-5 | 3 | general-purpose default |
| claude | claude-haiku-4-5 | 1 | fast, simple parsing or copy |
| codex | gpt-5-6-sol | 4 | high-level review, copy, mid-level code |
| codex | gpt-5-6-luna | 1 | simple parsing or copy |
```

Known issues with the current content, worth fixing: the claude rows may not
reflect the current model lineup (e.g. a `claude-opus-5` may exist alongside
or instead of `claude-opus-4-8` — check rather than assume either way), and
the codex model names (`gpt-5-6-sol`, `gpt-5-6-luna`) were never verified
against a real OpenAI/codex release — they may be wrong, stale, or
placeholder names that don't correspond to anything real.

## Your task

Research current, real, publicly known models available across relevant
CLI-drivable vendors — at minimum Anthropic (the `claude` CLI) and OpenAI
(the `codex` CLI), plus any other vendor/CLI you find genuinely relevant and
usable non-interactively (e.g. Google's Gemini CLI) — along with popular
opinion, benchmarks, and community sentiment on their relative capability,
speed, and cost.

If you have live web search available, use it to verify current model names,
release recency, and community sentiment rather than relying solely on
training data. If you don't have live web access, rely on your best current
knowledge, but say so plainly and flag anything that might be stale or
uncertain — don't present a guess as a verified fact.

Then produce a complete, revised `models.md`, following the existing file's
overall shape:

- A `## Tools` section, one subsection per CLI tool, with that tool's real
  non-interactive invocation syntax. Verify flags yourself if you can (e.g.
  the tool's own `--help`) rather than copying the snippet above uncritically
  — it was verified once, but re-verify since it may have changed.
- A single `## Models` section with one table (columns: tool, model,
  capability, notes) covering every tool's models together. Keep the
  capability scale simple (this file uses 1–5, 5 highest) — don't overengineer
  it into something more granular than that.
- The file is freeform prose an agent reads, not a schema anything parses —
  keep following this shape for comparability across proposals, but you're
  not bound to it if you have a clearly better structure in mind. If you
  deviate, briefly note why at the top of your file.

Ground everything in real, current information. Don't invent model names,
benchmark numbers, or opinions. Where a capability judgment or "popular
opinion" claim isn't self-evident, cite where it comes from inline as plain
text (e.g. "per <source>") so the reasoning is visible when your proposal is
compared against the others.

## Output

Do **not** modify `skills/delegate/models.md` itself — this is a proposal for
review, not a direct edit. Write your complete proposed file to the exact
path given in your prompt, and don't write anything else outside that path.
