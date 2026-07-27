# Presence handle collisions — overview

Two agents working the same project could `iac join` under the same handle and
silently clobber each other's `who/` entry. This was previously documented as
expected ("rewriting it is fine"). The user asked to reclassify it as unintended
and make a same-handle join fail loudly instead.

## Scope

The concrete worry: two agents on the same project/issue picking the same handle
and overwriting one another's presence, with no signal that it happened.

## Outcome

Implemented and merged to `master`:

- **`join` no longer overwrites.** It errors if the handle already exists,
  suggesting a distinct handle, `iac update`, or `--force`.
- **`join --force`** is a deliberate takeover escape hatch (mirrors `new -f`),
  writing the entry fresh.
- **New `iac update`** overlays only the fields you pass onto your existing
  entry (errors if you never joined), so updating status no longer means
  restating `from`/`for`.
- **Presence files are now JSON**, chosen so the update-merge is a stdlib
  `json.loads` + `dict.update` + `json.dumps` with no third-party dependency.
  `iac who` parses and pretty-prints `key: value` so humans still read it
  cleanly.
- Directive + README updated: announce-once vs. update, and a "run `iac who`
  first" nudge to catch honest collisions before they happen.

See [`design-decisions.md`](./design-decisions.md) for the full reasoning,
including the options weighed and rejected.

## Status

Closed on 2026-07-27. Landed on `master` (`2de98fa` feat, `0c05ec2` docs) via a
fast-forward from the `join-update-split` worktree, which was then removed.
Verified end-to-end in a throwaway `IAC_ROOT`: join creates; duplicate join
errors; `update --status` preserves `from`/`for`; update-before-join errors;
`--force` takes over; `who` pretty-prints. `py_compile` passes.
