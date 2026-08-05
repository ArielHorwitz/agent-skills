# Design notes & open threads

Deferred items to address once the permission testing is complete. Not to be
acted on now.

## 1. Delegates must not "crash"/stop on a failed command — CLOSED

The hard requirement: a spawned delegate must **never hang or halt entirely**
because a command was denied/failed — it should get the failure back and carry
on (try something else, or finish limited). A *limited* delegate is fine; a
*broken* one is not.

- Claude `-p`: prior finding says there is no interactive channel, so an
  unpermitted action is denied and returned immediately (no hang). Believed
  safe, re-confirm in the auto runs.
- Codex `codex exec`: `-a never` is *documented* to return execution failures
  to the model immediately (no hang). `-a on-request` + `auto_review` was
  *observed* not to hang in run 2. Neither is proven across all cases.

**Status: closed.** No stalling/crashing observed across runs 1–3 (the run-3
lead explicitly confirmed no stalls). If it ever surfaces, handle it in a
separate case or reopen this one.

## 2. Delegate should set delegate permissions explicitly, not inherit ambient user config (README)

Principle (from the user): **the delegator determines the delegates'
permissions**, not the user's own `~/.claude` / `~/.codex` defaults. A delegate
invocation should carry its own permission posture via CLI flags so it behaves
the same in any environment (e.g. codex: set `-c 'approvals_reviewer="auto_review"'`
explicitly rather than depending on the user having it configured).

Rationale to capture in the README when done:
- Default spawned sessions to **auto/classifier-governed** permissions. This
  both (a) lets headless delegates actually function and (b) appeases the
  *delegator's* own classifier (a claude delegator blocks spawning
  approvals-off delegates).
- **Override a more restrictive user default**: a user who manually approves
  everything can't realistically service recursive spawned-session prompts —
  delegate's whole premise is unattended (potentially recursive) spawning, so
  it should not inherit "ask me for everything."
- **A full-bypass user default** hits the opposite wall: a claude delegator's
  classifier denies spawning bypass sessions. Auto is the mode that threads
  both.
- The README should spell out the permission implications for **both** the
  delegator and the delegates so users understand the model.

**Status — README written (lean).** `skills/delegate/README.md` now has a
"trade-off" section covering the delegator/delegate permission implications (you
control each spawn's model + permissions and can go cross-vendor, but the
delegating session's own safety classifier judges each launch and you override
each tool's default config), plus a models-file note that the bundled defaults
are classifier-governed with a fallback ladder. The deeper exposition above
(override-restrictive-default, recursive-spawning, full-bypass wall) was
**intentionally kept out** for leanness (user preference) — it lives here, not
in the shipped README.

## 4. Forced-defaults — DONE (resolved via direct probes)

The strict skill-text scaffold didn't make the claude lead use `auto` — and
shouldn't have: **direct probes proved `auto` can't edit headless** (fails
closed on every edit + network, no human to approve). Net: `auto` **dropped**,
claude default → **`acceptEdits`**, codex posture-B confirmed to edit. Scaffold
reverted. See [matrix-run-results.md](matrix-run-results.md) "Forced-defaults
attempt + direct probes".

## 3. Canonical `models.md` is the repo copy

As of the posture-B change, edits go to the **repo** copy
(`skills/delegate/models.md`) as the single source of truth (tracked in git).
The user runs `install --upgrade delegate` to sync the installed copy
(`~/.agents/skills/delegate/models.md`), which the live delegate runs actually
read — so **`install --upgrade` before each test run** or the run uses a stale
file. Current content: claude `--permission-mode auto`; codex default
`-a on-request -c 'approvals_reviewer="auto_review"' exec … -s workspace-write`
(posture B), with `acceptEdits` / read-only / `never` / `danger-full-access`
documented as fallbacks. **Superseded:** the models.md structure described here
was restructured (doctrine → `SKILL.md`; invocations → new `tools.md`; roster →
`models.md`) — see §5 and
[permission-model-tiering-and-restructure.md](permission-model-tiering-and-restructure.md).

## 5. Architecture decision: doctrine vs inventory (DONE — user reviewing)

The permission logic proved to be *skill doctrine* (author-owned, cross-cutting),
not user *config* — specifying a tool now needs Layer-A/B understanding. So the
skill was split by ownership: `SKILL.md` (doctrine), `tools.md` (per-tool
invocations + version pins), `models.md` (user-overridable model roster),
`README.md` (tiering + bypass-lead + an agent-runnable **"adding a tool"
methodology** that generalizes this case's empirical procedure). Also: iac
default root → `/tmp` on `master` (`f866c96`) so codex delegates can coordinate.
**Open:** user reviewing/iterating; final commit-message pass; rebase/merge the
branch onto master.
