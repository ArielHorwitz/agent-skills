# Delegate

Delegate is a vendor-agnostic convention for agents to spawn other agents. It
is meant to supersede harness-native subagent mechanisms as a standard
convention to allow any agent to spawn any other agent.

## The models file

This skill points to a "models" file at
`~/.config/agent-skills/delegate/models.md`, using the copy bundled at
`<this-skill-dir>/models.md` as a default if that path doesn't exist. It
describes what tools and models are available and how to pick one for a
given task. The file is read by the agent, not parsed by any program, so it
can be formatted and described free-form — the bundled copy has two
sections, Tools (how to invoke each CLI) and Models (a table of models and
how to pick one), but notes, a plain list, or anything else that
communicates "what's available, how to run it, and how to pick which one"
works just as well.

How you manage the file — editing the bundled copy in place, copying it to
your own config, something else — is up to you.

## How an agent uses it

Given a task to delegate, the agent reads `models.md`, weighs whatever it says
about each tool/model against the task, and picks one. It writes a handoff
document and passes a short prompt like `follow path/to/handoff.md`, capturing
the result through the tool's own structured output mechanism (e.g.
`--output-format json`, `-o <file>`). It may consider running it in the
background, or opening a communication channel with it, if appropriate.
