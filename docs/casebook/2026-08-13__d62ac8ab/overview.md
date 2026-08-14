# Overview

## Goal

Design a **skill-feedback mechanism**: a way for a skill to collect *field
reports* from real, in-vivo use, so its maintainer can refine it from what
actually happened rather than from inorganic tests.

## Origin

Sparked while working the paused headless-permissions case
(`2026-08-04__cf504f22`). That case's central finding was that `delegate`
permission behavior is **genuinely hard to predict** — it shifts across tool
versions, the delegator's ambient config, and how a probe is framed — and that
**inorganic testing is contaminated** (naming a posture poisons the test; a
benign probe reads differently from real use). The case is paused *pending
real-world use* precisely because real usage is the only trustworthy signal.
This mechanism is the structured way to capture that signal.

## The idea (two forms)

- **Narrow:** a skill (e.g. `delegate`) carries feedback instructions; when the
  user asks for "skill feedback", the agent reports what invocations were tried
  and which succeeded/failed.
- **Generalized:** any skill may carry a `feedback-reporting.md` declaring what
  its maintainer wants to hear about. On request, the agent produces a
  *feedback report* containing the exact skill "version" at invocation, what the
  agent did, what led it to do so, and the results. Different per skill.

## Discussion / design position

See [design-discussion.md](design-discussion.md) for the full critique. Current
leanings:

- **Reframe as an in-vivo evidence channel / field report.** Well-founded; the
  delegate case is the poster child for why it's needed.
- **The "version" problem is the crux.** `install.sh` is a plain `cp -R` with
  no version stamp, so installed skills are content-detached from git. Robust
  answer: **content-hash (or excerpt) the files the agent actually read**, which
  pins the exact artifact without any version scheme; optionally stamp
  provenance at install time as a cheap human-readable anchor.
- **Weight the report toward objective traces** (verbatim invocations, denials,
  outputs, files touched, tool+version) over the agent's *reconstructed*
  reasoning, which is prone to post-hoc confabulation — and, given the whole
  area's lesson, is itself a framing.
- **Keep `feedback-reporting.md` out of the normal load path** — read only when
  feedback is requested, so it doesn't bias the behavior being observed (same
  contamination trap).
- **Don't over-prescribe the report**; solicit structured facts *and* "anything
  surprising / contradictory," to preserve unknown-unknowns.
- **Build it as a meta-skill (`feedback`)**, not a section per skill: each skill
  only *declares* its interest (opt-in `feedback-reporting.md`); the machinery
  (trace reconstruction, version-hash, structure, placement) lives once. Matches
  the repo's small-composable-skills factoring.
- **Opt-in, not universal**; **composes with casebook** (a report is case
  material) but shouldn't depend on it; **delivery to a maintainer is out of
  scope for v1**.

## Open questions

- **Capture timing:** retrospective-only (read back over the transcript on
  request) vs. a lightweight live breadcrumb the feedback pass harvests.
- **v1 scope:** general `feedback` meta-skill first, or a narrow delegate-only
  prototype to validate the shape, then generalize.

## Build (2026-08-13) — v1 delivered

Design settled (see [handoff](handoff-build-skill-feedback.md) for the full
spec) and built. The implementation was **delegated** to a headless
`claude-opus-5` subprocess under `acceptEdits` (session
`fe0c5e66-34f3-4e27-adb5-0ee7423924d6`) via the `delegate` skill, then reviewed.

Files produced (on branch `skill-feedback`, uncommitted pending user review):

- `skills/report-skill-feedback/SKILL.md` — doctrine: the single convention (a
  skill opts in by shipping `skill-feedback-reporting.md`), opt-in-or-stop, hard
  traces with an explicit no-rationalization rule, the one subjective
  context-note, a **PII gate** (flag + require user approval before disclosure),
  verbatim skill-dir dump + read-at-report-time drift caveat + **reproducible
  hash (with the command that made it)**, stand-alone, submit as the target file
  directs. `disable-model-invocation: true` (user-invocable only).
- `skills/report-skill-feedback/README.md` — human-facing: what it is, opt-in,
  report contents, the branch-the-session capture tip, author instructions.
- `skills/delegate/skill-feedback-reporting.md` — delegate's declaration:
  environment (tool+model, observed version, delegator posture, ambient config),
  what was delegated, verbatim spawn invocations, allowed-vs-denied outcomes,
  default-vs-knob, whether the guidance steered right (the rationale-not-flag
  failure mode), surprises, a suggested structure, light submission (casebook a
  non-binding suggestion).
- `README.md` (root) — added the `skill-feedback` Skills-table row.
- `skills/delegate/README.md` — one sentence noting the new reporting file plays
  no part in delegating (read only by `skill-feedback`).

**Naming (settled):** skill `report-skill-feedback` (invoked
`/report-skill-feedback <target>`); the `skill-feedback-reporting.md` file is
referred to as the **reporting instructions**; the output is a **feedback
report**. Used consistently across all files.

**Refinement round (user feedback):** procedure step 1 now **stops to ask** if
the user didn't name a skill (no guessing); the skill-dir hash is kept but must
ship **with the exact command** that produced it; added the **PII gate**. In
delegate's reporting instructions: the delegator's own posture is obtained by
**asking the user** (auto mode? manual approvals?); added a first-class
**adoption signal** — did the session use the `delegate` skill or a harness-native
mechanism (e.g. Claude's `Agent`), and if native, why (seen in practice); and
**simplified submission** to "hand to the user, point at the repo." General pass
for concision (kept the "why").

**In-vivo bonus:** the delegate build run is itself a clean `delegate` field
report — two Bash denials returned and were worked around, nothing hung,
`acceptEdits` sufficed (matches the paused permission case's resolution).

## Post-close: report output location (dogfooding fix)

First live use (a report run in another session) surfaced a gap: with no default
destination specified, the agent wrote the feedback report **into the skill
directory**. Fixed in `report-skill-feedback/SKILL.md` — reports now default to a
file under `/tmp/skill-feedback/` and must never be written inside a skill's
directory (managed content, wiped on `install.sh --upgrade`; the target dir is
also the very thing dumped verbatim). The reporting instructions still override
the default. Folded into the feature commit via amend; case stayed closed.

## Possible follow-ups (not in v1)

- Actually install + dogfood `skill-feedback` on a real session.
- Add `skill-feedback-reporting.md` to other skills that want field feedback.
- Implement the optional skill-dir hash for drift detection.
- The `report-skill-feedback/README.md` worked-example link to delegate's file dangles
  if only `skill-feedback` is installed (resolves in-repo and when both are
  installed) — soften to a plain mention if that matters.

## Status

**Closed.** `report-skill-feedback` v1 and delegate's reporting instructions were
built, reviewed, and merged to `master` (fast-forward, delivered as a single
commit). The possible follow-ups above are optional — pick them up as new work if
practice surfaces the need (dogfooding the skill live is the natural next step,
mirroring the paused delegate permission case).
