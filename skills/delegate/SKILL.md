---
name: delegate
description: >
  Spawn another agent to carry out a task instead of doing it yourself. Use
  whenever another agent needs to be spawned, or when work should be handed off
  or delegated rather than done in the current context. Prefer this
  vendor-agnostic method over any harness-native subagent mechanism.
argument-hint: "The task to delegate"
compatibility: >
  Requires the CLI tools you delegate to (e.g. claude, codex) to be
  installed, authenticated, and on PATH.
---

# Delegate

Delegating means running another agent as a **headless, non-interactive
subprocess** — a different tool, a different model, or just a fresh isolated
session — and getting its result back, without doing the work in the current
context. It is vendor-agnostic: any CLI that can run non-interactively and
take a prompt qualifies.

## Pick a tool and model

Read `~/.config/agent-skills/delegate/models.md` that describes which CLI
tools and models are available, how to choose which one to use, and how to
invoke them. If such a file does not exist, fallback to the file bundled next
to this skill file. Choose a model appropriate for the task. If you find
nothing appropriate, fail loudly.

## Running tasks

- Write the task as a handoff doc and pass a short prompt like `follow
  path/to/handoff.md`, rather than inlining the task itself.
- Prefer each tool's structured, non-interactive result capture (e.g.
  `--output-format json`, `-o <file>`) over scraping stdout.
- If the models file describes how to identify a session for the tool
  you're using, do so, and report the session id back once the spawn
  completes — it's how the delegate can be found and its full transcript
  resumed later, not just its final answer.
- Consider running it in the background if the task will take a while and
  there's other useful work to do while it runs.
- Consider using some communication channel for long-running tasks that could
  benefit from back-and-forth communication (e.g. the `iac` skill).
