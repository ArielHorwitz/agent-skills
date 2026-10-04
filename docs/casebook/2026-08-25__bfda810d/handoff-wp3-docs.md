# Handoff WP3: vendor compatibility documentation

Context: read `landscape-synthesis-and-plan.md` in this directory first
(the matrix, "What is wrong today", and WP3). Then read the three reports
it cites for details when you need them. Then read `README.md` and every
`skills/*/README.md`.

You are headless. Do the work yourself in this session, no subagents.
Do not commit. Another delegate is writing `bridge.sh` and
`tests/bridge-test.sh` in parallel and deleting `fix-claude.sh`. Do not
create or edit any `.sh` file. Write docs against the interface in
`handoff-wp1-bridge-script.md` in this directory (read it, especially
"Interface" and "Reporting and exit status").

## Style rules (public copy, strict)

- No em-dashes anywhere. Use commas, periods, or parentheses.
- No semicolons.
- Never use the phrase "load-bearing".
- Plain, concrete prose. Short sentences. Tables where a matrix is the
  natural shape. Match the existing README's voice.
- Do not overstate. Say "observed on version X" or "documented" where the
  reports do. Say "unverified" for remote surfaces.

## Deliverables

### 1. `README.md`

- Keep the intro, skills table, and Install section, but drop the
  "Using Claude?" callout and replace it with a one-line pointer to the
  new compatibility section.
- Replace the "Claude" section with a "Vendor compatibility" section:
  - A short statement that this repo keeps `.agents/` canonical and
    bridges vendors to it with symlinks, never copies.
  - The compatibility matrix (rows: global instructions, project
    instructions, global skills, project skills, explicit-only invocation.
    Columns: Claude Code, Codex). Mark native versus bridged versus
    unverified. Include the versions observed.
  - `bridge.sh` usage: `bridge.sh claude|codex|all [directory]`, home
    versus project examples, what each vendor mode creates, the
    no-clobber rule, that skipped paths are reported and give exit 1,
    and that re-running is safe.
  - The Codex config alternative for project instructions
    (`project_doc_fallback_filenames = [".agents/agents.md"]` in
    `~/.codex/config.toml`), with its tradeoffs in two or three sentences.
  - Known gaps in one short list: Claude Code on the web only sees
    committed project config, Desktop Cowork skips a home instruction
    symlink pointing outside the session directory, Codex cloud parity
    for `.agents/skills` and the sidecar is unverified.
- Rewrite "Model invocation": the Agent Skills spec defines no such
  control. Claude Code reads `disable-model-invocation: true` in
  frontmatter. Codex reads `agents/openai.yaml` with
  `policy.allow_implicit_invocation: false` and ignores the Claude field.
  Skills in this repo that are explicit-only ship both. Say how to flip
  either and that reinstalling overwrites the change.
- Anywhere `fix-claude.sh` is mentioned, replace with `bridge.sh`.

### 2. `skills/*/README.md`

Where a README shows `/name` invocation, add one sentence near the first
use saying that `/name` is Claude Code's syntax and Codex uses `$name`,
and that other harnesses have their own. `skills/casebook/README.md`
already has a sentence about harness syntax, so adjust it rather than
duplicate. Keep the change minimal.

### 3. `skills/delegate/tools.md`

Update the trailing "Orientation observed with ..." line to claude 2.1.258
and codex 0.153.4. Do not revalidate the flags, that is out of scope.

### 4. Report

`wp3-docs-report.md` in this case directory: files touched, a summary of
each change, and anything you were unsure about or left alone.

Before finishing, run this from the repo root and make sure it prints
nothing:

```
grep -rn -e '—' -e 'load-bearing' README.md skills/*/README.md skills/delegate/tools.md
```

Semicolons inside code blocks are fine, in prose they are not. Check with
`grep -n ';' README.md skills/*/README.md` and fix any in prose.
