# Verification report

Verifier model ID: `claude-sonnet-5-5`
Date checked: 2026-10-08
Draft: `/tmp/verify.XkpL/claude-sonnet-5-5/models-draft.md`

Web search worked. Fetch mostly worked. Failures: marktechpost.com returned 403, and `artificialanalysis.ai/models/claude-sonnet-5-5-max` returned 404. WebFetch passes pages through a small summarizing model, so numbers from fetches are only as good as that summary. Where it mattered I fetched twice with different prompts.

Short version: two items need attention before shipping. (1) The Sonnet vs Opus "at `max`" cost claim has conflicting evidence, and AA's live page may have made it stale. (2) "behind on tool-driven workflows" for Haiku rests on one provisional benchmark. Everything else in scope holds, with a few wording nits.

Abbreviations: AA = Artificial Analysis (independent). "Docs" = platform.claude.com (vendor). CC docs = code.claude.com (vendor).

## Verdict table

| # | Claim (scope item) | Verdict | Source |
| --- | --- | --- | --- |
| 1 | `claude-haiku-5-5` is a current model ID | HOLDS | Docs models overview and Haiku 5.5 page, released 2026-10-07, "Latest", retirement not before 2027-10-07 (vendor). AA, VentureBeat, 9to5Mac confirm the ID/release (independent) |
| 2 | Haiku 5.5 sticker $0.10/$0.50 per M | HOLDS | Docs pricing page (vendor); VentureBeat 2026-10-07, AA article 2026-10-07 (independent) |
| 3 | Haiku 5.5 $0.50/$2.50 for prompts over 100K, i.e. "5x per token" | HOLDS | Docs pricing (vendor): 0.50/0.10 = 5x input, 2.50/0.50 = 5x output, cache read 0.05/0.01 = 5x. AA article states "rises 5x" (independent) |
| 4 | Over 100K, the *whole request* is billed at the higher rate | HOLDS (reading is mostly vendor-based) | Docs: "a prompt of over 100,000 tokens pays higher prices", two full price rows. Independent worked examples: roo.beehiiv.com and kingy.ai (both read it as whole-request, $0.011 to $0.055 at 100,001 tokens). Anthropic does not spell out "whole request" in so many words |
| 5 | "A long session's growing transcript can cross that" | HOLDS | Follows from 1M window plus per-prompt tiering (Docs). Reasoning, not a measured fact |
| 6 | Haiku 5.5 is "the cheap Claude" and use cases: extraction, classification, summaries, triage | HOLDS | Anthropic launch page and Docs overview: "high-volume, latency-sensitive tasks such as classification, extraction, and routing", summaries (vendor) |
| 7 | "small well-specified edits" as a Haiku use case | UNSUPPORTED (minor) | Docs mention "subagent tasks", and coding benchmarks exist, but no source says "small well-specified edits". Reads as advice |
| 8 | Haiku 5.5 "about level with GPT-6 Luna overall" | HOLDS loosely, see detail A | AA Intelligence Index (independent, 2026-10-07/08): Haiku 43 vs Luna 38 at max, 34 vs 30 at medium, 39 vs 37 at high. Haiku leads at every effort level |
| 9 | "ahead on terminal tasks at `high` and above" | PARTLY UNSUPPORTED, see detail B | AA: Terminal-Bench 4.0 Haiku (max) 32.8% vs Luna (max) 12.6% (independent). Anthropic: 39.2% vs 16.4% (vendor). I found no Haiku vs Luna terminal numbers at `high` or `xhigh` |
| 10 | "behind on tool-driven workflows" | UNSUPPORTED / contested, see detail C | Only AutomationBench-AA: Haiku 35.4% vs Luna 53.2% (AA, independent), which AA flags as likely understated by a pre-release over-refusal bug |
| 11 | "often dearer per task because it writes more tokens" | HOLDS (understated) | AA cost per task, Haiku vs Luna: low $0.02/$0.0045, medium $0.05/$0.02, high $0.08/$0.03, xhigh $0.12/$0.04, max $0.21/$0.07. Output tokens at max about 162K vs 50K (AA, independent). Dearer at every effort level in AA's data, not just "often" |
| 12 | `medium` for routine work, `high` for longer tool sequences | HOLDS (as advice) | Docs effort page, Haiku 5.5 section: start with `medium`, `high` for "longer agent tasks" (vendor) |
| 13 | Beyond `high`, "its token use climbs steeply" | HOLDS | AA: high about 55K tokens per task, max about 162K, "xhigh to max adds 2 points for about 1.8x the tokens" (independent) |
| 14 | "step up to 6.1 Sol or Sonnet 5.5 instead" | HOLDS (as advice) | Docs effort page tells readers to compare `xhigh`/`max` with Sonnet 5.5 (vendor). AA: Sol (Low) 42 at $0.13/task beats Haiku (max) 43 at $0.21 (independent) |
| 15 | Haiku 5.5 is newly released | HOLDS | Released 2026-10-07 (Docs, AA, VentureBeat) |
| 16 | Sonnet 5.5 row: cost vs Opus 5.5 is lower below `max` | HOLDS | AA cost per task, Sonnet vs Opus: low $0.41/$0.55, medium $0.59/$1.34, high $1.08/$1.82, xhigh $2.74/$3.46 (launch-era, via beri.net citing AA 2026-09-28). AA's current comparison page shows Sonnet lower at every level too (different numbers, see 17) |
| 17 | Sonnet 5.5 at `max` costs "about the same or more" than Opus 5.5 | CONFLICTED, possibly STALE, see detail D | Launch-era AA: Sonnet $7.60 vs Opus $5.98 (27% more). AA's live comparison page today (two fetches): Sonnet $5.46 vs Opus $5.98 (9% less) |
| 18 | Starting-choices bullet: Luna or Haiku 5.5 for cheap, bounded, checkable work | HOLDS (with nit, see detail E) | Both are priced $0.10/$0.50 (Docs, OpenAI pricing). AA shows Haiku about 3x Luna per task |
| 19 | Effort defaults: Opus 5.5, Sonnet 5.5, Haiku 5.5 start at `medium` in Claude Code | HOLDS (vendor only) | CC docs model-config: "Opus 5.5, Sonnet 5.5, and Haiku 5.5 default to `medium`". Anthropic Sonnet 5.5 launch page: "In Claude Code and our apps, the default effort is set to Medium, while the Claude Platform defaults to High." Docs effort page: Haiku 5.5 `medium` "on the Claude API and in Claude Code" |
| 20 | Fable 5.1 starts at `high` in Claude Code | HOLDS (vendor only) | CC docs: `high` on every model except the 5.5 trio (and Opus 4.7 `xhigh`). Docs effort page: Fable 5.1 default `high` |
| 21 | Cost-to-task bullet: "Haiku 5.5 at `max` costs more per task than 6.1 Sol at `low` for about the same quality" | HOLDS | AA: Sol (Low) index 42, $0.13/task (AA comparison page, independent). Haiku (max) index 43, $0.21/task (AA Haiku vs Luna page, independent) |
| 22 | Cost-to-task bullet, rest (Opus/Sonnet emit 4-10x Astra's output tokens at `max`, so Astra costs less per task) | NOT RECHECKED | Outside the new text, verified 2026-10-04. But see detail D: if Sonnet's `max` cost really fell, recheck the Sonnet half of this sentence |
| 23 | Sticker prices: Fable 5.1 and Astra $10/$50 | HOLDS | Docs pricing (vendor); OpenAI pricing page (vendor) |
| 24 | Opus 5.5 $4/$20 | HOLDS | Docs pricing |
| 25 | Sonnet 5.5 and 6.1 Sol $2/$10 | HOLDS | Docs pricing; OpenAI pricing page |
| 26 | Haiku 5.5 and 6 Luna $0.10/$0.50 | HOLDS | Docs pricing; OpenAI pricing page; VentureBeat |
| 27 | Haiku 5.5 $0.50/$2.50 over 100K tokens | HOLDS | Docs pricing |
| 28 | Sonnet 5.5 cache reads $0.10 | HOLDS | Docs pricing (0.05x of $2 base). Vendor only |
| 29 | Long inputs: codex models bill the whole request at 2x input, 1.5x output once input passes 272K | HOLDS | OpenAI pricing page (vendor): Astra $10/$50 to $20/$75, Sol $2/$10 to $4/$15, Luna $0.10/$0.50 to $0.20/$0.75; "entire request" over 272K. VentureBeat and orcarouter agree on the 272K threshold (independent) |
| 30 | Claude models bill flat across their 1M window, except Haiku 5.5 | HOLDS | Docs pricing, long context section: "Claude 4.6 and later models (except Claude Haiku 5.5) ... include the full 1M token context window at standard pricing" (vendor only) |
| 31 | Haiku 5.5 bills the whole request at 5x once the prompt passes 100K | HOLDS | See rows 3 and 4 |
| 32 | "So very large contexts favor the larger Claude models on cost, and Luna over Haiku 5.5" | HOLDS | Arithmetic from rows 24-31. Above 272K and 100K respectively: Opus $4/$20 vs Astra $20/$75, Sonnet $2/$10 vs Sol $4/$15, Luna $0.20/$0.75 vs Haiku $0.50/$2.50. AA does not yet model the 5x step in its cost-per-task (AA, independent), so per-task evidence is thin |
| 33 | "Not listed" bullet: Haiku 4.5 is still callable | HOLDS | Docs models overview lists Haiku 4.5 under "Legacy models (still available)"; pricing page lists it with no retirement tag |
| 34 | Haiku 4.5 is superseded by Haiku 5.5, which is better, cheaper, or both | HOLDS | Docs pricing: Haiku 4.5 $1/$5 vs Haiku 5.5 $0.10/$0.50 (or $0.50/$2.50 over 100K, still half). Anthropic: about 75% cheaper per workload including tokenizer change. AA: index up 26 points (Haiku 5.5 at 43), Terminal-Bench 33% vs 0% for Haiku 4.5 (independent). Haiku 5.5 is also "Latest" in Docs |

## Details for anything not HOLDS

### A. "About level with GPT-6 Luna overall" (row 8)
Not wrong, but it undersells. AA (independent, 2026-10-07/08, `artificialanalysis.ai/models/releases/comparisons/claude-haiku-5-5-vs-gpt-6-luna`) has Haiku ahead at every effort: low 29 vs 22, medium 34 vs 30, high 39 vs 37, xhigh 41 vs 38, max 43 vs 38. A 2 to 7 point lead is "slightly ahead", not "level". Suggest "slightly ahead overall" (the similar-priced, similar-rated framing in the table is still fair).

### B. "Ahead on terminal tasks at `high` and above" (row 9)
The threshold "`high` and above" has no source. The only Haiku vs Luna terminal data I found are at max (AA: 32.8% vs 12.6%; Anthropic launch: 39.2% vs 16.4%, effort unstated). Anthropic's launch material (via roo.beehiiv.com) also gives about 20% for Haiku at medium vs Luna's 16.4%, which hints at a small lead even at medium, but Luna's effort setting for that number is not stated. Suggest "ahead on terminal tasks" with no effort threshold, or cite only max.

### C. "Behind on tool-driven workflows" (row 10)
The only evidence is AutomationBench-AA (Haiku 35.4% vs Luna 53.2%, Gemini 3.8 Flash and GLM-5.3 Flash 53-60%). AA says the score is likely understated: "During pre-release testing, a safety refusal issue caused the model to over-refuse. Anthropic is working on resolving this", and expects a re-run (AA article 2026-10-07; latent.space 2026-10-08 summarizing AA). Anthropic's own system card does report Haiku over-refusing more than any other model in its automated behavioral audit. Meanwhile the other agentic results go the other way: OSWorld 2.1 72.4% vs 48.9% (vendor-reported), Terminal-Bench as above. One provisional benchmark does not support a general "behind on tool-driven workflows". Recommend dropping it or narrowing to "trailed on AutomationBench-AA at launch". Also, the draft's own "Newly released, so ... thin early evidence" sentence is the right instinct, but see the leak flags below.

### D. Sonnet 5.5 vs Opus 5.5 cost at `max` (rows 16, 17)
Conflicting evidence, and I could not resolve it with certainty.
- Launch-era numbers, repeated by many secondary sites and traced to AA (2026-09-28/29): Sonnet 5.5 max $7.60 per task (index 56, about 193K output tokens per task, "the highest Output Tokens per Task we have measured"), Opus 5.5 max $5.98 (index 58, about 119K). Sources: beri.net (2026-09 citing AA), codersera, emergent.sh, tess.im, pulse.adyog.com, AA changelog entry for the token-count remark. One site (aiwiz.uk) reports AA later nudged it to $7.62. Under these numbers the draft's "about the same or more" is right (27% more).
- AA's live comparison page (`artificialanalysis.ai/models/releases/comparisons/claude-sonnet-5-5-vs-claude-opus-5-5`, fetched twice today) shows a table with Sonnet 5.5 cheaper at every level: max $5.46 (Opus $5.98), xhigh $2.01 (Opus $3.46), high $0.88 (Opus $1.82), medium $0.48 (Opus $1.34), low $0.35 (Opus $0.55). Those Sonnet figures are all below the launch-era numbers ($7.60, $2.74, $1.08, $0.59, $0.41), consistently, which looks like a real re-measurement or re-pricing by AA rather than a parsing slip. The Opus figures are unchanged.
- I found no changelog entry or article explaining the revision, and no second source showing the new numbers. A search for the revision returned nothing. So I cannot rule out that the fetch summary is wrong, but two fetches agreed and the table is internally coherent.

Verdict: STALE if the live page is right (at `max` Sonnet is now about 9% cheaper per task than Opus, i.e. "about the same" but not "or more"), HOLDS if the launch-era numbers are still current. Either way "Cheaper below max" holds, and the stated conclusion "so it isn't the budget Claude either" survives, since $5.46 is still far from budget. Suggest softening to "about the same as Opus 5.5 at `max`" and rechecking on AA's Sonnet 5.5 model page before shipping. If Sonnet's `max` cost is lower than the launch figure, the cost-to-task bullet's "Sonnet 5.5 at $2/$10 [costs more than Astra]" should be rechecked too (row 22), though Astra's much lower token use probably still wins.

### E. Starting-choices bullet (row 18)
Facts hold. Nit: it names Luna and Haiku side by side as the cheap pick, but AA shows Haiku about 3x Luna per task at every effort (row 11), and the Haiku row itself says so. A reader of only the bullet would not learn that. Consider listing Luna first with a note, or "Luna, or Haiku 5.5 when Claude is required".

## Ratings that look off

- Haiku 5.5 cost-to-task "lowest" (same as Luna). AA puts Haiku at about 3x Luna's cost per task at every effort level, and Sol (Low) at $0.13 is cheaper per task than Haiku (max) at $0.21 at equal quality. At default `medium` ($0.05 vs $0.02) Haiku is still the cheaper tier than Sonnet, so "lowest" is defensible, but "low" would separate it from Luna. Judgment call; the "see notes" caveat already covers it.
- Depth 2 / execution 2 for Haiku, matching Luna's 2 / 2, while AA's index has Haiku ahead by 2 to 7 points and well ahead on Terminal-Bench. If anything Haiku's execution is the stronger of the two. Not clearly wrong.

## Leaks of research process, honesty notes, etc.

- Haiku row: "Newly released, so this placement rests on thin early evidence." This is a note on the evidence base rather than guidance for the reader. It is the kind of caveat the shipped file should not carry (and it will go stale in a few weeks). Remove, or fold into the row as a fact only if wanted (e.g. nothing).
- Haiku row: "and often dearer per task because it writes more tokens" and "behind on tool-driven workflows" read as results of a comparison study rather than settled fact. Not source names, so not leaks, but see detail C.
- No source names, study names, "this used to say X", or outage/evaluation-gaming/silent-substitution notes found anywhere else in the draft.
- "Table and notes last updated: 2026-10-08" is fine.

## Source reliance

- Verdicts 1 to 6, 19, 20, 28, 30, 33 rest on Anthropic docs alone (vendor), though the fact types (IDs, prices, defaults) are authoritative for the vendor.
- Rows 8, 9, 11, 13, 21 rest largely on one AA dataset (the Haiku vs Luna comparison page and the Haiku article). Secondary sites (latent.space, orcarouter.ai, kingy.ai) repeat the same AA numbers, so they are not independent confirmation.
- Rows 16 and 17 depend on AA's Sonnet/Opus numbers, which disagree between the launch-era reports and the live page (detail D).
- Row 29 rests on OpenAI's pricing page (vendor).
- Several secondary pages (kingy.ai, orcarouter, beri.net) are SEO-style aggregators. I used them only where they cite AA figures that I could cross-check against AA's own pages (Opus 5.5, Sol, Haiku/Luna), except the $7.60 Sonnet figure, which I could not cross-check on AA directly.

## Key URLs (all accessed 2026-10-08)

- https://platform.claude.com/docs/en/about-claude/pricing (vendor)
- https://platform.claude.com/docs/en/models/overview (vendor)
- https://platform.claude.com/docs/en/models/haiku-5-5/overview (vendor)
- https://platform.claude.com/docs/en/build-with-claude/effort (vendor)
- https://code.claude.com/docs/en/model-config (vendor)
- https://www.anthropic.com/claude-sonnet-5-5 and https://www.anthropic.com/claude-haiku-5-5 (vendor)
- https://developers.openai.com/api/docs/pricing (vendor)
- https://artificialanalysis.ai/articles/claude-haiku-5-5 (independent, 2026-10-07)
- https://artificialanalysis.ai/changelog (independent)
- https://artificialanalysis.ai/models/releases/comparisons/claude-haiku-5-5-vs-gpt-6-luna (independent)
- https://artificialanalysis.ai/models/releases/comparisons/gpt-6-1-sol-vs-claude-opus-5-5 (independent)
- https://artificialanalysis.ai/models/releases/comparisons/claude-sonnet-5-5-vs-claude-opus-5-5 (independent, the $5.46 figure)
- https://venturebeat.com/technology/anthropic-launches-claude-haiku-5-5-with-90-api-price-reduction-matching-gpt-6-luna (independent, 2026-10-07)
- https://www.latent.space/p/ainews-claude-haiku-55-better-than (independent summary of AA, 2026-10-08)
- https://roo.beehiiv.com/p/claude-haiku-5-5-pricing-benchmarks (independent, whole-request reading)
- https://www.beri.net/article/claude-sonnet-5-5-vs-opus-5-5-cost-per-task-matched-score-effort-between-tools-migration (secondary on AA, 2026-09-28 data)
