# Model research report: delegation catalog refresh

Author model ID: **claude-opus-5-5**. Date: 2026-10-04.

## Tooling status

- Web search worked throughout.
- Some fetches failed and I carried on without them. openai.com announcement pages returned 403 (GPT-6.1 Sol launch). TechRepublic returned 403. The New Stack's Opus 5.5 vs Fable 5.1 article loaded without its body. The Artificial Analysis Coding Agent leaderboard page loaded without its data rows, and X posts weren't fetched. For those I rely on search-result summaries or mirrors and say so inline.
- My fetch tool summarizes pages through a small model rather than returning raw HTML. Wherever a number matters I cross-checked it against a second page or source. Where I couldn't, I mark it "single fetch".

## Evidence caveats (read before using the numbers)

1. **Most cost-per-task data comes from one source: Artificial Analysis (AA).** That covers the Intelligence Index and the Coding Agent Index. Vals.ai is the only other independent source with cost per task across most of these models, and Epoch AI is the main third for depth. When a claim below rests only on AA, it isn't corroborated, even if several blogs repeat it. Most third-party blogs (OrcaRouter, Kingy, Tess, ExplainX, BenchLM) just relay AA numbers.
2. **AA rescaled its Intelligence Index on 2026-09-07 (v4.3), with a further methodology change on 2026-09-19 (v4.3.2)** [S1]. Pre-v4.3 numbers aren't comparable to current ones. For example, Fable 5.1 was 66 at its 2026-09-01 launch and is 53 now, and Opus 5 was 61 at launch and is 51 now. Any reference text quoting AA scores from before 2026-09-07 is stale. Prefer bands or ranks over raw scores.
3. **The Coding Agent Index composition changed too.** It now covers DeepSWE v1.1, Terminal-Bench 4.0 and SWE-Atlas-QnA. Mirrors label it inconsistently (v1.1, v1.4, v1.5), so treat cross-date comparisons with care [S1][S20].
4. **Harness matters.** Coding Agent Index scores are for model+harness pairs (Claude Code vs Codex), not for models alone.
5. **Vendor and independent figures diverge noticeably.** Opus 5.5 on Terminal-Bench 4.0 is 66.4% per Anthropic [S2], 59.6% per AA [S3] and 65.15% per Vals [S11]. Sonnet 5.5 is 70.6% per Anthropic [S13] and 64.14% per Vals [S12]. OpenAI's GPT-6.1 Sol per-task cost claims ($5.47 vs $23.21 for Opus 5.5 on a science benchmark) don't match AA's ratios. I use independent numbers wherever they exist.
6. **Community signal on the newest models is thin.** GPT-6.1 Sol is 5 days old and Sonnet 5.5 is 6 days old. Most hands-on complaints in OpenAI threads concern GPT-6 Sol, not 6.1.

## Roster changes and status (since 2026-08-05)

| model | status today | source |
| --- | --- | --- |
| claude-fable-5-1 | Active, released 2026-09-01, $10/$50 | [S4][S5] |
| claude-opus-5-5 | Active, released 2026-09-22, $4/$20. Anthropic's recommended default ("start with Opus 5.5 for most workloads") | [S2][S4] |
| claude-sonnet-5-5 | Active, released 2026-09-28, $2/$10 | [S4][S13] |
| claude-haiku-4-5 | Active. Retirement "not sooner than 2026-10-15", no deprecation notice as of 2026-10-04. Anthropic gives at least 60 days' notice, so it is usable until at least early December. Haiku 5.5 is announced but unreleased. | [S5][S21] |
| claude-opus-5, -opus-4-8, -fable-5, -sonnet-5 | Legacy, still callable. Retirement floors run from 2027-05-28 to 2027-07-24. AA's model pages label them "deprecated" in favor of successors, but Anthropic hasn't deprecated them. | [S5][S16][S17][S18] |
| gpt-6-astra | Current flagship, released 2026-09-03, $10/$50 | [S6][S7] |
| gpt-6.1-sol | Current, released 2026-09-29, $2/$10, cached input $0.10 | [S6][S8] |
| gpt-6-sol | Superseded by 6.1 Sol after 7 days. Not in OpenAI's current model list, not yet on the deprecations page. | [S6][S8][S9] |
| gpt-6-luna | Current, released 2026-09-22, $0.10/$0.50 | [S6][S10] |
| gpt-5.6-sol / terra / luna | Not in OpenAI's current model list, and AA marks them deprecated. No shutdown date on OpenAI's deprecations page (latest entry 2026-10-01). | [S6][S9][S19] |

Missing or renamed:
- **GPT-6.1 Astra never shipped.** OpenAI scrapped or delayed it on 2026-09-28 over safety-test results. GPT-6 Astra is unaffected [S22][S23]. Don't add a gpt-6.1-astra row.
- **Still-callable Claude legacy models not on the list:** claude-opus-4-7, -4-6, -4-5 (floor 2026-11-24) and claude-sonnet-4-6. claude-sonnet-4-5 was deprecated 2026-09-30 and retires 2026-11-30 [S5]. None is worth adding, since all are older than models already listed.
- **claude-mythos-5-1** has restricted access [S4], so it isn't a candidate.
- **No new OpenAI tiers were found** beyond those listed. There is no GPT-6 Terra.

## Pricing (per 1M tokens, standard tier)

| model | input / output | cache read | change since 2026-08-05 |
| --- | --- | --- | --- |
| claude-fable-5-1 | $10 / $50 | $0.25 | New. Same list price as Fable 5, but cache reads are 75% cheaper [S4][S24] |
| claude-opus-5-5 | $4 / $20 | $0.20 | New. 20% below Opus 5, cache reads 60% cheaper [S2] |
| claude-sonnet-5-5 | $2 / $10 | $0.20 | New, same as Sonnet 5 [S13] |
| claude-haiku-4-5 | $1 / $5 | $0.10 | No change [S5] |
| claude-opus-5 / 4-8 | $5 / $25 | $0.50 | No change [S2][S17] |
| claude-fable-5 | $10 / $50 | $1.00 | No change [S24] |
| claude-sonnet-5 | $2 / $10 | | No change [S18] |
| gpt-6-astra | $10 / $50 | $1.00 | New [S6][S7] |
| gpt-6.1-sol | $2 / $10 | $0.10 | New. Same as 6 Sol, but the cache discount rises to 95% [S8] |
| gpt-6-sol | $2 / $10 | $0.20 | New [S10] |
| gpt-6-luna | $0.10 / $0.50 | $0.01 | New, about half of GPT-5.6 Luna [S10] |
| gpt-5.6-sol | $4 / $20 promo (list $5 / $30) | $0.40 | Promo since 2026-08-21, "through at least 2026-11-21" [S19] |
| gpt-5.6-terra | $2 / $12 | $0.20 | Cut on 2026-07-30 [S19] |
| gpt-5.6-luna | $0.20 / $1.20 | | Cut on 2026-07-30 [S19] |

All OpenAI GPT-6 models reprice the entire request at 2x input and 1.5x output once input exceeds 272K tokens [S7][S10]. Anthropic has no long-context surcharge on these models [S24]. Batch pricing is 50% off on both vendors.

## Independent cost-to-task data

### AA Intelligence Index v4.3.2: score / cost per task by effort

Source: AA leaderboard and model pages, accessed 2026-10-04 [S3][S14][S16][S17][S18]. All figures are from AA, so this is one source.

| model | low | medium | high | xhigh | max |
| --- | --- | --- | --- | --- | --- |
| claude-opus-5-5 | 42 / $0.55 | 51 / $1.34 | 54 / $1.82 | 56 / $3.46 | 58 / $5.98 |
| claude-sonnet-5-5 | 36 / $0.42 | 41 / $0.59 | 47 / $1.12 | 52 / $2.75 | 56 / $7.67 |
| claude-fable-5-1 | 47 / $2.37 | 49 / $2.98 | 51 / $3.91 | 53 / $5.98 | 53 / $7.63 |
| gpt-6-astra | 46 / $0.82 | 50 / $1.54 | 51 / $1.73 | 52 / $2.31 | 53 / $3.26 |
| gpt-6.1-sol | 42 / $0.13 | 48 / $0.21 | 50 / $0.32 | 51 / $0.39 | 52 / $0.72 |
| gpt-6-luna | 22 / $0.005 | 30 / $0.02 | 33 / $0.03 | 35 / $0.04 | 38 / $0.07 |
| gpt-5.6-terra | 27 / $0.14 | 30 / $0.18 | 34 / $0.34 | 38 / $0.63 | 42 / $1.40 |
| max only: claude-opus-5 51 / $5.86 · claude-fable-5 50 / $8.75 · claude-opus-4-8 42 / $4.08 · claude-sonnet-5 38 / $5.09 · gpt-6-sol 48 / $1.04 · gpt-5.6-sol 47 / $1.99 · gpt-5.6-luna 37 / $0.18 · claude-haiku-4-5 (reasoning) 17 / $0.28 | | | | | |

Output tokens per task at max effort: Sonnet 5.5 ~193k, Opus 5.5 ~119k, Fable 5.1 ~78k, Opus 5 ~73k, GPT-6 Astra ~27k [S3][S15].

Caveats:
- The Fable 5 figure comes from a June-dated page and may predate v4.3 [S16].
- AA's Sonnet 5.5 run was on a pre-release deployment with a structured-output bug that Anthropic says is fixed. AA said it would re-run the affected evaluations [S15].
- A secondary source quotes Haiku 4.5 at $0.21 per task rather than $0.28 [S25].

### AA Coding Agent Index (agentic coding, model+harness)

This is the closest available proxy for a typical delegated coding job. Data rows didn't load from AA directly, so the numbers come via AA's posts as relayed by search summaries, OrcaRouter, and BenchLM's 2026-10-02 mirror [S20][S26][S27].

| agent | score | cost/task | time/task |
| --- | --- | --- | --- |
| Claude Code + Sonnet 5.5 (max) | 68 | $14.19 | n/a |
| Claude Code + Opus 5.5 (max) | 66 | $13.04 (Opus 5 was $10.79) | ~1.1 h |
| Claude Code + Sonnet 5.5 (xhigh) | 62.9 | n/a | n/a |
| Codex + GPT-6.1 Sol (xhigh) | 63 | $1.04 | n/a |
| Codex + GPT-6.1 Sol (max) | 60 | n/a | n/a |
| Codex + GPT-6 Astra (max) | 62 | $7.09 to $7.47 | ~29 min |
| Claude Code + Fable 5.1 | 62 | not found. AA says Astra matches it "at ~60% of the cost", which would put Fable around $12 (my inference) | n/a |
| Codex + GPT-6 Sol (max) | 57 | $2.99 | ~22 min |

On this index, Opus 5.5 at max used 15.6M tokens per task (333k output), against 11.4M (137k output) for Opus 5 [S26]. That's why its cost per task rose 21% despite cheaper tokens.

### Vals Index v2.1 (independent, updated 2026-10-02) [S11]

| model | accuracy | cost/test | latency |
| --- | --- | --- | --- |
| Claude Sonnet 5.5 | 67.04% | $21.34 | 1h18m |
| Claude Opus 5.5 | 66.97% | $32.14 | 1h19m |
| Claude Fable 5.1 | 65.83% | $28.71 | 1h17m |
| Claude Opus 5 | 63.67% | $19.31 | 58m |
| GPT-6 Astra | 63.13% | $18.46 | 28m |
| GPT-6.1 Sol | 61.15% | $3.24 | 43m |
| GPT-5.6 Sol | 58.01% | $14.24 | 37m |
| GPT-6 Sol | 57.54% | $7.58 | 29m |
| GPT-5.6 Terra | 53.09% | $5.78 | 36m |
| Claude Sonnet 5 | 51.77% | $13.72 | 54m |
| GPT-5.6 Luna | 51.69% | $0.82 | 29m |
| GPT-6 Luna | 51.22% | $0.43 | 31m |

Haiku 4.5, Opus 4.8 and Fable 5 aren't on the current Vals board. Vals ran GPT-6.1 Sol at max effort [S12b].

## What the data says, by axis

### Cost-to-task (inference from the tables above)

- **Sticker price misleads in both directions.**
  - Sonnet 5.5 costs half of Opus 5.5 per token, yet on AA's Intelligence Index Opus 5.5 is cheaper at every matched score. Opus high scores 54 for $1.82, while Sonnet xhigh scores 52 for $2.75. Opus xhigh scores 56 for $3.46, while Sonnet max scores 56 for $7.67.
  - The other independent sources disagree. On Vals, Sonnet 5.5 is ~1/3 cheaper than Opus 5.5 for equal accuracy. On the Coding Agent Index the two are roughly at cost parity at max.
  - So I'd treat Sonnet 5.5 as Opus-class quality at roughly Opus-class task cost, not half. Its per-token discount is eaten by verbosity, worst at max (193k output tokens per task, the highest AA has measured [S15]).
- **GPT-6.1 Sol is the cost-to-task outlier.**
  - It's 4 to 8x cheaper per task than Opus 5.5 on AA, ~10x cheaper on Vals, and ~12x cheaper on the Coding Agent Index.
  - It trails by 2 to 6 points on AA, about 6 points on Vals, and 3 to 5 points on the Coding Agent Index.
  - At low effort it scores the same as Opus 5.5 low (42) for a quarter of the cost [S14].
- **GPT-6 Astra has a high sticker price but is token-frugal** (~27k output tokens per task).
  - On AA it's cheaper per task than every Claude model at max.
  - It's dominated by GPT-6.1 Sol (52 for $0.72 vs 53 for $3.26) and by Opus 5.5 xhigh (56 for $3.46).
- **Fable 5.1 is the most expensive per task everywhere and isn't top on any independent aggregate.**
  - Firecrawl's 57-run measurement found 1.1 to 1.4x more output tokens than Fable 5, with a 15 to 30% real bill reduction only on cache-heavy agentic builds. AA measured an 18 to 20% higher cost per task than Fable 5 [S24].
- **Effort is as big a lever as model choice.**
  - Opus 5.5 rises from $0.55 to $5.98 across its effort range, for 42 to 58 points.
  - On the Coding Agent Index, Opus 5.5 at max effort burns 2.4x the output tokens of Opus 5 [S26].

### Depth (hard, ambiguous, novel problems)

- **GPT-6 Astra has the strongest independent signal on novel math and reasoning.**
  - Epoch's FrontierMath Tier 4 has Astra at 98%, Opus 5.5 at 95% and Fable 5.1 at 88%. Tiers 1-3 are 94 / 91 / 90 [S28].
  - Astra was the only model to solve any of the 68 open FrontierMath Erdős problems: 2 on the official run, 5 with retries at over $220k of compute. Others solved none [S29].
  - It scored 62.7% on ARC-AGI-3 under the standard harness, against Opus 5's 30.2% [S30]. Opus 5.5 and Fable 5.1 have no ARC-AGI-3 score.
  - Caveat: OpenAI funded FrontierMath and has access to part of it [S29].
- **Opus 5.5 leads Epoch's overall Capabilities Index**, 167.35 vs Astra 166.51 with overlapping intervals (as of ~2026-10-02) [S28][S29].
  - It leads strongly on software: MirrorCode 77% vs Astra 47% [S28].
  - It also tops AA's index, HLE (61.4%) and SciCode (66.9%) [S3].
- **Fable 5.1 has no independent case as the "deepest" model.**
  - Anthropic positions it as the escalation for "demanding reasoning" when Opus 5.5 at xhigh or max falls short [S4] (vendor).
  - Independent data puts it below Opus 5.5 on nearly everything: AA, Epoch FrontierMath, Mystery Game Puzzles and MirrorCode [S28].
  - Its residual edges are narrow:
    - knowledge recall (SimpleQA, a 24-point lead over Sonnet 5.5 per Epoch [S31])
    - small leads at API-default settings on GDPval-AA, HLE and CritPt [S32]. These are confounded because Fable defaults to high effort and Opus to medium.
    - fewer tokens at max than Opus 5.5 (78k vs 119k) [S3]
- **Sonnet 5.5 ties Fable 5.1 on Epoch's index at 165**, from fewer evaluations (11 vs 20) [S31]. It trails Opus 5.5 by ~6 points on HLE and SciCode on AA [S15].
- **Community color on Opus 5.5**, from a single source each:
  - Every.to rates it about 90% as capable as Fable at coding [S33].
  - The New Stack's headline on the pair is "one overthinks, the other cuts corners". I couldn't read the body [S34].

### Execution (long agentic or terminal loops)

- **Claude models top the agentic-coding scores** (Coding Agent Index 66 to 68, Terminal-Bench 4.0 on AA and Vals). They're also slow:
  - Vals latency is ~78 min for Opus 5.5, Sonnet 5.5 and Fable 5.1, against 28 min for Astra and 43 min for 6.1 Sol [S11].
  - Coding Agent Index time is ~1.1 h for Opus 5.5 vs ~29 min for Astra [S20].
- **Opus 5.5 tends to run long without a hard bound.** Every.to describes a single prompt running 1h52m, and a timeboxed task that ran out the clock on side work [S33]. Simon Willison saw it hit the 128k output cap twice at max [S32] (single fetch). For headless delegation this argues for xhigh or lower plus explicit scope and time limits.
- **GPT-6.1 Sol in Codex** scores 63 at ~$1/task, and xhigh beats max by 3 points [S8][S27]. Practitioner advice converges on: Sol for many parallel, well-scoped tasks, and Opus 5.5 where a failed run costs more than the tokens [S35] (secondary, unverified).
- **GPT-6 Astra in Codex** has mixed reviews.
  - Endor Labs measured it near Claude Code + Fable 5.1 on pass rate, but slower: 16.8 min per task vs 9.5 min, with 29 timeouts [S36].
  - Practitioners report overthinking on small tasks and some still prefer GPT-5.6 Sol for everyday software engineering [S36].
  - It's better on hard cross-file bugs: 57.1% vs 47.6% actionable bug coverage against 5.6 Sol [S36].
- **GPT-6 Sol was widely reported as a regression vs GPT-5.6 Sol** on code review and refactoring, which is the stated reason 6.1 followed within a week. Users found Opus 5.5 code had fewer high-severity bugs than 6 Sol code [S35].

### Cheap tier

- **GPT-6 Luna dominates Haiku 4.5 on independent data.**
  - AA scores Luna 37-38 at $0.07 per task against Haiku's 17 at $0.21 to $0.28 [S14][S25].
  - Luna has a 1.05M context window vs Haiku's 200K.
- **GPT-6 Luna vs GPT-5.6 Luna:** on Vals the two are tied (51.2 vs 51.7) at half the cost for 6 Luna [S11].
- **Haiku 4.5 is only worth listing as a Claude-only fallback.**

## Dominated models (my recommendation: drop from the catalog)

On independent data, each of these is beaten on both score and cost by a sibling at the same vendor:

| drop | dominated by | evidence |
| --- | --- | --- |
| gpt-6-sol | gpt-6.1-sol (same price, higher score, cheaper per task on AA and Vals) | [S8][S11][S14] |
| gpt-5.6-sol | gpt-6.1-sol (AA 47/$1.99 vs 52/$0.72, Vals 58.0/$14.24 vs 61.2/$3.24) | [S11][S14][S19] |
| gpt-5.6-terra | gpt-6.1-sol (AA max 42/$1.40 vs high 50/$0.32) | [S3][S11] |
| gpt-5.6-luna | gpt-6-luna (AA 37/$0.18 vs 38/$0.07) | [S11][S14] |
| claude-fable-5 | claude-fable-5-1 (same price, higher score) and Opus 5.5 | [S3][S16] |
| claude-opus-4-8 | claude-opus-5-5 (AA 42/$4.08 vs 54/$1.82 at high) | [S3][S17] |
| claude-sonnet-5 | claude-sonnet-5-5 (AA 38/$5.09 vs 47/$1.12 at high) | [S3][S18] |

Borderline cases:
- **claude-opus-5.** It's beaten by Opus 5.5 on AA. On Vals it's ~40% cheaper per test for 3.3 fewer points, and it was cheaper per task than Opus 5.5 at max on the Coding Agent Index. Firecrawl recommends Opus 5 over Fable 5.1 for tightly specified tasks because it's faster [S24].
  - There's also a scope-adjacent reason that I flag but don't argue, since the brief excludes substitution topics. Opus 5.5 and Sonnet 5.5 hand most cybersecurity requests to Opus 4.8, and biology and frontier-model-development requests to Opus 5. On the raw API without a fallback configured, the request comes back with empty content [S37][S38]. A delegator sending security work to a Claude model may want an explicit non-5.5 option. Whether the catalog covers that is the writer's call.
- **claude-fable-5-1.** Keep it, but only as an escalation rung, not a default.

## How I would choose (recommendation)

My working rule is to pick the cheapest model that clears the bar, and raise effort before you switch models. Ordered by how often each case comes up in delegation:

1. **Well-specified execution** (implement to a spec, fix tests, migrations with clear acceptance, bulk edits, parallel fan-out): **gpt-6.1-sol, at medium for simple work and xhigh for coding** (not max). It's roughly 1/10th of Claude's cost per task at 3 to 6 points lower, and faster wall-clock. Confidence: moderate. The independent numbers are solid, but hands-on experience is only 5 days old.
2. **Ambiguous or quality-critical engineering** (design-heavy changes, large refactors, code review where misses are costly, unclear requirements): **claude-opus-5-5 at high or xhigh.** It leads every independent aggregate and is strongest on software (MirrorCode, Coding Agent Index). Reserve max for when xhigh fails, because max roughly doubles cost for ~2 points and runs long.
3. **Hard novel reasoning** (math, proofs, puzzles, research questions with no known path): **gpt-6-astra**, with claude-opus-5-5 at max as an independent second attempt. Astra has the clearest independent lead on novel math (FrontierMath T4, Erdős, ARC-AGI-3) and is token-frugal, so its cost per task is moderate despite the $10/$50 sticker.
4. **Escalation when Opus 5.5 fails, or knowledge-recall-heavy work:** **claude-fable-5-1.** This rests mostly on vendor positioning plus narrow independent edges. It's the most expensive per task and slowest.
5. **Sonnet 5.5:** I'd present it as Opus-class at similar task cost, not as the budget Claude.
   - Use it at high or xhigh when its speed (95-130 t/s vs 70-90) matters, or as a stand-in for Opus 5.5.
   - Avoid max, which produces 193k output tokens per task.
   - The independent sources disagree on whether it beats Opus 5.5 on cost (Vals yes, AA no). That deserves a re-check after AA re-runs the bug-affected evaluations.
6. **Cheap high-volume subtasks** (classification, extraction, summarizing, simple lookups): **gpt-6-luna.** Use claude-haiku-4-5 only when the delegation must stay on Claude.
7. **When wall-clock matters:** prefer OpenAI models. Claude's top models run ~2 to 3x longer per task on Vals and the Coding Agent Index.
8. **Cross-checking:** pair across vendors (Opus 5.5 with GPT-6.1 Sol or Astra) rather than within one. Their independent strengths differ (Claude on software and agentic work, Astra on math and puzzles), so their errors are less correlated. This last point is my inference, not something a source shows.

## How I'd organize the reference (recommendation to the writer)

1. **A short roster table** of about 8 models, not 15:
   - Claude: Opus 5.5, Sonnet 5.5, Fable 5.1, Haiku 4.5, plus Opus 5 if the writer keeps it
   - OpenAI: GPT-6.1 Sol, GPT-6 Astra, GPT-6 Luna

   Columns:
   - role (default executor / quality default / deep reasoning / escalation / cheap)
   - **depth** and **execution** as relative 1-3 ratings, not raw scores. Indexes rescale (the AA v4.3 rescale silently invalidated every pre-September number).
   - **cost-to-task band** (for example $ <$0.50, $$ $0.50-3, $$$ >$3 per representative task), anchored to one named benchmark and effort
   - **wall-clock band**
   - **recommended effort** and an effort to avoid (Sonnet 5.5 max, GPT-6.1 Sol max for coding)
   - one-line caveat
2. **A decision guide** of 6-8 "if the task is X, use Y at effort Z, escalate to W" lines, like the list above. This is what a delegating agent actually reads at spawn time.
3. **An effort note.** Effort moves cost 5 to 10x within a model, as much as switching models does. Give the per-model default (Opus 5.5 is medium on the API, Fable 5.1 and Sonnet 5.5 are high on the API, Sonnet 5.5 is medium in Claude Code [S4][drift report]) and the sweet spot.
4. **A "not listed and why" line** for dropped models (dominated, superseded, restricted, never shipped), so a future refresh doesn't re-add them.
5. **Provenance footer:** as-of date, the three independent sources the ratings rest on (AA, Vals, Epoch), and a note that most cost-per-task data is from AA alone.

Avoid embedding raw benchmark numbers in the skill reference. They churn weekly and differ by harness. Keep them in this casebook instead.

## Sources

I = independent, V = vendor, S = secondary (third party relaying another source). Dates are publication dates where shown, otherwise the access date (2026-10-04).

- [S1] AA changelog, https://artificialanalysis.ai/changelog. Entries 2026-08-20, 2026-09-07, 2026-09-19. I.
- [S2] Anthropic, Introducing Claude Opus 5.5, https://www.anthropic.com/claude-opus-5-5. 2026-09-22. V.
- [S3] AA, Claude Opus 5.5 article, https://artificialanalysis.ai/articles/claude-opus-5-5. 2026-09-22. Also AA leaderboard https://artificialanalysis.ai/leaderboards/models and comparison https://artificialanalysis.ai/models/releases/comparisons/gpt-6-1-sol-vs-claude-opus-5-5, both accessed 2026-10-04. I.
- [S4] Anthropic, Models overview, https://platform.claude.com/docs/en/about-claude/models/overview, accessed 2026-10-04. Fable 5.1 announcement https://www.anthropic.com/claude-fable-and-mythos-5-1, 2026-09. V.
- [S5] Anthropic, Model deprecations, https://platform.claude.com/docs/en/about-claude/model-deprecations. Latest entry 2026-09-30. V.
- [S6] OpenAI, API models list, https://developers.openai.com/api/docs/models, accessed 2026-10-04. V.
- [S7] GPT-6 Astra pricing and launch as relayed by Developers Digest, https://www.developersdigest.tech/blog/gpt-6-astra-release-guide-2026 (2026-09), and AA [S14b]. S/V.
- [S8] AA, GPT-6.1 Sol replaces GPT-6 Sol after just 7 days, https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence. ~2026-09-30. I. Pricing also from https://thenextweb.com/news/openai-gpt-6-1-sol-price-astra-devday (2026-09-29), S.
- [S9] OpenAI, Deprecations, https://developers.openai.com/api/docs/deprecations. Latest entry 2026-10-01. V.
- [S10] The New Stack, OpenAI releases GPT-6 Sol and Luna, https://thenewstack.io/openai-gpt-6-sol-luna-release/ (~2026-09-22), via search summary. Also https://kingy.ai/blog/gpt-6-sol-luna-specs-benchmarks-pricing-comparison/. S, vendor numbers.
- [S11] Vals Index v2.1 leaderboard, https://www.vals.ai/benchmarks/vals_index. Updated 2026-10-02. I. Opus 5.5 page https://www.vals.ai/models/anthropic_claude-opus-5-5. I.
- [S12] Vals, Sonnet 5.5 page, https://www.vals.ai/models/anthropic_claude-sonnet-5-5. [S12b] Vals, GPT-6.1 Sol page, https://www.vals.ai/models/openai_gpt-6.1-sol. Both accessed 2026-10-04. I.
- [S13] MarkTechPost, Sonnet 5.5 release, https://www.marktechpost.com/2026/09/28/anthropic-releases-claude-sonnet-5-5-70-6-on-terminal-bench-4-0-at-the-same-2-10-price/. 2026-09-28. S, vendor numbers.
- [S14] AA leaderboard (per-effort rows), https://artificialanalysis.ai/leaderboards/models, accessed 2026-10-04. [S14b] AA, Benchmarking GPT-6 Astra, https://artificialanalysis.ai/articles/benchmarking-gpt-6-astra, 2026-09-09. Both I.
- [S15] AA on Sonnet 5.5 (X post, via search summary), https://x.com/ArtificialAnlys/status/2104640155843989864. ~2026-09-28. I. Not fetched directly.
- [S16] AA, Claude Fable 5 page, https://artificialanalysis.ai/models/claude-fable-5. Data dated June 2026. I.
- [S17] AA, Claude Opus 4.8 page, https://artificialanalysis.ai/models/claude-opus-4-8. AA, Opus 5 release page, https://artificialanalysis.ai/models/releases/claude-opus-5. Both accessed 2026-10-04. I.
- [S18] AA, Claude Sonnet 5 page, https://artificialanalysis.ai/models/claude-sonnet-5. AA, GPT-6 Sol page, https://artificialanalysis.ai/models/gpt-6-sol. Both accessed 2026-10-04. I.
- [S19] GPT-5.6 pricing history: CloudZero https://www.cloudzero.com/blog/gpt-5-6-pricing/ and Layer3Labs https://www.layer3labs.io/guides/gpt-5-6-pricing, undated, via search summary. AA GPT-5.6 Sol page https://artificialanalysis.ai/models/gpt-5-6-sol and GPT-5.6 Luna page https://artificialanalysis.ai/models/gpt-5-6-luna, accessed 2026-10-04 (consistent $4/$20 and $0.20/$1.20). S/I.
- [S20] Coding Agent Index time and cost figures (Astra $7.47 / 29.4 min, GPT-6 Sol $2.99 / 22.3 min, Opus 5.5 $13.00 / 1.1 h, "checked Sept 28"), relayed via search summary of OrcaRouter, https://www.orcarouter.ai/blog/gpt-6-astra-codex. Undated. S. Not verified against AA directly.
- [S21] Haiku 4.5 retirement analysis, https://www.orcarouter.ai/blog/claude-haiku-5-5-leak and https://qcode.cc/en/claude-haiku-5-5-status-tracker, ~2026-09-28, via search summary. S. Consistent with [S5].
- [S22] GIGAZINE, https://gigazine.net/gsc_news/en/20260929-openai-abandons-plan-to-release-gpt-6-1-astra/. 2026-09-29. I (news).
- [S23] Yahoo Finance, https://finance.yahoo.com/technology/ai/articles/openai-one-fifth-pricing-move-075503685.html. 2026-09-30. I (news).
- [S24] Firecrawl, Is Fable 5.1 cheaper than Fable 5?, https://www.firecrawl.dev/blog/is-fable-5-1-cheaper-than-fable-5. 2026-09-07. I.
- [S25] Haiku 4.5 vs GPT-6 Luna: https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning (accessed 2026-10-04, I), and https://www.orcarouter.ai/blog/gpt-6-luna-vs-claude-haiku-4-5 (undated, S).
- [S26] OrcaRouter, Claude Opus 5.5 tops Coding Agent Index at 66 as cost rises, https://www.orcarouter.ai/blog/claude-opus-5-5-coding-agent-index. ~late 2026-09. S relaying AA.
- [S27] BenchLM mirror of AA Coding Agents, https://benchlm.ai/benchmarks/aacodingagents. Snapshot 2026-10-02. S. The AA post of 2026-10-02 (https://x.com/ArtificialAnlys/status/2105814318294114720) came via search summary.
- [S28] Epoch AI, Claude Opus 5.5 model page, https://epoch.ai/models/claude-opus-5-5. Accessed 2026-10-04. I.
- [S29] Epoch data insight, GPT-6 Astra leads on math but not on software engineering, https://epoch.ai/data-insights/astra-eci-breakdown (2026-09). TechJack on the Erdős results, https://techjacksolutions.com/ai-brief/epoch-ai-frontiermath-erdos-gpt6-astra-results/. Both via search summary. I/S.
- [S30] ARC-AGI-3 results, https://arcprize.org/results and https://benchlm.ai/benchmarks/arcagi3 (as of 2026-09-29), via search summary. I/S.
- [S31] OrcaRouter, Claude Sonnet 5.5 ties Fable 5.1 on the Epoch index, https://www.orcarouter.ai/blog/claude-sonnet-5-5-epoch-capabilities-index. Undated. S relaying Epoch.
- [S32] Opus 5.5 vs Fable 5.1 comparisons (AA defaults, Simon Willison anecdote), https://www.lindy.ai/blog/opus-5-5-vs-fable-5-1 and https://aivy.com.au/resources/claude-opus-5-5-vs-fable-5-1/, via search summary. ~2026-09/10. S.
- [S33] Every, Vibe Check: Opus 5.5, https://every.to/vibe-check/vibe-check-opus-5-5-is-pulling-our-codex-converts-back-to-claude. 2026-09-22. I (hands-on).
- [S34] The New Stack, Claude Opus 5.5 vs. Fable 5.1, https://thenewstack.io/claude-opus-5-5-vs-fable-5-1/. Body not retrievable. I.
- [S35] Hacker News threads, https://news.ycombinator.com/item?id=49906669 and https://news.ycombinator.com/item?id=49897054. ~2026-09-23 to 10-01. I (community). Practitioner split advice via https://www.datacamp.com/blog/gpt-6-1-sol-vs-opus-5-5, S.
- [S36] Endor Labs, https://www.endorlabs.com/learn/gpt-6-astra-on-codex---the-biggest-codex-leap-to-date, 2026-09, I. OrcaRouter Astra in Codex [S20], S. Both via search summary.
- [S37] Mixed News, Opus 5.5 sends most cybersecurity work to Opus 4.8, https://mixed-news.com/en/claude-opus-5-5-cybersecurity-reroute-opus-4-8-safeguards/. ~2026-09-22. I (news) on vendor policy.
- [S38] Jahanzaib, Claude Opus 5.5 fallback: what your agent gets back, https://www.jahanzaib.ai/blog/claude-opus-5-5-fallback-model-cyber-safeguards. Undated. S (single developer's account).
- Dreasays, Claude 5.5 is brilliant, confusing, and very hungry, https://dreasays.substack.com/p/claude-55-is-brilliant-confusing. 2026-09-29. I (commentary). Used for Sonnet 5.5 token appetite and the effort advice, consistent with [S15].
