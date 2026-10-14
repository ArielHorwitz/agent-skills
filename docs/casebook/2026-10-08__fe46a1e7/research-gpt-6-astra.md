Model ID: `gpt-6-astra` (the identifier supplied by this research assignment, not independently verified runtime metadata).
Research date: 2026-10-08.

**Recommendation.** Adopt Haiku 5.5 as the preferred Haiku for bounded extraction, summarization, repository reading, and small implementation subtasks. Treat it as a stronger alternative to Luna when task difficulty warrants additional spend, not as the universally cheapest worker. Keep Sonnet 5.5, Opus 5.5, and GPT-6.1 Sol for difficult diagnosis and sustained execution. This is my inference from the independent comparisons below, not a measured result on this repository's delegation workload.

**Evidence status and dates.** Live search worked. The Haiku overview initially failed to fetch, then succeeded. The linked system card failed to fetch. LiveBench's full table did not render, so its results below come from search-indexed text of LiveBench itself. Some Artificial Analysis comparison tables likewise appeared in search results but not fetched page text. I did not run model evaluations. For every citation marked “undated,” the source exposes no reliable publication date in the retrieved content and the observation date is 2026-10-08. A crawl date is not a publication date.

Haiku 5.5 launched on October 7, so independent operational experience is only about a day old. The launch date is vendor-confirmed. [Anthropic launch, vendor, 2026-10-07](https://www.anthropic.com/claude-haiku-5-5). Broad comparisons below depend heavily on **one evaluator, Artificial Analysis**. Its different model pages are not separate corroboration. LiveBench, DataCamp's own test, and one firsthand community report provide distinct but narrower evidence. Vendor-hosted customer testimonials and articles repeating launch charts were not counted as independent evaluations.

**Depth and cost measured together.** These are Artificial Analysis Intelligence Index v4.3.2 results and its reported weighted average dollars per benchmark task. They are not dollars per successfully completed repository change. The methodology accounts for input, cache, reasoning, and answer tokens. [AA methodology explanation, independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-high-vs-claude-haiku-5-5-medium).

| Model and evaluated setting | Intelligence Index | Reported dollars/task | Total output tokens over index | Source, all independent and undated |
| --- | ---: | ---: | ---: | --- |
| Haiku 4.5, reasoning | 17 | $0.28 | 78M | [AA Haiku 4.5](https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning) |
| Haiku 5.5, high | 38 | $0.08 | 97M | [AA Haiku high](https://artificialanalysis.ai/models/claude-haiku-5-5-high) |
| Haiku 5.5, xhigh | 41 | $0.12 | 180M | [AA Haiku xhigh](https://artificialanalysis.ai/models/claude-haiku-5-5-xhigh/) |
| Haiku 5.5, max | 43 | $0.21 | about 440M | [AA Haiku max](https://artificialanalysis.ai/models/claude-haiku-5-5/) |
| GPT-6 Luna, max | 38 | $0.07 | 140M | [AA Luna](https://artificialanalysis.ai/models/gpt-6-luna) |
| GPT-6.1 Sol, max | 52 | $0.72 | 67M | [AA Sol](https://artificialanalysis.ai/models/gpt-6-1-sol) |
| Sonnet 5.5, max | 56 | $5.46 | 420M | [AA Sonnet](https://artificialanalysis.ai/models/claude-sonnet-5-5) |
| Opus 5.5, max | 58 | $5.98 | 260M | [AA Opus](https://artificialanalysis.ai/models/claude-opus-5-5) |

Interpretation: Haiku has gained substantial headroom over 4.5. At high it matches Luna's max composite score for slightly more reported spend. Max buys another five points but costs 2.625 times Haiku high and three times Luna max, calculated from the table. It remains below Sol, Sonnet, and Opus on this composite. These are useful indicators for difficult work, not proof of performance on an ambiguous architecture decision or novel debugging problem. Index scores are not percentages of arbitrary tasks solved, so dividing task cost by the score would be invalid.

A separate evaluator is less decisive about Haiku versus Luna: LiveBench lists Haiku xhigh at 72.1 and Luna max at 72.0, with Sonnet xhigh at 77.8. Treat 0.1 points as an effective tie without uncertainty estimates. This supports a larger-model gap while weakening any universal “Haiku beats Luna” statement. [LiveBench primary leaderboard, independent, undated, search-indexed results](https://livebench.ai/?orgid=145), [Sonnet row, same evaluator and date status](https://livebench.ai/?error=error_code).

**Execution, including long terminal loops.** Independent evidence separates terminal skill from general automation:

| Comparison | What Artificial Analysis reports | Interpretation |
| --- | --- | --- |
| Haiku max versus Luna max | Terminal-Bench 4.0: 33% versus 13%. AutomationBench-AA: 35% versus 53%. | Haiku's terminal advantage does not extend to all agent workflows. [Independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-luna) |
| Haiku high versus Sol high | Terminal-Bench: 22% versus 52%. AutomationBench: 34% versus 64%. | Sol retains a substantial execution advantage. [Independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-high-vs-gpt-6-1-sol-high) |
| Haiku max versus Sonnet xhigh | Terminal-Bench: 33% versus 57%. AutomationBench: 35% versus 66%. | Even higher Haiku effort does not close the gap. [Independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-claude-sonnet-5-5-xhigh) |
| Haiku max versus Opus max | Terminal-Bench: 33% versus 60%. AutomationBench: 35% versus 70%. | Opus remains the stronger sustained worker in these tests. [Independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-claude-opus-5-5) |

Anthropic's own Terminal-Bench 4.0 figures are Haiku 5.5 39.2%, Haiku 4.5 0%, Luna 16.4%, and Sonnet 70.6%. Its no-tools HLE figures are 45.9%, 10.2%, and 56.9% for Haiku 5.5, Haiku 4.5, and Sonnet respectively. These support direction, but are vendor-run results and differ from AA's terminal measurements. I could not inspect the system card's harness details, so do not combine the percentages or assume identical evaluation conditions. [Anthropic launch, vendor, 2026-10-07](https://www.anthropic.com/claude-haiku-5-5).

Anthropic's prompting guide specifically reports early stopping in long coding-agent prompts at low effort. Moving to medium roughly halves that failure but more than doubles output tokens per attempt. It also recommends explicitly requiring verification at low and medium. This is directly relevant to headless delegation: a cheap attempt that hands work back unfinished is not a cheap completed task. [Haiku prompting guide, vendor, undated](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-haiku-5-5).

My execution recommendation is medium for bounded tasks with a clear completion check, high for longer tool sequences, and escalation to a larger model when planning or diagnosis dominates. Do not interpret fast output generation as fast completion. For example, AA's xhigh comparison reports Haiku at 188 tokens/second versus Luna at 115, yet task time of about 291 versus 242 seconds and cost of $0.12 versus $0.04. [AA xhigh comparison, independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-xhigh-vs-gpt-6-luna-xhigh).

**Realistic cost-to-task evidence.** The useful examples point in different directions:

1. A short, precisely specified decision task: DataCamp supplied both Haikus the same 24 invoices, purchase orders, delivery notes, and payment policy. Both got 24/24 decisions correct. Haiku 5.5 high cost $0.0098 for the run versus $0.25 for Haiku 4.5 with a 16K thinking budget, with under one-quarter of its output tokens. This is roughly a 25.5-fold saving, calculated from reported totals. It is one small, ceiling-saturated test with unequal reasoning controls, so it supports cheap routine decisions rather than universal superiority. [DataCamp firsthand test, independent, updated 2026-10-07](https://www.datacamp.com/blog/claude-haiku-5-5).

2. A long creative coding run: a user reported Haiku xhigh producing 4.46M output tokens and processing 268.8M input tokens, 262.7M cached, against Luna xhigh's 1.18M output and 64.5M input, 61.1M cached. Reported API-equivalent totals were $24.96 and $1.96, about 12.7-fold apart. Runs used subscriptions through atomic.chat, so these are reconstructed costs, not paid API invoices. Quality judgments in comments differ and there is no objective equal-success check. The report is a useful warning about long contexts and token consumption, not a representative population estimate. [Firsthand Reddit report, independent anecdote, 2026-10-08 as indexed](https://www.reddit.com/r/ClaudeAI/comments/1x0agoh/claude_haiku_55_cost_12x_more_than_gpt6_luna_for/).

3. A broader task mix: the AA table measures actual benchmark token consumption. Its max results make Haiku only 25% cheaper than Haiku 4.5, calculated from $0.21 versus $0.28, despite the much larger sticker discount. At matched high effort, Sol costs four times Haiku per index task, $0.32 versus $0.08, while its weighted output usage is 13K versus 55K tokens/task. That is a much smaller cost gap than their 20-fold short-context token-price gap. [AA Haiku 4.5, independent, undated](https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning), [AA Haiku max, independent, undated](https://artificialanalysis.ai/models/claude-haiku-5-5/), [AA high-effort Sol comparison, independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-high-vs-gpt-6-1-sol-high).

AA costs are weighted benchmark-attempt averages. I did not verify that its displayed Haiku totals fully incorporate the new long-context surcharge. Do not use them as a production quote. They also exclude the local cost of review, corrections, and escalation. There is insufficient independent evidence to predict the total bill for a representative multi-file change across all six models at matched success criteria.

For a local evaluation, my proposed metric is total worker, reviewer, retry, and escalation spend divided by accepted tasks. If trying Haiku first costs C_H and succeeds acceptably with probability p, then a simple one-escalation policy costs C_H + (1-p)C_L, where C_L is the larger model's full fallback cost. This is an illustrative accounting model, not a measured success estimate. It explains why cheap first attempts can help easy work and add overhead to hard work.

**Pricing, context, and effort.** All prices below are standard direct API USD per million tokens, not task costs. Documentation sources are vendor and undated, observed 2026-10-08.

| Model | Input / output | Cache read | Context / max output | Reasoning control |
| --- | --- | --- | --- | --- |
| Haiku 5.5, prompt up to 100K | $0.10 / $0.50 | $0.01 | 1M / 128K | Adaptive, medium default |
| Haiku 5.5, prompt over 100K | $0.50 / $2.50 | $0.05 | Same | Same |
| Haiku 4.5 | $1 / $5 | $0.10 | 200K / 64K | Extended thinking budget, no effort parameter |
| Sonnet 5.5 | $2 / $10 | $0.10 | 1M / 128K | Adaptive, high API default |
| Opus 5.5 | $4 / $20 | $0.20 | 1M / 128K | Adaptive always on, medium default |
| GPT-6 Luna, input up to 272K | $0.10 / $0.50 | $0.01 | 1.05M / 128K | none, low, medium, high, xhigh, max. Medium default |
| GPT-6.1 Sol, input up to 272K | $2 / $10 | $0.10 | 1.05M / 128K | low, medium, high, xhigh, max. Medium default |

Sources: [Haiku 5.5 specifications](https://platform.claude.com/docs/en/models/haiku-5-5/overview), [Haiku 4.5 specifications and Claude comparison](https://platform.claude.com/docs/en/models/haiku-4-5/overview), [Opus pricing in AA's comparison, independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-claude-opus-5-5), [Luna specifications](https://developers.openai.com/api/docs/models/gpt-6-luna), [Sol specifications](https://developers.openai.com/api/docs/models/gpt-6.1-sol).

Haiku's 5-minute cache writes cost $0.125/$0.625 across the two prompt tiers, and 1-hour writes cost $0.20/$1. Batch discounts input and output by 50%. Its new tokenizer counts approximately 30% more tokens for the same text than Haiku 4.5. Recount actual prompts before assuming they fit the cheap tier. [Haiku specifications, vendor, undated](https://platform.claude.com/docs/en/models/haiku-5-5/overview).

Luna's price increase begins above 272K input tokens, at $0.20 input and $0.75 output for the full request, with cache rates doubled. Thus the 100K-to-272K region materially favors Luna on rates, although actual token counts and success still decide task cost. [Luna specifications, vendor, undated](https://developers.openai.com/api/docs/models/gpt-6-luna).

Haiku effort levels are low, medium, high, xhigh, and max. Thinking can be disabled through high, but not at xhigh/max. The guide recommends comparing Sonnet when buying the two highest efforts. [Haiku prompting guide, vendor, undated](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-haiku-5-5). Independently, AA reports medium/high Terminal-Bench scores of 15%/22%, versus 29%/33% at xhigh/max. Extra effort buys execution quality, but the cost table shows diminishing returns. [AA medium/high, independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-high-vs-claude-haiku-5-5-medium), [AA xhigh/max, independent, undated](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-claude-haiku-5-5-xhigh).

**Supersession and catalog placement.** My recommendation is to supersede Haiku 4.5 in the default same-vendor small-worker slot: independent evidence supports both higher capability and lower cost on the observed tasks. Preserve 4.5 only for a demonstrated workload regression or compatibility need. Haiku 5.5 does not supersede Sonnet or Opus on depth or execution, and Luna retains a meaningful cost/automation role. Sol remains a stronger terminal worker with materially lower token consumption than Haiku in AA's matched-high comparison. These are conclusions from the cited measurements, not universal rankings.

Suggested catalog description: “Fast, inexpensive Claude worker for bounded reading, extraction, and small checked changes. Start at medium, use high for longer tool work. Strong upgrade over Haiku 4.5. Better terminal capability than Luna in early independent tests, but often more expensive per task. High effort and prompts over 100K can erase much of the price advantage. Use Sonnet, Opus, or Sol for difficult diagnosis and sustained complex execution.”

One other catalog-relevant change: Sonnet cache reads dropped from $0.20 to $0.10/M at Haiku's launch. Anthropic estimates approximately 20% lower agentic task cost from that change, but that saving depends on cache usage and is not independent evidence. Its roughly 75% average Haiku saving is likewise a vendor workload estimate, not a guarantee. [Anthropic launch, vendor, 2026-10-07](https://www.anthropic.com/claude-haiku-5-5).

**Other releases since October 4.** I found no additional newly named Claude model in Anthropic's current newsroom beyond Haiku 5.5. This is a bounded search result, not proof of absence. [Anthropic newsroom, vendor, undated, entries through 2026-10-07](https://www.anthropic.com/news?_bhlid=dcdd664e2a7f18a86f9c6bcce5c8af34c32c5a0f).

OpenAI announced GPT-6 with Intelligent UI in ChatGPT on October 7. It identifies the conversation-tuned models as GPT-6 Sol for paid tiers and Luna for Free/Go, and explicitly says Work and Codex models are unchanged. The API changelog separately records an October 7 update to `chat-latest`. Do not invent a new `gpt-6-instant` delegation ID from the product label. [OpenAI announcement, vendor, 2026-10-07](https://openai.com/index/gpt-6-for-everyone/), [API changelog, vendor, entry dated 2026-10-07](https://developers.openai.com/api/docs/changelog).

For completeness, placement of that update:

- Depth: OpenAI claims better results on an internal difficult-web-question evaluation versus GPT-5.6. I found no independent evaluation establishing its position against Haiku or the requested roster.
- Execution: the advertised improvement concerns interactive answers and earlier response starts. It does not establish long terminal-loop performance. My recommendation is to leave headless delegation choices unchanged.
- Cost-to-task: unknown. The consumer announcement contains no task-token measurements. `chat-latest` currently lists $5 input, $0.50 cached input, and $30 output per million tokens, with 400K context and 128K max output. It supports function calling but lists hosted shell and apply-patch as unsupported. These are alias specifications, not a price/performance characterization of all ChatGPT GPT-6 variants.
- Effort and supersession: the announcement discusses Extra High, but the retrieved alias page does not establish an effort-control mapping for this update. No supported conclusion that it supersedes any requested delegation model.

Sources for these bullets: [OpenAI launch, vendor, 2026-10-07](https://openai.com/index/gpt-6-for-everyone/), [Chat Latest model documentation, vendor, undated](https://developers.openai.com/api/docs/models/chat-latest). The capability claims above share the same vendor announcement and are not independently corroborated. October 6's Decisions API launch uses existing Luna, so it is a new interface rather than another model release. [API changelog, vendor, entry dated 2026-10-06](https://developers.openai.com/api/docs/changelog).
