# Design discussion: skill-feedback mechanism

## What the idea is

An **in-vivo evidence channel**: a way for a skill to collect *field reports*
from real use, so the maintainer refines it from what actually happened rather
than from inorganic tests. The motivating case (headless permissions,
`2026-08-04__cf504f22`) established that `delegate` behavior is unpredictable
across versions/config/framing and that inorganic tests are contaminated — so
real usage is the only trustworthy signal, and there is currently no structured
way to capture it. This mechanism is that structure.

## Hard parts / critique

### 1. The "version" problem (the crux)

`install.sh` copies skills into `~/.agents/skills` with a plain `cp -R`
(line 111) — no commit or version stamp. The running agent reads that
*installed copy*, which may lag the repo and has no identity. So "the exact
version when invoked" cannot be a version string that does not exist.

- **Primary answer — content-hash what was read.** Record paths + hashes (or
  verbatim relevant excerpts) of the skill files the agent actually used. Pins
  the exact artifact with no version scheme; the maintainer can diff against any
  commit.
- **Optional — stamp provenance at install time** (commit SHA / date into the
  installed skill dir), giving a cheap human-readable anchor *in addition to*
  the hash.

### 2. The confabulation problem

"What led the agent to do what it did" is the softest input. The reporting agent
is the acting agent reconstructing its own reasoning after the fact —
post-hoc rationalization invents cleaner chains than really occurred, and (per
this area's own lesson) the self-narrative is itself a framing. Mitigation:
**weight the report toward objective traces** — verbatim invocations, verbatim
denials/outputs, files touched, tool+version — and mark the "why" as
reconstructed and subordinate to the facts.

### 3. Contamination — keep the prompt out of the normal load path

A per-skill `feedback-reporting.md` is the right shape (maintainer declares
interests → signal not noise). But loading it during *ordinary* use would bias
the behavior being observed — the same contamination trap. Read it **only when
feedback is requested**.

### 4. Don't over-prescribe

A rigid checklist gets pattern-matched and loses the unknown-unknowns (the whole
point). Solicit structured facts *and* "anything surprising, confusing, or that
contradicted the instructions." For `delegate` the maintainer's real interests:
posture/flags chosen, what the delegator was, allowed-vs-denied, tool+version,
whether the default fit or needed a knob, and whether the *rationale text*
steered the choice right (the `models.md` "re-reach for bypass" lesson).

## The design decision

**Make it a meta-skill (`feedback`), not a per-skill section.** Each skill
carries only its opt-in *declaration* (`feedback-reporting.md`); the mechanism —
trace reconstruction, version-hash, report structure and placement — lives once
in the `feedback` skill. Matches the repo's small-composable-skills factoring
(casebook / delegate / iac / lead), avoids duplicating machinery, and degrades
to a generic report when a skill declares nothing. Invocation names the target
("feedback on delegate").

Supporting choices:
- **Opt-in, not universal** — valuable where behavior is empirically uncertain
  and environment-dependent (delegate = poster child); a deterministic skill
  like casebook does not need it.
- **Composes with casebook but does not depend on it** — a report is case
  material for the skill's own improvement (the delegate case literally waits to
  "resume when practice surfaces gaps"), yet should stand alone too.
- **Delivery to a maintainer is out of scope for v1** — same cross-boundary
  "where does the fix live" question the delegate case flagged. v1 just emits a
  well-structured report; forwarding is the user's choice.

## Open questions for the user

- **Capture timing:** retrospective-only (agent reads back over the transcript
  on request) — cheapest, and what was originally described, but details may
  have scrolled out of context by the time feedback is asked for. Alternative: a
  lightweight breadcrumb (delegate already suggests reporting session ids) that
  the feedback pass harvests. Is retrospective enough for v1?
- **v1 scope:** build the general `feedback` meta-skill first, or prototype the
  narrow delegate-only version to validate the shape, then generalize?
