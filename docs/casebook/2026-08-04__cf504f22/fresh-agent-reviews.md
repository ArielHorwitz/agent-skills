# Fresh-agent UX review of the `delegate` skill

Three fresh agents (no prior context) reviewed the skill by working six task types and flagging where they had to guess. Verbatim outputs.


## claude-opus-5

I read the four skill files, then worked each of the six task types as a fresh agent would. Where I got stuck I did what a real agent would do next — ran `claude --help` / `codex exec --help` — and I flag every place that was necessary, since needing the CLI's own help is itself a UX failure of the skill.

## Per task type

### 1. Read-only repo review

**Chosen:** `claude`, `claude-opus-5`, read-only posture.

```
cd /path/to/repo && claude -p "follow /tmp/review/handoff.md" \
  --model claude-opus-5 --output-format json \
  --allowedTools "Read Grep Glob WebSearch WebFetch" -n repo-review
```

Friction:
- **Where does the prompt go?** Not one example in `tools.md` includes a prompt. SKILL.md says pass `follow path/to/handoff.md`, `tools.md` shows flags only. I had to check `--help` to learn it's positional after `-p`. This is the single biggest gap — no complete, copy-able command exists anywhere in the skill.
- **What `--permission-mode` pairs with the read-only tool list?** The bullet says "instead of `acceptEdits`, restrict tools" — instead of *what*, then? Omit the flag? Use `manual`? `plan`? (`--help` shows `manual`, `dontAsk`, `plan` exist; `tools.md` mentions none of them.) I guessed "omit it" and trusted SKILL.md's "denials return, it doesn't hang."
- **Can it even read my handoff doc?** SKILL.md's default posture explicitly includes "coordinate over a channel in a writable location (e.g. `/tmp`)", but `tools.md` says `acceptEdits` "denies out-of-cwd access" and says nothing about `/tmp` for claude (the codex entry *does* call out `/tmp` and `$TMPDIR`). So a handoff doc in `/tmp` — exactly what this very task used — is plausibly unreadable without `--add-dir /tmp`. **SKILL.md and tools.md contradict each other here.** I'd defensively add `--add-dir /tmp`, but I'm guessing.
- **No `Bash`** in the reviewer tool list. Reviewing a repo usually wants `git log`/`git diff`. The skill doesn't say whether that's a deliberate exclusion or an oversight, or how to grant a scoped `Bash(git *)`.
- **Working directory is never discussed.** Every posture is defined relative to "the working directory" and nothing tells you how to set it. I inferred `cd`.

### 2. Web research

**Chosen:** `codex`, `gpt-5.6-sol` ("strong at terminal and browsing tasks" — the only browsing hint in `models.md`), read-only + search.

```
codex --search exec --model gpt-5.6-sol -s read-only \
  -o /tmp/research/result.md "follow /tmp/research/handoff.md"
```

Friction:
- `--search` before `exec` looked like a typo until I checked; `tools.md` does say "top-level `--search` flag", which saved me. Good.
- **Does `-s read-only` block writing `-o /tmp/research/result.md`?** The file is written by the CLI, not the model, so probably fine — but the skill never says, and this is the natural pairing for a research delegate.
- Nothing says whether `-o` gets the raw last message or structured JSON, or how that compares to claude's `--output-format json`. I had to guess how to consume the result.

### 3. Implement a feature

**Chosen:** `claude`, `claude-opus-5`, the documented default.

```
cd /path/to/project && claude -p "follow ./handoff.md" \
  --model claude-opus-5 --output-format json \
  --permission-mode acceptEdits --allowedTools "WebSearch WebFetch" -n feat-x
```

This is the one task the skill fully supports — the default composition maps directly onto it. Remaining doubts: whether `acceptEdits` also permits `Bash` (running tests/builds is inherent to "implement a feature", and the skill is silent — `acceptEdits` is about approving *edits*, so does the delegate get to run `pytest`?). I put the handoff doc *inside* the project to dodge the `/tmp` question, which is a workaround the skill should have told me about instead.

### 4. Refactor across several projects

**Chosen:** `codex`, `gpt-5.6-sol`, workspace-write + extra dirs.

```
cd /mnt/black/prog/project-a && codex --search exec --model gpt-5.6-sol \
  -s workspace-write --add-dir /mnt/black/prog/project-b \
  --add-dir /mnt/black/prog/project-c \
  -o /tmp/refactor/result.md "follow /tmp/refactor/handoff.md"
```

Friction:
- **The trusted-directory landmine.** "Only enforced in an *untrusted* directory — a codex-**trusted** project ... runs unsandboxed, so `-s` has no effect there." This is stated as a fact but never as an *instruction*: the skill never tells me to check `~/.codex/config.toml` before relying on a posture, and never says which way this cuts. For this task it's convenient; for task 1 (read-only review) it silently voids my whole posture. That deserves to be a warning in SKILL.md, not a parenthetical in a bullet.
- **Which project do I `cd` into, and does it matter?** Codex has `-C/--cd` ("use the specified directory as its working root") — `tools.md` doesn't mention it. For a genuinely cross-project task, "primary workspace + add-dirs" is an awkward fit and the skill offers no pattern (one delegate per project? one delegate over a parent dir?).
- Picking codex over claude here was a coin flip. The skill gives me no **tool**-selection guidance at all — only model ratings. `models.md` compares models *across* tools, which implicitly makes tool choice a model choice, but SKILL.md asks me to "choose a tool and model" as if they were separate decisions.

### 5. Two delegates handing work back and forth

**Chosen:** ...I largely had to invent this.

```
mkdir -p /tmp/chan && \
cd /path/a && claude -p "follow /tmp/chan/handoff-a.md" --model claude-opus-5 \
  --output-format json --permission-mode acceptEdits --add-dir /tmp/chan \
  --allowedTools "WebSearch WebFetch" -n worker-a &
cd /path/b && codex exec --model gpt-5.6-sol -s workspace-write \
  --add-dir /tmp/chan -o /tmp/chan/result-b.md "follow /tmp/chan/handoff-b.md" &
```

Friction — this is the **weakest-supported** task type:
- The entire guidance is one parenthetical: "Consider using some communication channel for long-running tasks that could benefit from back-and-forth communication (e.g. the `iac` skill)." No statement of what `iac` is, whether the *delegates* need to know about it, how they'd discover it, or what a channel looks like on disk. I only know `iac` exists because I listed `skills/`.
- **How do I run two at once?** SKILL.md says "consider running it in the background" but names no mechanism. `claude --bg` exists (per `--help`) and `tools.md` doesn't mention it; codex has no equivalent I was told about, so I fell back to shell `&`, which loses the ergonomics `--bg` presumably provides.
- The shared channel dir puts the `/tmp`-access ambiguity from task 1 on the critical path: if claude's `acceptEdits` really denies out-of-cwd, this whole pattern silently fails without `--add-dir`, and the skill never spells that out even though "coordinate over a channel in a writable location" is described as part of the *default* posture.
- Nothing on how the delegator supervises: polling, waiting, deadlock if both wait on each other.

### 6. Open-ended machine maintenance

**Chosen:** `claude`, `claude-opus-5`, unrestricted — and I expect to be blocked.

```
claude -p "follow /tmp/maint/handoff.md" --model claude-opus-5 \
  --output-format json --permission-mode bypassPermissions -n machine-maint
```

Friction:
- **I cannot tell whether I'm allowed to do this.** SKILL.md says "you can't reliably know your own privileges in advance" and "a fully unrestricted delegate generally requires an unrestricted delegator" — honest, but as an operating instruction it leaves me to fire a call I expect to be refused. There's no suggested probe, and no guidance on whether attempting-and-being-denied is fine or something to avoid.
- The fallback is vague: "fall back to a more restrictive posture, or surface it to the user." For *this* task there is no meaningful restrictive fallback — installing packages and editing system config needs root-ish scope. The right answer is almost certainly "surface it and tell the user to restart the delegator unrestricted" (which the README explains well) — but that advice lives in the **README, which an agent never reads**. That's a placement bug: the most actionable sentence about unrestricted delegation is in the human doc.
- `--help` shows claude has both `--dangerously-skip-permissions` and `--allow-dangerously-skip-permissions` alongside `--permission-mode bypassPermissions`; `tools.md` names only the last. Not obviously wrong, but a fresh agent hitting a refusal will start guessing among three flags.

## Overall UX

**What's clear and good.** The doctrine is genuinely well-written: the two-layer model (delegator's safety layer vs. delegate's flags), "headless means posture is fixed up front", "denial returns rather than hangs" (this one preempts real anxiety — I'd otherwise have worried about a hung subprocess), and least-privilege-then-grant-more. The version pins (*Observed with claude 2.1.220*) and the parenthetical about `--permission-mode auto` failing headless are exactly the kind of hard-won detail that saves an agent a wasted run. `models.md`'s three-axis framing with cost-to-task, and the "try effort before escalating model" rule, are usable. The `--search`-before-`exec` note saved me an error. Every flag I checked against the real CLIs was accurate.

**What's confusing or missing**, roughly in order of how much it hurt:

1. **No complete command anywhere.** Not one example includes a prompt argument or shows the resulting invocation end-to-end. SKILL.md tells me *what* to pass, `tools.md` shows *flags*, and the two are never joined. Every one of the six tasks began with me guessing prompt placement.
2. **The `/tmp` contradiction.** SKILL.md: default posture covers "coordinate over a channel in a writable location (e.g. `/tmp`)". `tools.md` claude: `acceptEdits` "denies out-of-cwd access", with no `/tmp` carve-out (codex has one). The handoff-doc workflow and the multi-agent channel both depend on the answer.
3. **Working directory is undiscussed.** All postures are cwd-relative; nothing says how to set the delegate's cwd, and codex's `-C/--cd` is unmentioned.
4. **The read-only claude posture is half-specified** — an `--allowedTools` list with no accompanying `--permission-mode`, and no mention that `manual`/`dontAsk`/`plan` exist.
5. **Multi-delegate coordination is a single parenthetical** for what the skill presents as a first-class capability.
6. **Tool selection has no guidance**, only model ratings.
7. **"Run it in the background" names no mechanism** (`claude --bg` exists and is undocumented here).
8. **The most actionable unrestricted-delegation advice is README-only**, invisible at runtime.

**Top improvements I'd make:**

1. Add one **complete worked invocation per posture per tool** in `tools.md` — prompt included, `cd`/`-C` included, output capture included. Four or five lines each; it eliminates most of the guessing above.
2. **Resolve the `/tmp` question explicitly** for claude and state the handoff-doc convention: where the doc goes and which flag makes it readable. If `--add-dir /tmp` is required for the default flow, put it in the default composition.
3. Add a short **"Coordinating multiple delegates"** section to SKILL.md: channel dir, the `--add-dir` grant both sides need, how to run concurrently, and one sentence on what `iac` actually is.
4. Promote the **codex trusted-directory caveat** from a bullet to an explicit check ("before relying on `-s`, confirm the project isn't trusted in `~/.codex/config.toml` — a trusted project runs unsandboxed and `-s` is ignored"), since it silently voids a read-only posture.
5. Move the README's unrestricted-delegator paragraph — the "tell the user to restart their session unrestricted" advice — into SKILL.md's fallback guidance, where the agent will actually see it.

One factual item to verify: `models.md` lists `claude-haiku-4-5`, while the full model ID is `claude-haiku-4-5-20251001`. `--model` accepts aliases, so it may resolve fine — but the other rows use full IDs, so it's worth confirming rather than assuming.


## claude-sonnet-5

I did the walkthrough myself (no context beyond the four files) rather than delegating, since the task is to *be* the fresh agent and report friction — spawning a sub-agent to role-play that would just add a layer of indirection.

## Per task type

**1. "Review this repo's code and report problems" (read-only)**

tools.md gives edit-mode as one full block but read-only only as a diff instruction: *"instead of `acceptEdits`, restrict tools: `--allowedTools "Read Grep Glob WebSearch WebFetch"`"*. It never says what happens to `--permission-mode` itself — do I drop the flag, or keep `acceptEdits` and just not include `Edit` in `--allowedTools`? I inferred the latter (mode stays, but `Edit` isn't in the allowlist so it's moot), giving:

```
claude -p --model claude-sonnet-5 --effort medium --output-format json \
  --permission-mode acceptEdits --allowedTools "Read Grep Glob WebSearch WebFetch" -n review-task
```

Model choice was a guess: models.md never maps task-types to models, so I reasoned from the "notes" column myself (opus-5 for hard/architectural review, sonnet-5-medium for routine review) — reasonable, but unsupported by the doc.

**2. "Research X and summarize"**

No edit needed at all, so the *default composition* (edit + web) is over-privileged for this task, and "least-privileged posture that fits" points me back to the same read-only block as #1, minus `Grep`/`Glob` maybe (irrelevant locally, only web matters) — but the skill never offers a "web-only, no local read" preset, so I'm assembling one ad hoc:

```
claude -p --model claude-sonnet-5 --output-format json \
  --permission-mode acceptEdits --allowedTools "WebSearch WebFetch" -n research-task
```

Minor friction: I had to synthesize this from two separate bullets (read-only + web-research) rather than being given it directly, even though "pure research, no repo access" feels like a very common case.

**3. "Implement this feature"**

The one case with zero friction — it's the literal example given in SKILL.md's Permissions section ("the default composition in tools.md ... launches without fuss"):

```
claude -p --model claude-opus-5 --output-format json \
  --permission-mode acceptEdits --allowedTools "WebSearch WebFetch" -n impl-feature
```

**4. "Refactor across several projects on this machine"**

Needs `--add-dir` per tools.md: *"extra locations — `--add-dir <path>` grants specific dirs outside the workspace."* Singular example, singular path. For N project dirs I had to guess whether the flag repeats (`--add-dir /a --add-dir /b`) or takes a list — the doc gives no syntax for the multi-dir case, which is exactly the case this task needs.

```
claude -p --model claude-opus-5 --output-format json --permission-mode acceptEdits \
  --allowedTools "WebSearch WebFetch" --add-dir /path/to/proj2 --add-dir /path/to/proj3 -n multi-refactor
```

**5. "Coordinate two delegates handing work back and forth"**

Here the doc contradicts itself. SKILL.md says the default posture covers *"coordinate over a channel in a writable location (e.g. `/tmp`)"* — implying `/tmp` is writable by default. But tools.md's claude entry says `acceptEdits` *"denies out-of-cwd access"*, and only lists `/tmp`/`$TMPDIR` as in-scope for **codex**'s `workspace-write` default, not claude's. So if I pick `claude` as my tool, the "coordinate via /tmp" promise in SKILL.md is false unless I additionally add `--add-dir /tmp` — which nothing tells me to do. I'd only catch this by cross-referencing both files closely; a fresh agent following SKILL.md at face value would spawn two claude delegates, point them at a `/tmp` channel file, and watch both writes get denied.

Beyond that, "coordinate two delegates handing work back and forth" gets one clause — *"Consider using some communication channel for long-running tasks... (e.g. the `iac` skill)"* — with no detail on the actual mechanics (polling? file locking? how does delegate B know delegate A wrote?). I'd have to go read the separate `iac` skill, which isn't bundled here, to actually execute this task type.

**6. "Open-ended machine maintenance"**

Requires the unrestricted posture: `bypassPermissions` (claude) or `-s danger-full-access` / `--dangerously-bypass-approvals-and-sandbox` (codex), and both SKILL.md and README are explicit that *"a delegator must itself be unrestricted to launch this."* The doc is honest that I can't check this in advance ("you can't reliably know your own privileges in advance") — so the documented procedure is just: attempt it, and if refused, "fall back to a more restrictive posture, or surface it to the user." That's a coherent instruction, not a gap, but it does mean this task type can't be planned deterministically from the doc alone — it's discover-by-attempting every time.

## Overall UX

**Clear:** the two-layer permission model (delegator vs. delegate) is well explained and consistently referenced across all three files. The "least-privileged posture that fits" principle is stated once and actually usable as a decision rule. The default (edit+cwd+web) composition is genuinely copy-pasteable for the common case (#3).

**Confusing / missing:**
- No worked example of the **read-only** or **web-only-no-edit** invocation as a complete command — only the edit-default gets a full code block; every other posture requires the agent to hand-assemble flags from prose, and the `--permission-mode` question in #1 is a real ambiguity (keep it or drop it?).
- No multi-value syntax for `--add-dir` when a task spans several external directories (#4) — plausible failure mode: agent tries `--add-dir a,b` (comma list) since that's a common CLI convention, and it silently doesn't do what's expected, or errors.
- The `/tmp`-is-writable claim in SKILL.md (used for delegate-to-delegate coordination) doesn't hold for claude's own documented default in tools.md — that's a direct cross-file inconsistency, not just an omission, and it's exactly the scenario (#5) where a silent permission denial would be most confusing to debug headless (no human in the loop to explain why the write failed).
- models.md has no task→model mapping at all, just axis ratings; every task requires the agent to freehand a justification from a table, which is fine for a capable agent but is unograted guessing for anything borderline.
- "Coordinate two delegates" is one clause deep and points outside the skill (`iac`) with no summary of what that integration actually requires here.

**Top concrete improvements:**
1. Give the read-only/web-only postures full copy-paste command blocks (like the edit-default has), not diffs against it — and resolve whether `--permission-mode` is kept or dropped for read-only.
2. Document `--add-dir` multi-directory syntax explicitly (repeat the flag? one call per dir? verified example).
3. Either fix the `/tmp` claim in SKILL.md to be tool-conditional, or make claude's default include `--add-dir /tmp` when a channel is in play — right now the general doctrine and the specific tool entry disagree.
4. Add one sentence in SKILL.md on what "coordinate over a channel" concretely means mechanically (a shared file both delegates poll? who initiates?), even if `iac` has the full detail.


## codex gpt-5.6-sol

The fresh-agent review is complete. Full report: [result.md](/tmp/delegate-review/result.md). Resumable delegate session: `019ff27e-4d24-75a0-8368-08a3baee96da`.

The central finding: the permission model is understandable, but a fresh agent still has to invent important command syntax and coordination mechanics.

### 1. Repository review

Claude Opus 5, high effort, read-only, no web:

```bash
claude -p 'follow .delegate/repo-review.md' \
  --model claude-opus-5 \
  --effort high \
  -n repo-review \
  --output-format json \
  --allowedTools "Read Grep Glob" \
  > /tmp/delegate-repo-review.json
```

Unclear points: prompt placement is undocumented; the allowlist prevents `git`, tests, and other useful read-only shell commands; placing the handoff outside the workspace may make it unreadable.

### 2. Web research

Codex Sol, read-only with web search:

```bash
codex --search exec \
  --model gpt-5.6-sol \
  -s read-only \
  -o /tmp/delegate-web-research.txt \
  'follow .delegate/web-research.md'
```

Unclear points: positional prompt placement and whether `-o` works under read-only. More seriously, the documented Codex “trusted project” behavior may silently defeat the read-only sandbox.

### 3. Feature implementation

Codex Sol, workspace-write, no web:

```bash
codex exec \
  --model gpt-5.6-sol \
  -s workspace-write \
  -o /tmp/delegate-feature-x.txt \
  'follow .delegate/feature-x.md'
```

Unclear points: no model-selection threshold between Sol and cheaper Luna; no guidance for tests needing caches, containers, sibling directories, or networking; inherited secrets and environment are unexplained.

### 4. Multi-project refactor

Assuming three known paths:

```bash
cd /work/project-a && codex exec \
  --model gpt-5.6-sol \
  -s workspace-write \
  --add-dir /work/project-b \
  --add-dir /work/project-c \
  -o /tmp/delegate-multiproject-refactor.txt \
  'follow .delegate/multiproject-refactor.md'
```

Unclear points: repeatable `--add-dir` usage is inferred rather than demonstrated; working-directory selection is undocumented; discovery across unknown projects may require unrestricted access; symlink and nested-repository behavior is unspecified.

### 5. Two-agent coordination

Best-effort Codex/file-channel interpretation:

```bash
codex exec \
  --model gpt-5.6-sol \
  -s workspace-write \
  -o /tmp/delegate-channel/agent-a-result.txt \
  'follow /tmp/delegate-channel/agent-a-handoff.md' &

codex exec \
  --model gpt-5.6-sol \
  -s workspace-write \
  -o /tmp/delegate-channel/agent-b-result.txt \
  'follow /tmp/delegate-channel/agent-b-handoff.md' &

wait
```

This case is materially underspecified. The skill mentions `iac` but provides no channel setup, messaging protocol, locking, turn-taking, timeout, cancellation, or failure recovery. The command launches two agents but does not ensure they can hand work back and forth.

### 6. Open-ended machine maintenance

Codex Sol, unrestricted with web search:

```bash
codex --search exec \
  --model gpt-5.6-sol \
  -s danger-full-access \
  -o /tmp/delegate-machine-maintenance.txt \
  'follow /tmp/delegate-machine-maintenance.md'
```

The delegator must already be unrestricted. The skill does not explain whether this grants root or `sudo`, package-manager networking, credentials, secrets, or interactive terminal access.

### Overall recommendations

The highest-value improvements are:

1. Supply complete, copy-paste commands showing prompt placement, quoting, working directory, output capture, and session identification.
2. Resolve the Codex trusted-project sandbox issue.
3. Document two-delegate coordination end to end.
4. Clarify what “unrestricted” does and does not grant.
5. Add safe shell/VCS inspection to the read-only review posture.
6. State where handoff files should live for every posture.
7. Add preflight checks for CLI availability, authentication, versions, models, and sandbox state.

The permission doctrine and model table are useful, but the runtime documentation is not yet sufficient for exact, reliable use without outside CLI knowledge.
