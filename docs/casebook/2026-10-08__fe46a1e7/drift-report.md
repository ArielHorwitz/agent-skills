# Drift report, 2026-10-04 to 2026-10-08

Merged from `drift-models-claude-opus-5-5.md` and `drift-models-gpt-6-1-sol.md`
(independent, both vendor-sourced, agree on every point below).

## Candidate roster

- **Add `claude-haiku-5-5`** (released 2026-10-07, cheap tier). Smoke OK
  2026-10-08 on claude 2.1.286, but see CLI note.
- **Keep** all seven current rows and the "Not listed" legacy set. Nothing
  retired or unrunnable. `claude-haiku-4-5` is now "Legacy (still available)"
  with a retirement floor of 2026-10-15 (no deprecation notice yet); whether
  Haiku 5.5 supersedes it is for synthesis.
- OpenAI: no new API/Codex model, no repricing, no deprecation of a roster
  model. ChatGPT-only October snapshots of GPT-6 Sol/Luna do not reach Codex.
  `gpt-5.5` (not in the table) leaves Codex with ChatGPT sign-in 2026-10-14,
  announced pre-baseline. GPT-6.1 Sol Ultrafast still unshipped.

## Facts the synthesis needs

- Haiku 5.5: $0.10/$0.50 per MTok up to 100K-token prompts, $0.50/$2.50 above
  (whole request). 1M context, 128K max output. Effort low..max, default
  `medium` (API and Claude Code). Adaptive thinking. New tokenizer, roughly
  25-30% more tokens than Haiku 4.5 for the same text.
- So "Claude bills flat across its 1M window" is no longer true of every
  Claude model.
- Sonnet 5.5 cache reads $0.20 -> $0.10 per MTok, 2026-10-07; other prices
  unchanged.

## Tool changes

- Claude Code 2.1.293 (2026-10-07) adds Haiku 5.5 and points the first-party
  `haiku` alias at it; docs say Haiku 5.5 needs 2.1.293+. Installed 2.1.286
  runs the ID but logs `unrecognized_model`, `costBasis: unknown`, and reports
  a 200K context / 32K max output. Codex 0.161.0 (2026-10-07) changes the
  bundled default to gpt-6.1-sol and Bedrock items only. Neither CLI was
  upgraded or re-probed in this run.
