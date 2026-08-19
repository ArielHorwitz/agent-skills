# Delegate

Delegate is a vendor-agnostic convention for agents to spawn other agents. It is
meant to supersede and replace harness-native subagent mechanisms as a standard
convention — so it is model-invocable by default, and its `description` tells an
agent to use it in place of the harness's own subagents.

There's a real trade-off. You control the model and permissions of each spawn,
can spawn across vendors, and the call is explicit and resumable; against that,
you give up the harness's native support — your own session's safety layer judges
each launch, and you take over the permission decision the harness would
otherwise make for you.

To stop preferring it — e.g. you only want it for spawning a *different* vendor's
tool and would otherwise defer to the harness's own subagents — soften the
"REPLACEMENT for the harness's native subagent tools" wording in the
`description` in `SKILL.md` (reinstalling the skill overwrites the edit).

## How an agent uses it

Given a task, the agent reads `SKILL.md` (postures), `tools.md` (invocations), and
`models.md` (models); picks a tool + model + the least-privileged posture that
fits; writes a handoff doc; and passes a short prompt like `follow
path/to/handoff.md`, capturing the result through the tool's structured output. It
may run in the background or open a channel (e.g. `iac`) if useful.

## The files

Split so parts with different owners and update-rates stay separate:

- **`SKILL.md`** — the *doctrine*: how delegate permissions work (the bounds,
  composing a posture up from a modest default). Skill-authored; you shouldn't need
  to touch it.
- **`tools.md`** — the *tools*: how to invoke each CLI headless and compose its
  permissions, with the observed tool version. Extended when a tool is added (see
  below); changes rarely.
- **`models.md`** — the *models*: which models exist and how to pick one. The part
  you'll customize; the skill prefers a user copy at
  `~/.config/agent-skills/delegate/models.md` if present, else the bundled one.

All three are read by the agent, not parsed by any program, so they're free-form.

A fourth file, **`skill-feedback-reporting.md`** (this skill's *reporting
instructions*), plays no part in delegating: it declares what field feedback the
author wants from a real delegation, and is read only by the
[`report-skill-feedback`](../report-skill-feedback/) skill.

## Permissions

A delegate runs headless — it can't ask a human to approve anything mid-run — so
its posture is fixed when spawned. It picks the **least-privileged posture that
fits** and grants more only as a task needs it (extra directories, or unrestricted
access for open-ended system work); the `tools.md` defaults stay modest, which
covers most work.

The one thing to know as a user: **fully unrestricted delegates require an
unrestricted delegator.** A normally-permissioned session's safety layer refuses
to launch a delegate that drops all its guardrails — by design. So to have
delegates that can do *anything* (e.g. maintain a machine), start the delegator
session itself in your harness's unrestricted mode; it can then spawn unrestricted
delegates freely — safety net off end to end, so do it only when you mean to.

## Adding a tool

Any non-interactive agent CLI can be a delegate tool. What you can't assume is how
its permissions behave, so adding one is a short bit of hands-on work, not a
copy-paste: run it, find its knobs, verify enough to trust the entry, then append a
`tools.md` entry shaped like the existing ones (ideally upstreamed). For a
candidate CLI, work out and record:

1. **Headless invocation** — how to run it non-interactively with a prompt and
   capture the result (e.g. `--output-format json`, `-o <file>`), and how to
   name/resume the session.
2. **Its composition knobs** — which flag sets the baseline (how restrictive the
   delegate is), which grants an extra directory, which enables web research, and
   how to constrain it (drop editing, grant back specific reads). Map each knob to
   the *intent*; don't try to chart an exhaustive behavior table.
3. **It doesn't hang** — give it a task needing a denied action and confirm the
   denial *returns* to the delegate rather than blocking on a human.
4. **The bounds are real enough to trust** — confirm the restrictive baseline
   actually restricts (have it write something you didn't grant; check it was
   denied and nothing landed on disk), and that a fully-unrestricted launch is
   refused by a normal delegator. Enough to trust the entry, not every combination.

**Don't name the permission posture in the prompt when probing what a delegator
will *allow*, or what an agent picks on its own.** A safety classifier reads an
explicit request for a posture as the user authorizing it, so the launch is
approved for the wrong reason and the result means nothing — drive the probe with a
natural task and let the agent choose. This behavior is also context-sensitive (a
benign-looking probe may be treated unlike real use), so treat a result as a
tendency and confirm in a realistic run.

Note the **observed tool version** in the entry — permission behavior shifts across
releases, so it says when to re-check. This is how the bundled `claude` and `codex`
entries were derived; see `docs/casebook/` for the worked examples — including a
cautionary tale about over-specifying behavior that then changed between two
releases.
