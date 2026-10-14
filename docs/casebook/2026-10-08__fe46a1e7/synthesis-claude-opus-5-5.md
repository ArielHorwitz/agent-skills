# Synthesis: Haiku 5.5 incremental refresh

Synthesizer model ID: `claude-opus-5-5` (Anthropic). Date: 2026-10-08.

Disclosure: I'm an Anthropic model rating a new Anthropic model, and I'm the
same model as the `claude-opus-5-5` row. Judgments about Claude rows are
self-vendor judgments, and the Opus 5.5 row is a self-judgment. I left it
unchanged. One of the three research reports (O below) was also written by
`claude-opus-5-5`.

Inputs:

- New: three research reports, the drift report with its two detail files,
  and the run log.
- Previous case 5f21657f: synthesis, rating reconciliation, verification
  summary, user decisions.
- The current `models.md`, read after forming a view on Haiku 5.5.

Output: this file and `models-draft-claude-opus-5-5.md`.

## Report labels

| label | report | researcher's vendor | marking |
| --- | --- | --- | --- |
| O | research-claude-opus-5-5.md | Anthropic | `[self-vendor]` on Haiku 5.5 and all Claude rows |
| S61 | research-gpt-6-1-sol.md | OpenAI | `[self-vendor]` on Luna and Sol, `[self]` on Sol |
| A | research-gpt-6-astra.md | OpenAI | `[self-vendor]` on Luna and Sol |

## 1. Evidence base

The model is one day old, so independent signal is thin.

1. **Artificial Analysis (AA)**, Intelligence Index v4.3.2 plus its
   Terminal-Bench 4.0 and AutomationBench-AA runs. This is the only broad
   independent evaluator. O, S61 and A all lean on it, and its many pages
   count as one source. Its cost figures use Haiku's short-prompt rate. None
   of the three reports could confirm that AA applies the over-100K tier.
2. **Narrow independent workloads**, each a single run:
   - LiveBench (S61, A), read through search snippets
   - Plotly 43-question analytics exam (S61)
   - DataCamp's 24-invoice decision test (O, A), which hit the ceiling
   - one Simon Willison prompt (O)
3. **Cognition FrontierCode** (O), reached through an aggregator. Cognition
   is a launch partner quoted in the vendor post. One semi-independent
   source.
4. **Vals AI** (O): one unfetched article plus a site drawing on the same
   data. Secondhand, one source, weak.
5. **Anecdotes**: a Reddit long-loop cost report (S61, A), a few HN comments
   (O).
6. **Vendor**: the launch post, model docs, pricing, the prompting guide, and
   the Claude Code docs. I used these for facts (prices, the 100K tier,
   effort levels and defaults, context) and for the vendor's own effort
   guidance, but no rating rests on a vendor benchmark. As in the previous
   case, Anthropic's Terminal-Bench 4.0 numbers run 6 to 9 points above AA's
   (39.2% vs 33% for Haiku 5.5 at max).

Drift: Haiku 5.5 is the only new model. Sonnet 5.5 cache reads were cut from
$0.20 to $0.10 per MTok on 2026-10-07. Nothing else changed on the roster.
The ChatGPT-only October snapshots of GPT-6 Sol and Luna, and the
`chat-latest` refresh, don't reach Codex or the API IDs. Both drift reports
and S61 and A agree on all of this.

## 2. Convergent findings

**C1. Haiku 5.5 supersedes Haiku 4.5.** O, S61 and A all say so.

- Depth: AA index 17 vs 34 (medium) to 43 (max).
- Execution: AA Terminal-Bench 4.0 0% vs 15% (medium) to 33% (max).
- Cost per AA task: Haiku 4.5 $0.21 to $0.28 vs Haiku 5.5 $0.05 (medium),
  $0.08 (high) and $0.21 (max).
- Plotly: 37 vs 27 of 43 passed, at $0.38 vs $3.27.
- DataCamp: both 24/24, at $0.0098 vs $0.25.
- Rests on AA, Plotly and DataCamp, all independent.
- Contrary signal: the secondhand Vals report says Haiku 5.5 costs more per
  test than Haiku 4.5 on every shared benchmark. It is one unfetched source,
  and even if it holds, Haiku 5.5 is still "better", which meets the file's
  "better, cheaper, or both" test.

**C2. Depth sits far below Sol, Sonnet and Opus.** O, S61, A. On the AA
index:

| model | AA index (effort) |
| --- | --- |
| Haiku 5.5 | 43 (max) |
| GPT-6.1 Sol | 52 (max), 42 (low) |
| Sonnet 5.5 | 56 (max) |
| Opus 5.5 | 58 (max), 42 (low) |

Haiku at max only reaches Sol or Opus at `low`. HLE agrees (AA about 44% vs
53 to 61%). Plotly found bounded analysis strong but hidden-pattern and
statistical-trap questions weak (2 of 5 each).

**C3. Execution is far below Sol, Sonnet and Opus.** O, S61, A. All AA:

| model | Terminal-Bench 4.0 (effort) | AutomationBench-AA (effort) |
| --- | --- | --- |
| Haiku 5.5 | 15% (medium), 22% (high), 29% (xhigh), 33% (max) | 34% (high), 35% (max) |
| GPT-6.1 Sol | 52% (high), 56% (max) | 64 to 65% |
| Sonnet 5.5 | 57% (xhigh), 64% (max) | 66 to 72% |
| Opus 5.5 | 60% (max) | 70% |

**C4. Verbose, steeply so with effort.** O, S61, A.

- AA output tokens over the index: medium 54M, high 97M, xhigh 180M, max
  440M. For comparison, Sol max 67M, Luna max 140M, Sonnet max 420M.
- Per-task cost rises much faster than score. Max costs 2.6x high for 5
  points.
- At max, Haiku ($0.21, score 43) costs more than Sol at low ($0.13, 42).
- FrontierCode (single source) has the same shape: Haiku max 46.4% at $1.33
  vs Sol medium 50.2% at $0.36.

**C5. The 100K-prompt tier matters for delegation.** O, S61, A, both drift
reports, all vendor.

- Above 100K tokens the whole request bills at $0.50/$2.50 per MTok.
- Luna's surcharge starts at 272K and is milder. So above 100K, Luna's rates
  are 2.5x to 5x lower than Haiku's.
- Inference (O): a headless session resending a growing transcript crosses
  100K partway through a long task.
- Unconfirmed: whether cached tokens count toward the threshold.

**C6. Start at `medium`, use `high` for longer tool work.** S61 and A
explicitly, O close (see D4).

- Default is medium on both the API and Claude Code (vendor).
- The vendor prompting guide reports that low effort stops early on long
  coding prompts.
- The AA Terminal-Bench gains from medium to high are real, and the cost per
  AA task is $0.05 to $0.08.

**C7. Supporting fact for an existing row: AA's Sonnet 5.5 cost per task
dropped and its token counts didn't.** All three reports cite AA's current
Sonnet 5.5 numbers:

| AA, Sonnet 5.5 | previous case | now |
| --- | --- | --- |
| max | 56 / $7.60 | 56 / $5.46 |
| low | 36 / $0.41 | 36 / $0.35 |

- The output token ratio to Opus is unchanged (420M vs 260M now, 193k vs 119k
  per task before, both about 1.6x).
- Inference: AA repriced its runs for the 2026-10-07 cache-read cut. It is
  not a rerun with different behavior.
- Opus 5.5 max is still $5.98, so on AA, Sonnet at max is now slightly
  cheaper than Opus at max.

## 3. Real disagreements

**D1. Haiku 5.5 vs Luna on depth.**

- O `[self-vendor]` calls Haiku smarter at the same price (AA 43 vs 38 at
  max).
- S61 and A `[self-vendor, for Luna]` point to LiveBench (72.1 vs 72.0) and
  Plotly (37 vs 38) and call it a tie.
- At matched effort names AA has Haiku slightly ahead (medium 34 vs 30, high
  38 vs 33), but effort names aren't equal compute across vendors.
- Two narrower independent tests show a tie. I rate depth 2, the same as
  Luna. The case for 3 is AA at xhigh/max, but at that effort Sol at `low`
  matches it for less (C4), and the row is rated at medium/high. Unresolved
  in the evidence, settled for the table by the effort assumption.

**D2. Haiku 5.5 vs Luna on execution.**

- Terminal work favors Haiku: AA Terminal-Bench 33% vs 13% at max, but only
  15% vs about 13% at medium.
- Tool-driven SaaS workflows favor Luna: AutomationBench 35% vs 53%.
- FrontierCode (single source) has Haiku at medium level with Luna at max.
- Secondhand Vals has Haiku third on Vibe Code Bench (90.4%), which would
  argue for 3. It is one unfetched source, and I gave it no weight.
- I rate execution 2. The case for 3 is the terminal edge at high and above,
  but no agentic board shows Haiku ahead of Luna across the board.

**D3. Haiku 5.5 vs Luna on cost-to-task.** Evaluators point different ways.

| evaluator | Haiku 5.5 | Luna | ratio |
| --- | --- | --- | --- |
| AA, matched score 38 | $0.08 (high) | $0.07 (max) | about 1.1x |
| AA, xhigh | $0.12 | $0.04 | 3x |
| Plotly | $0.38 | $0.13 | 2.9x |
| LiveBench, per success | $0.019 (xhigh) | $0.026 (max) | Haiku cheaper |
| FrontierCode | $0.13 (medium) | $0.10 (max) | 1.3x |
| Reddit long loop | | | about 12x (anecdote) |

S61 and A `[self-vendor, for Luna]` say neither is universally cheaper. O
says they're at parity for short work. All three agree Luna wins on long
loops and on prompts over 100K. I placed it in the next section.

**D4. How far up the effort ladder.**

- O says xhigh only for short, quality-critical runs.
- S61 and A say high for longer tool sequences.
- The vendor guide says compare against Sonnet before buying the top two
  levels.
- Draft: `medium` routine, `high` for longer tool sequences, then switch
  model. This follows C4.

**D5. Small facts, unresolved and not used in the draft:**

- FrontierCode Sonnet 5.5 is 52.1% (vendor) or 46.2% (Cognition via
  aggregator).
- Tokenizer inflation over Haiku 4.5 is about 25% (one measurement) or 30%
  (vendor).
- Whether AA's Haiku costs include the 100K tier.

## 4. Placement of Haiku 5.5

Rated at `medium`/`high`, the effort named in its notes.

| axis | rating | reason |
| --- | --- | --- |
| depth | 2 | D1. Same as Luna (AA 34 to 38 at the rated effort vs Luna 38 at max; LiveBench and Plotly ties). Twice Haiku 4.5, well under Sol at 4 |
| execution | 2 | D2. Terminal-Bench 15 to 22% at the rated effort (Luna 13.6%, Sol 55%), AutomationBench below Luna. Better than Haiku 4.5's 1, below Astra's 4 |
| cost-to-task | lowest, see notes | Per AA task at medium/high it costs $0.05 to $0.08: about Luna at matched score, a quarter of Sol at medium ($0.21), and a quarter or less of Haiku 4.5. It sits with Luna rather than with Sol at "low", which would hide a 3 to 4x gap. The ordering is Luna ≤ Haiku 5.5 < Sol, and the notes say Luna is often cheaper per task, especially on long sessions and over 100K |

**Earns a row:** yes. It's the cheap Claude tier for Claude-only pipelines,
which is why Haiku 4.5 kept its row, and it's now competitive with Luna
rather than dominated by it. Its profile differs from Luna's: stronger on
terminal tasks, weaker on tool workflows, more verbose. That difference is
worth showing.

**Supersedes:** Haiku 4.5 (C1). It moves to "Not listed". The vendor already
lists it as legacy, but that is availability, not the reason.

## 5. Every change from the current file

### Rows

| row | axis or field | current | draft | reason |
| --- | --- | --- | --- | --- |
| claude-haiku-5-5 | all | (new) | 2 / 2 / lowest, see notes | Section 4 |
| claude-haiku-4-5 | all | 1 / 1 / low | dropped to "Not listed" | C1 |
| claude-sonnet-5-5 | notes | "Cheaper than Opus 5.5 below `max`, more expensive at `max`" | "Cheaper than Opus 5.5 below `max`, about the same or more at `max`" | C7 |
| claude-sonnet-5-5 | cost-to-task | medium-high | unchanged | see below |

Why "about the same or more" for Sonnet at max:

- AA now has Sonnet at 0.91x Opus.
- The agentic boards from the previous case had it at 1.09x to 1.6x (Coding
  Agent Index, Vals Terminal-Bench 4.0 and Terminal-Bench-Science). Those
  were measured before the cut and haven't been re-measured.

Why the Sonnet cost band holds:

- It was already cheaper than Opus below `max`. The cut makes it cheaper
  still, but medium is a whole band down, past Astra's medium-high.
- The only evidence for a bigger agentic saving is the vendor's unverified
  "about 20% cheaper".
- Revisit when the agentic boards re-measure.

### Rows not moved, and why

Haiku 5.5 sits below every one of these on depth and execution, so it
compresses nothing at the top of the scale. No new or previous evidence
moves them.

- **claude-opus-5-5** (5 / 5 / high) `[self]`: no new independent data
  beyond the AA numbers already in the previous case (58 / $5.98 unchanged).
- **claude-fable-5-1** (4 / 4 / highest): no new data.
- **gpt-6-astra** (5 / 4 / medium-high): no new data.
- **gpt-6.1-sol** (4 / 5 / low): the new data agrees with the row.
  - AA 52 / $0.72 at max and 42 / $0.13 at low are unchanged.
  - AA Terminal-Bench 52 to 56% is unchanged.
  - FrontierCode medium 50.2% / $0.36 was already in the previous case.
  - The new comparisons support its "default executor" note: it beats Haiku
    5.5 at max on score and cost.
- **gpt-6-luna** (2 / 2 / lowest): Haiku 5.5 doesn't displace it.
  - Luna is still the cheapest per task on most measurements and wins
    AutomationBench.
  - Note left as is. The comparison lives in the Haiku 5.5 row, replacing
    Haiku 4.5's "Luna does more for less".

### Notes

| note | change | reason |
| --- | --- | --- |
| Starting choices | added "`gpt-6-luna` or `claude-haiku-5-5` for cheap, bounded, checkable work" | All three reports converge on this use. The file had no cheap starting choice |
| Effort | "Opus 5.5, Sonnet 5.5 and Haiku 5.5 start at `medium` in Claude Code" | Vendor docs, both drift reports |
| Cost-to-task | Dropped "Sonnet 5.5 at $2/$10 costs more per task than Opus 5.5 at $4/$20" because it no longer holds on AA (C7). Kept the Astra example, now against both. Added the Haiku 5.5 `max` vs 6.1 Sol `low` example (AA: 43 / $0.21 vs 42 / $0.13) | C4, C7. The four-to-ten-times token claim still holds and now covers Haiku 5.5 at `max` (440M, about Sonnet's 420M) |
| Sticker prices | Haiku 4.5 $1/$5 replaced by Haiku 5.5 $0.10/$0.50, with the over-100K rate | Vendor pricing. The Sonnet cache-read cut isn't listed because the note gives input/output only |
| Long inputs | "Claude bills flat across its 1M window" now excepts Haiku 5.5's 5x tier. Very large contexts favor the larger Claude models, and Luna over Haiku 5.5 | C5. Without this change the note would be wrong |
| Not listed | added Haiku 4.5 | C1 |
| Footer | 2026-10-08 | brief |

Haiku 5.5 row wording choices:

- **No speed claim.** The previous verification dropped every speed and
  wall-clock claim. The new data conflicts too: AA throughput is high, but
  AA task time at xhigh was slower than Luna's.
- **"Newly released, so this placement rests on thin early evidence"** keeps
  it honest without naming sources.
- **No numbers in the row**, matching the other rows' voice.

## 6. Out of scope, deliberately left out

- Haiku 4.5's 2026-10-15 retirement floor and its legacy label
  (availability, user decision).
- Penetration-testing refusals (O). That's a safeguard/substitution topic,
  excluded.
- Tooling, for tools.md and not models.md:
  - Claude Code 2.1.293 is needed for proper Haiku 5.5 support. The installed
    2.1.286 runs it but reports a 200K context and unknown cost basis.
  - The first-party `haiku` alias now points to Haiku 5.5.
  - Codex 0.161.0 default change.
- Speed and latency figures (see section 5).
- `chat-latest` and the ChatGPT October snapshots. They aren't delegation
  targets.

## 7. For the lead

Contestable calls, most likely to differ from the other synthesizer first:

1. **Haiku 5.5 cost "lowest" vs "low".** "Low" puts it beside Sol, which
   costs 3 to 4x more per task. "Lowest" puts it beside Luna, which is about
   1x to 3x cheaper depending on workload. I chose "lowest, see notes", per
   the reconciliation lesson to keep the column ordering.
2. **Haiku 5.5 execution 2 vs 3** (D2). 3 needs the terminal edge at high
   effort to outweigh AutomationBench and the effort assumption.
3. **Haiku 5.5 depth 2 vs 3** (D1). Same logic.
4. **The Sonnet 5.5 `max` wording** (C7). It is one evaluator's repricing
   plus a vendor claim. Reverting to the old wording is defensible until the
   agentic boards re-measure.

Watch items:

- AA confirming whether its Haiku costs apply the 100K tier.
- An independent Coding Agent Index or Vals Terminal-Bench entry for Haiku
  5.5.
- Agentic-board re-measurement of Sonnet 5.5 after the cache cut.
- Whether cached tokens count toward Haiku's 100K threshold.
