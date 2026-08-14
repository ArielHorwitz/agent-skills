# Handoff: build the `skill-feedback` meta-skill + delegate's reporting file

You are building two things in this repo (`agent-skills`, a collection of
vendor-agnostic agent skills). Work in the current working directory (a git
worktree on branch `skill-feedback`). Follow this spec closely — the design is
settled; do not redesign it. Write clear, tight prose that matches the house
style of the existing skills.

## Background (why this exists)

The maintainer wants a way to send an *author* of a skill a **field report** on
how their skill actually behaved in real use — an **in-vivo** signal — because
some skills' correct behavior is empirically uncertain and **inorganic testing
is contaminated** (the `delegate` skill is the poster child: its behavior shifts
across tool versions, ambient config, and how a probe is framed; see
`docs/casebook/2026-08-04__cf504f22/`). Real usage is the only trustworthy
signal, and there is currently no structured way to capture it. This skill is
that structure.

## Orientation — read these first

- `skills/delegate/SKILL.md`, `skills/delegate/README.md` — the house style for a
  skill's doctrine file and its human-facing README. Match this register.
- `skills/iac/SKILL.md` — a compact SKILL.md with minimal frontmatter.
- `README.md` (repo root) — the Skills table and the "Model invocation" section
  you will add to.
- `skills/delegate/tools.md`, `skills/delegate/models.md` — the *content* source
  for delegate's reporting file (deliverable C): what a delegate report should
  capture. Also skim the case overview at
  `docs/casebook/2026-08-04__cf504f22/overview.md` for the concrete lessons.

## The core design (applies to all deliverables)

- **The only convention this introduces:** a skill opts in to field feedback by
  shipping a `skill-feedback-reporting.md` in its directory. The `skill-feedback`
  skill reads *that file* for its instructions — how to structure the report,
  what to consider, and how/where to submit it. Nothing else is standardized.
- **Opt-in.** If a target skill has no `skill-feedback-reporting.md`, it hasn't
  opted in — say so and stop; do not invent a report.
- **User-invocable only.** This skill is invoked by a human who wants to send
  feedback to an author. It must NOT be model-invocable
  (`disable-model-invocation: true` in frontmatter).
- **Hard traces, not rationalization.** The report's substance is *objective
  evidence* from the session: what was actually invoked/done with the target
  skill, verbatim commands/inputs/outputs, results, errors/denials, what landed
  on disk. Do NOT include a reconstructed narrative of "why I decided X" —
  post-hoc rationalization is explicitly unwanted and considered worthless.
- **The one useful subjective element.** Beyond the hard traces, and beyond what
  the target's reporting file asks for, the reporting agent should identify
  whether anything *in the session's context* may have influenced how it used
  the skill — context that swayed a decision the skill's behavior depends on
  (for `delegate`: something that pushed a particular permission posture or
  invocation). State it factually — *what* context, *what* it may have swayed —
  not as justification. The point is to let the author tell whether a behavior
  was the skill's doing or the surrounding context's.
- **Verbatim skill version.** The report includes a verbatim copy of the target
  skill's entire directory as it is at report time, so the author sees exactly
  the skill text that was in play. Caveat to state in the report: the skill files
  are read *at report time*, which may differ from when the skill was actually
  used earlier in the session (it could have been reinstalled/edited since) —
  so note that risk, and consider recording a hash of the skill dir to help
  detect such drift. (The hash is a nice-to-have, not required — mention it as a
  consideration.)
- **Stand-alone.** The report must be fully self-contained: readable by the
  author with no access to this session, no casebook, nothing else. It does NOT
  compose with casebook by design — an author *may* choose to handle reports via
  casebook, but that is the author's choice expressed in their own
  `skill-feedback-reporting.md`, never assumed by this skill.
- **Honesty.** Report faithfully, including the skill misbehaving or failing —
  that is the entire point.

## Deliverable A — `skills/skill-feedback/SKILL.md`

The agent-facing doctrine. Frontmatter: `name: skill-feedback`; a `description`
that captures "report field feedback on another skill to its author"; and
`disable-model-invocation: true`. Add an `argument-hint` for the target skill.
No external dependencies, so no `compatibility` line is needed.

The body must instruct the agent to:

1. **Identify the target skill** the user means (from the argument or the
   session) and locate its installed directory.
2. **Read the target's `skill-feedback-reporting.md`.** That file is the source
   of truth for how to structure the report, what to consider, and how/where to
   submit. If it's absent, the skill hasn't opted in — tell the user and stop.
3. **Assemble the report from hard traces** of how the target skill was used in
   this session (verbatim invocations, inputs, outputs, results, denials/errors,
   what landed) — not rationalizations.
4. **Add the one subjective element** — session context that may have swayed the
   skill's behavior — per the core design above.
5. **Include the verbatim skill-dir dump** and the drift caveat / optional hash.
6. **Make it stand-alone**, then **submit it** the way the target's reporting
   file specifies. If that file doesn't specify a destination, default to
   presenting the finished report to the user to forward. This skill itself makes
   no assumption about the destination.

Keep it doctrine, tight, in the register of `skills/delegate/SKILL.md`.

## Deliverable B — `skills/skill-feedback/README.md`

Human-facing. Cover:

- **What it is:** send a skill's author a field report on how the skill actually
  behaved when you used it — from real, in-vivo use.
- **Opt-in:** works only for skills that ship a `skill-feedback-reporting.md`;
  that author-written file defines what the report contains and where it goes.
- **What the report contains:** hard traces of the actual use (not the agent's
  rationalizations), a verbatim copy of the skill version in play, and any
  session context that may have influenced the skill's behavior.
- **How to use it + capture-timing tip:** invoke `/skill-feedback <skill>`
  whenever you notice something worth reporting; because it reads back over the
  session, do it while the relevant use is still in context. **Tip:** to report
  mid-session without polluting your working context, branch/fork the session,
  invoke `skill-feedback` in the branch, then return to the original — the report
  is produced without adding anything to your main thread. It also works fine at
  session end.
- **For skill authors:** add a `skill-feedback-reporting.md` to your skill
  declaring what feedback you want and how it should be structured and submitted;
  `skill-feedback` reads it and does the rest. That file is the only convention.

Match the register of `skills/delegate/README.md`.

## Deliverable C — `skills/delegate/skill-feedback-reporting.md`

Delegate's own declaration of what field feedback its author wants. This is
delegate-specific *content* (the meta-skill supplies the verbatim dump and the
subjective-context element generically; don't duplicate those here — focus on
what's specific to delegating). Draw the specifics from `tools.md`, `models.md`,
and the case lessons. The author wants, per delegation performed:

- **Environment:** which tool + model were delegated to, and the **observed tool
  version** (permission behavior shifts across releases — this is central), plus
  **what the delegator was** and its own permission mode/sandbox (a delegate can
  be no freer than its delegator; unrestricted needs an unrestricted delegator).
- **Posture chosen:** the exact spawn invocation(s) and permission flags,
  verbatim (`--permission-mode` / `-s` / `--add-dir` / `--allowedTools`, etc.).
- **Outcome — allowed vs. denied:** what the delegate could do vs. what got
  denied/returned (e.g. claude's `permission_denials`), verbatim; whether the
  chosen posture fit or had to be adjusted mid-run.
- **Default vs. knob:** did the modest default fit, or did the task need a
  composition knob (constrain / extend / unrestrict)? Which, and why.
- **Did the guidance steer right?** Did anything in `SKILL.md` / `tools.md` /
  `models.md` lead to a posture that then didn't work or had to be corrected?
  (The known failure mode: wording that makes an agent reach for a posture the
  task didn't need — the author wants to know if the text mis-steers.)
- **Surprises / contradictions:** behavior that didn't match what the skill's
  text described (a flag that didn't do what `tools.md` said, version drift,
  etc.).

Suggest a lightweight structure the reporter can follow (e.g. sections:
environment; what was delegated; spawn invocations verbatim; outcomes
[allowed/denied/what landed]; where the guidance helped or misled; surprises).
For **submission**: keep it light — present the finished report to the user, and
note that if the project keeps a casebook, recording it there (e.g. alongside the
delegate permission case) is a natural home — as a suggestion, not a requirement.

## Also update

- **Repo root `README.md`:** add a row to the Skills table for `skill-feedback`
  in the same style as the others (one-line "what it does"). Check whether the
  "Model invocation" section needs anything — this skill is user-invocable-only,
  which is a normal per-skill choice, so likely no change beyond the table row.

## Do NOT

- Do not make the report or the skill depend on casebook.
- Do not add rationalization/"why I decided" narrative to the report design.
- Do not make the skill model-invocable.
- Do not redesign the convention (it is exactly: a skill ships
  `skill-feedback-reporting.md`; `skill-feedback` reads it).

## When done

Report back: the files you created/edited (paths), any decisions or ambiguities
you hit, and anything you think the maintainer should double-check. Do not commit
— the lead will review and handle version control.
