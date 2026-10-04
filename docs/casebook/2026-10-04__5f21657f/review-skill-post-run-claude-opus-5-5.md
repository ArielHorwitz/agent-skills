I reviewed the skill against the run as asked, read-only. Most lessons landed in sensible places. One is built on a wrong diagnosis, and the post-verification steps have a gap.

## Findings, most important first

**1. Lesson 1 got the cause wrong, and the Spawning rules are built on it.**
- **Evidence:** codex records each session's real working directory. The drift researcher (`01a1064c…`) was started at the worktree root, not the case dir. The two codex researchers (`01a10652…`) were started in the case dir, and their reports landed where they should. So codex does not take the git root as its workspace. The lead's shell was simply in the wrong directory.
- **Failure:** `SKILL.md:94-100` presents the wrong cause as fact. It also replaces a setup that worked in this run (in-repo, absolute paths) with one used nowhere in this run for a researcher or synthesizer: a non-git scratch dir plus `--add-dir`. A future lead will trust the stated cause and misread the next stray file.
- **Fix:** state the real cause. Pass `-C <dir>` explicitly instead of relying on the shell's directory, and keep absolute paths. Keep scratch dirs for verifiers, which need them to stay blind. Make the non-git setup optional. The trust-entry reason is also overstated: codex appears to add one entry per repo, not one per directory.

**2. Wording written after verification is never checked.**
- **Failure:** the lead rewrote failed claims into new ratios ("about half the cost", "roughly four to ten times", "several times less") and shipped them unchecked. That is the class of claim lesson 12 calls riskiest. Phase 7's readability fixes also come after verification.
- **Fix:** phase 5 should take replacement wording only from a verifier's cited correction, or drop the claim. Any new factual wording the lead writes gets one cheap recheck.

**3. The "read it as a delegator would" step is in the wrong place.**
- **Failure:** "for a point or two" got HOLDS from all four verifiers, because they check truth, not clarity. Phase 7 then says "Apply… First read…", so the order is ambiguous.
- **Fix:** move the read to the end of phase 4, so verifiers see the final wording.

**4. Fresh leads have to reinvent the fill-ins.**
- **Failure:** `{{AXIS_QUESTIONS}}` and the other placeholders get written from scratch, and the run's wording drifts each time.
- **Fix:** phase 1 already finds the previous case. Tell the lead to start from that run's filled-in briefs.

**5. Names that break the next run's diff.**
- Phase 6 says `tools-<cli>.md`, but the run wrote a single `tools-probes.md`.
- The help-snapshot pattern doesn't name the top-level output. The run used `root`.
- **Fix:** match the run's names, so the next run can diff against this one.

**6. What could be cut.**
- Merge "Independent signal over vendor claims" into "Evidence quality over vote count".
- Move the "don't name a permission posture" principle into phase 6, the only place it applies.
- Drop the Bundled files line about tool probes, which repeats phase 6.
- Shrink the nested-DNS paragraph to one sentence.
- Spawning gets much shorter once finding 1 is fixed.
- Reword "plus the lead for spawns" in phase 2's heading to "plus the lead for smoke tests".

**7. Small traps.**
- A codex smoke test from a non-git scratch dir needs `--skip-git-repo-check`, but phase 2 doesn't say so.
- The synthesis brief no longer points at `drift-models-*.md`, which the run's own handoff did.
