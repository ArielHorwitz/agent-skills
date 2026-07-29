# Casebook

A **case** is durable project memory for a bounded piece of work: a feature,
investigation, design, decision, or process. Its files are checked into version
control, so the context belongs to the project. Future sessions can resume or
query the work without the original conversation, developer's machine, agent
harness, or model.

You work with cases by talking to your agent. The agent finds and maintains the
case files; you generally do not need to read or manage them yourself.

The examples below use `/casebook` to invoke the skill. Use your agent
harness's equivalent if its invocation syntax differs.

## When to open a case

A case is useful when either:

- the work will likely span sessions or involve several agents; or
- its architectural decisions, research findings, or process may be valuable
  in the future.

A straightforward feature may deserve a case simply because several sessions
will need its accumulated context. A short investigation may deserve one
because its reasoning will explain a decision months later.

> `/casebook open a new case: I want to investigate increased latency that
> started sometime in the last month`

The session does not need to start as a case: you can promote work already
underway or attach a new session to an existing case:

> `/casebook work on the latency investigation case`

## Working through agents

Agents are the normal interface. Ask them to review the project, resume work,
take an assignment, or retrieve a past finding:

> `/casebook give me a report on the open cases in this project`

> `/casebook did the docs case find any issue with docs referencing the
> generate_foo function?`

The agent reads the relevant context and records useful findings, progress, and
decisions back into the case. The files may be detailed; rely on agents to
synthesize them. Because they are version-controlled and vendor-agnostic,
future sessions can resume or query the work without the original conversation,
harness, or model.

## Coordinating multiple agents

For larger efforts, appoint a main session as the orchestrator:

> `/casebook open a new case to review and improve the documentation. You are
> the orchestrator: make a plan, manage its progress, and write handoffs for
> other agents`

It might create assignments such as `A1: main docs` and `A2: code docstrings`.
Start fresh sessions with those narrow contexts:

> `/casebook you are assigned A1 of the docs case`

Workers contribute their results to the case, while the orchestrator
synthesizes them and prepares subsequent work. This keeps detailed
investigation out of the main session's context while preserving it for the
project.

## Closing and consulting cases

Opening and closing a case are judgment calls. When the work appears finished,
ask:

> `/casebook is the docs case ready to close?`

The agent can summarize unresolved issues, deferred items, or other
considerations before you decide. Closed cases remain useful project history
and can be consulted by future work without being reopened.
