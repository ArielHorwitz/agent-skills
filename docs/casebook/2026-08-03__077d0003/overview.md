# Overview

**Goal:** Decide how to encode the user's recurring "main thread" workflow — a
session that holds the high-level goal and delegates significant work to other
agents — as a reusable skill, and how it relates to the existing `casebook` and
`delegate` skills.

## Status

**Closed.** The `lead` skill was built (`skills/lead/`) and committed. Design
analysis in
[main-thread-skill-design-discussion.md](main-thread-skill-design-discussion.md).

The skill commit sits on the `mainthread-skill` branch off `delegate`; it is to
be rebased on top of the `delegate` work once that is ready.

## Current direction

- **Approach 1** (standalone, casebook-agnostic, user-invoke-only posture skill)
  is recommended over folding it into `casebook` (approach 2) or `delegate`
  (approach 3), to keep those primitives unopinionated.
- Key reframe: the `delegate` skill already provides the *mechanism*; this new
  skill is the *posture* that should **compose with** delegate, not duplicate it.
- Possible problem: **posture persistence / drift** over a long session. User
  reports it may not be a big issue in practice — **deferred**. If pursued, any
  durable "charter" must be a *suggestion*, not an instruction, and must not
  override/collide with casebook's `overview.md` directive (defer to a shared
  workspace's own conventions rather than imposing a file).
- Naming **deferred**: user likes `lead` for brevity; `conductor`/`mainthread`
  also in play. Decide later.

## Decisions (2026-08-03)

- Direction: standalone posture skill (approach 1), no hard dependency on other
  skills — composition is noted in the README, not baked into the skill body.
- Name: `lead` (adopted as the working name; easy to rename).
- Anti-drift charter: not included; left as a soft nudge only, deferred.

## Open questions (deferred, not blocking)

- Whether to revisit the name (`conductor`/`mainthread` were also in play).
- Whether the session suffix (`-hub`/`-lead`) should align to the skill name.
- Whether to add any durable-state nudge later, if drift proves to be a problem.

## Related

- Sibling case `2026-08-03__df73dba7` — design/build of the `delegate` skill.
- `skills/delegate/`, `skills/casebook/` on the `delegate` branch.
