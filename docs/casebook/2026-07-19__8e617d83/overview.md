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
as implausible for this workflow; no change is planned.

The installation story is now resolved:

- The source script is executable (`f19276c`); channel-local copies were
  already `chmod 0o755` at copy time, so onboarding was never actually broken —
  only running from a fresh clone was.
- A self-install command `iac install` (`ee9d40b`) copies the script to
  `~/.local/bin/iac` by default (`--dest` to override, `--symlink` to track the
  checkout), chosen over hand-written `ln -s` instructions to match the tool's
  self-copy ethos. It stages a temp file and `os.replace`s it in, so an existing
  target — including a symlink back to the source — is swapped atomically without
  truncating the source.
- With both the installed command and every channel copy guaranteed executable,
  the fragile `python`/`python3` prefix was dropped from the docstring,
  directive, and README examples in favor of the shebang.

See [`follow-up-audit-2026-07-19.md`](./follow-up-audit-2026-07-19.md) for
evidence and additional lower-priority observations. Remaining/optional
follow-ups from the earlier review:

- Directive-tone softening of two prescriptive passages — **done** in
  `e71f9a0` (suggestive-but-firm reframing of the "narrate before you block"
  and autonomous-loop passages).
- No migration path for pre-restructure channels (accepted, by design —
  channels are throwaway).
