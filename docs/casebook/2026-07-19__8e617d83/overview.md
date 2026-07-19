# IAC review — overview

A review of the `iac` tool (single-file filesystem transport for inter-agent
communication) and its `README.md`, plus the fixes that came out of it.

## Scope

The user asked for a project review, flagging a preference for **suggestive
rather than prescriptive** directives in LLM-facing tooling — especially for a
generic tool meant to span many projects and workflows like this one.

Three findings were actioned; a fourth (directive tone) was discussed and left
mostly as-is by deliberate choice. See
[`review-findings-and-decisions.md`](./review-findings-and-decisions.md) for
the full record, including the reasoning and the options we rejected.

## Outcome

Two commits on `master`:

- `bb4eb81` — chore: ignore `__pycache__`
- `ad97afe` — fix: correct onboarding command and restructure channel layout

Working tree clean; changes verified end-to-end (`new` → `join` → `send` →
`ls` → `who` → `wait`, incremental cursor, no temp-file leakage).

## Status

Open. Remaining/optional follow-ups noted in the decision record:

- Directive-tone softening of two prescriptive passages (deferred, not yet done).
- No migration path for pre-restructure channels (accepted, by design —
  channels are throwaway).
