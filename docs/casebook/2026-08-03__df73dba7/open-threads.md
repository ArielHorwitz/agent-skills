# Open threads

Things deliberately left unresolved, to revisit as `delegate` gets used.

## Permission/approval posture for headless spawns

`models.md`'s bundled invocations use full bypass (`claude
--permission-mode bypassPermissions`, `codex exec -s danger-full-access`).
This was a direct choice, not a default arrived at by elimination — asked the
user to pick between a safer middle ground (`acceptEdits` /
`workspace-write`), full bypass, or full bypass scoped to a git worktree.
User's answer: full bypass for now, explicitly because settling on one
hardcoded posture for every possible use of this skill is itself the wrong
move — this needs to come back for real discussion once there's more
experience using the skill. Since permission posture already lives in the
user's own `models.md` (not the skill's instructions), changing it later is
just an edit to that file, not a skill change.

## The `orchestrate` skill hasn't been built yet

The second half of the original ask — a thin role/discipline skill that
focuses on a high-level goal and dispatches all significant work via
`delegate` rather than doing it directly — was discussed conceptually but no
files exist for it. Design instinct going in (not yet validated with the
user for this skill specifically): keep it soft-coupled to casebook (write
handoffs/overview into a case directory if one exists) rather than hard-wired
to it, since casebook is meant to stay unopinionated and usable outside this
pattern. Casebook's own README already documents a hand-rolled version of
this pattern (see "Coordinating multiple agents" in
`skills/casebook/README.md`) — worth reading before starting, since it's
effectively the prior art this skill is meant to formalize.

## `disable-model-invocation: true` worth re-confirming later

Set on `delegate`'s `SKILL.md` to match `casebook`/`iac` convention (no
silent auto-triggering, explicit invocation only). Reasonable for now, but
once `orchestrate` exists and is expected to invoke `delegate` routinely and
automatically, confirm this setting doesn't get in the way of that — may need
`orchestrate` to invoke it explicitly by name rather than relying on
description-matching, which it can already do either way.

## Unexplained auto-commit observed mid-session (not pursued)

Partway through this session, `git log` showed a commit ("WIP initial draft
of delegate skill") capturing an intermediate draft that no one in this
session ran `git commit` for — recurred at least once more under the same
message as work continued. Never investigated (some environment
auto-checkpoint mechanism is the likely explanation). No actual harm done:
the final state was cleanly amended into one real commit
(`feat: add delegate skill for vendor-agnostic agent spawning`) on request.
Noting only in case the underlying mechanism matters for a future session.
