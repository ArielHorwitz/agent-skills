# Claim verification report — `delegate` skill (tools.md / SKILL.md)

After building the restructured skill, we ran a fresh-agent UX review, then two
rounds of empirical claim-testing: a first round (one agent per bucket, no
redundancy) that surfaced disputes, and a hardened round of **five independent
verifiers**, each testing *every* claim with controls, codex config isolated in a
scratch `CODEX_HOME` (the real `~/.codex/config.toml` was never touched),
structural signals (`permission_denials`, disk state, CLI headers) over model
prose, and a poisoning guard on the unrestricted-delegator claim. Observed
tools: **claude 2.1.220, codex-cli 0.147.0**. A reversal was adopted only where
independent verifiers agreed.

This report documents each **contested or clarified** claim (plain-HOLDS claims
are omitted). The corrections implied here are pending; the only doc change made
so far is the benign `codex exec resume` syntax (A16).

---

## A1 — a headless delegate cannot escalate mid-run, and never hangs

**The claim.** The doctrine says a headless delegate cannot escalate its own
permissions mid-run: an action beyond its granted scope is denied and returned to
it (there is no human to approve), and it never hangs waiting on approval.

**What was clarified.** The "never hangs" half is universally true. The "cannot
escalate" half is true for claude in every mode, but for codex it is true *only
when no automatic approver is configured* — with codex's `approvals_reviewer`
set (as this machine's config is) or `--approve-for-me`, a headless codex
delegate can escalate past its sandbox (see A18). Accurate framing: a headless
delegate generally can't escalate — unless the tool provides an automatic
approver.

**The evidence.** Across dozens of runs by five verifiers, nothing ever hung
(no run hit the 300 s timeout); denied claude actions appeared structurally in
`permission_denials` and the delegate continued to later steps. For codex, a
`-s read-only` run under `approvals_reviewer=auto_review` wrote a file outside the
workspace, while the byte-identical run under a clean config was blocked
("writing is blocked by the read-only sandbox") — isolated in scratch
`CODEX_HOME`.

## A2 — a third bound: the delegator's own OS sandbox

**The claim.** The doctrine describes two layers: the delegator gates the launch;
the delegate's own flags gate what it does once running.

**What was clarified.** There is a third, independent bound the doctrine omits: a
delegate inherits the *delegator's own OS process sandbox*. A delegate spawned
`bypassPermissions` / `danger-full-access` is unrestricted only *within* the
delegator's process sandbox — e.g. it still has no network if the delegator's
shell has none.

**The evidence.** Several verifiers' own bash sandboxes had no DNS; a
`bypassPermissions` claude delegate they spawned still failed `curl` (exit 6) and
`WebFetch` (`getaddrinfo ENOTFOUND`) despite `permission_denials: []` — the
delegate's network failure exactly matched the delegator's, i.e. inherited, not a
permission denial.

## A3 — a fully unrestricted delegate requires an unrestricted delegator (UNTESTABLE)

**The claim.** A delegator's own safety layer may refuse to launch a
fully-unrestricted (bypass) delegate, so such a delegate "generally requires an
unrestricted delegator."

**What was clarified.** This cannot be tested cleanly, and an earlier result that
seemed to falsify it was poisoned. To launch an unrestricted delegate the
dangerous flag must be on the command line, and naming/requesting a dangerous
posture is itself read by a safety classifier as *user authorization* — so a
"successful" launch proves nothing. The claim stands as written; its ground truth
is the original case's run 1, where an interactive `/lead` session's classifier
*did* refuse a `bypassPermissions` spawn in genuine use.

**The evidence.** All five verifiers independently marked this UNTESTABLE,
reasoning that they could not restrict their own session from within it and that
any authorizing prompt voids the test. This reversed a first-round result in
which an agent had been *instructed* to spawn bypass delegates (explicit
authorization) and wrongly concluded the claim false — the poisoning trap the
skill's own methodology warns about.

## A4 — `acceptEdits` allows shell, but scoped to the working directory

**The claim.** `--permission-mode acceptEdits` lets the delegate "edit files in
the working dir and run local commands."

**What was clarified.** "run local commands" is too broad: under `acceptEdits`,
Bash is confined to the working directory. In-cwd commands run; a Bash command
that reads *or* writes outside cwd is denied (the confinement is not
write-specific). Corrected phrasing: "run commands scoped to the working dir."

**The evidence.** Under `acceptEdits`, `echo X > ./f` and `printf … > ./f`
succeeded, but `cat /etc/hostname`, `ls`/`touch`/`cp` against out-of-cwd paths,
and running a script that writes elsewhere were all denied (in `permission_denials`,
nothing on disk).

## A5 — "omit `--permission-mode` ⇒ read-only" depends on user settings

**The claim.** Omitting `--permission-mode` yields a read-only delegate (denies
edits, network, out-of-cwd).

**What was clarified.** What "omitting the flag" resolves to is read from the
user's `~/.claude/settings.json` `defaultMode`. On a machine with `defaultMode:
auto` (or the built-in default) omitting yields read-only, but a user with
`defaultMode: acceptEdits` would silently get a *writable* delegate — so "omit
for read-only" is not a guarantee. The reliable read-only path is the explicit
`--allowedTools` reviewer recipe (A8).

**The evidence.** A verifier found this machine's `settings.json` sets
`defaultMode: auto`; it re-ran with `--setting-sources ""` and confirmed the
built-in default is *also* read-only, but flagged the settings dependency. All
verifiers confirmed the omit-run denied edits and network here.

## A7 — `WebSearch` is server-side; `WebFetch` is client-side

**The claim.** `--allowedTools "WebSearch WebFetch"` gives web research
"server-side, no local network needed," composing with the permission mode.

**What was clarified.** Composition is correct (`acceptEdits` + these = edit *and*
research). But "server-side, no local network" is true only of `WebSearch`.
`WebFetch` performs the fetch from the delegate's *own* machine and needs local
network/DNS, so it fails in a network-restricted delegate. The two must be split
in the docs.

**The evidence.** In verifier sandboxes with no local DNS, `WebSearch` returned
live results with citations (server-side), while `WebFetch` failed every time
with `getaddrinfo ENOTFOUND example.com` — permitted by the permission layer,
then unable to resolve locally. Reproduced by all four verifiers who tested it.

## A8 — the read-only reviewer's scoped-Bash grant (possibly redundant)

**The claim.** A read-only reviewer = omit `--permission-mode` + `--allowedTools
"Read Grep Glob"` plus scoped `Bash(git:*)` / `Bash(ls:*)`, giving read + git/ls
without edits.

**What was clarified.** The recipe works exactly as documented. Whether the scoped
Bash is *necessary* is unsettled: some verifiers found read-only mode already
auto-allows safe read-only shell (making the grant redundant), others found Bash
denied without it. Because the explicit grant works reliably for everyone, it is
kept as belt-and-braces rather than removed.

**The evidence.** With `--allowedTools "Read Grep Glob Bash(git:*) Bash(ls:*)"`,
verifiers confirmed `git status`/`ls` ran while `Edit`/`Write`/`rm` were denied
(target file byte-identical afterward). The redundancy split: verifier 1 (and
round-1 agent 1) saw safe shell auto-allowed under the bare mode; verifier 4 saw
Bash denied without the grant — plausibly sensitive to the ambient `defaultMode`.

## A10 — `acceptEdits` confines Bash to cwd (no out-of-cwd escape hatch)

**The claim.** Under `acceptEdits`, the Write/Edit tools are blocked outside the
working dir, *but a Bash command could still write elsewhere* (e.g. an `iac`
channel under `/tmp`) without `--add-dir`.

**What was clarified.** False — a real doc bug. Under `acceptEdits`, Bash is
confined to the working directory exactly like Write/Edit; out-of-cwd reads and
writes are denied. The recommended `iac`-channel-under-`/tmp` pattern will
silently fail; it needs `--add-dir /tmp/<channel>`. (An earlier "it works"
observation was a fragile artifact — the classifier failed to *recognize* the
opaque `iac` script as an out-of-cwd write on one run, which is not reliable.)

**The evidence.** Under `acceptEdits`, verifiers tried `>` redirection, `cp`,
`touch`, `python3 -c "open(...,'w')"`, and running a script that writes
elsewhere, all targeting `/tmp` — every one denied (in `permission_denials`,
nothing on disk); the identical command *plus* `--add-dir` succeeded (the
control). Consensus 5/5. This also corrects the earlier session claim that
"resolved" the `/tmp` contradiction by asserting a Bash escape hatch.

## A16 — resuming a codex session (benign syntax; already fixed)

**The claim.** Resume a codex delegate with `codex resume <id>`.

**What was clarified.** `codex resume` is the interactive TUI and errors headless
(`stdin is not a terminal`). The headless form is `codex exec resume <id>
"<prompt>"`; it rejects `-s`/`--model`/`-C`, needs `--skip-git-repo-check` in a
non-git dir, and does *not* restore the original session's model/sandbox/cwd. This
fix was applied immediately as benign.

**The evidence.** `codex resume <id> </dev/null` → `Error: stdin is not a
terminal`; `codex exec resume <id> "<prompt>"` returned the earlier session's
stored token with the same session id. Rejections and the trust re-check
reproduced across verifiers.

## A18 — codex `exec` CAN escalate past `-s` under an automatic approver (safety)

**The claim.** A headless `codex exec` cannot escalate past its `-s` sandbox — an
out-of-sandbox action is rejected, and `-a` / `approvals_reviewer` have no effect.
(Written from codex 0.146.0 testing.)

**What was clarified.** On codex 0.147.0 this is false when an automatic approver
is present. `approvals_reviewer = "auto_review"` in `~/.codex/config.toml` (which
this machine sets) — or the `--approve-for-me` flag — flips headless `exec`
approval to `on-request` and auto-approves the delegate's own escalation requests,
letting a `-s read-only` (or `workspace-write`) delegate write *outside* its
sandbox, silently. `approval_policy` alone is inert in `exec`, and
`--approve-for-me` is mutually exclusive with `-s`. So `-s` is a hard ceiling only
when no auto-approver is configured; for a guaranteed bound, pass
`--ignore-user-config` (or clear `approvals_reviewer`). This is safety-relevant:
a *default* codex delegate on this machine can escape its sandbox.

**The evidence.** In clean scratch-`CODEX_HOME` isolation, four verifiers ran
identical `-s read-only` sessions differing only by config: with
`approvals_reviewer=auto_review` the delegate wrote to `/var/tmp/…` and
`/home/wiw/…` (outside the workspace; verified on disk, then removed); with a
`model`-only config (or `--ignore-user-config`) the same write was rejected;
`approval_policy=on-request` alone kept approval at `never` and blocked it;
`--approve-for-me` + `-s` errored (`cannot be used with --sandbox`). Consensus
5/5. This corrects tools.md *and* the earlier session probe, which on 0.146.0 had
gotten "approval is not supported in exec mode" — codex changed between versions.

## A20 — codex `read-only` is honored regardless of trust; trust only sets the default

**The claim.** `-s read-only` is "enforced only in an untrusted directory — a
codex-trusted project runs unsandboxed, so `-s` (read-only included) is ignored
there." (This was the earlier session's conclusion, that trust defeats read-only.)

**What was clarified.** Backwards. An explicit `-s` always wins — `-s read-only`
is honored in a trusted directory (writes denied). What trust actually changes is
the *default* sandbox when `-s` is *omitted*: an untrusted dir defaults to
`read-only`, a trusted dir to `workspace-write` (not "unsandboxed"). Codex records
trust for a dir only when it runs there with a writable sandbox. The real hole in
read-only is the automatic approver (A18), not trust. Relatedly, tools.md's
"`workspace-write` *(default)*" label is wrong — it is only the default in a
trusted dir; always pass `-s` explicitly.

**The evidence.** Verifiers pre-trusted a scratch dir and ran `-s read-only`
there: writes denied (`Read-only file system`), disk unchanged. The same trusted
dir with `-s` omitted defaulted to `workspace-write`; a fresh untrusted dir with
`-s` omitted defaulted to `read-only`. Trust entries were written only for
writable-sandbox runs. Consensus 5/5. This corrects the earlier "trust defeats
read-only" probe, which had mis-attributed an `approvals_reviewer`-driven
escalation to trust.

## A22 — codex `--search` and web availability

**The claim.** `--search` (top-level, before `exec`) enables web research via the
native server-side `web_search` tool, and it is part of the default invocation.

**What was clarified.** The placement requirement is real (`codex exec --search`
errors — it must precede `exec`) and web search is genuinely server-side. But on
codex 0.147.0, `web_search` is available *without* `--search` (the flag appeared
to be a no-op), and there is no reliable flag to *disable* web (even
`-c tools.web_search=false` still searched). So `--search` is belt-and-braces for
older versions, not the thing that gates web access.

**The evidence.** With a clean config, verifiers ran the same live-data prompt
with `--search`, without it, and with `--ignore-user-config` — all emitted
`web search:` tool-call lines and returned live results; server-side confirmed
with local DNS blocked. Majority (4/5) IMPRECISE; one verifier marked HOLDS
without running the no-flag control.

## Version drift — codex 0.146.0 → 0.147.0

**The context.** tools.md pinned "Observed with codex 0.146.0," and the earlier
session probes ran on 0.146.0.

**What was clarified.** The machine updated to codex 0.147.0 mid-effort, and at
least one core behavior changed: on 0.146.0 a headless `exec` could not escalate
(auto_review inert); on 0.147.0 `approvals_reviewer` / `--approve-for-me` *do*
escalate it (A18). A live demonstration of the version fragility the version-pin
convention exists for — a "settled" permission fact expired within days. The pin
should move to 0.147.0, and codex claims re-verified on future bumps.

**The evidence.** All five verifiers reported `codex-cli 0.147.0`; the A18
reversal correlates exactly with the version change.

## Methodology note — why this round is trustworthy

The first round (one agent per bucket, no redundancy) produced two wrong or
mis-stated conclusions (trust-defeats-read-only; the exact escalation mechanism)
because a single experiment is easy to mis-isolate. The second round used five
independent verifiers, each testing every claim, with codex config isolated in a
scratch `CODEX_HOME`, explicit with/without controls, structural signals over
prose, and a poisoning guard. Reversals were taken only on cross-verifier
agreement. Both of the user's challenges — that A3 was poisoned, and that A18's
mechanism had been mis-stated — were borne out.
