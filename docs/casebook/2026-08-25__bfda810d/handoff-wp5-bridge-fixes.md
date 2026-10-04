# Handoff WP5: fix bridge.sh and its test per review

Read `wp4-review-findings.md` in this directory. Fix findings 1, 2, 3, and 6
in `bridge.sh` and `tests/bridge-test.sh`. Do not touch any Markdown other
than a short `wp5-bridge-fixes-report.md` here. Do not commit. Do the work
yourself, no subagents.

Decisions already made:

- Finding 1: mirror the Codex-home logic. Resolve `.claude` with `cd -P`.
  If it resolves to `<project>/.claude`, keep the relative targets.
  Otherwise use absolute targets `<project>/.agents/skills` and
  `<project>/.agents/agents.md`. Also add the belt-and-braces check in
  `ensure_link`: after creating a link, if it does not resolve, print
  `warning: <link> does not resolve` and set status to 1.
- Finding 2: a dangling `.agents/agents.md` symlink goes through
  `report_occupied` and sets status to 1, then continue.
- Finding 3: route scaffold collisions (`.agents` or `.agents/skills`
  occupied by a non-directory) through `report_occupied` with status 1
  and continue with whatever can still be done, so the README claim
  "reports each skipped path and exits 1 after checking everything" holds.
  If `.agents` itself is unusable, the vendor links cannot be made, so
  report and skip them too, still exit 1, no `Done` line.
- Finding 6: add tests for every bullet: created links resolve, `.claude`
  as a symlink to a sibling directory gets absolute targets that resolve,
  `all` continues past a collision, `AGENTS.override.md` in the Codex
  home branch warns, existing `agents.md` with distinct content survives,
  a path with spaces works, and the two dangling cases above exit 1.
- Minor: rename the `directory` local in `create_directory` to avoid
  shadowing the parsed argument.

Keep the script POSIX sh and keep `sh -n bridge.sh` and shellcheck clean.
Run the test and paste its final output in the report.
