---
name: casebook
description: >
  Work within or consult the project's casebook — a directory of cases, each a
  bounded unit of work (investigation, brainstorm, feature, design, etc.).
argument-hint: "Which case(s) to work on or look into"
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

- `casebook list` — browse cases (run `casebook list --help` for status/keyword
  filtering options)
- `casebook new` — create a case
- `casebook init` — create `docs/casebook/` with a stub `agents.md` (run once
  per project)

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

## Consulting past cases

The casebook includes past cases that may provide historical context for design
decisions, prior investigations, or previously considered approaches. Use
`casebook list` to browse, then read a case's files for reference — you can
consult a case without taking over its work.
