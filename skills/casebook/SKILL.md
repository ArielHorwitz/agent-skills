---
name: casebook
description: >
  Work within or consult the project's casebook — a directory of cases, each a
  bounded unit of work (investigation, brainstorm, feature, design, etc.).
argument-hint: "Which case(s) to work on or look into"
compatibility: Requires Python 3.11+ (uses the stdlib tomllib).
disable-model-invocation: true
---

# Casebook

A **casebook** (`docs/casebook/`) is a collection of cases. Each case is a
bounded unit of work (investigation, brainstorm, feature, design, etc.). Each
case is a subdirectory named `YYYY-MM-DD__hex/` holding a `case.toml` (metadata)
and its files. `case.toml` is the tool's fixed schema — `title`, `status`,
`keywords`, `created` — used for listing and discovery. Everything else in
the directory is the case's actual content.

## The CLI

The `casebook` CLI is `casebook.py`, in this skill's own directory (the
directory containing this SKILL.md). Invoke it with `python3`, running from the
**project root** so it can find `docs/casebook/` beneath the current directory:

```
python3 <this-skill-dir>/casebook.py <command> ...
```

Below, `casebook` is shorthand for that invocation.

- `casebook list` — browse cases in the current working tree (run
  `casebook list --help` for status/keyword filtering options). Add `-a` /
  `--all-branches` to instead list committed cases on every local branch,
  grouped by branch — the cross-branch discovery/divergence view (see
  [Version control](#version-control)).
- `casebook new` — create a case
- `casebook init` — create `docs/casebook/` with a stub `agents.md` (run once
  per project)

## Plain invocation (no arguments)

When the `casebook` skill is invoked with no arguments, produce a succinct
review of the casebook rather than opening any case — a status dashboard, not
a deep-dive.

- Run `casebook list --all-branches` (the full flag, for clarity) to survey
  every case's `title`, `status`, and `keywords` across **all local branches**,
  not just the current tree — a plain review is meant to cover the whole project,
  wherever cases live. The output is grouped by branch and cases shared across
  branches repeat; treat each case once. If the same case shows a different
  `status` across branches, that divergence is itself an open thread worth a
  mention. If there are no cases, say so and stop.
- Classify each case as **relevant** (status other than `closed`-like, or among
  the most recently created/closed) or **routine** (older, `closed`-like, no
  open threads).
- Set a total length budget for the whole review — think a handful of
  sentences altogether, not a paragraph per case — and split it roughly 3:1
  between relevant and routine cases. With only one or two cases, this budget
  is moot — just give each its natural due.
- For **relevant** cases: read `overview.md` and spend one to two sentences on
  current state and any open thread. A case living only on another branch has
  its `overview.md` there, not on disk here — read it with
  `git show <branch>:<path>`, or lean on the metadata if that is enough.
- For **routine** cases: use `case.toml` metadata only (title/keywords) — do
  not open `overview.md` or other files. One short clause each, or fewer if
  the budget is tight.
- If the budget doesn't stretch to a clause per routine case, group them (e.g.
  "plus 5 older closed cases on X/Y") rather than shrinking the relevant
  cases' detail.
- Close by noting that naming any case gets a deeper look, and that plain
  `casebook list` narrows the view to the current branch's working tree.

## Identifying cases

The user may refer to a case explicitly (a full id or hex-prefix) or vaguely
(e.g. "the hardening case"). You can use `casebook list` to discover which case
or cases they mean, matching on id, title, and keywords.

## Working within a case

When working on a case, first orient yourself: read `overview.md` (if present)
and any other files relevant to the task to understand where the case stands
before acting. Then follow these conventions.

- Work within existing cases. New cases are normally created by the user via
  `casebook new` — don't create cases unprompted.
- **`case.toml` is the tool's interface, not the case's content.** Keep its
  fields current as the work evolves (edit the file directly), but record the
  actual analysis, decisions, and reports in separate files.
- **`title`** is the primary way cases are discovered — make it capture the full
  scope so anyone can find the case by title alone. New cases default to
  "Unnamed case"; rename early and refine as the scope becomes clearer.
- **`status`** is usually `open` or `closed`, though other values (e.g. `blocked`,
  `paused`) are also acceptable. Keep **`keywords`** updated to help future
  sessions find the case.
- The case's files (beyond `case.toml`) hold its content — analysis, reports,
  decisions, designs, transcripts, etc. Code belongs in the source tree, not the
  case directory.
- Use **highly descriptive filenames** so a file's purpose is clear from its
  name alone — prefer `websocket-reconnection-backoff-strategy.md` over
  `notes.md` or `report.md`.
- **`overview.md`** is a living summary of the case — keep it updated as the case
  evolves so it stays useful to future sessions.

## Version control

The casebook lives in the repo, so a case is a **branch-local mutable
document**. `casebook list` sees only the current working tree, so a case you
cannot find may live on another branch rather than not exist —
`casebook list --all-branches` lists committed cases on every local branch
(grouped by branch) to find it and to spot divergence. That cross-branch view reads
**committed tips only**, so uncommitted work is invisible to it; commit a case,
or a status change, to make it visible across branches.

**A case usually lives in one branch** — created in a worktree, worked, closed
there, then merged to the trunk in final form. Such a case has no divergence
risk and merges as a pure addition. Close it (finish the work, update files, set
`status = "closed"`), **commit the closing edit, then merge**, so the trunk
receives an already-closed case; merging first lands it open until a later commit
closes it.

**VCS delivery is plumbing, not case work** — for the single-branch case,
committing and merging carry the finished case but are not tasks within it, so
don't list "merge back", "open a PR", and the like as open items (they define the
case's completion to include an act that happens after it is done). Two
exceptions, where commit/merge *is* case activity: a case whose **subject** is
the commit/branch/merge/release, and a **multi-branch case**, which may commit
and merge while still open — those are mid-lifecycle syncs, so merge back
promptly to keep the trunk's copy fresh.

**Staleness vs. divergence.** Advancing an open case on a branch leaves the
trunk's copy stale — ordinary branching, fixed by merging back. The real hazard
is **concurrent mutation**: two live branches advancing one case conflict in
`overview.md` and `case.toml` (the shared single-points; per-topic files rarely
collide). Keep a case's active work on **one branch at a time**; if parallel work
is unavoidable, confine edits to disjoint per-topic files.

## Consulting past cases

The casebook includes past cases that may provide historical context for design
decisions, prior investigations, or previously considered approaches. Use
`casebook list` to browse, then read a case's files for reference — you can
consult a case without taking over its work.
