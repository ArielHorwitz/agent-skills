# Handoff WP4: independent review of the vendor compatibility change

You are a read-only reviewer. Do not edit files. Do the work yourself in
this session, no subagents. Print your review as your final answer in
Markdown, it will be saved by the lead.

## What to review

The full diff of this branch against `master`:

```
git diff master...HEAD --stat
git diff master...HEAD -- . ':!docs/casebook'
```

Ignore the casebook directory except as background. Read
`docs/casebook/2026-08-25__bfda810d/landscape-synthesis-and-plan.md` for
intent and the compatibility matrix, then the diff. Run
`sh tests/bridge-test.sh` and `sh -n bridge.sh`.

## What to check, in priority order

1. Correctness of `bridge.sh` against the plan and the claims in
   `README.md`. Look for shell portability problems (it must be POSIX sh),
   path edge cases (trailing slashes, symlinked home, `CODEX_HOME` set to
   a relative path or with a trailing slash, spaces in paths), and any way
   it could modify or remove an existing file.
2. Whether `README.md` makes any claim not supported by
   `claude-compatibility-report.md` or `codex-compatibility-report.md`
   in the case directory, or overstates support.
3. Whether the `agents/openai.yaml` sidecars in `skills/lead` and
   `skills/report-skill-feedback` match the schema in the Codex report.
4. Test coverage gaps in `tests/bridge-test.sh` that matter.
5. Public-copy style in the changed Markdown: no em-dashes, no semicolons
   in prose, nothing that reads as obviously machine-written.

## Output

A ranked list. For each item: file and line, what is wrong, why it
matters, and a concrete fix. Say "no findings" for a category you checked
and found clean. Keep it tight. Do not restate the diff.
