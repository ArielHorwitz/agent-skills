# Research report: claude-haiku-5-5

Author model ID: `claude-opus-5-5` (Claude Opus 5.5). Date: 2026-10-08.

Web search worked. WebFetch worked for most pages. One fetch failed (alphasignal.ai, HTTP 403), so the Vals AI numbers below are secondhand (see Evidence caveats). I could not read files outside the case directory, so I did not consult the existing models.md and placed the model only from web sources.

## TL;DR

- Haiku 5.5 **supersedes Haiku 4.5**: better on every shared benchmark, 90% cheaper per token under 100K prompt tokens, 1M context instead of 200K.
- Against GPT-6 Luna it is **smarter at the same sticker price, and roughly at cost parity when quality is matched**. Luna stays cheaper on long prompts and is more token-efficient at top effort.
- It is **not a cheap stand-in for GPT-6.1 Sol or Sonnet 5.5 on agentic coding**. On Cognition's FrontierCode, Sol at medium scores higher than Haiku at max for about 1/4 of the cost, because Haiku is very verbose.
- Best fit: fast, cheap, well-scoped subagent work (summaries, extraction, classification, triage, small well-specified edits) at low or medium effort, where the prompt stays under 100K tokens.
- Two traps for a delegation catalog:
  1. The **100K-token price tier**. Over 100K, input and output cost 5x. Long agent loops will likely cross it.
  2. **Verbosity at high effort**. Per-task cost rises much faster than quality.

## Other new models since 2026-10-04

- Anthropic: none other than Haiku 5.5. One related pricing change came in the same launch: Sonnet 5.5 cache reads were halved to $0.10/MTok. Sources: [VentureBeat, 2026-10-07, independent press](https://venturebeat.com/technology/anthropic-launches-claude-haiku-5-5-with-90-api-price-reduction-matching-gpt-6-luna) and the [pricing docs, accessed 2026-10-08, vendor](https://platform.claude.com/docs/en/about-claude/pricing), which list Sonnet 5.5 cache hits at 0.05x base.
- OpenAI: no new model name. On 2026-10-07 OpenAI published "GPT-6 Sol and GPT-6 Luna: October 2026 update", which describes new October versions (snapshots) of GPT-6 Sol and GPT-6 Luna ([OpenAI Deployment Safety Hub, 2026-10-07, vendor](https://deploymentsafety.openai.com/gpt-6-october)).
  - The document only covers safety and alignment. It gives no coding or agentic capability numbers.
  - It does not say whether API model IDs changed.
  - It covers GPT-6 Sol, not GPT-6.1 Sol.
  - Impact: Luna's capability numbers below may be slightly stale. I have no data on how.
- Tooling fact for whoever maintains tools.md: Claude Code 2.1.293 (2026-10-07) added Haiku 5.5 and made it "the default Haiku model on the Anthropic API". The catalog was last refreshed for Claude Code 2.1.286. Sources: the [Claude Code changelog, vendor](https://code.claude.com/docs/en/changelog), as quoted in search results, and [classmethod, 2026-10-08, independent](https://dev.classmethod.jp/en/articles/20261008-cc-updates-v2-1-293/). I did not research invocation syntax.

## Basic facts (vendor)

Sources: [Anthropic launch post, 2026-10-07, vendor](https://www.anthropic.com/claude-haiku-5-5), [Haiku 5.5 model docs, released 2026-10-07, vendor](https://platform.claude.com/docs/en/models/haiku-5-5/overview), and [pricing docs, accessed 2026-10-08, vendor](https://platform.claude.com/docs/en/about-claude/pricing).

**Pricing (per MTok)**

| Prompt size | Input | Output | Cache read | 5m cache write |
|---|---|---|---|---|
| Up to 100K tokens | $0.10 | $0.50 | $0.01 | $0.125 |
| Over 100K tokens | $0.50 | $2.50 | $0.05 | $0.625 |

- Batch API is 50% off.
- Haiku 5.5 is the only current Claude model with prompt-length pricing. Other 4.6+ models bill the full 1M at standard rates (pricing docs).
- Comparators: Haiku 4.5 $1/$5, Sonnet 5.5 $2/$10, Opus 5.5 $4/$20 (pricing docs).
- GPT-6 Luna is $0.10/$0.50 and GPT-6.1 Sol is $2/$10 ([Kingy.ai, 2026-10-07, independent aggregator](https://kingy.ai/blog/claude-haiku-5-5-benchmarks-specs-sol-luna/)). I saw no long-prompt surcharge for Luna. A worked example puts 150K in + 10K out at $0.100 on Haiku 5.5 vs $0.020 on Luna ([roo.beehiiv, date not shown, independent](https://roo.beehiiv.com/p/claude-haiku-5-5-pricing-benchmarks), via search summary).

**Specs**
- Context and output: 1M context, 128K max output (300K on Batch with a beta header), June 2026 knowledge cutoff. Haiku 4.5 had 200K context and 64K output.
- Tokenizer: the same newer tokenizer as Claude 4.7 and later, "approximately 30% more tokens" for the same text than Haiku 4.5. Anthropic says its "around 75% less to run than Haiku 4.5" figure already accounts for this.
- Effort and thinking: adaptive thinking with effort levels low / medium / high / xhigh / max. Default is `medium`. This is the first Haiku with an effort setting.
- Speed: docs label it "Fastest" in the lineup.

**What the 100K threshold counts (open question, inference)**
- The docs say only "a prompt of over 100,000 tokens pays higher prices".
- One writer could not confirm whether cached tokens count toward it (roo.beehiiv).
- My inference: cache reads also have a 100K tier in the price table, so the tier is probably per request and based on the total prompt length including cached prefix. In a multi-turn agent loop, each turn resends the growing transcript. So once a session passes about 100K tokens of context, probably every later turn bills at 5x.
- I could not confirm this from a source.

## Depth

**What sources show**
- Artificial Analysis Intelligence Index v4.3.2 (independent), per effort level: low 29, medium 34, high 38, xhigh 41, max 43. Source: [AA Haiku 5.5 release page, accessed 2026-10-08](https://artificialanalysis.ai/models/releases/claude-haiku-5-5) and the [AA Haiku vs Sonnet comparison](https://artificialanalysis.ai/models/releases/comparisons/claude-haiku-5-5-vs-claude-sonnet-5-5).

  | Model | Index score | Source |
  |---|---|---|
  | Opus 5.5 | 58 (max), 42 (low) | [AA Opus 5.5 page](https://artificialanalysis.ai/models/releases/claude-opus-5-5) |
  | Sonnet 5.5 | 56 (max), 36 (low) | AA Haiku vs Sonnet comparison |
  | GPT-6.1 Sol | 52 (max), 48 (medium), 42 (low) | [AA Sol page](https://artificialanalysis.ai/models/releases/gpt-6-1-sol) |
  | Haiku 5.5 | 43 (max) | AA Haiku 5.5 page |
  | GPT-6 Luna | 38 (max) | [AA Luna page](https://artificialanalysis.ai/models/releases/gpt-6-luna) |
  | Haiku 4.5 | 17 | AA Haiku 5.5 page |

  All AA pages were accessed 2026-10-08 and are independent.
- HLE without tools: 45.9% vs Sonnet 5.5 56.9% (vendor, launch post). AA's own HLE run shows 44.4% ([BenchLM, 2026-10-07, aggregator citing AA](https://benchlm.ai/models/claude-haiku-5-5)).
- GDPval-AA v2.1 Elo: Haiku 5.5 1620, Luna 1437, Sonnet 5.5 1840, Haiku 4.5 735 (vendor table). AA's own comparison page shows the same 1620 for Haiku and 1839 for Sonnet (independent).
- Hands-on: one HN commenter said that when they tried it, it "looked at the job and immediately delegated it to Opus 5.5". This is a single anecdote ([HN launch thread, 2026-10-07, community](https://news.ycombinator.com/item?id=49996437), via search summary).

**Inference**
- Clear step above Luna and far above Haiku 4.5.
- Even at max effort it sits below Sol, Sonnet 5.5 and Opus 5.5 at their defaults. Its max-effort composite roughly equals Sol at low and Opus 5.5 at low.
- It is not the pick for hard, ambiguous or novel problems. A delegator that needs depth should go to Sol, Sonnet or Opus.

## Execution (long agentic / terminal loops)

**What sources show**
- Terminal-Bench 4.0:
  - Vendor numbers: 39.2% at max effort vs Sonnet 5.5 70.6%, Luna 16.4%, Haiku 4.5 0.0% (launch post). At the default medium effort it is "approximately 20%" ([VentureBeat, 2026-10-07](https://venturebeat.com/technology/anthropic-launches-claude-haiku-5-5-with-90-api-price-reduction-matching-gpt-6-luna), reporting vendor material).
  - Artificial Analysis's own run: 32.8% for Haiku 5.5 (max) vs 63.6% for Sonnet 5.5 (max) (AA comparison page, independent). AA's Luna run is about 13% ([Latent Space AINews, 2026-10-08, aggregator](https://www.latent.space/p/ainews-claude-haiku-55-better-than)).
  - Public-leaderboard snapshot, which has no Haiku 5.5 row yet: Sol 58.2%, Sonnet 5.5 61.8%, Opus 5.5 64.8% (Kingy.ai, citing the public board).
  - Pattern: Anthropic's numbers for its own models run 6 to 9 points above independent runs.
- FrontierCode 1.1 Main (Cognition, Claude Code harness for Claude models, Codex harness for GPT). Sources: Kingy.ai and search summaries of [Kingy.ai's Sol/Luna vs Haiku piece, date not shown](https://kingy.ai/blog/gpt-sol-luna-vs-claude-haiku-5-5/).

  | Model / effort | Composite | Cost per rollout | Output tokens per rollout |
  |---|---|---|---|
  | Haiku 5.5 low | 34.8% | $0.06 | 23.9K |
  | Haiku 5.5 medium | 41.6% | $0.13 | 36.2K |
  | Haiku 5.5 high | 41.9% | $0.26 | 55.1K |
  | Haiku 5.5 xhigh | 45.8% | $0.63 | 100.8K |
  | Haiku 5.5 max | 46.4% | $1.33 | 181.4K |
  | GPT-6 Luna max | 42.4% | $0.10 | 56.6K |
  | GPT-6.1 Sol medium | 50.2% | $0.36 | 11.4K |
  | Opus 5.5 medium | 54.6% | $0.80 | 18.5K |
  | Sonnet 5.5 max | 46.2% | not found | not found |

  - Discrepancy: Anthropic's launch table lists Sonnet 5.5 at 52.1% on FrontierCode, while Kingy cites Cognition public data at 46.2%. I could not resolve which run or effort each refers to.
- Vals AI (secondhand via [AlphaSignal](https://alphasignal.ai/news/anthropic-s-claude-haiku-5-5-jumps-89-spots-to-rank-third-in-coding), which I could not fetch, so this comes from a search summary; also [HuggingNews, 2026-10-07/08](https://huggingnews.com/ai/claude-haiku-55-ranks-3rd-on-vibe-code-bench-89f9e96e)):
  - Vibe Code Bench v1.1 (build full apps from specs): 90.44%, 3rd of 110. All tests passed on 21 of 50 apps vs 24 for Sonnet 5.5, at about 1/5 of Sonnet's cost and about half the time.
  - Vals Index: 54.31% at $2.99/test (16th of 45).
  - Legal Research: about 59 steps per task vs 17 for Haiku 4.5, writing 15x more tokens.
  - HuggingNews says Haiku 5.5 is "more expensive to run per test than Haiku 4.5 across every shared benchmark due to higher token consumption".
- OSWorld 2.1 (vendor): Haiku 72.4%, Luna 48.9%, Sol 76.6%, Sonnet 5.5 83.9%, Opus 5.5 87.2%.
- Speed (AA, independent), output tokens/s:

  | Model | Output tokens/s |
  |---|---|
  | Haiku 5.5 | 137 (medium) to 243 (max) |
  | Luna | 112 to 127 |
  | Sol | about 50 |
  | Sonnet 5.5 max | 136 |
  | Opus 5.5 | 76 to 96 |

  One HN commenter measured 93 t/s on OpenRouter (HN thread).
- Launch-partner latency claims (vendor-curated customer quotes in the launch post): Box says 11 points better than Haiku 4.5 at about half the latency. Asana says over 30% lower latency and up to 2.5x faster per agent turn. Against that, one HN commenter running Haiku 4.5 in production called early 5.5 tests "trash", saw prompt leakage, and said "it's slower" (single anecdote, HN thread).
- Anthropic itself says "Sonnet 5.5 and Opus 5.5 remain better choices" for complex agentic coding like Terminal-Bench (launch post, vendor).

**Inference**
- It can drive an agentic loop, which Haiku 4.5 effectively could not (0.0% TB4).
- It is roughly half as good as Sonnet 5.5 or Sol on hard terminal tasks.
- It is strong on well-specified build work (Vibe Code Bench) and much faster per token than anything else in the roster.
- For delegated execution, it fits short, tightly specified loops. It is not a fit for long multi-hour terminal work, where Sol or Sonnet finish more often and, per FrontierCode, often cheaper.

## Cost-to-task

Token efficiency is the core issue. Haiku 5.5 is cheap per token but verbose, and it gets dramatically more verbose as effort rises.

**Token-volume evidence**
- AA Intelligence Index output tokens: Haiku high 97M, max 440M, against a median of 100M. AA called max "very verbose" (AA pages, independent). Sol max used 67M on the same index (AA Sol page).
- FrontierCode max: 181K output tokens per rollout vs 11.4K for Sol medium and 56.6K for Luna max.
- Latent Space cites about 162K output tokens per task at max, roughly 3x Luna (aggregator).
- [OrcaRouter, 2026-10-08, independent](https://www.orcarouter.ai/blog/claude-haiku-5-5-china-price-undercut) calls it verbose: its 1.5x rate-card advantage over GLM 5.3 Flash shrinks to about 1/6 cheaper per completed task.

**Representative costs**

1. **Short, well-scoped task (classification, extraction, summary), low or medium effort, prompt under 100K.** Very cheap and a clear win over Haiku 4.5.
   - DataCamp's hands-on test: 24 invoice decisions, both models 24/24. Haiku 5.5 cost $0.0098 vs $0.25 for Haiku 4.5 and used under 1/4 of the output tokens ([DataCamp, 2026-10-07, independent](https://www.datacamp.com/blog/claude-haiku-5-5)).
   - Cursor reportedly saw "10x less than Haiku 4.5 on shorter requests" (via Latent Space, secondhand).
   - Simon Willison's single SVG prompt: low effort cost 0.09 cents and took 7 s, max cost 3.38 cents and took 5 min 9 s ([simonwillison.net, 2026-10-07, independent](https://simonwillison.net/2026/Oct/7/claude-haiku-5-5/), numbers via HN and the blog). That is about 36x the cost and 44x the time for the same trivial task.
2. **Reasoning or knowledge-work task (AA index cost per task, independent).**

   | Model / effort | AA score | Cost per task |
   |---|---|---|
   | Haiku 5.5 low | 29 | $0.02 |
   | Haiku 5.5 medium | 34 | $0.05 |
   | Haiku 5.5 high | 38 | $0.08 |
   | Haiku 5.5 xhigh | 41 | $0.12 |
   | Haiku 5.5 max | 43 | $0.21 |
   | Luna max | 38 | $0.07 |
   | Sol low | 42 | $0.13 |
   | Sol max | 52 | $0.72 |
   | Sonnet 5.5 low | 36 | $0.35 |
   | Sonnet 5.5 max | 56 | $5.46 |
   | Opus 5.5 low | 42 | $0.55 |
   | Opus 5.5 max | 58 | $5.98 |

   Inference:
   - At matched quality, Haiku high and Luna max tie (38, about $0.07 to $0.08).
   - Haiku xhigh/max and Sol low tie (about 42, about $0.12 to $0.21). Haiku is 3 to 5x faster in throughput.
   - Haiku is about 5 to 7x cheaper than Sonnet 5.5 low at similar composite.
   - Caveat: one search summary said AA's provisional Haiku costs do not yet reflect the >100K tier, which would understate them. I could not see that caveat on the AA pages I fetched, so it is unverified.
3. **Agentic coding task in a CLI harness (FrontierCode, the closest proxy for a delegate run).**
   - Haiku medium (41.6%, $0.13) is about the same as Luna max (42.4%, $0.10).
   - Haiku xhigh or max (45.8 to 46.4%, $0.63 to $1.33) is dominated by Sol medium (50.2%, $0.36). Sol is better and 2 to 4x cheaper because it uses about 1/10 to 1/16 as many output tokens.
   - Kingy's summary: "Haiku at max costs about 3.7 times Sol at medium and 13.3 times Luna at max."
   - Opus 5.5 medium (54.6%, $0.80) also beats Haiku max on both score and cost.
   - Vals reports per-test cost on multi-step benchmarks rising above Haiku 4.5's despite the 90% price cut (secondhand).
4. **Long context or long loops (inference).**
   - Once the prompt passes 100K, Haiku costs 5x Luna per token ($0.50/$2.50). That is still 4x cheaper per token than Sonnet 5.5 or Sol.
   - The 30% tokenizer inflation makes the threshold easier to cross. Roo's example: a 78K-token contract on the old count becomes 101.4K on the new tokenizer and jumps tiers.
   - A headless agent session with a big system prompt, tool definitions and accumulated tool output will plausibly cross 100K partway through a long task.
   - Simon Willison: "Above 100,000 tokens, Luna looks like a much better deal."

**Bottom line on cost**
- Haiku 5.5 is the cheapest Anthropic option by far and on par with Luna for short work at low or medium effort.
- For long or high-effort agentic work, it is not cheaper than Sol and may cost more than Haiku 4.5 per task.
- I lack independent per-task cost for Sonnet 5.5 on FrontierCode, and for any model on Terminal-Bench, so the Sonnet comparison for coding loops is incomplete.

## Effort level

All numbers are from the FrontierCode and AA tables above. Mostly inference.

| Step | FrontierCode change | Cost change | AA index change |
|---|---|---|---|
| low → medium | +6.8 pts | about 2x | +5 |
| medium → high | +0.3 pts | about 2x | +4 |
| high → xhigh | +3.9 pts | about 2.5x | +3 |
| xhigh → max | +0.6 pts | about 2.1x | +2 |

On Terminal-Bench (vendor), medium scores about 20% vs 39.2% at max, so agentic terminal work gains much more from effort than FrontierCode suggests.

Practical guidance (inference):
- Use the **default medium** for routine subagent work.
- Use **xhigh** only where quality matters and the run stays short.
- **Max is rarely worth it**: it doubles the cost of xhigh for a small gain, and the extra thinking tokens grow the context toward the 100K tier.
- Prefer stepping up to Sol or Sonnet over running Haiku at max.

## Verdict

**Right pick for**
- High-volume or latency-sensitive subagent work: summaries, compaction, extraction, classification, routing, triage, research digests, quick lookups.
- Small, tightly specified edits or app scaffolding (Vibe Code Bench evidence).
- Parallel fan-out where wall-clock speed matters. It is the fastest model in the roster.
- Any job where you would otherwise use Haiku 4.5.
- Run at low or medium effort, with prompts under 100K.
- It is the cheapest sensible Anthropic option when a delegator wants to stay inside a Claude subscription or harness.

**Not the pick for**
- Hard, ambiguous or novel problems (depth well below Sol, Sonnet, Opus).
- Long multi-step terminal or coding loops. Sol medium or Opus medium give better results at similar or lower cost, and Sonnet 5.5 scores about twice as high on TB4.
- Long-context work over 100K tokens, where Luna is about 5x cheaper per token at similar or lower quality.
- Running at max effort as a cheap substitute for a bigger model. It is not cheap there.
- Penetration-testing or offensive-security tasks. VentureBeat reports these are blocked under standard safeguards, and a Claude Code changelog summary says refusals have no server-side fallback.

**Supersedes**
- **Yes, Haiku 4.5.** It is better on every shared benchmark (vendor and Vals, secondhand), 90% cheaper per token under 100K and 50% cheaper over, and has 5x the context.
- The one caveat: per-task cost on multi-step agentic work can exceed Haiku 4.5's because of verbosity. Effort can control this.
- Claude Code 2.1.293 already made it the default Haiku.
- It does not supersede Sonnet 5.5 or Opus 5.5.
- Cross-vendor (not supersession by definition): it is broadly better than GPT-6 Luna at the same price for short work. Luna keeps the edge on long prompts and on token efficiency at top effort.

## Evidence caveats

- **Independent signal is thin.** The model is one day old.
  - Artificial Analysis is the only fully independent benchmark runner with first-hand data I could fetch.
  - Many "independent" articles (VentureBeat, BenchLM, Technology.org, Kingy.ai) mostly restate Anthropic's launch table.
- **FrontierCode numbers rest on one source.** All come from Cognition, which is an Anthropic launch partner quoted in the launch post. I got them through Kingy.ai and search summaries, not from Cognition's leaderboard directly.
  - Cognition's own blog ([Devin, 2026-10-07](https://devin.ai/blog/claude-haiku-5-5)) headlines 58.4%. Per its chart label this appears to be FrontierCode Extended, not Main.
  - The Devin blog also reports a 66.2 "Fusion" score with Haiku as sidekick under Opus 5.5.
- **Vals numbers come from one unfetched article** (AlphaSignal), plus HuggingNews, which appears to draw on the same Vals data. Treat them as one source, secondhand.
- **AA cost-per-task figures may be provisional** with respect to the >100K tier (unverified, see above).
- **Community evidence** is a handful of HN comments and quote roundups (Latent Space, Handy AI). The comments disagree, and none is a systematic test.
- **I left out** honesty, hallucination, eval-gaming and alignment findings per the brief, even where sources discussed them.
