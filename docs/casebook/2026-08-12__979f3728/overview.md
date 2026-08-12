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

## Status

- [x] Framing + best practices written into the skill's new **Version control**
      section (`skills/casebook/SKILL.md`).
- [ ] **Git-aware `list` enhancement** — deferred until the framing lands. Idea:
      let `list` discover cases living on other branches/worktrees (e.g. walking
      refs + `git ls-tree`), since filesystem-only `list` is blind to them. Scope
      and design still open.
