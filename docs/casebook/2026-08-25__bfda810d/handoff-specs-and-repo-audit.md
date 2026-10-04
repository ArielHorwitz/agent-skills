# Handoff: specs review and repo audit

Read `handoff-common-lab-rules.md` in this directory first and follow it.
You do not need the lab directory. This is a reading and writing task.

## Goal

Produce `specs-and-repo-audit.md` in the case directory with two parts.

## Part 1: what the vendor-neutral specs actually say

Read, with web search, the current text of:

1. The Agent Skills spec at https://agentskills.io (the specification pages,
   including frontmatter fields and any "optional" or "vendor-specific"
   guidance, and the list of tools claiming support).
2. The `.agents` protocol draft at https://dotagentsprotocol.com/ (layout
   of `.agents/`, `agents.md`, `skills/`, global versus project scope, and
   whatever it says about vendor adapters or compatibility).

Report, with quotes and URLs:

- The exact frontmatter fields each spec defines, which are required, and
  which are explicitly vendor extensions.
- Whether either spec defines a model-invocability or "may the agent invoke
  this on its own" concept, and how.
- What each spec says about instruction files (`agents.md` versus
  `AGENTS.md`, case, location).
- Which vendors each spec lists as supporting it, and what level of support.
- Any conflicts between the two specs.

## Part 2: audit this repository for vendor-specific assumptions

Inventory every place this repo encodes or documents vendor behavior, and
say whether it is vendor-neutral, Claude-specific, Codex-specific, or
inaccurate given the specs above. Cover at least:

- `README.md` (install, Claude section, model invocation section).
- `fix-claude.sh` and `install.sh`.
- Every `skills/*/SKILL.md` frontmatter (fields used, which are standard,
  which are Claude-only). Note `disable-model-invocation` in particular.
- Every `skills/*/README.md` for vendor-specific invocation syntax such as
  `/skill-name`.
- `skills/delegate/tools.md` and `models.md` (these are intentionally
  vendor-aware; just note anything stale versus installed versions
  claude 2.1.258 and codex 0.153.4).
- Any other file mentioning claude, codex, `.claude`, `.codex`, `CLAUDE.md`,
  or `AGENTS.md` (use grep).

Present Part 2 as a table: file, line or section, what it assumes, vendor,
proposed disposition (keep, reword, generalize, move to a vendor adapter).

## Do not

- Do not modify any repo file other than your report.
- Do not run claude or codex.
- Do not speculate about vendor runtime behavior. Other delegates are
  testing that. Stick to what the specs and this repo say.
