# Casebook version control

Make the casebook skill explicit about the fact that a casebook is version
controlled, and establish the best practices that follow. The skill previously
said nothing about VCS, so agents improvised badly — most visibly by treating
"merge back to trunk" as an open work-item that keeps a case perpetually open.

## Anchoring fact

`casebook list` scans the current working tree's `docs/casebook/` with no git
awareness. A case's entire state — files, `overview.md`, `case.toml` status — is
therefore **branch-local**. This single fact drives every point below.

## Decisions

- **Option A (in-repo, branch-local) — committed.** The case lives with the code
  that implements it and merges back with it. The alternative (a casebook stored
  outside VCS, one source of truth across worktrees) was considered and rejected:
  it loses the case-travels-with-the-PR benefit and per-branch snapshots.
- **Default lifecycle: a case is born, worked, and closed in one branch, then
  merged in final form.** Safest — no divergence, and the merge is a pure
  addition.
- **VCS delivery is plumbing, not case work — with two exceptions:** (1) cases
  whose *subject* is the commit/merge/release, and (2) cross-branch cases that
  commit and merge *while still open* as mid-lifecycle syncs. Outside those,
  don't list merge/PR as case open-items.
- **Ordering:** close → commit the closing edit → merge, so the trunk receives an
  already-closed case.
- **Staleness on trunk is normal branching, not a bug;** the real hazard is
  concurrent mutation of one case on two live branches, which conflicts in
  `overview.md` and `case.toml`.

## Git-aware `list` (`casebook list -a`)

Cross-branch discovery/divergence view, added to `casebook.py`. Design settled
after discussion:

- **Opt-in** via `-a` / `--all-branches`. Default `list` is unchanged (current
  working tree, live filesystem). Keeps the common case terse and leaves the
  bare-invocation review untouched.
- **Branches only, committed tips.** Every local branch is read uniformly via
  `git ls-tree` / `git show` — including the current branch. Consequence
  (accepted for simplicity, and stated as a directive in the skill):
  **uncommitted work is invisible to `-a`**; commit to make casework visible
  across branches.
- **Per-branch grouping, no union.** Cases are listed under each branch with
  that branch's own `case.toml`. Divergence (same id, differing status/title
  across branches) is *shown*, never computed — no priority/merge algorithm.
  Cost: cases shared across branches repeat once per branch.
- **Remotes out of scope.** Local branches only.
- **Metadata only.** `-a` reads `case.toml`, never `overview.md`. How the bare
  `casebook` review folds in cross-branch awareness is left to agent judgment,
  not spelled out as rules.

Rejected alternatives: a case-grouped view with computed divergence flags (needs
a which-metadata-wins rule); a hybrid that reads the current worktree live but
others from committed tips (extra concept for little gain once uncommitted work
is conceded); scanning worktrees (`git worktree list`) for uncommitted state.

## Status

- [x] Framing + best practices in the skill's **Version control** section.
- [x] `casebook list -a` implemented in `skills/casebook/casebook.py`.
- [x] Skill updated for `-a`: CLI listing, Version control section, and the
      bare-invocation review (scope made explicit).

The substantive work is complete; this case is ready to close.
