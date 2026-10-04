# Handoff WP6: fresh-eyes review of the WP5 fixes

You are a read-only reviewer. Do not edit files in the repo and do not commit.
Do the work yourself in this session, no subagents. Print your review as your
final answer in Markdown, it will be saved by the lead.

## Background

An earlier review (`wp4-review-findings.md` in this directory) found a bug and
some gaps. A fix pass landed them (`wp5-bridge-fixes-report.md`). Nobody has
reviewed the fixes. You are that review.

## What to review

The WP5 commits:

```
git show d4a1610   # bridge.sh fixes and test additions
git show c3a099e   # README copy fixes
```

Then read the final `bridge.sh` and `tests/bridge-test.sh` in full. Run
`sh -n bridge.sh` and `sh tests/bridge-test.sh`. You may experiment in a
throwaway directory under `/tmp/wp6-review/`, using a fake `HOME` and
`CODEX_HOME` there. Never touch anything under `/home/wiw`.

## What to check, in priority order

1. Did each WP4 finding actually get fixed, or only papered over?
2. Did the fixes introduce new bugs or regressions? It must stay POSIX sh,
   must never modify or remove an existing path, and must stay idempotent.
3. Do the new tests really exercise the fixed behavior (would they fail if
   the fix were reverted)?
4. Anything the WP4 review missed that matters.

Already known, do not report: if `$CODEX_HOME` (or `~/.codex`) is occupied by
a regular file, `set -e` aborts the codex step early (still exit 1 with a
report). Hard-coded vendor versions in the README.

## Output

A ranked list. For each item: file and line, what is wrong, why it matters,
and a concrete fix. Say "no findings" for a category you checked and found
clean. Keep it tight. End with a one-line verdict: merge, or merge after
specific fixes.
