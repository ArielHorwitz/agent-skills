# Rating reconciliation

Synthesizers: claude-opus-5-5 (`synthesis-claude-opus-5-5.md`) and gpt-6-astra
(`synthesis-gpt-6-astra.md`), independent.

## Ratings

No disagreement. Both, independently:

- Add `claude-haiku-5-5` at depth 2, execution 2, cost-to-task "lowest, see
  notes", level with GPT-6 Luna on all three axes. Both rest this on the same
  independent evaluator for broad numbers (one source), plus narrower
  independent tests (a ceiling-saturated invoice test, one long-run anecdote,
  a second leaderboard showing a near tie with Luna). Haiku leads Luna on
  terminal tasks at high effort and above but often costs more per task
  (verbosity, 5x pricing past 100K-token prompts). Both chose to keep Luna
  and Haiku in one band and carry the cost difference in notes rather than
  split the band, which would have broken the "lowest" floor shared with Luna
  on short prompts.
- Move `claude-haiku-4-5` to "Not listed": Haiku 5.5 is better and cheaper
  per token on every shared measure.
- All other cells unchanged.

The lead's own prior (Haiku at "low") was dropped: both synthesizers weighed
the same evidence and kept the band, and nothing stronger argues to break it.

## Wording merged

- Base: Opus draft (tighter, same structure).
- Sonnet row: "about the same or more at `max`" (Opus). Both synthesizers
  found the categorical "more expensive than Opus at `max`" no longer holds
  after the 2026-10-07 cache-read cut (current independent per-task cost has
  Sonnet max slightly below Opus max), while older task studies still show
  workloads where it costs more.
- From Astra: the output-token-at-`max` claim names Opus 5.5 and Sonnet 5.5
  rather than "the Claude 5.5 models" (Haiku 5.5 made the family-wide claim
  misleading); Sonnet's $0.10 cache-read price added to the sticker note.
- Not taken from Astra: the Luna row addition (redundant with the Haiku row),
  the rewritten intro paragraph (no evidence-driven reason to change it), the
  longer long-input note (Opus version says the same in fewer words).
