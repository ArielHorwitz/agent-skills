# Skill design brief: `refresh-delegate-catalog`

Lead's design decisions for the repo-local skill that refreshes
`skills/delegate/models.md` and `skills/delegate/tools.md`. The author drafts
the skill from this. Anything marked **open** is the author's call, with
reasoning recorded.

## Shape

- **Path:** `.agents/skills/refresh-delegate-catalog/` (repo-local, not shipped
  by `install.sh`). Explicit invocation only: the maintainer runs it on purpose.
  Follow whatever explicit-only convention the repo uses (frontmatter, plus the
  Codex sidecar pattern from the vendor compatibility case, if applicable).
- **Who runs it:** a lead session (typically under the `lead` skill) that
  orchestrates and delegates heavy phases through `delegate`. The skill states
  what each phase produces and who should do it, not a rigid script.
- **Depends on:** `delegate` (all spawns), `casebook` (each run is recorded as
  its own case, holding every artifact: drift report, research reports,
  synthesis, verification, probe results, help snapshots).
- **Files:** `SKILL.md` (the procedure) plus bundled brief templates the lead
  copies into the run's case and fills in (research brief, verification brief,
  at least). Reference the delegate README's "Adding a tool" method for tool
  probes rather than duplicating it. Keep the file count minimal.

## Principles (carry into SKILL.md)

- **Independence and cross-vendor diversity.** Research and verification passes
  run on several models from both vendors, independently, without seeing each
  other. Models judging themselves or their own vendor are a known bias: the
  synthesis tracks which model said what.
- **Live web, always.** Researchers must have web search. New models are newer
  than most researchers' training data, so anything not sourced live is suspect.
- **Independent signal over vendor claims**, and **cost-to-task over sticker
  price** (carry over the wave-2 brief's framing, see the delegate design case
  df73dba7, `handoff-models-research-wave2.md`).
- **Unprimed research.** Researchers get the list of model IDs to cover and the
  baseline date, but *not* the current ratings, so they don't anchor on them.
- **Re-rate everything.** Ratings are relative. Adding models means revisiting
  every row, not appending.
- **Guidance over enumeration for tools.md** (the permission-posture case,
  cf504f22). Change an entry only when observed behavior changed. Bump the
  observed versions.
- **Shipped files carry no research-process framing** (no source names, no "this
  used to say X"). The case holds the trail.
- **Lab rule:** delegates do not spawn subagents of their own.
- **Don't name a permission posture in a probe prompt** (delegate README).

## Phases

1. **Setup.** Worktree, new casebook case for this run.
2. **Drift inventory.** Baseline: current roster and "last updated" footer of
   models.md, observed versions in tools.md, and the previous run's `--help`
   snapshots if any. Discover: installed CLI versions, `--help` output (save
   snapshots into the case so the *next* run can diff), models released or
   retired since the baseline (vendor docs/changelogs, CLI model listings).
   **Smoke-test each candidate model ID through its CLI** with a trivial prompt:
   a model the user's account can't run doesn't belong in the roster. Output:
   drift report with a candidate roster (add/keep/drop) and tool changes.
   Chicken-and-egg note: spawn new models by the IDs discovered here, not from
   the stale roster.
3. **Research fan-out.** One independent researcher per strong model, covering
   both vendors and including the new models. Bundled brief template, adapted
   from the wave-2 brief. Reports land in the case.
4. **Local calibration.** First-party signal for the weakest-sourced axes
   (cost-to-task, execution, fidelity): run a small fixed task set (2-3
   representative, verifiable tasks, bundled with the skill so runs are
   comparable over time) through each roster model's CLI, recording tokens,
   cost if reported, wall-clock, and pass/fail. Informs ratings, doesn't
   override the research. **Open:** the exact tasks and how to keep them cheap
   to maintain. Keep this minimal and honest about noise (one run per model is
   an anecdote).
5. **Synthesis and draft.** A strong agent (not one of the researchers' raw
   outputs) synthesizes convergent findings, disagreements, and per-model
   evidence, then drafts the new models.md. Keep the four-axis format unless the
   research convergently argues for a change.
6. **Claim verification.** Several independent cross-vendor verifiers check
   every factual claim in the draft (fidelity flags, pricing, availability,
   effort notes) against sources and report verdicts. Fix or drop what fails.
7. **Tools re-verification.** Per CLI: review the `--help` diff, re-run the
   delegate README's "Adding a tool" checks (no hang, default posture edits,
   restrictive baseline holds, web research works, resume works) at the new
   version. Update tools.md only where behavior changed. Bump versions.
8. **User review gate.** Present the diff of both files, with a short summary of
   every rating change and why. User approves before the change is final.
   Close the case.

## Open for the author

- Skill name, if a better one exists. Its description.
- Template contents, calibration task design, how much of each phase to specify
  vs. leave to the lead's judgment.
- Anything in this brief that seems wrong or overbuilt. Say so in the report
  rather than silently dropping it.
