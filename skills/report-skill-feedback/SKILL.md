---
name: report-skill-feedback
description: >
  Report field feedback on another skill to its author — how the skill actually
  behaved in this session's real use, following that skill's reporting instructions.
argument-hint: "The skill to report feedback on"
disable-model-invocation: true
---

# Report skill feedback

Some skills' correct behavior is empirically uncertain, and out-of-band testing
is contaminated — behavior shifts with context, config, and framing, so the
probe measures itself. Real use is the only trustworthy
signal; this skill turns one real use into a **feedback report** for the skill's
author.

Report faithfully — especially the skill misleading you, misbehaving, or
failing; a flattering report is worthless.

## The convention

A skill opts in by shipping **`skill-feedback-reporting.md`** — its **reporting
instructions** — declaring what the author wants and how to structure and submit
the report. That's the only convention.

## Procedure

1. **Identify the target skill.** If the user didn't say which, stop and ask —
   don't guess; a report on the wrong skill is wasted work.
2. **Read its reporting instructions** (`skill-feedback-reporting.md` in the
   skill's directory), the source of truth for everything skill-specific. If
   absent, the skill hasn't opted in: say so and stop.
3. **Assemble the report** — hard traces, the context note, the skill version,
   and a PII check (all below) — plus whatever the instructions ask for.
4. **Make it stand-alone**, then **submit** as the instructions direct.

## Hard traces

The substance is objective evidence from this session — what was actually done
with the skill:

- each invocation, and what prompted it
- the resulting commands, inputs, and prompts — **verbatim**
- outputs and results: exit statuses, errors, denials, retries
- what landed — files written, processes spawned, state changed

Quote, don't paraphrase; mark anything you cut. **Don't narrate why you decided
things** — reconstructed reasoning is unverifiable justification, worse than
nothing.

## The one subjective element

One judgement: **did anything in this session's context plausibly sway how you
used the skill — including whether you reached for it at all, or passed it over
for an alternative?** A phrasing in the request, a project convention, an ambient
config, an earlier step. State *what* it was and *what* it may have swayed, as
fact, not justification. If nothing, say so.

Whether the skill was invoked, and why or why not, is itself feedback: a skill
that never gets reached for is failing regardless of how it behaves once it does.

## PII

The traces can carry personal or sensitive data — paths, names, tokens, file
contents. Often that's fine (an author reporting on their own session), but
before submitting, **flag anything sensitive and get the user's explicit
approval** for each disclosure. Never submit unapproved sensitive data.

## The skill version in play

Include a verbatim copy of the skill's **entire directory**, so the author sees
the exact text that was live. Caveat: it's read **at report time**, which may
differ from what ran earlier (reinstalled or edited since) — so add a directory
hash **with the command that produced it**, letting the author reproduce it and
spot drift.

## Stand-alone, then submit

The author reads this with no access to your session or project: spell out paths,
identifiers, and versions; never point at something they can't open.

Write the report to a file under **`/tmp/skill-feedback/`** (e.g.
`/tmp/skill-feedback/<skill>-<timestamp>.md`) — **never inside a skill's own
directory**, which is managed content that gets wiped on reinstall. Then submit
as the reporting instructions direct, or — if they name no destination — give the
user the path to forward.
