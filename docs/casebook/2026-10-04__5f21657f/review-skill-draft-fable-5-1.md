Review of the `refresh-delegate-catalog` draft. Read-only, nothing in the repo was touched. I did run `check.py` from a scratch copy in `/tmp` since the author never executed it: it correctly passes a true fix, fails the unfixed file, catches a special-cased fix, and its reference summary for `orders.log` matches my hand count. The desk-check holds.

## Findings, most important first

1. **The lead's own shell may have no network, and everything inherits it.** This session's shell cannot resolve DNS right now, exactly the inherited-sandbox finding from the permission-posture case (A2). Phases 2, 4, and 7 default to the lead running nested CLIs, and every delegate inherits the lead's sandbox, so no delegate can be the fallback. Failure: the lead runs smoke tests, every model fails, and the drift report drops the whole roster. Fix: phase 1 gets a go/no-go check. Spawn one trivial delegate per CLI with web research and confirm it answers. If it cannot, restart the lead session outside the sandbox before doing anything else.

2. **The fidelity axis is hardcoded in four places while its status is unknown.** The permission-posture case records the user dropping the column and the Sol and Fable notes. `git log -S fidelity` shows only the original commit, so the removal never reached the file. The skill bakes it into phase 5 ("four-axis format"), the research brief's fourth dimension, the verification brief's "fidelity flags", and the planted-conflict calibration check. Fix: replace "four-axis" with "the current file's axes", and make phase 1 put this discrepancy to the user before the fan-out. My view: keep the research question, because substitution and outage facts are operationally useful whatever the table does, and let the user decide the column.

3. **Rating bias has no control.** Verifiers are told ratings are judgments and not to verdict them. The synthesizer is one model from one vendor and writes every rating. So the one thing the file exists for is the one thing nothing cross-checks. Fix: two synthesizers, one per vendor, same inputs, with the lead reconciling from a disagreement table. This answers the author's open point: two.

4. **Calibration measures overhead, not cost-to-task, and its effort setting drifts.** Both tasks finish in seconds, so tokens are dominated by system prompt, tool schemas, and file reads, not the loop verbosity that produced the Sonnet 5 finding. "CLI default" effort also breaks comparability: claude defaults to `high`, codex to something else, and both change across versions. The default posture also grants web, so one model's stray search skews its count. Fix: pin a named effort per CLI and record it. Drop web from calibration spawns. Either state plainly that calibration can flag execution and honesty but never move cost-to-task, or add one larger multi-file task now, before the first run freezes the set. Also record "refused to fix because the tests contradict" as a distinct outcome, since the checker scores it as a failure and it is arguably the faithful answer. Compute cost from tokens times the researched price list, since codex reports none and claude's number is API-rate regardless of account.

5. **Researchers and verifiers can edit the repo.** Under the default posture a delegate edits anything under its working directory. Spawned from the worktree root, a verifier can edit the draft it is told not to edit, and a researcher can touch `skills/delegate/`. Fix: spawn researchers with the case directory as working directory, and verifiers from a scratch directory holding a copy of the draft.

6. **Phase 8 never syncs the installed copy.** `install.sh` copies skills into the user's agents directory, and live spawns read that copy. Failure: user approves, lead commits, and the next delegate spawn still reads the August file. Fix: end phase 8 with the upgrade reinstall, named explicitly.

7. **Self-reported model ID is the weakest signal for substitution.** A substituted model reports the ID it believes it is. Fix: the lead records the requested ID and what the structured output reports per spawn, and treats the self-report as a third signal.

## Ambiguities a fresh session would trip on

- **"Strong model"** is undefined. Say which roster rows qualify.
- **"Verifiers agree"** with three verifiers is unclear. Suggest two matching FAILS adopt a correction and a lone FAILS goes to the lead to check directly.
- **"Both vendors"** in phases 6 and 7 contradicts "every vendor in tools.md". Pick one.
- **Token and final-message extraction** differs per CLI and the skill never says so. Tell the lead to work the recipe out during the phase 2 smoke tests and record it in the case.
- **"Every run is its own case"** collides with this run living in the design case. Allow the first run to use it.
- **Phase 7 "delegate or lead"**: default to the lead. A probe delegate's handoff must name postures, which its own classifier reads, and nested state writes under the default posture are unverified.
- **Web research wording**: a Claude researcher can have search working while fetch fails. Say "web search" and "stop only if search fails".
- **Budget**: researchers with web can run long. Say to background them with a generous cap.

## The author's remaining open points

Effort level: pin, per finding 4. Stale overview numbers: fix them, trivial. Case keyword: already present in `case.toml`, resolved. Peeking at the held-out cases: accept the risk, the scratch copy carries no pointer to the repo. One addition for the research brief: ask researchers to say when several claims rest on one source, since wave 2 found most cost numbers trace to Artificial Analysis.
