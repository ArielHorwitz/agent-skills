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

## Earlier outcome

Two commits on `master`:

- `bb4eb81` — chore: ignore `__pycache__`
- `ad97afe` — fix: correct onboarding command and restructure channel layout

Working tree clean; changes verified end-to-end (`new` → `join` → `send` →
`ls` → `who` → `wait`, incremental cursor, no temp-file leakage).

## Status

Open. A follow-up audit on 2026-07-19 found two implementation issues, now
addressed in the working tree:

- `wait --interval` now rejects zero, negative, and non-finite values with an
  argparse error instead of reaching `time.sleep()`.
- `new` now normalizes its name and always creates beneath `IAC_ROOT`, so a
  slash or `..` cannot escape the channel root. Channel selection by explicit
  `--channel` path remains supported.

The theoretical same-second message-name collision was discussed and accepted
as implausible for this workflow; no change is planned. The non-executable
top-level script remains an open packaging/onboarding decision rather than a
code change.

See [`follow-up-audit-2026-07-19.md`](./follow-up-audit-2026-07-19.md) for
evidence and additional lower-priority observations. Remaining/optional
follow-ups from the earlier review:

- Directive-tone softening of two prescriptive passages (deferred, not yet done).
- No migration path for pre-restructure channels (accepted, by design —
  channels are throwaway).
