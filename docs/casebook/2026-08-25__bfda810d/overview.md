# Codex compatibility with the `.agents` protocol

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

## Open questions

1. Should Codex receive a focused `fix-codex.sh`, or should vendor adapters be
   consolidated into a more general setup command?
2. How should the adapter behave when a real `AGENTS.md`, an override, or a
   pre-existing symlink already occupies the Codex-visible location?
3. Should global and project setup be separate operations, as they are for the
   current Claude bridge?
4. Can Codex configuration provide a reliable nested-path fallback, or are
   root-level symlinks the only documented approach?
5. Which Codex surfaces share this behavior: CLI, IDE extension, desktop,
   cloud, and the ChatGPT-hosted harness?
6. How should the README describe native, partial, and adapter-mediated
   compatibility without overstating support for the draft protocol?

## Intended outcomes

- Establish the exact Codex compatibility matrix for `.agents` instructions
  and skills.
- Choose an idempotent bridge that preserves existing user files.
- Add focused verification for global and project instruction discovery.
- Correct the installation and compatibility documentation.
- Decide whether the remaining gap should also be reported upstream to Codex.
