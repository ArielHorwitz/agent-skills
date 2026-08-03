# Design discussion: a "main thread" / orchestrator-role skill

## What is actually being proposed

A skill that puts the current session into a standing **posture**: hold the
high-level goal, stay out of the weeds, and hand off any significant work to
other agents. The user already does this by hand with a prompt like:

> you are the case's "main thread": responsible for managing the case, focusing
> on the high-level goal, and orchestrating other agents. For any significant
> work, dispatch it to other agents.

## Key reframe: this is a *posture*, not a *mechanism* — and the mechanism already exists

The single most important observation: this repo **already** has the mechanism
half of this idea — the `delegate` skill (`skills/delegate/`). `delegate`
answers *"given a task, spawn an agent to do it"* (pick a CLI/model, write a
handoff doc, run headless, capture the result).

What the user is describing is not a second spawning mechanism. It is the
*discipline that decides when and why to spawn* and that keeps the session from
doing the work itself. So:

- **`delegate`** = the act (how to spawn one task out).
- **"main thread"** = the standing role (do little yourself; route significant
  work through `delegate`; hold the goal; integrate what comes back).

The new skill should therefore **compose with `delegate`, not duplicate it** —
its body should point at `delegate` as its execution mechanism.

## The three disciplines (the user's draft only names two)

The main-thread role is really three things, and the draft prompt emphasizes
only the first two:

1. **Hold the goal** — keep the high-level objective in view; don't lose the plot.
2. **Delegate significant work** — don't sink into implementation/investigation.
3. **Integrate & remember** — sub-agents are ephemeral and forget; the main
   thread is the *persistent memory and single source of truth* that tracks
   what's been dispatched, synthesizes results, and holds decisions.

#3 is arguably the highest-value part and is under-specified in the current
prompt ("managing the case" only gestures at it). Worth making explicit.

A useful motivating framing the user may not have articulated: delegation is
also **context hygiene for the orchestrator**. By offloading heavy work, the
main thread keeps its own context lean and therefore *survives longer* and can
steer the whole case. Delegation isn't only parallelism — it's what lets the
orchestrator outlive any single piece of work.

## Approaches

### Approach 1 — standalone, user-invoke-only skill (e.g. `/mainthread`) — recommended

A separate skill, casebook-agnostic, `disable-model-invocation: true`, invoked
by the user, composable with others (`/casebook /mainthread work on this
case…`).

**For:**
- Keeps casebook unopinionated — its whole value is being non-prescriptive; an
  orchestration posture baked in (even optionally) exerts gravitational pull and
  implies endorsement.
- The posture is genuinely useful **outside** casebook — any long-running goal.
- Skills compose cleanly when separate; the user's own example
  (`/casebook /mainthread …`) shows the intended usage.
- Consistent with the repo's emerging design principle (below).

**Against / cost:** one more skill to maintain; the persistence problem (below)
must be solved for it to be more than a one-shot reminder.

### Approach 2 — a `hub.md` mode inside casebook

Rejected, and the user already leans away. Same objection as loading it into
`delegate`: it couples an opinionated workflow to an intentionally unopinionated
primitive.

### Approach 3 (new) — put it inside `delegate` instead of casebook

The user framed the choice as "casebook vs standalone," but `delegate` is a
third candidate home — main-thread is, after all, *the posture that motivates
delegation*. Rejected for the **same reason** as approach 2: `delegate` is a
clean single-responsibility mechanism ("given a task, spawn"); a standing-role
posture muddies it exactly as it would muddy casebook. Keep them separate but
**explicitly linked**.

This surfaces the repo's coherent design principle:

> **Primitives stay unopinionated** (casebook = project-state management,
> delegate = spawn mechanism). **Postures/workflows are separate composable
> skills that reference the primitives.**

Main-thread is the first *posture* skill — a new genre alongside the existing
*state* skill (casebook), *mechanism* skill (delegate), and *comms* skill (iac).

### Approach 4 (new) — not a skill at all, just a convention/prompt macro

The instruction is short; one could keep it as a documented convention or a
saved prompt/keybinding. But the user does this *often*, and a skill gives it a
home next to `delegate` and lets it carry the persistence machinery below. A
skill is the right call — but note it sits near the skill/slash-command boundary
since it's largely a fixed instruction block.

## The hard part nobody has raised: persistence / drift

A skill invocation is a **one-shot injection** at invocation time. But "you are
the main thread" is a *standing posture* meant to last the whole session. Over a
long session the instruction decays as context fills, and the agent drifts back
into doing work itself. This is the central design problem.

**User steer (2026-08-03):** in the user's experience this drift may not be much
of a problem in practice — **deferred for now**. If pursued, the charter should
be framed as a **suggestion, not an instruction**, and — importantly — must
**not override casebook's own `overview.md` directive**. Since this skill is
casebook-agnostic, it should not impose a file convention at all: where a shared
workspace already exists (e.g. a casebook case), defer to *its* conventions
(overview.md) rather than mandating a separate charter file. Keep any durable-
state idea as an optional nudge.

Proposed mechanism (deferred) — the skill *suggests* the agent maintain durable
posture state, rather than relying on the one-shot prompt:

- goal statement,
- operating rules (delegate significant work; do only orientation/planning/
  synthesis/decisions yourself),
- a **running log of delegated threads and their status** (which doubles as the
  discipline-#3 integration artifact).

The agent re-reads and updates this file as it works, so the posture is
re-surfaced instead of forgotten. In a casebook case this artifact is naturally
the case's `overview.md` (or a dedicated `orchestration-log.md`). This single
mechanism solves persistence, integration, and state-tracking at once.

## The threshold problem: what counts as "significant"?

"Delegate significant work, do trivial things yourself" is fuzzy. Without a
usable heuristic the agent either delegates everything (wasteful — spawning a
subprocess for a two-line edit) or nothing (drifts). The skill should draw the
line, roughly:

- **Main thread does:** orientation, planning, decomposition, writing handoffs,
  reviewing/integrating results, decisions, keeping the charter/overview current.
- **Delegate:** implementation, investigation, research — anything long,
  parallelizable, or context-heavy.

## Naming (user explicitly asked)

Two distinct names to consider — the **invocation** (what you type) and the
**session-name suffix** (`case-a1b2-hub`). They need not match.

| candidate | connotation | cons |
| --- | --- | --- |
| `main-thread` / `mainthread` | matches the user's mental model exactly | "thread" is overloaded (concurrency, forum threads); longish to type |
| `hub` | short; spokes = agents; current suffix | a *place*, not a posture — doesn't convey "do less yourself"; generic |
| `conductor` | holds the baton, directs, **plays no instrument** — captures the restraint | slightly cute |
| `lead` | short, "you're the lead," delegates to the team | overloaded (metal / verb) |
| `orchestrate(r)` | describes the role, common term | implies active conducting, understates the key discipline (restraint) |
| `steward` / `overseer` | holds the goal, doesn't do the work | obscure / has a bossy tone |
| `dispatcher` | routes work out | too close to `delegate`'s mechanism |

**Lean:** `conductor` best captures the defining discipline (directs, holds the
goal, plays nothing itself) and is unambiguous; `mainthread` is the safest if
you value matching your existing mental model over connotation. The session
suffix can stay `-hub` (short, already in muscle memory) even if the skill is
named differently — or align them.

**User steer (2026-08-03):** likes `lead` for its brevity; **name deferred** —
decide later. Note `lead` reads as a role noun ("you're the lead") and pairs
naturally with a `-lead` session suffix if alignment is wanted.

## Recommendation

1. **Approach 1** — standalone, casebook-agnostic, `disable-model-invocation:
   true` posture skill.
2. Frame it as the repo's first **posture** skill; state the primitive-vs-posture
   design principle in its README.
3. Make the **three disciplines** explicit; add the context-hygiene rationale.
4. **Compose with `delegate`** for execution — point at it, don't reimplement.
5. Solve **drift** by having it write/maintain a durable charter/log artifact
   (in a casebook case, that's `overview.md` or an `orchestration-log.md`).
6. Give it a **threshold heuristic** for "significant."
7. Pick a name (lean `conductor`, or `mainthread` to match your mental model).

## Open questions for the user

- Invocation name, and whether the `-hub` session suffix should align to it.
- Should the charter/log be a fixed filename convention, or left to the agent?
- Is the durable-artifact mechanism acceptable, or do you prefer to rely on
  re-invoking `/mainthread` when drift is noticed?
