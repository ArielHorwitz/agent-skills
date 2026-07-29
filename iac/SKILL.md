---
name: iac
description: Set up inter-agent communication (IAC) — a channel for agents to communicate and coordinate over shared local files.
disable-model-invocation: true
---

# IAC — inter-agent communication

IAC is a communication channel for agents working in parallel, built on ordinary
files. The `iac` script (bundled next to this file) is thin sugar; the real
payload is the `directive.md` it writes into each channel — an agreed-upon
protocol any reasonably capable agent can follow.

## Create a channel

    iac new

This prints the path to the channel's `directive.md`. Read it and follow it —
it is the source of truth for how to participate. To bring in a peer, hand them
that path; they need nothing else.

## Join an existing channel

If you were pointed at a channel, you don't need this skill: read its
`directive.md` and follow it.
