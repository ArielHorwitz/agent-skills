# Vendor compatibility with the `.agents` protocol

## Scope (reframed 2026-09-08)

Originally opened as a Codex-only instruction-discovery case. Reframed to cover
**all vendor compatibility concerns** for this repo across the supported
vendors, currently **Claude Code and Codex**:

- instruction discovery (`agents.md` / `AGENTS.md` / `CLAUDE.md`, global and project)
- skill discovery (`.agents/skills/` vs vendor-specific directories)
- skill metadata (frontmatter fields, model-invocability, and any vendor-specific
  sidecar files)
- adapters/bridges (`fix-claude.sh`, a possible Codex equivalent, or a unified
  setup), including collision handling and idempotency
- documentation accuracy about what is native, partial, or adapter-mediated

The original Codex-focused problem statement follows and remains valid as the
first concrete instance.

## Problem

This repository treats `.agents/` as the canonical, vendor-neutral home for
agent configuration. Codex currently provides only partial interoperability
with that layout:

- The active Codex harness discovers skills in
  `/home/wiw/.agents/skills/`.
- It does not automatically discover the global instructions in
  `/home/wiw/.agents/agents.md`.
- Codex's documented global instruction location is
  `$CODEX_HOME/AGENTS.md`, normally `~/.codex/AGENTS.md`.
- Codex's documented project discovery walks from the project root to the
  working directory and checks instruction filenames in those directories. It
  does not document discovery of `<project>/.agents/agents.md`.

The result is split support by artifact type: skills work from `.agents`, but
instructions require a Codex-specific location. This contradicts the current
repository documentation's implication that Claude is the sole tool requiring
a compatibility bridge.

## Relevant contracts

- The draft [`.agents` protocol](https://dotagentsprotocol.com/) defines
  `~/.agents/agents.md` as global guidance and
  `<project>/.agents/agents.md` as workspace guidance.
- [Codex's official `AGENTS.md` documentation](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
  defines `$CODEX_HOME/AGENTS.md` for global guidance and direct hierarchical
  discovery of `AGENTS.md`, `AGENTS.override.md`, or configured fallback
  filenames for project guidance.

These are related but distinct contracts. Codex can comply with its own
`AGENTS.md` discovery rules without implementing the `.agents` directory
protocol.

## Initial compatibility direction

Keep `.agents/agents.md` canonical and expose it through vendor-facing
adapters, avoiding copied instruction files that can drift. The simplest Codex
bridge appears to be:

- Global: `~/.codex/AGENTS.md -> ~/.agents/agents.md`
- Project: `<project>/AGENTS.md -> <project>/.agents/agents.md`

This resembles the existing Claude bridge in `fix-claude.sh`, but it should not
be accepted as the design until collision handling, installation scope, and
Codex lifecycle behavior have been examined.

## Status (closed 2026-10-04)

Landscape review done by three probes (see `claude-compatibility-report.md`,
`codex-compatibility-report.md`, `specs-and-repo-audit.md`), synthesized in
`landscape-synthesis-and-plan.md`. Plan approved and implemented:

- `bridge.sh <claude|codex|all> [dir]` replaces `fix-claude.sh`. Codex gets a
  root `AGENTS.md` symlink (or `$CODEX_HOME/AGENTS.md` for the home
  directory), no skill links. Collisions are reported and exit 1.
  `tests/bridge-test.sh` covers the collision and home cases.
- `lead` and `report-skill-feedback` ship `agents/openai.yaml` with implicit
  invocation disabled, mirroring their Claude frontmatter flag.
- README has a vendor compatibility section with the matrix, bridge usage,
  the Codex config alternative, known gaps, and an honest model invocation
  section. Skill READMEs note `/name` versus `$name`.

Independent review (claude-opus-5, `wp4-review-findings.md`) found one real
bug (a symlinked `.claude` produced dangling links reported as success) and a
few reporting and copy gaps. All fixed (`wp5-bridge-fixes-report.md`).

A fresh-eyes review of those fixes (gpt-5.6-sol, `wp6-fresh-eyes-review-findings.md`)
confirmed them and found one more edge case: a directory at `.agents/agents.md`
was bridged as if valid. Fixed with a test.

## Resolution of the original open questions

1. Focused `fix-codex.sh` or consolidated setup: consolidated `bridge.sh`.
2. Collisions: never touched, reported by kind, exit 1.
3. Global versus project: one command, behavior keyed on whether the
   directory is `$HOME`.
4. Nested-path fallback: `project_doc_fallback_filenames = [".agents/agents.md"]`
   works on Codex 0.153.4 (undocumented path handling). Documented as the
   alternative, symlink is the default.
5. Surfaces: CLI observed. IDE and desktop documented as same engine. Codex
   cloud and Claude web or Cowork have gaps, listed in the README.
6. README wording: native, bridged, unverified, with observed versions.

## Remaining threads

- Upstream report to Codex: not pursued, the config fallback closes the gap.
- Runtime probes are not repo tests. Reproduction commands live in the probe
  reports.
- Agent-facing docs (`SKILL.md` files, `models.md`) still use em-dashes.
  Out of scope here.
- Side finding for the delegate skill: claude-sonnet-5 headless spawned a
  background subagent and exited before it finished, producing nothing.
  A fidelity note in `models.md` is suggested.
