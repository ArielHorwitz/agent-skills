# Final permission model, tiering, and the skill restructure

Consolidates the findings and decisions after the matrix runs — the direct
permission probes, the iac/web capability test, the tier model, and the skill
restructure that resulted. This is the current end state; earlier per-step notes
(overview, matrix-run-results, models-md-decisions) remain as the trail.

## The permission model (now the skill's doctrine)

Two facts govern a **headless** delegate:

1. **It can't escalate, and never hangs.** No human is present to approve an
   action beyond its initial scope, so such an action is denied and returned
   immediately — the delegate works around it or stays within scope. Posture is
   chosen up front.
2. **Two layers.** The *delegator* gates the launch command (Layer A); the
   *delegate* gates its own actions (Layer B). A delegator's classifier may
   refuse to launch a delegate that disables sandbox/approvals — and a session
   can't reliably introspect its own privileges, so a denied launch *is* the
   signal (fall back or surface, don't fight it).

### Vendor specifics (from direct probes)

- **claude:** `--permission-mode auto` **fails closed on edits headless** (Edit
  denied, no hang) — so `acceptEdits` is the editing default, `auto` was dropped.
  Web research via `--allowedTools "WebSearch WebFetch"` (server-side, composes
  with any mode). iac works under `acceptEdits` because the permission system
  gates the *Bash command*, not the subprocess's out-of-cwd write.
- **codex:** `codex exec` **cannot escalate at all** — exec has no approval
  channel ("file/command approval is not supported in exec mode"), so
  `-a`/`approvals_reviewer=auto_review` are **inert** for delegates (they work
  only in *interactive* codex, e.g. a codex *lead*). A delegate is bounded purely
  by `-s`; workspace-write edits fine. Web via top-level `--search`. **Trust
  caveat:** `-s` is only enforced in an *untrusted* dir — a codex-trusted project
  runs unsandboxed. Out-of-workspace writes (e.g. iac to `~/.iac`) are rejected
  under workspace-write.

## The iac /tmp fix (committed to `master`, `f866c96`)

Out-of-workspace coordination was the one regular-tier gap for codex: iac
channels defaulted to `~/.iac`, outside codex's sandbox. Fix: **iac now defaults
`IAC_ROOT` to a per-user dir under the system temp dir** (`$TMPDIR`/`/tmp`, a
codex writable root), overridable via `IAC_ROOT`. Verified: a codex
`workspace-write` delegate then researches the web (`--search`) *and* posts to
the channel cleanly. Trade-off (no reboot persistence) is fine — iac channels are
already throwaway.

## The tier model

- **Regular** — edit the working dir + read + server-side web research +
  coordinate over a channel in a writable root. No special flags; launches
  cleanly; covers most delegation.
- **Middle** — targeted extra dirs via `--add-dir` for a task reaching just
  outside its workspace. Still launches cleanly. (Rarely load-bearing.)
- **Extreme (full bypass)** — arbitrary host access (machine maintenance, etc.).
  **Requires the delegator itself to be in bypass** — a normal delegator's Layer
  A refuses to launch a bypass delegate. All-or-nothing (the "nuclear" setup).

Boundary for judging any task (known or not): does it stay within the sandbox +
granted dirs + server-side tools (→ regular/middle), or need arbitrary host
access (→ extreme)? Machine maintenance is inherently extreme.

## The restructure (built; user reviewing)

The permission logic turned out to be *doctrine* (hard-won, cross-cutting,
author-owned), not user *config*. Specifying a tool now requires Layer-A/B
understanding — expert work — so it shouldn't live in the user-editable models
file. Split by ownership:

- **`SKILL.md`** — the doctrine (tiers, two layers, headless-can't-escalate).
- **`tools.md`** (new) — per-tool invocations + per-tier flags + version pin.
- **`models.md`** — trimmed to just the model roster (still user-overridable via
  `~/.config/agent-skills/delegate/models.md`).
- **`README.md`** — user-facing tiering + the bypass-lead rule + an **"adding a
  tool" methodology**: a generalized, agent-runnable version of the empirical
  procedure we used this case (invocation, doesn't-hang, per-tier Layer-B probes,
  escalation check, Layer-A-as-delegator check, version pin). This makes
  `tools.md` community-extensible without maintainer bottleneck.

## Status

Core issue long resolved. This turn delivered: iac `/tmp` default (master), the
delegate restructure (branch), and this record. **Open:** the user is reviewing
the restructure and expects to iterate; final commit-message pass before push;
rebase/merge the branch onto master (which now carries the iac commit).

## Methodology lessons (learned the hard way; now in the README's "adding a tool")

- **Don't name the permission posture in the test prompt.** When probing whether
  a delegator will *allow* a posture (Layer A) — or what an agent picks on its
  own — an explicit request for that posture in the prompt is read by the safety
  classifier as the *user authorizing it*, so it's approved for the wrong reason
  and the test tells you nothing. We poisoned exactly this way early on. Drive
  probes with a natural task; when you must force a posture, do it via the *skill
  text*, not the user prompt.
- **Layer-A behavior is context-sensitive** — a benign, research-framed probe was
  not treated like real use (the asymmetry we couldn't explain at first). Treat
  Layer-A results as tendencies and confirm in a realistic run.
- **Version-pin tool findings** — permission behavior shifts across releases.

## Framing decision (final)

The skill describes permissions as a **posture composed up front** (least-
privileged default → grant more as a task needs → fully unrestricted requires an
unrestricted delegator), *not* rigid named tiers, and hedges behavioral claims as
**observed** ("as of this writing … a headless delegate does not escalate") so it
survives tool and classifier changes. Exact per-tool compositions live in
`tools.md`, version-pinned. This replaces the earlier "regular / middle / extreme
tiers" language used elsewhere in these notes.

## Read-only posture — verified (fresh-agent review follow-up)

A 3-reviewer fresh-agent UX review (see the review transcripts) surfaced that
read-only was under-documented; two probes then settled the behavior:

- **claude read-only is clean and enforced.** Omit `--permission-mode` (the
  default denies edits, network, and out-of-cwd headless) + `--allowedTools` for
  the reads you want. Probe: read ✓, `ls` via `Bash(ls:*)` ✓, edit **denied** ✓ —
  so a read-only reviewer *can* run scoped read-only shell (git/ls). The docs had
  omitted "drop the mode," which led one fresh reviewer to keep `acceptEdits` and
  ship an edit-capable "read-only" delegate.
- **codex `-s read-only` is NOT a hard guarantee.** Probe: in a codex-*trusted*
  dir, `-s read-only` was ignored (trusted → unsandboxed) and the delegate edited
  the file. Codex auto-trusts working dirs, so read-only only holds in an
  *untrusted* dir. `tools.md` now states this plainly.

Kept read-only (claude's is reliable and commonly needed); `tools.md` was
restructured **by argument → values** (not a mix of args and values) and now
shows prompt-passing, cwd, and encourages `--help` for tool specifics.
