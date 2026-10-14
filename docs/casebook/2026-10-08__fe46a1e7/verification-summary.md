# Verification summary

Verifiers (blind, scoped to changed claims): claude-sonnet-5-5
(dde4d55b-b08c-48d1-96a5-8fe934a1c4c7, $1.49), gpt-6.1-sol
(01a11b29-2984-7d00-ae45-378696d74c7f), gpt-6-astra
(01a11b29-298e-7f30-a0da-e61b72326111). IDs, prices, effort levels and
defaults, the 100K tier, Haiku 4.5 supersession: HOLDS across all three.
Nearly all independent performance and cost verdicts rest on one evaluator.

## Decisions

| claim | verdicts | decision |
| --- | --- | --- |
| Haiku "behind on tool-driven workflows" | UNSUPPORTED x2, FAILS x1 | Dropped. Rests on one benchmark the evaluator itself flags as understated by a pre-release refusal bug; other agentic results point the other way. |
| Haiku "about level with Luna overall" | UNSUPPORTED (6.1 Sol); others silent | Dropped. Sol's correction: Haiku leads the aggregate at every matching effort. Rating band unchanged (no verifier calls it clearly wrong). |
| Haiku "often dearer per task" | HOLDS, understated (Sonnet) | Reworded per Sonnet's cited correction: dearer at every effort level. |
| "Newly released, so this placement rests on thin early evidence" | flagged by all three as research process | Dropped. |
| Sonnet "about the same or more at `max`" | STALE x2 (or-more part), HOLDS (about the same) | "about the same at `max`". Current per-task figures put Sonnet ~9% below Opus at `max`; launch-era figures had it above, so "about the same" rather than "cheaper". |
| "very large contexts favor the larger Claude models on cost, and Luna over Haiku" | UNSUPPORTED (6.1 Sol) | Dropped the sentence; the surcharge facts stand alone. |
| "small well-specified edits" | UNSUPPORTED minor (advice) | Kept as advice. |

## Rating flags (not acted on)

Two verifiers note Haiku's `lowest` cost band is right at routine effort but
misleads at `max` or with long prompts, and that equal execution ratings with
Luna hide opposite strengths (Haiku terminal, Luna SaaS automation). Both
call the ratings defensible and the row notes already carry the caveats.
Kept, and raised at the user gate.

No lead-written factual wording entered the draft, so no recheck was needed.
