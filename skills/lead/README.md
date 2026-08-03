# Lead

Lead is a **posture** skill: it puts the current session into the role of
holding a high-level goal and steering it, delegating significant work to other
agents rather than doing it in-context.

It stands on its own — the skill names no other skill and depends on none — but
it composes naturally with the rest of this collection:

- [`delegate`](../delegate/) is a *mechanism* the lead can reach for to spawn an
  agent for a task; `lead` is the *standing role* that decides when to.
- [`iac`](../iac/) gives the lead a channel to coordinate with long-running
  dispatched agents, rather than only firing off one-shot tasks.
- [`casebook`](../casebook/) gives dispatched agents a shared workspace, and the
  lead a natural place to keep the goal and track what's out.

## How to use

Invoke the skill with a goal to put the session into the role — e.g.
`/lead ship the auth refactor`, or alongside a case: `/casebook /lead work on
the latency investigation case`. From then on the session holds the goal,
delegates significant work, and integrates the results.
