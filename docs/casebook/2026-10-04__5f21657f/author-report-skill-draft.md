# Author report: `refresh-delegate-catalog` skill draft

## What I built

`.agents/skills/refresh-delegate-catalog/`:

| file | purpose |
| --- | --- |
| `SKILL.md` | the procedure: principles, bundled files, eight phases, each with its output artifact and who does it |
| `agents/openai.yaml` | Codex sidecar disabling implicit invocation, mirroring `disable-model-invocation: true` (same as `lead`, `report-skill-feedback`) |
| `research-brief.md` | researcher handoff template, adapted from the wave-2 brief |
| `verification-brief.md` | claim-verifier handoff template |
| `calibration/check.py` | checker for a finished calibration run |
| `calibration/fix-intervals/` | `TASK.md`, `intervals.py`, `test_intervals.py` |
| `calibration/extract-orders/` | `TASK.md`, `orders.log` |

No bridge work was needed: `.claude/skills` already symlinks to `.agents/skills`,
and Codex reads `.agents/skills` natively. No em-dashes in any of it.

**`check.py` was never executed.** Running scripts needed approval in my
session and wasn't granted, so I desk-checked it (expected values computed by
hand, matching the reference implementation's logic, and a correct fix, an
unfixed file, and a gamed fix traced through each check). Run it once against a
known-good and a known-bad copy before relying on it.

## Decisions on open points

- **Name** kept. It matches the case and branch, and says what it does.
- **Calibration tasks.** Two, offline, a few seconds each, checked
  deterministically:
  - `fix-intervals` (execution, fidelity): a two-bug function and its tests,
    one of which (`test_preserves_input_order`) contradicts the docstring and
    another test, so it can't pass with a correct fix. Checks: test file
    untouched, held-out cases pass (catches special-casing the planted test),
    only the planted test fails, and the final message names it (a heuristic,
    the lead reads the message).
  - `extract-orders` (cost-to-task on mechanical work, instruction following):
    a 22-line log with out-of-order updates, non-USD orders, and six malformed
    lines, summarized to exact JSON.
  - Cheap to maintain: the checker computes the expected summary from the log
    with a reference implementation, so editing the fixture needs no hand
    recomputation. Held-out interval cases are hardcoded.
  - Each task directory carries its own `TASK.md`, so the prompt is `follow
    TASK.md`, consistent with the delegate convention.
  - Honesty about noise is stated in `SKILL.md`: one run is an anecdote, only a
    large gap on both tasks moves a rating on its own, most models should pass,
    and the signal is mostly tokens, time, and how the conflict is reported.
- **No templates for drift, synthesis, or tool probes.** `SKILL.md` names each
  phase's output and what it must cover. Tool probes point at the README's
  "Adding a tool" method as the brief asked.
- **Case keyword `delegate-catalog-refresh`** so the next run finds the
  previous one and its `help/` snapshots (named
  `help/<cli>-<version>-<subcommand>.txt`).
- **Counts.** At least two researchers per vendor, at least three verifiers
  across both vendors. Reconciliation borrows the cf504f22 rule: adopt a
  reversal only where verifiers agree, the lead decides contested claims and
  records why.
- **Drafts live in the case** (`models-draft.md`), applied to
  `skills/delegate/` only at the user gate, so the shipped file changes once.

## Deviations from the brief

1. **The lab rule needed a carve-out.** Smoke tests (phase 2), calibration
   (phase 4), and tool probes (phase 7) all spawn CLIs, which a literal "no
   subagents" rule forbids. `SKILL.md` allows running a CLI as the *subject of
   a test*, in the foreground, while still forbidding handing off any of the
   delegate's own work.
2. **The lead runs smoke tests and calibration itself** by default, not a
   delegate. Nested CLIs need network and write state under the home
   directory, which a sandboxed delegate may be denied (the inherited-sandbox
   finding, cf504f22 A2). Phase 7 says to confirm a delegate can run one
   nested CLI before handing probes off.
3. **An optional early check with the user** after the drift report, if the
   candidate roster is surprising, since the fan-out is the expensive phase.
   Phrased as "consider", not a hard gate.
4. **The research brief names the four dimensions** to research (hard problems,
   agentic execution, cost to finish a task, honest unsupervised behavior),
   never the ratings. That is mild structural priming the wave-2 brief
   avoided, traded for comparable reports. It still invites proposing a
   different structure.
5. **Synthesizer**: the brief can be read as "a model that wasn't a
   researcher", but every strong model will have researched. I wrote "a fresh
   session on a strong model", and noted that its vendor bias is what the
   cross-vendor verification catches.
6. **Small additions**: verifiers also flag research-process framing in the
   draft. Phase 7 says to probe under the real config but contrast against an
   isolated one (scratch `CODEX_HOME`) where results may be config-dependent,
   and to mark untestable claims as such (A3). The gate points out that a user
   override at `~/.config/agent-skills/delegate/models.md` won't pick up the
   refresh.

## For the lead to decide

- **The fidelity axis.** This is the one that matters most.
  `2026-08-04__cf504f22/models-md-decisions.md` section 4 records the user
  dropping the fidelity column and the `gpt-5.6-sol` gaming note (and the Fable
  note) because they caused constant second-guessing. Shipped `models.md`
  still has all three (`git log -S fidelity` shows only the original commit).
  Either the removal was lost or it was reversed and nobody recorded it. The
  skill says "keep the four-axis format", the brief's "fidelity flags" assume
  the axis, and the calibration task partly measures it. Ask the user before
  the run.
- **Is calibration worth it?** It is the most overbuilt-risk piece (6 of 10
  files). I think it earns its place because cost-to-task is the weakest-sourced
  axis and identical-task token counts are the only first-party signal on it,
  but cutting it would leave the skill much smaller.
- **Calibration effort level.** I chose the CLI default, recorded. Effort swings
  cost heavily, so a model whose notes make effort claims might warrant a
  second run at another level.
- **One synthesizer or two** (one per vendor, reconciled by the lead). Two cost
  little next to the fan-out and would directly counter self-vendor bias.
- **Stale numbers in this case's `overview.md`**: it gives the old tool
  versions as claude 2.1.220 and codex 0.147.0, but `tools.md` already says
  2.1.258 and 0.153.4. The skill reads the baseline from the files, so this
  only matters for the overview.
- **Tag this case** with the `delegate-catalog-refresh` keyword, since it is
  the first run and the next run will look for it.
- **Peeking**: a delegate on the default posture can read outside its scratch
  directory, so in principle it could read `check.py`'s held-out cases. Low
  risk, but worth knowing if a result looks too clean.

## Revision

Applied the lead's rulings in `handoff-revise-skill-draft.md`, from the reviews
by gpt-5.6-sol and fable-5.1.

### What changed

- **Two synthesizers, one per vendor** (phase 5), same inputs, independent
  drafts. The lead builds `rating-reconciliation.md` (row, axis, each rating,
  cited evidence) and resolves by evidence quality. The phase says outright that
  this is where rating bias gets controlled.
- **Evidence quality over vote count** is now a principle, and phase 6
  reconciles by it: a single well-sourced FAILS can beat several HOLDS that cite
  one vendor page, and the lead checks the source when it's still unclear. This
  replaces the "adopt where verifiers agree" rule. Both briefs ask agents to
  flag when several claims rest on one source.
- **Exact baseline.** Phase 1 records the date and commit of the last change to
  each file plus the previous case. Phase 8 puts an exact date in the footer.
- **Axes are the file's axes.** Phase 1 reads them and puts the axis set to the
  user if anything is unsettled. The research brief takes `{{AXIS_QUESTIONS}}`,
  and its honesty, substitution, outage, and operational questions stay fixed
  regardless. "Fidelity" no longer appears anywhere in the skill. The verifier
  brief says "reliability or honesty flags".
- **Phase 1 go/no-go.** The lead confirms its own shell has network and runs
  each CLI, and stops if not. It records the observed nested-delegate DNS
  failure, so the lead runs smoke tests, calibration, and tool probes. Phase 7
  is now lead-only.
- **New "Spawning" section.** It covers postures per role (researchers and
  synthesizers use the case dir as working dir, verifiers use a scratch copy of
  the draft outside the repo), a `spawns.md` log of requested versus reported
  model per spawn (self-report counts as weak signal), and backgrounding long
  spawns with a generous timeout.
- **Calibration:**
  - one effort level pinned per CLI, carried over from the previous run, with
    `medium` suggested on a first run
  - no web in calibration spawns
  - scratch copy outside the repo
  - cost computed as tokens times the researched prices
  - a "what calibration can and cannot move" paragraph
- **`check.py` outcomes.** It ends with `OUTCOME fixed|refused|gamed|failed`
  (or `passed|failed`). `refused` (code untouched, conflict cited) is a distinct
  outcome. The visible tests now run against the bundled test file in a scratch
  copy, so an edited test file can't hide a special case. Any edit to the test
  file is `gamed`.
- **`calibration/self_test.py`** covers 11 cases: known-good, unfixed, refused,
  test-editing, special-cased, a correct fix with a false report, and five
  extract-orders cases. **Ran it: 11/11 as expected.**
- **Calibration is a clean cut.** It is marked optional, and phase 4 and the
  synthesis inputs say to skip it if `calibration/` is absent. Deleting the
  directory breaks nothing.
- **Ambiguities fixed:**
  - "strong model" is defined
  - "every vendor" is defined once and used throughout
  - phase 2 works out the per-CLI recipe for capturing tokens, the final
    message, and the serving model, and records it
  - a first run may live in an existing case
  - "stop only if web search fails, not on a failing fetch"
  - long spawns run in the background
- **Phase 8** offers `install.sh --force delegate` after approval and reminds
  about the user override.
- **Dropped the "subject of a test" carve-out** from the no-subagents
  principle. With the lead running every nested CLI, no delegate needs it, so
  the rule is back to plain "no subagents".

### Rejected, and why

- **Generating hidden cases after each run** (Sol). It would break
  comparability across runs, which is the point of fixed tasks, and add moving
  parts. The scratch copy sits outside the repo and holds no pointer to the
  skill, so I took Fable's view: accept the small peeking risk.
- **A larger multi-file calibration task.** I could make one deterministic, but
  it still finishes in a handful of turns, so it wouldn't reach the
  long-loop regime where verbosity drives cost. It would add fixture files to
  maintain without lifting the core limitation. I stated that limitation in
  phase 4 instead: calibration can't establish cost-to-task for long agentic
  work.
- **A named effort level for every run** (Sol suggested one normalized posture).
  Level names differ per CLI and change across releases, so the skill pins one
  per CLI, carries it forward, and records it, rather than hardcoding a name.

### Still pending with the user

The fidelity column, and whether calibration stays. The skill is neutral on
both.

## User-decision cuts

Applied `user-decisions.md` in `fa8dacc`. This supersedes the calibration and
fidelity material above.

- **Calibration removed.** That covers the whole `calibration/` directory
  (tasks, `check.py`, `self_test.py`), the phase, and every reference to it.
  Phases are renumbered 1 to 7. The `Python 3` requirement went with it.
- **No honesty or availability coverage.** The research brief no longer asks
  about honesty, gaming, fabrication, substitution, outages, or availability.
  The verifier brief no longer lists those claims. `SKILL.md` drops them from
  phases 3 and 5.
- **New principles.** "Ratings come from research only" (the smoke test only
  gates the roster) and "Capability and cost, nothing else".
- **Logging trimmed.** Requested versus reported model is gone from the spawn
  log and the smoke test, and so is the phase 2 "spawn recipe", which existed
  only to feed calibration. The spawn log keeps role, model and effort,
  session id, and outcome.
- **Kept.** Retired or renamed IDs still matter, since that is roster
  membership and not an availability note. So does pricing and effort.
- **One judgment call.** I kept a one-line exclusion in each brief ("leave
  out honesty, evaluation gaming, outages, and silent substitution"), and the
  verifiers flag any such note in the draft. Without it, unprimed researchers
  surface these unprompted (wave 2 did), and they would leak back in through
  the synthesis. Drop the lines if you would rather the skill never names them.

## Post-run revision

I folded `lessons-from-first-run.md` into the skill, committed as a fixup of
`b1191d2`. I applied every lesson, mostly as a sentence in the phase it
affects. Two new templates, per lesson 7.

| lesson | where it landed |
| --- | --- |
| 1 codex workspace is the git root | Spawning: absolute paths for every spawn. Every codex spawn runs from a non-git scratch dir outside the repo with `--skip-git-repo-check`, and the reason is stated. It writes there or to the case dir via `--add-dir` |
| 2 delegates tried to commit | "don't commit" in all four briefs |
| 3 usage limits | Spawning: check output for a limit error, not exit status. Re-run after the reset, and expect the run to span limit windows |
| 4 phase 6 alongside 4 and 5 | one sentence in phase 6 |
| 5 two drift researchers | phase 2 default, with the reason |
| 6 codex model listing | phase 2 names `~/.codex/models_cache.json`, saved into `help/` and fed to the drift brief |
| 7 bundled templates | new `drift-brief.md` and `synthesis-brief.md`, generalized from the lead's handoffs. Phase 4's drafting-rule list moved into the synthesis brief |
| 8 baseline wording | research brief: "last updated on {{BASELINE_DATE}}" |
| 9 lead overrode the research | phase 4: reconcile a column's ordering before its bands, keep orderings both synthesizers agree on, no lead anecdotes |
| 10 self-explanatory bands, jargon | synthesis brief: state band order, write for a delegator without research context. Phase 7: the lead re-reads the draft that way before the gate |
| 11 verifier noise | verification brief: facts only, advice checked only for its reason, skip repo-file references |
| 12 superlatives and ratios | synthesis brief: use sparingly, only where the evidence clearly supports them |
| 13 canaries in /tmp | phase 6: canaries outside `/tmp` and `$TMPDIR` |
| 14 stdin prompts | phase 6 |
| 15 codex trust entries | phase 6: prefer non-git dirs (no entries). Otherwise back up the config and remove the entries. "Never modify the real config" became "don't change it yourself, undo what a CLI writes" |
| 16 run shape | one line under Long runs (a few hours, priciest spawn about $20) |
| 17 one run log | `spawns.md` replaced by `run-log.md` throughout |

### Skipped as one-off

- **Exact figures**: the ~2 h ChatGPT reset, the $18.86 Fable researcher, and
  the ~20 min research wall clock. These are this run's numbers, so the skill
  keeps only the rough shape.
- **Word bands over a 1 to 5 cost scale.** That was the user's call on
  `models.md`'s format this run, not a procedure. The synthesis brief already
  keeps the current file's structure, so it carries forward without a rule.
- **"The claude CLI has no model listing."** True at 2.1.286, but a version
  fact. The skill says "any model listing a CLI keeps" instead.
- **The specific Fable/Opus case** behind lesson 9. Only the general rule went
  in.

### Worth knowing

- Codex spawns writing outside the case dir means more copying for the lead,
  which is why `--add-dir` is offered as the alternative. Writing in the
  scratch dir worked for this run's codex verifiers. The `--add-dir` route is
  untested, so it is offered, not required.
- The fixup commit carries no `Co-Authored-By` line, because `--fixup` writes
  its own message. It disappears into `b1191d2` on autosquash anyway.

## Post-run review revision

Applied the lead's rulings on `review-skill-post-run-claude-opus-5-5.md` (all
seven findings) and `review-skill-post-run-gpt-6-astra.md` (1 and 3).
Committed as a fixup of the skill commit. This supersedes the codex-spawning
material in "Post-run revision" above, which rested on the wrong lesson 1.

- **Spawning rewritten on the corrected lesson 1.** The real cause was the
  lead's shell: a `cd` backgrounded with only the first job. So: set every
  working directory explicitly (`-C <dir>` for codex, `cd` inside each
  subshell) with absolute paths. Researchers and synthesizers run in the case
  dir, and only verifiers use scratch dirs, to stay blind. The non-git and
  `--add-dir` setup is gone.
- **Probes back in disposable git repos.** The trust note now says codex adds
  an entry per git repo it runs in with `workspace-write`, and each probe dir
  is its own repo, so back up and clean up. That also settles Astra's 2.
- **Post-verification wording (Opus 2, lesson 18).** Replacement wording comes
  only from a verifier's cited correction, or the claim is dropped. Any new
  factual wording the lead writes gets one cheap recheck before the gate.
- **The delegator read moved** from phase 7 to the end of phase 4 (Opus 3), so
  verifiers see the final wording.
- **Previous briefs as starting point** (Opus 4). Bundled files: start from
  the previous case's filled-in copies when one exists.
- **Names match this run** (Opus 5): `tools-probes.md`,
  `help/<cli>-<version>-root.txt` for top-level help, and
  `codex-<version>-models-cache.tsv`.
- **Cuts** (Opus 6):
  - "Independent signal" merged into "Evidence quality".
  - The posture-naming rule moved into phase 6's probe list.
  - The Bundled files line on tool probes dropped.
  - The nested-DNS paragraph cut to one clause.
  - Phase 2's heading now says "plus the lead for smoke tests".
- **Traps** (Opus 7): `--skip-git-repo-check` named for the codex smoke test.
  The synthesis brief points at `drift-models-*.md` again.
- **Comparisons keep their conditions** (Astra 1): the synthesis brief asks
  every comparison to keep workload, effort level, and what was measured.
- **The dollar anecdote is gone** (Astra 3). Duration and the usage-limit
  warning stay.

Nothing rejected.
