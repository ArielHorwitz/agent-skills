# `skills/delegate/models.md` — changes & rationale

As a result of this investigation we rewrote `skills/delegate/models.md`. This
records *why*, so the edits aren't opaque to a later reviewer. (See
[overview.md](overview.md) for the pivot and [matrix-run-results.md](matrix-run-results.md)
for the runs that motivated it.)

## 1. Default permission flipped off full-bypass

- **claude:** `--permission-mode bypassPermissions` → **`acceptEdits`** (the
  working headless editing default — denies network/out-of-cwd, never hangs).
  Options: read-only reviewer via `--allowedTools "Read Grep Glob WebSearch
  WebFetch"`; `bypassPermissions` only with explicit user auth. (`auto` was the
  first-chosen default but **dropped** — direct probes proved it fails closed on
  all edits and network headless; see matrix-run-results.)
- **codex:** `-s danger-full-access` → **posture B**:
  `codex -a on-request -c 'approvals_reviewer="auto_review"' exec … -s
  workspace-write`. Fallbacks: read-only + top-level `--search`; `-a never`
  (safest/most portable, documented no-hang); `danger-full-access` (with auth).

**Why:** the bypass default is what tripped the claude delegator's Layer-A
"Create Unsafe Agents" block (matrix run 1). Its stated justification — "so a
headless call doesn't hang on approval" — is false: headless `-p`/`exec` never
hangs (a denial returns immediately). So bypass solved a non-problem and caused
the real one. `acceptEdits` / posture-B launch cleanly and let delegates do real
work; run 1 showed a capable lead downshifts to exactly these on its own.

## 2. Codex permission model clarified + made self-contained

Codex has **two orthogonal axes** — sandbox (`-s`) and approval (`-a`,
top-level before `exec`) — plus the **reviewer** (`approvals_reviewer` ∈
`user | auto_review`; `guardian_subagent` is a backward-compat alias, dropped).
We set `approvals_reviewer="auto_review"` **explicitly via `-c`** so the
delegate's permissions are determined by the delegator invocation, **not by the
user's ambient `~/.codex/config.toml`** (portability principle — must work in
any environment).

Verified against codex 0.146.0: flags parse; **`on-failure` does not exist**
(policies are `untrusted | on-request | never`); `--help` does *not* validate
`-c` values, so `auto_review`'s runtime validity rests on the binary's enum
string + the user's config + run 2 — **live confirmation pending run 4**.

## 3. Reason-first framing, concision, version pins

- "Denials and fallback" is one shared section (not repeated per tool),
  written to **explain the why** rather than hardcode do/don'ts — the user's
  stated preference for durability as the models reasoning over it improve. It
  records the observed asymmetry (claude delegator classifier denied
  unrestricted sessions that codex's approved).
- Tools section tightened (~90 → ~55 lines); **observed versions** pinned at
  the end of each tool block (claude 2.1.220, codex 0.146.0), and the Models
  table carries a "last updated" month — both to help future maintainers judge
  staleness.

## 4. Removed misalignment concerns (for now)

Dropped the **Fidelity axis + its table column** and the **`gpt-5.6-sol`
"gaming evaluations" note**. Rationale (user): that note caused constant
second-guessing of `sol`; for the vast majority of delegate work "did it cheat"
is irrelevant, and where it matters the user can request independent review.
The column existed only to carry those trust flags, so it went with them.

**Removed** the `claude-fable-5` note as well (later user decision) — it was
*reliability/availability* info (silent substitution to Opus 4.8, past
export-control outage), not model misalignment, but trimmed in the same
decluttering pass.

## 5. Canonical source

The **repo** `skills/delegate/models.md` is the single source of truth (git-
tracked); the user runs `install --upgrade delegate` to sync the installed copy
that live runs read. See [design-notes-and-open-threads.md](design-notes-and-open-threads.md) §3.
