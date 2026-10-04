# Lessons from the first run (step 3 input)

Drawn from `run-log.md`, `tools-probes.md`, `rating-reconciliation.md`, and the
user's interventions. Each says what happened and what the skill should do.

## Spawning

1. **~~Codex's workspace is the git root~~ (wrong diagnosis, corrected after
   the post-run review).** The stray drift report came from the lead's own
   shell: `cd X && ( opus ) & ( sol ) &` backgrounds the `cd` together with the
   first job, so the codex job started at the worktree root. Codex researchers
   started properly in the case dir wrote where they should. Skill: pass the
   working dir explicitly (`-C <dir>` for codex, `cd` inside each subshell) and
   use absolute output paths; scratch dirs stay for verifiers, who need them to
   be blind.
2. **Delegates tried to `git commit`** (two codex researchers). Briefs: "don't
   commit".
3. **Usage limits hit both vendors mid-run** (Claude session limit, ChatGPT
   limit with a ~2 h reset), killing three of four verifiers. Skill: check every
   spawn's result for a limit error rather than trusting exit status, re-run
   after the reset, and expect the run to span limit windows.
4. Phase 6 (lead probes) ran in parallel with phases 4 and 5 without
   conflict. Say it can.

## Drift

5. **Two drift researchers, one per vendor**, agreed on everything and cost
   little next to the fan-out. Make that the default.
6. Codex keeps a model listing at `~/.codex/models_cache.json` (it showed the
   GPT-6 generation before any research). Name it as a source.
7. The ad hoc drift and synthesis handoffs the lead wrote should be bundled
   templates (`drift-brief.md`, `synthesis-brief.md`): they carried rules
   (binding user decisions, axes, shipped-file voice, exact-date footer) that a
   future lead would otherwise have to rediscover.
8. Research template: "last brought up to date in {{BASELINE_DATE}}" reads
   badly with an exact date.

## Reconciliation and drafting

9. **The lead overrode the research.** Resolving each disagreeing cell on its
   own, the lead flattened Fable 5.1 and Opus 5.5 to the same cost band although
   both synthesizers had ranked Fable above Opus. The user caught it. Skill:
   reconcile a column's *ordering*, not cells in isolation; never break an
   ordering both synthesizers agree on unless strong evidence demands it; and
   the lead doesn't substitute its own anecdotes (e.g. this run's spend) for
   research.
10. **Bands must be self-explanatory.** State the cost band order in the file.
    The user also caught unexplained jargon ("for a point or two"). Before the
    gate, the lead reads the draft as a delegator would and removes anything
    that needs research context to understand.
11. **Verifier noise.** Codex verifiers marked advice ("avoid `max`
    unattended") and references to repo-local files as UNSUPPORTED. Brief:
    verify factual claims only; for advice, check only that the stated reason
    holds; skip claims about the repo's own files.
12. Verification caught a lot (every speed claim, a dozen overstated
    superlatives and ratios). Superlatives and ratios in notes are the riskiest
    thing a synthesizer writes; the synthesis brief should discourage them.

## Tools probes

13. Canaries must live outside /tmp (codex `workspace-write` includes /tmp and
    `$TMPDIR`).
14. Pass probe prompts on stdin (claude's variadic `--add-dir`/`--allowedTools`
    swallow a positional prompt).
15. **Codex writes `trust_level = "trusted"` entries** into
    `~/.codex/config.toml` for git dirs it runs in with `workspace-write`. Probes
    must clean these up afterward (back up, remove entries for the probe dirs).
    Non-git scratch dirs with `--skip-git-repo-check` added none.

## Run shape, for expectations

16. Wall clock for the whole run was a few hours, dominated by research (~20
    min) and a usage-limit wait. The single most expensive spawn was a Fable 5.1
    researcher (~$19). Worth a line so the next lead budgets for it.
17. The skill's `spawns.md` was folded into a single `run-log.md` (phase notes,
    sessions, costs, lessons together), which was easier to keep current.
    Simplify to one run log.

## Added after the post-run review

18. **Wording written after verification went unchecked.** The lead's
    replacement for a failed Sonnet claim ("close to Opus at high effort")
    contradicted the very verifiers it came from (closeness holds at `max`
    only). Fixed in the shipped file. Skill: replacement wording comes from a
    verifier's cited correction, and any new factual wording gets a recheck.
