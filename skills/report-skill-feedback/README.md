# Report skill feedback

Send a skill's author a **feedback report** on how their skill actually behaved
when you used it — a record of one live use, not a review of its text or a
synthetic probe.

That's the point: some skills' correct behavior can't be established by testing —
it shifts with context, config, and framing, so a probe measures the probe. Real
use is the only trustworthy signal, and this captures it.

## Opt-in

It works only for skills that ship **`skill-feedback-reporting.md`** — their
*reporting instructions* — declaring what feedback they want and where it goes. A
skill without one hasn't opted in, and the skill says so rather than invent a
report.

## What the report contains

- **Hard traces of the actual use** — verbatim invocations, outputs, denials,
  and what landed. Not the agent's after-the-fact reasoning, which is
  unverifiable and left out by design.
- **A verbatim copy of the skill version in play**, with a reproducible hash so
  the author can detect drift.
- **Any session context that may have influenced the skill's behavior**, stated
  as fact.
- Whatever else the reporting instructions ask for.

Before sending, the agent flags **PII** and asks your approval — sensitive data
is never submitted unapproved. The report stands alone: readable with no access
to your session or project.

## Using it

Invoke `/report-skill-feedback <skill>` whenever the skill does something worth
reporting — odd, wrong, unexpectedly good, or needing correction. It reads back
over the session for evidence, so do it while the use is still in context (end of
session is fine).

**Tip — report mid-session without polluting your context:** branch or fork the
session, invoke it there, and return to the original — the report comes from the
same context with nothing added to your working thread.

## For skill authors

Add a `skill-feedback-reporting.md` to your skill: what you want to know, how to
structure it, how to submit it. The generic parts (traces, skill dump, context
note, PII check) are supplied — spend the file on what's specific to your skill.
It's the only convention; no schema, no registry. See
[`skills/delegate/skill-feedback-reporting.md`](../delegate/skill-feedback-reporting.md)
for a worked example.
