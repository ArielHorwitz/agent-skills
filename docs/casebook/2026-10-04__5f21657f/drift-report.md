# Drift report (phase 2)

Merged by the lead from two independent drift researchers
(`drift-models-claude-opus-5-5.md`, `drift-models-gpt-6-1-sol.md`), which agree
on every release, price, and retirement date checked. Details, prices and
sources are in those two reports.

## Candidate roster (15)

| model | action | reason | smoke |
| --- | --- | --- | --- |
| claude-fable-5-1 | add | new 2026-09-01, Fable successor, same price | OK |
| claude-opus-5-5 | add | new 2026-09-22, vendor default, cheaper than Opus 5 | OK |
| claude-sonnet-5-5 | add | new 2026-09-28, same price as Sonnet 5 | OK |
| claude-haiku-4-5 | keep | still the cheap tier (retirement floor 2026-10-15, no notice) | OK |
| claude-opus-5 | keep | legacy, synthesis decides if dominated | OK |
| claude-opus-4-8 | keep | legacy, synthesis decides if dominated | OK |
| claude-fable-5 | keep | legacy, synthesis decides if dominated | OK |
| claude-sonnet-5 | keep | legacy, synthesis decides if dominated | OK |
| gpt-6-astra | add | new 2026-09-03, OpenAI flagship | OK |
| gpt-6.1-sol | add | new 2026-09-29, near-Astra at lower cost | OK |
| gpt-6-sol | add | new 2026-09-22, superseded by 6.1 Sol within a week | OK |
| gpt-6-luna | add | new 2026-09-22, cheap tier, half GPT-5.6 Luna's price | OK |
| gpt-5.6-sol | keep | previous gen, promo price through at least 2026-11-21 | OK |
| gpt-5.6-terra | keep | previous gen, no GPT-6 Terra tier exists | OK |
| gpt-5.6-luna | keep | previous gen | OK |

Not candidates: `gpt-5.5` (retires from Codex 2026-10-14), `claude-mythos-5-1`
and the GPT cyber/daybreak models (restricted access, not general CLI use).

## Tool changes

claude 2.1.258 to 2.1.286, codex 0.153.4 to 0.159.3. Help snapshots in `help/`.
Diff and probes are phase 6. Noted by the drift researchers: Opus 5.5 needs
Claude Code 2.1.280+, Sonnet 5.5 needs 2.1.284+; Opus 5.5's default effort is
medium and Sonnet 5.5's in Claude Code is medium; codex "Ultra" is an
orchestration option, not a reasoning effort.
