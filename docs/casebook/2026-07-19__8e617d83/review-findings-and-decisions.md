# IAC review — findings, decisions, and reasoning

Record of the review of `iac` and `README.md`, the fixes applied, and the
reasoning behind each decision (including options considered and rejected).

Commits: `bb4eb81` (gitignore) and `ad97afe` (onboarding fix + restructure).

---

## Finding #1 — broken onboarding command (fixed)

**Problem.** The single most-copied command in the project was wrong. Both the
script docstring and `README.md` told a new agent to run:

```
python ~/.iac/<channel>/iac wait --since 0
```

But `wait` takes `since` as a *positional* argument — there is no `--since`
flag. Running it exits 2 with `unrecognized arguments: --since`. Notably
`directive.md` (the agent-facing doc) got this right (`wait <cursor>`), so the
two human-facing docs disagreed with the agent-facing one.

**Decision.** Change both occurrences to `iac wait 0`.

**Reasoning.** `0` is kept explicit (rather than dropping to the bare `iac
wait` default) so the cursor mechanic stays visible and matches the
`wait <cursor>` shape used in `directive.md`. Verified the corrected command
runs and exits 0.

---

## Finding #2 — channel-layout restructure (done)

**Problem.** Two coupled issues:

1. `scan_channel` walked `rglob("*")` over the whole channel and skipped only
   the tool's own copy. It did **not** skip dotfiles, so the
   `.{name}.{token}.tmp` scratch files created by `atomic_write` could surface
   as changed paths in `wait` output. Reproduced: a leftover/in-flight temp
   file showed up as a changed path. A crash mid-write leaves a stale temp file
   that then appears in *every* subsequent `wait` result.
2. `cmd_ls` filtered to `*.md`, but `directive.md` explicitly invites
   hand-written messages of any name — those would not appear in `ls`.

**Decision.** Give the channel more structure:

```
<channel>/
  iac            # the tool
  directive.md   # agent-facing directive
  who/           # presence, one file per agent
  messages/      # one file per message
  tmp/           # atomic-write scratch, never scanned
```

- Messages now live in `messages/`.
- `atomic_write` stages through `<channel>/tmp/`.
- `scan_channel` scans only `messages/` and `who/`.
- `cmd_ls` lists any file under `messages/` (no `*.md` glob).

**Reasoning.**

- Scoping the scan to the two content dirs kills the temp-file leak
  *structurally* rather than by a dotfile-skipping heuristic — the tool, the
  directive, and in-flight temp files are simply out of scope. It also drops
  the old `SCRIPT_NAME`-skip special case.
- Listing a directory instead of globbing `*.md` fixes the `ls`/directive
  mismatch as a side effect: any file in `messages/` counts as a message.
- The layout becomes self-documenting: the old "messages live loose in the
  root next to the tool and the directive" arrangement was exactly what forced
  all the filtering.

**Why temp files go to `<channel>/tmp/` and NOT `/tmp`.** `atomic_write` relies
on `os.replace`, which is only atomic *within a single filesystem*. `/tmp` is
frequently a separate mount (often tmpfs) from `~`, so staging there would
raise `EXDEV` and break every send/join. `<channel>/tmp/` is guaranteed to
share the channel's filesystem, so the final `replace` stays a true rename.

**Alternative considered and rejected.** Keep the flat layout and just skip
dotfiles in `scan_channel` + `cmd_ls` (~2 lines). This fixes the leak but not
the `*.md`/non-`.md` mismatch, and leaves the "why are messages loose in the
root" awkwardness. Rejected in favor of the restructure, which folds in both
issues and reads more clearly. The user's own instinct favored more structure.

**Accepted breaking change.** This changes the channel contract. Channels
created before this change keep their messages in the root and will not be seen
by the new `messages/`-scoped `ls`/`wait`. No migration was added — channels
are explicitly throwaway and nothing is released, so the cost is near zero.
Recreate any live channel rather than expecting the updated tool to pick up its
old root-level messages.

---

## Finding #3 — sync-cursor edge cases (docs only, no code change)

The `wait` cursor is a filesystem mtime, compared with `mtime > since_ns`. Two
edges were raised.

**System clock stepping backward — left alone, deliberately.** If the wall
clock steps back, newly written files get an mtime below the current cursor and
are missed until the clock catches up.

- Decision: do **not** engineer around it; document it.
- Reasoning: `wait` is deliberately *stateless* — the entire cursor is one
  integer the caller hands back, and independent agents share nothing but the
  filesystem, so mtime is the only common clock. Every real fix needs state
  (tracking seen paths, or per-message sequence numbers that concurrent writers
  cannot allocate without a lock/races), which would kill the design's main
  virtue. Real backward *steps* are rare on an NTP-synced host (the daemon
  slews, it does not step, once synced); big steps happen mainly at boot before
  first sync. Acceptable risk for a throwaway local tool.

**Coarse mtime granularity — documented, not common for this use.** On a
filesystem with coarse mtime resolution, two messages sharing the newest mtime
can be missed once the cursor advances past that timestamp.

- How common: a non-issue for the intended target. ext4 (modern 256-byte
  inodes), XFS, Btrfs, tmpfs, and APFS are all nanosecond-resolution. Coarse
  cases are off to the side and none are typical home-directory storage:
  FAT (2 s) / exFAT (10 ms) on removable media; HFS+ (1 s, deprecated since
  APFS); legacy ext4 128-byte inodes (1 s, long non-default); some NFS/SMB
  configs.

**Decision.** Reword the README's overclaim rather than add code. Kept the
genuinely-true point that each poll compares against the same cursor (not the
wall clock), so nothing slips through *between polls*; added a caveat that this
assumes sub-second timestamps of a modern local filesystem, and that coarse
media or a backward clock step can drop a same-/older-timestamp message — a
non-issue for a throwaway local channel.

---

## Directive tone — suggestive vs. prescriptive (discussed, mostly kept)

The user prefers suggestive over prescriptive directives for generic LLM
tooling. Assessment: the directive is mostly pitched well ("IAC won't impose
one", "invent a convention and state it", "rewriting it is fine"). Two passages
lean prescriptive in a way that reaches beyond IAC's remit as a transport:

- The instruction to narrate "waiting for channel updates" before blocking on
  `wait` — this prescribes how the agent talks to *its own* human/harness,
  which is a property of the agent's session, not of the channel.
- The "make `iac wait` the last thing you do each turn" autonomous-loop
  passage — the most workflow-opinionated part; saved by its "To participate
  autonomously" conditional, but still frames one pattern as *the* way.

**Decision.** Left both as-is for now (a suggested follow-up, not yet applied).
Deliberately **kept** "Messages are write-once. Never edit or delete another
agent's message" firm: it reads as a rule but is the single invariant the whole
model rests on, and nothing enforces it in code, so stating it firmly earns its
keep.

---

## Commit strategy

Two focused commits:

1. `bb4eb81` — `.gitignore` add for `__pycache__` (unrelated housekeeping,
   kept separate).
2. `ad97afe` — the review fixes (#1, #2, and the #3 doc caveat) as one cohesive
   pass over `iac` + `README.md`. Not split further because the #3 caveat
   describes the same `wait` behavior #2 reshapes, and #1 is a one-liner in the
   same files; splitting would have required interactive hunk staging for
   little gain. Offered to break #1 out as its own commit if desired.

Committed directly on `master` at the user's explicit direction (no worktree
this time).

## Verification

`py_compile` passes. End-to-end run confirmed: `new` provisions
`who/`/`messages/`/`tmp/`; `join`/`send` write via `tmp/` with no leftover
scratch; `ls` and `wait` show a hand-written non-`.md` message; incremental
cursor is gapless and empty on no-change; the self-copied `directive.md`
carries the new layout block.
