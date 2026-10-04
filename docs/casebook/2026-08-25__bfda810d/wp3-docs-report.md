# WP3 vendor compatibility documentation report

## Files touched

- `README.md`
- `skills/casebook/README.md`
- `skills/delegate/README.md`
- `skills/delegate/tools.md`
- `skills/iac/README.md`
- `skills/lead/README.md`
- `skills/report-skill-feedback/README.md`
- `docs/casebook/2026-08-25__bfda810d/wp3-docs-report.md`

## Changes

`README.md` now describes `.agents/` as the canonical source and documents the
Claude Code and Codex bridges. It includes the observed versions, compatibility
matrix, `bridge.sh` interface, examples, collision behavior, Codex configuration
alternative, remote gaps, and separate explicit-invocation controls.

The casebook, lead, and report-skill-feedback READMEs now identify slash commands
as Claude Code syntax and give the corresponding Codex dollar syntax. Existing
public prose across all skill READMEs was adjusted to meet this work package's
restrictions on punctuation. No invocation note was added where a README did not
show a slash command.

`skills/delegate/tools.md` now records Claude 2.1.258 and Codex 0.153.4 as the
versions used for orientation. Its flags were not revalidated.

## Uncertainty and exclusions

The compatibility claims follow the supplied reports. Claude's whole-directory
skills symlink was observed on 2.1.258 but is not explicitly documented. Remote
Claude and Codex surfaces were not tested, so the README keeps those limits
explicit.

No shell file was created or edited. The documentation follows the fixed WP1
interface even though the bridge implementation was being written separately.
No commit was created, as required by the handoff.
