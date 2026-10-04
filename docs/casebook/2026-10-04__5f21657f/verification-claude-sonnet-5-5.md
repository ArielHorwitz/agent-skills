# Verification report: models-draft.md

**Verifier model ID:** claude-sonnet-5-5

**Web search:** worked. **Page fetching:** I did not fetch any pages. Every verdict rests on WebSearch result summaries (which name the underlying sites), not on pages I opened myself. Anthropic's and OpenAI's own docs pages came up in results but I did not read them directly. Where a source is "vendor" below, the number was reported secondhand through a search summary of the vendor's launch material or docs. Most dates are from the summaries (Opus 5.5 2026-09-22, Sonnet 5.5 2026-09-28, GPT-6.1 Sol 2026-09-29, Fable 5.1 2026-09-01).

Shorthand for sources:
- **AA** = Artificial Analysis (artificialanalysis.ai, independent). Several rows below use AA numbers that I only saw reproduced by Lindy (lindy.ai/blog/opus-5-5-vs-astra), DigitalApplied and a Sonnet-vs-Sol DataCamp piece, so those rows share one upstream source.
- **Anthropic launch** = anthropic.com/claude-sonnet-5-5, anthropic.com/claude-fable-and-mythos-5-1, platform.claude.com effort and model docs (vendor).
- **OpenAI** = developers.openai.com docs and launch coverage (vendor), relayed by TheNextWeb, Yahoo Finance, SitePoint, eesel, Kingy AI.

## Table

| # | Claim | Verdict | Source |
| --- | --- | --- | --- |
| 1 | `claude-opus-5-5` is a current model ID | HOLDS | Opus 5.5 launch coverage (mixed-news.com, eesel.ai, digitalapplied.com), 2026-09-22. Third-party restating vendor. |
| 2 | `claude-sonnet-5-5` current | HOLDS | MarkTechPost 2026-09-28, unite.ai, codersera. Same upstream (Anthropic launch). |
| 3 | `claude-fable-5-1` current | HOLDS | Anthropic launch page, platform docs, AA comparison pages. |
| 4 | `claude-haiku-4-5` current, not retired | HOLDS | Anthropic Haiku page lists $1/$5; no deprecation notice found. Dated ID is `claude-haiku-4-5-20251001`; the draft uses the alias. |
| 5 | `gpt-6-astra`, `gpt-6.1-sol`, `gpt-6-luna` current | HOLDS | OpenAI launch coverage (TheNextWeb, SitePoint, qz.com), AA. I did not see the literal API strings in a vendor doc, only the display names plus slug-style URLs (e.g. AA `gpt-6-1-sol`). |
| 6 | Opus 5.5 $4/$20 | HOLDS | mixed-news.com, eesel.ai, benchlm.ai. Vendor figure relayed by several sites. |
| 7 | Sonnet 5.5 $2/$10 | HOLDS | MarkTechPost, unite.ai, DataCamp. |
| 8 | Fable 5.1 $10/$50 | HOLDS | AA and Opus 5.5 vs Fable comparisons (computingforgeeks, cometapi). |
| 9 | Haiku 4.5 $1/$5 | HOLDS | Anthropic Haiku page. |
| 10 | Astra $10/$50 | HOLDS | OpenAI coverage, Lindy. |
| 11 | 6.1 Sol $2/$10 | HOLDS | TheNextWeb, SitePoint, Yahoo Finance, 2026-09-29. |
| 12 | 6 Luna $0.10/$0.50 | HOLDS | qz.com, openrouter.ai, layer3labs. |
| 13 | Astra has the "top sticker price" (row text) | HOLDS, tie | Fable 5.1 is also $10/$50. Not wrong, but Astra is not alone. |
| 14 | Opus 5.5 starts at `medium` (Claude Code) | HOLDS | Claude Code docs, Cat Wu post on X. Vendor. |
| 15 | Sonnet 5.5 starts at `medium` in Claude Code | HOLDS, with caveat | Medium in Claude Code and apps; API default is `high` (unite.ai, Anthropic launch). |
| 16 | Fable 5.1 starts at `high` | HOLDS | Anthropic announcement and effort docs. Medium in Cowork and claude.ai. |
| 17 | Codex models default to `medium` | HOLDS for Sol, UNSUPPORTED for Astra and Luna | OpenAI docs list Sol `medium (default)`. One third-party X post says Codex defaults Sol to `low`, unconfirmed. For Astra the sources conflict (one says no default is named). Nothing found for Luna. |
| 18 | Opus 5.5 `max` roughly doubles cost for a point or two | HOLDS | AA via Lindy: xhigh $3.46 (56) to max $5.98 (58) is 1.7x for 2 points. From `high` it is 3.3x. |
| 19 | Opus 5.5 at `max` "can run for hours" | HOLDS (weak) | Vals: Opus 5.5 at max, 78 min per test (one source). "Hours" is not shown. |
| 20 | Opus 5.5 at `max` can spend the whole output window thinking and return nothing | UNSUPPORTED | Found nothing either way. |
| 21 | Effort moves cost-to-task 5x to 18x within a model | HOLDS | AA index, low to max: Sol about 5.5x, Opus 11x, Sonnet 18.5x (digitalapplied and similar, one upstream). The 5x and 18x ends are different models, so "5x to 18x" is a spread across models, not a range for one. |
| 22 | Sonnet 5.5 token appetite puts cost-to-task at Opus level, above at `max` | HOLDS | AA: Sonnet 5.5 max $7.60 vs Opus $5.98, 193K output tokens per task, highest AA has measured. Below max I found no per-effort Sonnet row, so "Opus level" is only shown at max. |
| 23 | "Opus-class quality on most work" (Sonnet 5.5) | HOLDS | the-decoder.com, Anthropic launch: nearly matches Opus 5.5. Mostly vendor numbers. |
| 24 | Sonnet 5.5 has "the best terminal-loop scores of any model" | UNSUPPORTED | Only Anthropic's Terminal-Bench 4.0 (70.6% vs Opus 5.5 66.4%). No Sol, 6.1 Sol or Astra score on that benchmark. AA measured 64% for Sonnet. A different leaderboard reverses it (Opus 61.6, Sonnet 53.0). OpenAI's Terminal-Bench Science has Astra 68.1, Sol 57.0. See details. |
| 25 | Opus 5.5 "strongest on software and agentic knowledge work" | HOLDS (vendor-leaning) | Anthropic launch table, 9 of 9 vs Fable 5.1; AA index Opus 58 vs Astra 53, Sol 52 at max. |
| 26 | Fable 5.1 is positioned as the escalation above Opus 5.5 | STALE, partly | Fable still costs 2.5x and wins on hardest open-ended reasoning, but Anthropic now defaults Opus 5.5 to `medium` as "comparable to Fable 5.1". See details. |
| 27 | Fable 5.1 doesn't measurably beat Opus 5.5 on hard problems | FAILS, partly | AA index ties at default. But coverage says Fable wins the hardest reasoning and a Browserbase agent test (82 vs 74). See details. |
| 28 | Fable 5.1 is among the most expensive per task | HOLDS | AA at default: Fable $3.91 vs Opus $1.34. |
| 29 | Fable 5.1 edges: knowledge recall, competitive coding, fewer tokens per coding task than Opus 5.5 | UNSUPPORTED / FAILS in part | No competitive coding test found. Recall: Endor Labs says Opus 5.5 benefits more from memorized solutions, which is the opposite framing. Tokens: Opus uses fewer at default effort, Fable fewer only at max (AA 78K vs 119K). |
| 30 | Fable 5.1 is the slowest model | FAILS | AA output speed at max: Opus 92 t/s, Fable 67, Astra 53 to 61, 6.1 Sol 51. Fable is faster than Astra and Sol per token. No wall-clock data for Fable found. |
| 31 | Astra is the fastest frontier model | FAILS | Opus 5.5 streams faster (92 vs about 57 t/s, AA). On task time at medium, Astra 198 s vs Opus 206 s (DEV Community citing AA). GPT-6 Sol is faster than Astra. |
| 32 | Claude flagships take 2 to 3 times as long as Astra or 6.1 Sol | FAILS for Astra, partly for Sol | Astra roughly ties Opus at medium (198 vs 206 s). Vals at max: Opus 78.5 min vs 6.1 Sol 43 min, about 1.8x. No Sonnet or Fable wall-clock data. Same claim repeated in the Opus row ("two to three times Astra's wall clock") and in Notes. |
| 33 | 6.1 Sol is "fast" | UNSUPPORTED | AA output speed has 6.1 Sol slowest of the four (51 t/s). It finishes sooner only because it uses fewer tokens (Vals, one source). |
| 34 | Claude 5.5 models emit 4 to 7 times Astra's output tokens per task | FAILS | At max: Opus 119K vs Astra 27K is 4.4x; Sonnet 193K vs Astra about 20K is about 9.7x (the Sonnet/Astra figure is a single source). Range should read about 4x to 10x. |
| 35 | At `max`, Sonnet 5.5 costs more per task than Opus 5.5, and Astra less than either | HOLDS | AA: Sonnet $7.60, Opus $5.98, Astra $3.26. |
| 36 | 6.1 Sol at `xhigh` beats its own `max` on agentic coding at two-thirds the cost | FAILS in the number, HOLDS in direction | AA coding index: max scores 3 below xhigh. DeepSWE: both 71.9%, xhigh $0.79 vs max $1.57 (half). AA index $0.39 vs $0.72 (54%). Writing benchmark $0.13 vs $0.18 (72%). Correct to "about half". On OpenAI's Terminal-Bench Science max is +3.3 points for about twice the cost, so "beats" holds only on some benchmarks. |
| 37 | 6.1 Sol: "a fifth to a tenth of the frontier cost per task" | HOLDS | AA coding: under 15% of Astra at xhigh. Terminal-Bench Science (OpenAI): $5.47 vs $23.80 (Astra) and $23.21 (Opus), about a quarter at max. "Fifth to tenth" is fair at xhigh, generous at max. |
| 38 | 6.1 Sol "near-Astra depth" and top-tier agentic coding | HOLDS | AA index 52 vs 53; AA coding index 1 above Astra at xhigh; OpenAI says it "nearly matches" Astra. |
| 39 | Astra and Sol trail Opus/Sonnet 5.5 on terminal-heavy loops | UNSUPPORTED | Same single vendor comparison as row 24, and OpenAI's own Terminal-Bench Science shows Astra ahead of Sol and on par with or above Opus on cost-adjusted terms. Different benchmarks, no like-for-like. |
| 40 | Astra is strongest on novel math, science, mechanism problems | UNSUPPORTED | Terminal-Bench Science (OpenAI) has Astra 68.1 vs Sol 57.0, which is mildly supportive. No independent math or science comparison found. |
| 41 | Astra "can overthink small tasks" | UNSUPPORTED | Hex DataBench shows Astra scoring lower at `medium` and `high` than at `low`, but the page itself warns this is not proof. Synthorai: `max` costs 2.3x `low` with identical answers on easy tasks. Suggestive, not conclusive. |
| 42 | Astra is frugal with tokens, so cost-to-task is moderate despite the sticker | HOLDS | AA table: Astra costlier than Opus at low and medium, cheaper at xhigh and max. "Moderate" is right only at high effort and above. |
| 43 | Codex models bill 2x input and 1.5x output on the whole request past 272K input tokens | HOLDS | Sol (SitePoint, eesel), Luna (layer3labs), Astra ($20/$75, via Lindy). OpenAI vendor figures. |
| 44 | Claude bills flat across its 1M window | HOLDS for Opus 5.5 | Opus 5.5 launch coverage. Not checked for Sonnet 5.5 or Fable 5.1. |
| 45 | Haiku 4.5 is beaten by GPT-6 Luna on cost and capability ("does more for less") | HOLDS | AA index: Luna (max) 38 vs Haiku (reasoning) 17; Luna costs 10x less per token. wojciech.io, benchlm.ai. |
| 46 | Luna is weak at terminal loops | HOLDS | Codex with Luna scores 15% on Terminal-Bench 4.0 (AA, via a write-up). |
| 47 | Haiku 4.5 "not for shell work" | UNSUPPORTED | No Terminal-Bench 4.0 entry for Haiku. A Terminal-Bench 2.1 score of about 41 to 44% exists (benchlm, DocsBot), which is not "not for shell work". |
| 48 | Previous-gen models (Opus 5, Opus 4.8, Fable 5, Sonnet 5, GPT-6 Sol, GPT-5.6 Sol/Terra/Luna) are still callable | HOLDS for Anthropic, UNSUPPORTED for OpenAI | Anthropic deprecations page (via a search summary) lists none of Opus 5, Opus 4.8, Fable 5, Sonnet 5 as deprecated. For GPT-6 Sol I found only pricing and speed pages. GPT-5.6 is named as OpenAI's migration target, not deprecated. |
| 49 | Each is beaten on quality and cost-to-task by a listed model from the same vendor | UNSUPPORTED | True and well sourced for Opus 5 (Opus 5.5 is cheaper and better) and Sonnet 5. For GPT-6 Sol the only change to 6.1 Sol is cached-input price. Opus 4.8 and the GPT-5.6 models: nothing found. |

## Details for anything not HOLDS

**Wall-clock and speed claims (rows 30 to 33).** This is the most important cluster. The draft says the Claude flagships take two to three times as long as Astra or 6.1 Sol, that Astra is the fastest frontier model, and that Fable is the slowest. AA's output-speed numbers (max effort) say the opposite ordering per token: Opus 5.5 92 t/s, Fable 67, Astra 53 to 61, 6.1 Sol 51. Whole-task time depends on tokens used. Evidence I found: Astra and Opus roughly tie at medium (198 s vs 206 s, a DEV Community post citing AA); Vals has Opus at about 1.8x 6.1 Sol at max (78.5 vs 43 min); a hands-on test had Astra faster on one task (32 vs 40 min) and slower on another (39 vs 31 min). Fable's wall clock has no data at all. Suggested replacement: "Opus 5.5 streams faster than the codex models but often finishes later because it spends more tokens; 6.1 Sol usually finishes first." Drop "fastest frontier model" and "slowest model".

**Token ratio (row 34).** Sonnet 5.5 at max is about 10x Astra, not 7x. Say "four to ten times".

**Sol xhigh vs max (row 36).** Cost ratio is about one half on the coding benchmarks, not two-thirds. Also note OpenAI's own Terminal-Bench Science does show max ahead by 3.3 points, so "beats" is benchmark-dependent.

**Fable 5.1 (rows 26, 27, 29).** Anthropic's launch table has Opus 5.5 winning 9 of 9 against Fable (one source says 8 of 9, with 4 within error bars). AA ties them at default for a third of the cost. But several sources say Fable keeps an edge on the hardest reasoning and open-ended problems Opus cannot crack at high effort, which is what "escalation" means. The draft's own advice (reserve for when Opus at `xhigh` falls short) is consistent with that, but "doesn't measurably beat Opus 5.5 on hard problems" overstates. The "Edges" list is the weakest part: I found no support for competitive coding, and Endor Labs' memorization finding cuts against "knowledge recall" as a Fable strength.

**Sonnet 5.5 terminal claim (row 24).** Rests on Anthropic's own table. The only independent number I saw (AA 64% for Sonnet) is below Anthropic's 70.6% and below Opus's 66.4%. One write-up says the 70.6% was at `max` and the 66.4% at `xhigh`, so not like-for-like. Another leaderboard reverses the order. Suggest "scores at or near the top on Anthropic's Terminal-Bench 4.0" or drop the superlative.

**Single-source dependencies.** Rows 18, 21, 22, 34, 35 all rest on AA's index as reproduced by Lindy and DigitalApplied. Rows 6 to 9, 14 to 16 rest on Anthropic's vendor material; rows 10 to 12, 43 on OpenAI's.

## Ratings that look clearly wrong or shaky

- **Astra execution 4 vs 6.1 Sol execution 5.** The only per-task agentic number I found (OpenAI's Terminal-Bench Science) has Astra 68.1 vs Sol 57.0. AA's index has them within a point. Nothing supports Sol being ahead of Astra on execution except cost. Consider both at 4 or Sol 4, Astra 5, or note that execution here includes efficiency.
- **Fable 5.1 cost-to-task "high" same as Opus 5.5 "high".** AA at default effort has Fable at about 2.9x Opus ($3.91 vs $1.34). If a finer scale is available, Fable should be above Opus.
- **Fable 5.1 depth 4 vs Opus 5.5 depth 5.** Consistent with Anthropic's table and AA, but contradicted by the hardest-reasoning reports. Defensible, flag only as contested.
- **Astra "medium-high" cost-to-task.** At low and medium effort Astra is costlier than Opus (AA), at high and above cheaper. Fine as a coarse label, but the row's assumed effort level should be explicit.

## Draft hygiene (research mentions, honesty, outages, substitution)

Clean. I found none of the following: source names, "used to say" language, named studies, evaluation-gaming notes, outage notes, or silent-substitution notes. No em-dashes. Two small points:
- Intro of Models section says "these models trade places depending on task shape", which is fine as method-neutral prose.
- "*Table and notes last updated: 2026-10-04.*" is a date stamp, not a research note. Keep or drop as the project prefers. Given the contents move week to week (prices, defaults), keeping it is useful.
