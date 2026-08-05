# Overview

## Goal

Make headless `delegate` spawns work **at full power** without a human having
to click through a per-spawn confirmation. The user wants delegated sessions
empowered as much as the delegator — especially for the `lead` pattern, where
the lead does no work itself and delegates everything. Secondary: explore
offering the delegator a choice between a read-only and an empowered delegate.

## The problem

A live `delegate` spawn was blocked by the delegator's **outer safety
classifier** (`claude auto-mode`, rule "Create Unsafe Agents") because the
launch command used `codex exec -s danger-full-access`. See
[prior-session-investigation-layer-a-classifier-block.md](prior-session-investigation-layer-a-classifier-block.md)
for the full prior-session research dump (nothing there was implemented; all
edits it describes were reverted).

## Key reframing (the crux)

Two independent permission systems are in play:
- **Layer A** — the delegator's outer classifier, evaluating the *launch Bash
  command* before it runs. This is what blocked. Configured via `claude
  auto-mode` + `~/.claude/settings.json` `autoMode`.
- **Layer B** — the spawned session's own permissions (`--permission-mode` /
  `-s`), governing what the delegate does once running.

The "Create Unsafe Agents" rule fires on a **conjunction**: no sandbox
isolation **AND** no per-action approval gate — which is precisely the
definition of a fully-empowered headless delegate. So there is no clever
invocation that keeps full power *and* dodges the rule; the rule is doing its
job. Realistic paths for a full-power delegate:

1. **Standing scoped exception** in `claude auto-mode` config (opt out of the
   guardrail once, for this specific spawn shape). Most promising; untested.
2. **Per-prompt naming** of the unsafe flag (human authorizes each spawn) —
   works today but defeats the headless point.
3. Sandboxing the *outer* Bash satisfies the rule but then contains the
   delegate → not full power. Rejected as incompatible with the goal.

Layer-B scoping (`acceptEdits`, `-s workspace-write`, allowlists) is good
reference for the optional read-only/empowered tiers, but is **not** the fix
for the blocking problem — the user wants full power by default.

## Open questions before committing a fix

- **The asymmetry**: the prior research session ran the same full-access
  spawns and was *never* blocked. Reproduce and explain (hypothesis: the
  outer session's own Bash tool is itself sandboxed). Determines whether this
  is even consistently reproducible or is environment-dependent.
- **Exact `autoMode` JSON** for a scoped allow rule that `claude auto-mode
  critique` accepts — never tested end-to-end.
- **Where a fix lives**: `delegate` is vendor-agnostic and `autoMode` is
  Claude-Code-specific to the *delegator*. Options: skill documentation only,
  the repo's install path (note: `install.sh`/`fix-claude.sh` touch neither
  `settings.json` nor `autoMode` today), or purely the user's environment.

## Status

**Verification complete** (see
[verification-findings.md](verification-findings.md)). The playing field is
understood:

- **Codex delegator: solved** — no semantic guard; `-s danger-full-access` +
  `approval_policy="never"` runs headless. Document it.
- **Claude Code delegator**: the block is a *deliberately hardened* soft-deny
  ("Create Unsafe Agents", `[named+specifics]`), clearable **only by the actual
  user naming the specific spawn shape** — never by a peer/agent, and an agent
  cannot even config its way past it (Auto-Mode Bypass + Self-Modification +
  Multi-Agent Coordination rules). Provenance + specificity, not command shape
  or sandbox, is the gate.

## Direction pivot (2026-08-04, after reviewing test transcripts)

Two realizations reset the approach:

1. **All prior tests were contaminated** — every spawn was IAC/peer-directed
   (visible provenance) *and* had a benign/adversarial task payload the
   classifier reads. We never tested a real delegate doing real work. So the
   codex "solved" result and the Layer-A findings describe the classifier
   reacting to those signals, not the actual use case.
2. **The requirement was self-inflicted.** Demanding *full/bypass* permissions
   for children is what trips Layer A — the "Create Unsafe Agents" trigger *is*
   the sandbox/approval-disabling flag. **Drop the flag, spawn children under
   `--permission-mode auto`** (a real mode) and: the child runs the same
   classifier the user trusts; `claude -p` never hangs (denials return, child
   works around them); the lead's Layer A has nothing to fire on; it's
   vendor-agnostic (codex: default `workspace-write`, no `-s
   danger-full-access`); no guard weakened, no injection surface, no wrapper.
   Only the lead needs Layer A (already has it); children don't spawn children
   (deferred), so the recursive case disappears.

**Kicker:** `models.md`'s stated reason for bypass ("so a headless call never
blocks on an approval prompt") is moot — `claude -p` never blocks regardless.
Bypass only *suppresses denials*, which the user now welcomes. The bypass
default solved a non-problem and caused the real one.

**Rejected:** routing empowered work through codex (vendor lock — anathema).
**Shelved:** the standing `autoMode.allow` carve + wrapper (the auto-permissions
approach dominates it).

**Remaining unknown (empirical):** can a child under `auto` (or the confirmed
fallback `acceptEdits`) actually do real work headlessly (edit files, run
build)? Prior "auto denied edits" data is untrusted (contaminated framing).

## Run 1b — BLOCK REPRODUCED in-situ (bypass variant, valid)

After reinstalling the skills with correct frontmatter, a genuine user-driven
`/lead` run (explicit prompt forcing `delegate`) **reproduced the Layer-A block
with zero contamination**:

- Lead correctly used `delegate` this time, spawning
  `claude -p "follow …review-design.md" … --permission-mode bypassPermissions`
  (and a parallel code-review spawn).
- **Both denied**: *"[Create Unsafe Agents] Spawning a sub-agent with
  `--permission-mode bypassPermissions` disables per-action approval gates
  without explicit user authorization for that bypass."*
- The lead surfaced it honestly and offered: (1) scoped `allowedTools`
  (read-only reviewer — it *invented the read-only tier* on its own), (2)
  authorize bypass, (3) add a settings rule.

This confirms the block is real outside our IAC tests. Two design signals:

- **The lead reached for bypass because `models.md`'s rationale tells it to**
  ("so a headless agent doesn't hang on an approval prompt"). That rationale is
  the flawed one — `claude -p` never hangs (denials return). The `models.md`
  edit must fix the *rationale*, not just the flag, or agents will re-reach for
  bypass.
- The watcher captured no process — Layer A blocks pre-execution, so blocked
  spawns are transcript-only; the watcher catches only spawns that run.

Note: an earlier run (labeled below) used the harness `Agent` tool instead of
`delegate` due to a stale install with `disable-model-invocation: true`; now
fixed.

## Run 0 (stale install — invocation problem, superseded)

First user-driven `/lead` run on the fixture: the lead **did the revamp and
committed it** (`d96c9e2`, added `styles.css`) but via the **harness-native
`Agent` tool**, not the `delegate` skill — and it **asked the user** what/how
instead of delegating autonomously. Watcher confirmed **zero** `claude -p` /
`codex exec` spawns, so Layer A was never exercised. Two *invocation* misses
(distinct from the *permission* question):

1. **Lead used `Agent`, not `delegate`** — even though delegate's *description*
   (decision-time visible) says "Prefer this vendor-agnostic method over any
   harness-native subagent mechanism." The always-present built-in tool won.
   Likely lever: the `lead` skill body (loaded via `/lead`) says "delegate" as
   a *verb* and never names the `delegate` skill or the Agent tradeoff — assert
   the routing there.
2. **Lead asked instead of driving** — a `lead`-fidelity miss, separate thread.

Note: the successful in-harness `Agent` run is *indirect evidence* for the auto
hypothesis — a classifier-governed, no-bypass, in-process delegate did real
edits with no block and no hang.

**Decision:** treat invocation-autonomy as a separate thread; for the
*permission* test, be explicit in the prompt to force the delegate/subprocess
path and isolate the variable we care about.

## Current state: 2×2 matrix runs + `models.md` rewritten

Realistic end-to-end testing on the `~/prog/webpage-dated/` fixture (`762d88c`),
a 2×2 of **lead** {claude, codex} × **variant** {bypass, auto}. See
[matrix-run-results.md](matrix-run-results.md):

- **Run 1 (claude, bypass):** block reproduced, lead self-recovered to
  `acceptEdits`/`workspace-write`, completed.
- **Run 2 (codex, bypass):** codex's classifier *approved* the bypass spawns;
  completed. Vendor asymmetry confirmed.
- **Run 3 (claude, auto):** **CLEAN** — full cross-vendor pipeline completed,
  no block/denial/stall/hang. The lead itself confirmed no failures.
- **Run 4 (codex, auto):** deferred (confirmation only).

On the strength of runs 1–2 we **rewrote `skills/delegate/models.md`** to the
auto/posture-B defaults — see [models-md-decisions.md](models-md-decisions.md)
for the full rationale (default off bypass; codex two-axis + explicit
`auto_review`; reason-first framing; removed misalignment concerns).

## Resolution & status

**The load-bearing issue is RESOLVED.** With the softened `models.md`, an
empowered headless delegation pipeline runs end-to-end with none of the
bypass-era Layer-A block (run 3). Fix + full record **committed** (on a branch;
to be amended before push).

The delegate skill's README is **done**. Forced-defaults testing is **done**
(via direct probes): `--permission-mode auto` **can't edit headless**, so `auto`
was **dropped** and the **claude default is now `acceptEdits`** (codex posture-B
confirmed to edit) — see [matrix-run-results.md](matrix-run-results.md). All
committed on branch `delegate-permission-softening` (unpushed). Only optional
item left: a vanilla codex-lead confirmation run (low value). (Resolved along
the way: `fable-5` note removed; don't-crash watch closed with nothing
observed.)

## Latest: capability tests + tier model + skill restructure

Further probes settled the capability picture and reshaped the skill — see
[permission-model-tiering-and-restructure.md](permission-model-tiering-and-restructure.md)
for the consolidated record. Headlines:

- **codex `exec` can't escalate at all** — `auto_review`/`-a` are inert for
  delegates; a delegate is bounded purely by `-s`. Web works via `--search`.
- **Web research needs no bypass** either vendor (server-side tools, granted
  explicitly). **iac** works for claude under `acceptEdits`; for codex it needed
  the channel in a writable root → **iac now defaults `IAC_ROOT` to `/tmp`**
  (committed to `master`, `f866c96`).
- **Three tiers** — regular / middle (`--add-dir`) / extreme (full bypass, which
  requires a bypass *delegator*).
- **Skill restructured** (branch): permission *doctrine* → `SKILL.md`; per-tool
  invocations → new `tools.md`; `models.md` trimmed to the model roster;
  `README.md` gains an **"adding a tool" methodology** (a generalized, runnable
  version of what this case did).

## Reconciliation — and the case's central finding

The chronological sections above are the trail, and they **contradict each
other** in places. That is left in deliberately, because the contradictions are
the point. Over the investigation the same questions were tested more than once
and gave different answers:

- **Can a headless `codex exec` escalate past `-s`?** Early probes said *no*
  ("`auto_review`/`-a` inert; a delegate is bounded purely by `-s`", above). A
  later five-verifier round said *yes* — `approvals_reviewer="auto_review"` (set
  in this machine's real config) or `--approve-for-me` lets it write outside its
  sandbox. Part of the flip was genuine drift: **codex updated 0.146.0 → 0.147.0
  mid-case and changed this behavior.**
- **Does `-s read-only` hold in a codex-trusted directory?** An early probe said
  trust *defeats* read-only. Verification showed the opposite: an explicit `-s`
  always wins; trust only sets the *default* when `-s` is omitted.
- **Can a claude `acceptEdits` delegate use an `iac` channel under `/tmp`
  without `--add-dir`?** An early note said yes (the permission system "gates the
  Bash command, not the subprocess's write"). Verification showed no — Bash is
  confined to the working dir under `acceptEdits`; the channel dir must be
  granted.

These are not just mistakes to bury. Taken together they **are** the case's
central finding: **delegate permission behavior is genuinely hard to predict** —
it shifts across tool versions, across the delegator's ambient config, and with
how a probe is framed (a benign research prompt is read differently from real
use; naming a posture in the prompt poisons the test). A skill that tried to
*enumerate* "flag X does Y" was therefore bound to be wrong on some machine, some
release, or some config. That is exactly why the skill was consolidated to
**guidance over enumeration**: a good default, composition knobs described by
*intent*, and a standing instruction to **verify the posture you chose from what
a run reports** rather than trust a description. Per-claim verdicts, evidence,
and the 5/5 consensus are in
[claim-verification-report.md](claim-verification-report.md).

## Status: paused (2026-08-12)

Load-bearing issue resolved; skill consolidated and internally consistent; case
merged to `master`. **Paused pending real-world use** — trying the skill in
practice may reshape wording. Resume if practice surfaces gaps, or to fold the
matching "grant the channel directory" note into the `iac` skill (iac's own
concern). This section supersedes the earlier "codex can't escalate", "three
tiers", and "trust defeats read-only" statements in this file and in
`permission-model-tiering-and-restructure.md`.
