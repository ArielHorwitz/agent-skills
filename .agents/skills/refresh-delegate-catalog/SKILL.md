---
name: refresh-delegate-catalog
description: >
  Refresh the delegate skill's bundled models.md and tools.md: inventory what
  drifted since the last refresh, re-research and re-rate the model roster with
  independent cross-vendor agents, re-verify each CLI, and put the diff to the
  user for approval. Repo maintainer use.
argument-hint: "Optional focus or constraints for this run"
disable-model-invocation: true
compatibility: >
  Requires the delegate and casebook skills, the CLIs listed in
  skills/delegate/tools.md (installed and authenticated).
---

# Refresh the delegate catalog

`skills/delegate/models.md` (which models to pick) and `skills/delegate/tools.md`
(how to invoke each CLI) go stale as vendors ship models and CLIs change. Every
delegate spawn reads them, so a refresh is worth real effort. This skill is the
procedure.

Run it as a **lead**: hold the run, delegate the heavy phases through `delegate`,
and keep the light work (orientation, briefs, reconciling, the user gate) for
yourself. Each phase below says what it produces and who should do it. How is
left to your judgment unless a principle says otherwise.

Each run is recorded in a **casebook case** holding all its artifacts: drift
report, `--help` snapshots, run log, research reports, syntheses, drafts,
verification reports, probe results. Normally a run opens its own case. A first
run may live in an existing case that is already about the refresh. Give the
case the keyword `delegate-catalog-refresh` so the next run can find it.

"Every vendor" below means every vendor with a CLI in `tools.md`.

## Principles

- **Ratings come from research only.** The skill never tests model capability
  itself. The phase 2 smoke test only confirms that a model ID runs on the
  user's account, and doesn't feed the ratings.
- **Capability and cost, nothing else.** The catalog carries no notes on
  honesty, evaluation gaming, outages, or silent substitution, and the run
  neither researches nor rates them.
- **Independence and cross-vendor diversity.** Research, synthesis, and
  verification run on models from every vendor, each blind to the others. A
  model judging itself or its own vendor is a known bias, so every rating
  traces back to which model said what.
- **Live web, always.** New models postdate most researchers' training data.
  Anything not sourced live is suspect. Every researcher and verifier gets web
  research. One whose web search fails says so and stops (a failing page fetch
  alone is not a reason to stop).
- **Evidence quality over vote count.** Weigh independent sources (third-party
  benchmarks, evaluations, community experience) at least as heavily as a
  vendor's own numbers, and say when independent signal is missing. When reports
  or verifiers disagree, weigh source independence, recency, and authority.
  Several agents citing the same page are one source.
- **Cost-to-task over sticker price.** Token efficiency varies a lot across
  models, so price per token is not cost. What matters is the realistic cost to
  get a representative task done.
- **Unprimed research.** Researchers get the model IDs to cover and the baseline
  date, never the current ratings or notes, so they don't anchor on them.
- **Re-rate everything.** Ratings are relative. A new model moves every row, so
  revisit them all rather than appending.
- **Guidance over enumeration for `tools.md`.** It describes knobs by intent and
  tells the reader to confirm what a run reports. Change an entry only where
  observed behavior changed, and bump the observed versions.
- **Shipped files carry no research process.** No source names, no "this used
  to say X", no mention of the run. The case holds the trail.
- **Delegates don't hand off their own work.** No subagents, no background
  agents. A headless session ends when it stops and anything it handed off dies
  with it.

## Bundled files

Copy a template into the run's case, fill in the `{{placeholders}}`, and point
the delegate at the copy. If a previous run's case exists, start from its
filled-in copies instead, so the wording carries over between runs. Adapt a copy
freely, but keep the bundled originals generic and fix them here when a run
shows a gap.

- `drift-brief.md`: the drift researcher handoff (phase 2).
- `research-brief.md`: the researcher handoff (phase 3).
- `synthesis-brief.md`: the synthesizer handoff (phase 4).
- `verification-brief.md`: the claim-verifier handoff (phase 5).

## Spawning

- **Working directories.** Give every spawn absolute paths for its inputs and
  output, and set its working directory explicitly rather than relying on your
  shell's: `-C <dir>` for codex, and a `cd` inside each backgrounded subshell
  (`cd X && a & b &` puts the `cd` in the first job only, which is how the first
  run's stray report landed at the worktree root). Researchers and synthesizers
  run in the case directory. Verifiers run from a scratch directory outside the
  repo holding a copy of the draft, so they stay blind, and you copy their
  reports into the case.
- **Run log.** Keep one `run-log.md` in the case: phase notes, and per spawn the
  role, model and effort, session id, cost if reported, and outcome, plus
  lessons as they come up.
- **Long runs.** Research, synthesis, and verification can run long. Run them
  in the background with a generous timeout and keep working. The first run
  took a few hours, mostly research and a wait for a usage limit to reset.
- **Usage limits.** A run can exhaust either vendor's subscription limit
  mid-phase. Check every spawn's output for a usage-limit error rather than
  trusting its exit status, re-run what hit one after the reset, and expect the
  run to span limit windows.

## Phases

### 1. Setup and go/no-go (lead)

Work in a worktree and open (or join) the case.

- **Go/no-go.** Confirm your own shell has network and can run each CLI with a
  trivial prompt. Every delegate inherits your sandbox, so if you can't, stop
  and have the user restart the lead session where it can. A nested delegate's
  shell may lack network even when yours has it, so you run the smoke tests and
  tool probes yourself.
- **Baseline.** Record the exact date and commit of the last change to each of
  `models.md` and `tools.md` (`git log -1` on each), their footers, and the
  previous refresh case if any (`casebook list`, by keyword). "Since the
  baseline" means since that date.
- **Axes.** Read the axes the current `models.md` rates on. If anything about
  them is unsettled (a column the case history says was dropped, a column the
  user has doubts about), put the axis set to the user now. Later phases use
  "the file's axes" as settled here.

### 2. Drift inventory (two delegates with web, one per vendor, plus the lead for smoke tests)

Produces `drift-models-<model>.md` per drift researcher, your merged
`drift-report.md`, and `help/` in the case.

- **CLIs.** Installed versions, and `--help` output saved as
  `help/<cli>-<version>-<subcommand>.txt`, with `root` for the top-level help
  (`claude-<version>-root.txt`, `codex-<version>-root.txt`,
  `codex-<version>-exec.txt`, and the same for any other tool in `tools.md`).
  Diff against the previous run's snapshots, or, on a first run, against what
  `tools.md` documents.
- **Models.** What each vendor released, renamed, repriced, or retired since the
  baseline, with current per-token prices and their dates. First save any model
  listing a CLI keeps into `help/` (codex keeps one at
  `~/.codex/models_cache.json`, saved as `codex-<version>-models-cache.tsv`; it
  can show a new generation before any research does). Then fill in
  `drift-brief.md` with the baseline roster and those listings, and give it to
  two researchers from different vendors. Two are cheap next to the fan-out and
  make a missed release less likely.
- **Smoke test every candidate ID** through its CLI with a trivial prompt
  ("Reply with OK") from a scratch directory (codex needs
  `--skip-git-repo-check` there). A model the user's account can't run doesn't
  belong in the roster. This is a gate on the roster, not a capability test.

The report gives a **candidate roster** (add, keep, drop, each with a reason and
its smoke result) and the tool changes. Drop here only what is retired or can't
run. Whether a model is dominated is for the synthesis. From here on, spawn new
models by the IDs found here, not from the stale roster.

The fan-out is the expensive part of the run. If the candidate roster is
surprising (a flagship dropped, a family you didn't expect), consider checking
it with the user first.

### 3. Research fan-out (one delegate per strong model)

Produces `research-<model>.md` per researcher.

A **strong model** here is one its vendor positions as flagship or
near-flagship, plus any new model that might be one. Cheap, mechanical-tier
models are researched (every candidate is covered) but don't research.

One independent researcher per strong model, at least two per vendor, including
the new models. Fill in `research-brief.md`: the candidate roster's IDs, the
vendors, the exact baseline date, one research question per axis of the file
(as settled in phase 1), and the output path. The pricing and effort question
stays in the brief whether or not it is a column. Grant web research.
Run them in parallel. Effort is your call. Research rewards depth.

### 4. Synthesis and draft (two delegates, one per vendor)

Produces `synthesis-<model>.md` and `models-draft-<model>.md` per synthesizer,
then your `rating-reconciliation.md` and `models-draft.md`.

Two synthesizers, each a fresh session on a strong model from a different
vendor, get the same inputs independently: every research report, the drift
reports, any user decisions, and only now the current `models.md`, as the thing
being replaced. Fill in `synthesis-brief.md`, which carries the drafting rules
(axes, re-rating, evidence quality, shipped-file voice, exact-date footer).

Then reconcile. Lay the two drafts' ratings side by side in a disagreement table
(row, axis, each synthesizer's rating, the evidence each cites). Reconcile each
axis as a whole column, not cell by cell: settle the ordering of the rows first,
then the bands. Never break an ordering both synthesizers agree on unless strong
evidence demands it. Resolve by evidence quality, not by which vendor's model
said it, and record why. Don't let your own anecdotes (such as this run's spend)
stand in for research. This is where rating bias gets controlled, since
verifiers don't judge ratings. Merge into `models-draft.md`.

Last, read the merged draft as a delegator would, with no research context, and
fix anything that needs the research to understand: unexplained shorthand, or a
band whose order the file doesn't state. Verifiers check truth, not clarity, so
this happens before they see the draft.

### 5. Claim verification (several cross-vendor delegates)

Produces `verification-<model>.md` per verifier, and your
`verification-summary.md`.

At least three verifiers, from every vendor, each blind to the others, check
every factual claim in `models-draft.md` (model IDs, pricing, effort notes,
positioning, anything else checkable) against live sources. Fill in
`verification-brief.md`.

Then reconcile by evidence quality. A single FAILS backed by a strong
independent source can stand against several HOLDS that cite one vendor page.
Where verifiers conflict and the sources don't settle it, check the source
yourself. Fix or drop what fails, and record each decision and why. Replacement
wording comes only from a verifier's cited correction. Otherwise drop the
claim. Any new factual wording you write yourself, here or later, gets one cheap
recheck (a single verifier against its sources) before the gate.

### 6. Tools re-verification (lead)

Produces `tools-probes.md`.

For each CLI, review the `--help` diff, then re-run the delegate README's
"Adding a tool" checks at the new version: no hang, the default posture edits,
the restrictive baseline holds, web research works, resume works. You run the
probes yourself (see phase 1). This phase doesn't depend on phases 4 and 5 and
can run alongside them. For every probe:

- Run it in a disposable git repo outside this repo, with a cheap model. Codex
  adds a trust entry to `~/.codex/config.toml` for each git repo it runs in with
  `workspace-write`, and each probe dir is its own repo, so back up the config
  first and remove those entries afterward.
- Pass the prompt on stdin. Claude's variadic flags (`--add-dir`,
  `--allowedTools`) swallow a positional prompt.
- Don't name a permission posture in the prompt (see the README). Drive it with
  a natural task.
- Use explicit canary paths to show what a posture let it write, and check them
  on disk afterward. Put them outside the probe's working directory and outside
  `/tmp` and `$TMPDIR`, which codex `workspace-write` grants.
- Run it under the user's real configuration (that is what spawns see), record
  which config files were in effect, and contrast it against an isolated
  configuration (e.g. a scratch `CODEX_HOME`, or a scratch `HOME` with only the
  credentials linked in) to tell flag effects from ambient-config effects.
  Don't change the real configuration yourself, and undo what a CLI writes to
  it.
- Mark what can't be tested cleanly as untestable rather than forcing a result.

Update `tools.md` only where behavior changed, and bump the observed versions.

### 7. User review gate (lead)

Apply the verified draft to `skills/delegate/models.md` and the tools changes to
`tools.md`. The models footer carries the exact date of this refresh. Present
the diff of both files with a short summary of every rating change and why.
Nothing is final until the user approves.

Once approved, commit, and offer to reinstall the skill
(`install.sh --force delegate`) so live spawns read the new files. If the user
keeps an override at `~/.config/agent-skills/delegate/models.md`, remind them it
won't pick up the refresh. Then record in the run log what this run would do
differently, fold any lasting lesson back into this skill, and close the case.
