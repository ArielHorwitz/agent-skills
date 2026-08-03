# Design and build the `delegate` skill

## Origin

The user regularly opens a "main thread" session for a casebook case and
instructs it, roughly: *manage the case, dispatch all significant work to
other agents, write handoff documents, and I'll start fresh sessions pointed
at those handoffs.* It works well but is tedious to restate every time,
especially with many concurrent sessions. The goal: encode this as skill(s)
so it's standard, and let sessions spawn agents themselves rather than always
requiring the user to start each one by hand.

The idea forked into two skills:

1. **`delegate`** — a generally useful, vendor-agnostic skill standardizing
   how an agent spawns and manages "subagents" (other CLI tools, other
   models, fresh isolated sessions). This case.
2. **`orchestrate`** (working name, not yet built) — a thin role/discipline
   skill: focus on the high-level goal, dispatch all significant work through
   `delegate`, don't do the work yourself. See `open-threads.md`.

Casebook itself was deliberately left out of `delegate`'s design — it's
related (a `delegate`-heavy session will often be a casebook main thread) but
casebook is intentionally unopinionated, so the coupling should stay soft
(e.g. "if working inside a case, write handoffs into the case directory")
rather than baked in.

## Where things stand

`delegate` is built, on the `delegate` branch, committed cleanly as one
commit (`feat: add delegate skill for vendor-agnostic agent spawning`):

```
skills/delegate/SKILL.md    — the skill instructions
skills/delegate/README.md   — human-facing design rationale and setup
skills/delegate/models.md   — bundled reference: which tools/models are
                               available, how to invoke and identify each,
                               and how to pick one for a task
README.md                   — top-level skill table, updated with an entry
```

No script is bundled (unlike `casebook`/`iac`) — `delegate` is pure
convention: read `~/.config/agent-skills/delegate/models.md`, pick a
tool/model, spawn it headless, get a result back.

Full rationale and the sequence of design decisions (and reversals) are in
[`design-decisions.md`](design-decisions.md). Remaining open items are in
[`open-threads.md`](open-threads.md) — the permission/approval posture for
headless spawns (deliberately deferred) and the not-yet-built `orchestrate`
skill are the two that matter; the rest are minor or already closed out.

## Current shape of `delegate`

- Reads `~/.config/agent-skills/delegate/models.md` — freeform prose/tables,
  not a parsed schema (mirrors `iac`'s `directive.md` and casebook's own
  `agents.md` convention). Falls back to the bundled copy in the skill dir
  if the user's own file is missing.
- The bundled `models.md` rates each model on four axes — depth, execution,
  cost-to-task, fidelity — rather than one blended score, and gives each
  tool its own `## Tools` subsection (invocation syntax, plus how to
  identify/name a session for that specific tool). Content is drawn from
  eleven independent research passes across two rounds (see
  `design-decisions.md` and `wave2-synthesis.md`), but the shipped file
  itself carries none of that research-process framing — no source names,
  no "this used to say X" — just what to pick and why.
- Model/tool selection is explicitly *not* algorithmic in the skill: "consider
  the task and the file, and choose a model appropriately. If nothing is
  available, fail loudly." Any cost-vs-capability policy belongs in the
  user's own `models.md`, not the skill's instructions.
- Invocation: write a handoff doc, pass a short prompt like `follow
  path/to/handoff.md` over stdin, capture results via each tool's structured
  output (`--output-format json` / `-o <file>`), identify/name the session
  per the models file if it says how, run in the background for anything
  non-trivial.
- Deliberately meant to **supersede** harness-native subagent mechanisms
  (e.g. Claude Code's `Agent` tool), not defer to them — one vendor-agnostic
  spawning path regardless of harness.
- `disable-model-invocation: true` is set, matching `casebook`/`iac`'s
  convention of requiring explicit invocation rather than silent
  auto-triggering.
