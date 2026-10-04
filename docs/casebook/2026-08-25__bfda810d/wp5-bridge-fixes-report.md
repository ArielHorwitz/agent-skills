# WP5 bridge fixes

Fixed review findings 1, 2, 3, and 6 in `bridge.sh` and
`tests/bridge-test.sh`.

- Symlinked `.claude` directories now receive absolute targets when needed,
  and every newly created link is checked for resolution.
- Dangling canonical guidance and scaffold collisions are reported, produce
  status 1, and do not prevent independent paths from being checked.
- Regression coverage now includes resolving links, symlinked Claude config,
  collision continuation, both Codex override branches, preservation of
  existing guidance, paths with spaces, scaffold collisions, and dangling
  links.
- `sh -n bridge.sh` and ShellCheck are clean.

Final test output:

```text
PASS: bridge.sh vendor bridge tests
```
