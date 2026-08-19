---
name: delegate
description: >
  Spawn another agent to carry out a task instead of doing it yourself - the
  standard mechanism for every handoff, investigation, review, or parallel
  spawn. This is not a supplement, it is a REPLACEMENT for the harness's native
  subagent tools - use it even when a native subagent tool is available, because
  only this way do you choose the model, permissions, and vendor deliberately
  per spawn.
argument-hint: "The task to delegate"
compatibility: >
  Requires the CLI tools you delegate to (e.g. claude, codex) to be
  installed, authenticated, and on PATH.
---

# Delegate

Delegating means running another agent as a **headless, non-interactive
subprocess** — a different tool, a different model, or just a fresh isolated
session — and getting its result back, without doing the work in the current
context. It is vendor-agnostic: any CLI that can run non-interactively and
take a prompt qualifies.

## Pick a tool and model

Read the bundled `tools.md` (how to invoke each CLI and compose its permissions)
and `models.md` (which models are available and how to choose one). For
`models.md`, prefer a user override at
`~/.config/agent-skills/delegate/models.md` if present, otherwise the bundled
copy. Choose a model appropriate for the task — which determines the tool (e.g.
a Claude model → `claude`, a GPT model → `codex`) — and use `tools.md` for how to
invoke it. If you find nothing appropriate, fail loudly.

## Permissions

A delegate runs **headless** — no human is there to approve a step mid-run, so (as
observed at this writing) it can't escalate its own permissions once started: a
step beyond its granted scope is denied and returned to it rather than queued, and
it doesn't hang. You therefore fix its **posture up front**.

Three things bound a delegate: your own session as the **delegator** (whether a
launch is permitted at all), the **flags** you give the delegate (what it may do
once running), and the delegator's **own sandbox**, which the delegate inherits —
it can be no freer than the session that spawned it.

Start from the **least-privileged posture that fits**, and compose upward. For most
work that is the default in `tools.md` — edit within the working directory, read,
and do server-side web research. Reach for a composition knob when the task calls
for it:

- **Constrain it** — for a delegate that shouldn't change things (say, a reviewer),
  drop its edit permission and grant back only the reads it needs.
- **Extend it** — give it a specific extra directory (for example, the directory of
  a coordination channel like `iac`, which a headless delegate can't write to
  unless it's granted), or web research, when the task reaches just past the
  default.
- **Unrestrict it** — for open-ended host work; this needs an unrestricted
  delegator (below).

`tools.md` maps each knob to its flags. Don't count on a flag doing exactly what
you expect — tools and versions differ — so **choose a posture, then confirm it**
from what a run reports (denials, the sandbox header, what actually landed on
disk). Two standing cautions:

- **A more permissive launch may be refused by your own harness**, and you can't
  reliably know your own privileges in advance. If a launch is denied, fall back to
  a tighter posture or surface it — don't fight it. In particular, **a fully
  unrestricted delegate generally requires an unrestricted delegator.**
- **A restrictive flag isn't guaranteed airtight.** A tool's own configuration can
  loosen a sandbox you asked for. If safety — not just task success — depends on a
  restriction, verify it holds; don't assume.

## Running tasks

- Write the task as a handoff doc and pass a short prompt like `follow
  path/to/handoff.md`, rather than inlining the task itself.
- Consider using the tool's structured, non-interactive result capture (e.g.
  `--output-format json`, `-o <file>`) over scraping stdout.
- If `tools.md` describes how to identify a session for the tool you're using,
  do so, and if possible report the session id back once the spawn completes —
  it's how the delegate can be found and its full transcript resumed later, not
  just its final answer.
- Consider running it in the background if the task will take a while and
  there's other useful work to do while it runs.
- Consider using some communication channel for long-running tasks that could
  benefit from back-and-forth communication (e.g. the `iac` skill).
