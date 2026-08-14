# Delegate — reporting instructions

What this skill's author wants from a real delegation. `report-skill-feedback`
supplies the generic parts (verbatim traces, skill-directory dump, context note,
PII check); everything here is specific to delegating.

## Was this skill even used?

First, and most important: did the session **use the delegate skill at all**, or
reach for a harness-native mechanism (e.g. Claude's `Agent` tool)? Either way, say
**why** — what pulled you toward the skill, or what made the native path the line
of least resistance (its always-on availability, the wording of a prompt or
another skill, habit). Non-invocation is a signal in itself, since a delegate
skill that never gets reached for fails no matter how well it works once invoked.
Report even when the skill wasn't used; everything below assumes it was.

## Report per delegation

If the session made several spawns, cover each — they may differ in posture and
outcome.

### Environment

- **Tool and model** delegated to, and the **observed tool version** (`claude
  --version`, `codex --version`) — the single most important field, since
  permission behavior shifts between releases.
- **What the delegator was** (tool, model, harness) and **its own permission
  posture** — ask the user if unsure: *"Was I in auto mode? Were you manually
  approving/denying my delegation commands?"* A delegate is no freer than its
  delegator, so a denial only means what it means in that light.
- Anything ambient bearing on permissions: relevant config, directory trust,
  whether the working dir was a git repo or worktree.

### What was delegated

The task in a sentence, and enough of its shape to judge the posture: write or
read-only, inside the working dir or beyond, network, a coordination channel?

### Spawn invocations, verbatim

The exact command line for each spawn, every permission flag included
(`--permission-mode`, `-s`, `--add-dir`, `--allowedTools`, `--search`, …). If a
spawn was retried with a different posture, give every attempt in order.

### Outcomes

- What the delegate could do vs. what was **denied or refused** — verbatim
  (claude's `permission_denials`, codex refusals, any Layer-A block by your own
  harness before the command ran).
- **What landed**: files written, anything outside the expected scope, anything
  expected that never appeared.
- Whether the posture **fit** or was **adjusted mid-run**, and what forced it.
- Whether anything **hung** waiting for a human — a headless delegate should get
  a denial and continue, never block; a hang is a significant finding.

### Default vs. knob

Did the modest default fit, or did the task need a knob — **constrain**,
**extend**, or **unrestrict**? Which, and why. If you reached for one that turned
out unnecessary, say so — that's the more useful direction.

### Did the guidance steer right?

Did anything in `SKILL.md`, `tools.md`, or `models.md` lead you to a posture that
didn't work or had to be corrected? Quote the wording — point at the sentence,
not just the outcome. The known failure mode is text that makes an agent reach
for a posture the task never needed (an earlier bypass rationale did exactly
this; the fix was the rationale, not the flag). Where the guidance helped, say
that too.

### Surprises and contradictions

Any behavior that didn't match the text: a flag that didn't do what `tools.md`
says, a model unavailable or running as something else, a version behaving unlike
the recorded observation, a restriction that didn't hold. Contradicting the text
is a welcome result — it's why this file exists.

## Submitting

Hand the finished report to the user to send to the maintainer by whatever
channel they prefer. The skill lives at <https://github.com/ArielHorwitz/agent-skills>.
