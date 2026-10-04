# Research report: Claude and GPT models for delegation (as of 2026-10-04)

Researcher model ID: `claude-fable-5-1`

## Status of the research

Web search worked. Page fetching mostly worked, with these exceptions:

- `openai.com/index/...` announcement pages (GPT-6 Astra, GPT-6.1 Sol) returned HTTP 403. OpenAI's vendor benchmark claims below are relayed through press coverage and OpenAI's developer docs, and are marked as such.
- The Artificial Analysis launch article for Claude Fable 5.1 (Sept 2) was not fetchable at the URL I tried. I used the Artificial Analysis changelog and the Fable 5.1 model page instead.
- The Artificial Analysis models overview page returned no per-model data. Individual model pages did.

Every date below is the source's publication or last-update date where one was visible. Where a page shows no date, I note "fetched 2026-10-04".

Source key (used throughout): [V] vendor, [I] independent (third-party benchmark, evaluation, or press reporting independent data), [C] community or individual hands-on.

## 1. What changed since 2026-08-05

This section matters most. Six of the fifteen models in the brief did not exist on August 5.

### New models

| Model | Released | Source |
|---|---|---|
| claude-fable-5-1 | 2026-09-01 | [V] https://platform.claude.com/docs/en/models/fable-5-1/overview (fetched 2026-10-04) |
| gpt-6-astra | 2026-09-03 | [I] https://thenewstack.io/openai-gpt6-astra-benchmarks/ (Sept 2026) |
| claude-opus-5-5 | 2026-09-22 | [V] https://www.anthropic.com/claude-opus-5-5 (2026-09-22) |
| gpt-6-sol, gpt-6-luna | 2026-09-22 | [I] https://artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier (2026-09-22) |
| claude-sonnet-5-5 | 2026-09-28 | [I] https://artificialanalysis.ai/articles/claude-sonnet-5-5 (2026-09-28) |
| gpt-6.1-sol | 2026-09-29 | [V] https://developers.openai.com/api/docs/models/gpt-6.1-sol (fetched 2026-10-04) |

### Roster status changes

- Anthropic now lists Fable 5, Opus 5, Opus 4.8, and Sonnet 5 as "legacy (still available)". All remain Active on the deprecations page with retirement floors: Fable 5 not before 2027-06-09, Opus 5 not before 2027-07-24, Opus 4.8 not before 2027-05-28, Sonnet 5 not before 2027-06-30. [V] https://platform.claude.com/docs/en/about-claude/model-deprecations (last entry 2026-09-30), https://platform.claude.com/docs/en/models/overview (fetched 2026-10-04)
- Claude Haiku 4.5 is still the current small model. Its retirement floor is "not sooner than October 15, 2026", the nearest of any current model. Anthropic said on Sept 22 that "Claude Haiku 5.5 will follow in the coming weeks". No Haiku 5.5 ID, price, or spec exists yet. [V] https://www.anthropic.com/claude-opus-5-5 (2026-09-22); [V] models overview (fetched 2026-10-04)
- Anthropic's own positioning flipped: the models overview now says "start with Claude Opus 5.5 for most workloads. Use Claude Fable 5.1 for demanding reasoning and long-horizon agentic work, or when your evals on Claude Opus 5.5 at higher effort still fall short." [V] models overview (fetched 2026-10-04)
- GPT-6 Sol was superseded by GPT-6.1 Sol seven days after launch. GPT-6 Sol is still on OpenAI's pricing page and still named as the migration target for gpt-5.3-codex and gpt-5.1 (shutdown 2027-04-01). [V] https://developers.openai.com/api/docs/deprecations (last entry 2026-10-01); [I] https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence (2026-09-29)
- GPT-5.6 Sol, Terra, and Luna are all still served with no deprecation notice. They remain the named replacements for the Dec 11, 2026 GPT-5 shutdowns. There is no GPT-6 Terra. [V] OpenAI deprecations (2026-10-01); [V] https://developers.openai.com/api/docs/pricing (fetched 2026-10-04)
- OpenAI reportedly scrapped a planned GPT-6.1 Astra over internal safety test results, per a Wall Street Journal report relayed by secondary press. I could not read the WSJ piece. Treat as plausible but second-hand. [I] https://techcrunch.com/2026/09/29/openai-launches-gpt-6-1-sol-says-it-nearly-matches-gpt-6-astra-and-costs-less/ (2026-09-29)
- Models not in the brief that exist: claude-mythos-5-1 (same model as Fable 5.1, restricted to Project Glasswing), gpt-6-astra Pro / `reasoning.mode: pro` variants, gpt-5.6-cyber ($12.50/$75). None are relevant for general delegation. Claude Sonnet 4.5 was deprecated 2026-09-30 (retires 2026-11-30, replacement Sonnet 5.5). [V] Anthropic pricing and deprecations pages; [V] OpenAI pricing page

### Price changes

| Change | Detail | Source |
|---|---|---|
| Opus 5.5 priced below Opus 5 | $4/$20 vs $5/$25, cache reads $0.20 (0.05x) vs $0.50 | [V] https://platform.claude.com/docs/en/about-claude/pricing (fetched 2026-10-04) |
| Fable 5.1 cache reads cut | $0.25 (0.025x) vs $1.00 on Fable 5. Anthropic claims ~25% lower cost on typical workloads, up to ~45% on highly agentic ones | [V] https://www.anthropic.com/claude-fable-and-mythos-5-1 (Sept 2026) |
| Sonnet 5 intro price made permanent | The scheduled Sept 1 rise to $3/$15 was cancelled. Sonnet 5 and 5.5 are both $2/$10 | [V] Anthropic pricing page |
| GPT-6 Sol and Luna at half of GPT-5.6 | Sol $2/$10 (was $4/$20), Luna $0.10/$0.50 (was $0.20/$1.20). OpenAI told VentureBeat these are permanent | [V] OpenAI pricing page; [I] https://venturebeat.com/technology/openai-releases-gpt-6-sol-and-luna-models-slashing-api-costs-50-or-more (2026-09-22) |
| GPT-6.1 Sol cached input halved | $0.10 vs $0.20 on GPT-6 Sol, same $2/$10 | [V] OpenAI 6.1 Sol model page |
| GPT-5.6 Sol on promotional pricing | $4/$20 "at least through November 21, 2026". Launch price was $5/$30 | [V] OpenAI pricing page; [I] https://www.datacamp.com/blog/gpt-5-6-sol-luna-terra (July 2026) for the launch price |
| OpenAI long-context surcharge | Every GPT-6 and GPT-5.6 model bills the whole request at 2x input and 1.5x output once input exceeds 272K tokens. Anthropic bills the full 1M window at the flat rate | [V] OpenAI pricing page; [V] Anthropic pricing page |
| Speed tiers | Anthropic fast mode (research preview) is 2x price on Opus 5.5 ($8/$40), Opus 5, Opus 4.8 only. OpenAI Fast is 2x on all GPT-6/5.6; Ultrafast is 6x (Astra $60/$300), live for Astra, "coming soon" for 6.1 Sol | [V] Anthropic pricing page; [I] https://venturebeat.com/technology/openais-gpt-6-1-sol-offers-astra-like-performance-at-1-5th-price-a-new-ultrafast-tier-clocks-at-300-tokens-per-second (2026-09-29) |

## 2. The evidence base and its limits

Most independent numbers come from one organisation, Artificial Analysis (AA). Its Intelligence Index was rescaled three times in September (v4.2 on Sept 4, v4.3 on Sept 7 adding Terminal-Bench 4.0, v4.3.2 on Sept 19). Numbers published before mid-September are on a different scale. For example Fable 5.1 "scored 66" at launch and "53" now, with no change to the model. All AA numbers in this report are v4.3.2 unless stated. [I] https://artificialanalysis.ai/changelog (entries through 2026-10-03)

AA's cost-per-task figures use list prices and the tokens the model actually spent, which is the right framing for this brief. AA runs Claude models "with fallback" (server-side fallback to an older Claude on classifier refusals).

The second independent source is Vals AI, whose Vals Index is GDP-weighted toward finance, coding, legal and tax and reports cost per full index run. [I] https://www.vals.ai/benchmarks/vals_index (2026-10-02)

Community signal: Hacker News launch threads, Simon Willison's blog, swyx's X roundup, a handful of hands-on blog tests. These are anecdotal and mostly a few days old.

What I could not find: any METR time-horizon measurement for any model in the brief (a community GitHub chart has extrapolations only, not measurements). Any independent signal on GPT-5.6 Terra beyond AA and Vals. Any independent evaluation of Haiku 4.5 on the current agentic benchmarks.

## 3. Cross-cutting independent data

### 3a. AA Intelligence Index v4.3.2, max effort unless noted

| Model | Score | Cost per index task | Output tokens per task | Source |
|---|---|---|---|---|
| Claude Opus 5.5 | 58 | $5.98 | ~119k | [I] https://artificialanalysis.ai/articles/claude-opus-5-5 (2026-09-22) |
| Claude Sonnet 5.5 | 56 | $7.60 | ~193k (highest AA has measured) | [I] AA Sonnet 5.5 article (2026-09-28) |
| Claude Fable 5.1 | 53 | $7.63 | ~78k | [I] https://artificialanalysis.ai/models/claude-fable-5-1 (fetched 2026-10-04); AA Astra article for the 78k |
| GPT-6 Astra | 53 | $3.26 | ~27k | [I] https://artificialanalysis.ai/articles/benchmarking-gpt-6-astra (2026-09-09) |
| GPT-6.1 Sol | 52 | $0.72 | 10 to 30% more than GPT-6 Sol | [I] AA 6.1 Sol article (2026-09-29) |
| Claude Opus 5 | 51 | $5.86 | ~73k | [I] https://artificialanalysis.ai/models/claude-opus-5 (fetched via search 2026-10-04) |
| Claude Fable 5 | 50 | $8.75 | 130M total | [I] https://artificialanalysis.ai/models/claude-fable-5 (fetched 2026-10-04) |
| GPT-6 Sol | 48 | $1.06 | ~31k | [I] AA GPT-6 Sol and Luna article (2026-09-22) |
| GPT-5.6 Sol | 47 | $1.99 | 90M total | [I] https://artificialanalysis.ai/models/gpt-5-6-sol (fetched 2026-10-04) |
| Claude Opus 4.8 | 42 | $4.08 | 170M total | [I] https://artificialanalysis.ai/models/claude-opus-4-8 (via search) |
| GPT-5.6 Terra | 42 | $1.40 | 120M total | [I] https://artificialanalysis.ai/models/gpt-5-6-terra (via search) |
| Claude Sonnet 5 | 38 | $5.09 | 370M total | [I] https://artificialanalysis.ai/models/claude-sonnet-5 (via search) |
| GPT-6 Luna | 37 to 38 | $0.07 | 140M total | [I] https://artificialanalysis.ai/models/gpt-6-luna (fetched 2026-10-04) |
| GPT-5.6 Luna | 37 | $0.18 | 150M total | [I] https://artificialanalysis.ai/models/gpt-5-6-luna (fetched 2026-10-04) |
| Claude Haiku 4.5 (reasoning) | 17 to 18 | $0.21 to $0.28 | n/a | [I] https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning (via search); [C] https://wojciech.io/insights/gpt-6-luna-vs-claude-haiku-4-5/ (2026-09-23) |

Per-effort data for the three models where it matters most (all from AA, relayed by [C] https://dev.to/genelab_999/claude-opus-55-vs-gpt-6-astra-vs-gpt-6-sol-the-effort-knob-matters-more-than-the-model-55gm (2026-09-23), with the Opus 5.5 low and max rows confirmed directly on [I] https://artificialanalysis.ai/models/releases/claude-opus-5-5):

| Effort | GPT-6 Sol | GPT-6 Astra | Opus 5.5 |
|---|---|---|---|
| low | 34 / $0.13 | 46 / $0.82 | 42 / $0.55 |
| medium | 40 / $0.25 | 50 / $1.54 | 51 / $1.34 |
| high | 43 / $0.37 | 51 / $1.73 | 54 / $1.82 |
| xhigh | 44 / $0.53 | 52 / $2.31 | 56 / $3.46 |
| max | 48 / $1.06 | 53 / $3.26 | 58 / $5.98 |

GPT-6.1 Sol by effort (AA, relayed by [I] https://www.vellum.ai/blog/gpt-6-1-sol-benchmarks-explained and https://aivy.com.au/resources/claude-sonnet-5-5-vs-gpt-6-1-sol/, both late Sept 2026): low 42 / $0.13, medium 48 / $0.21, high 50 / $0.32, xhigh 51 / $0.39, max 52 / $0.72.

Sonnet 5.5 by effort (AA, relayed by [I] https://computingforgeeks.com/claude-sonnet-5-5-released-features-benchmarks/ and the aivy page): low $0.41 (13.9k tokens), medium 41 / $0.59, high 47 / $1.08, xhigh 52 / $2.74, max 56 / $7.60.

### 3b. AA Coding Agent Index v1.5 (agent plus model, three attempts each on DeepSWE v1.1, Terminal-Bench 4.0, SWE-Atlas-QnA)

All rows from one page: [I] https://artificialanalysis.ai/agents/coding-agents/comparisons/claude-code-vs-codex (fetched 2026-10-04). This is the single most relevant independent table for "execution" and it is one source.

| Agent + model (effort) | Index | DeepSWE | TB 4.0 | Cost/task | Time/task | Tokens/task |
|---|---|---|---|---|---|---|
| Claude Code + Sonnet 5.5 (max) | 68 | 72% | 66% | $14.19 | 1.5h | 27.7M |
| Claude Code + Opus 5.5 (max) | 66 | 68% | 63% | $13.04 | 1.1h | 15.6M |
| Claude Code + Sonnet 5.5 (xhigh) | 63 | 68% | 58% | $3.33 | 27m | 7.1M |
| Codex + GPT-6.1 Sol (xhigh) | 63 | 73% | 55% | $1.04 | 15.5m | 3.2M |
| Claude Code + Fable 5.1 (max) | 62 | 64% | 58% | $12.39 | 34.8m | 5.7M |
| Codex + GPT-6 Astra (max) | 62 | 68% | 56% | $7.47 | 29.4m | 3.3M |
| Codex + GPT-6.1 Sol (medium) | 61 | 72% | 52% | $0.70 | 10.9m | 2.3M |
| Claude Code + Opus 5 (max) | 60 | 63% | 55% | $10.79 | 41.9m | 11.4M |
| Codex + GPT-6.1 Sol (max) | 60 | 70% | 53% | $1.55 | 24.4m | 4M |
| Codex + GPT-6 Sol (max) | 57 | 69% | 43% | $2.99 | 22.3m | 9.8M |
| Claude Code + Sonnet 5.5 (high) | 55 | 67% | 42% | $1.24 | 12.3m | 2.7M |
| Codex + GPT-5.6 Sol (max) | 55 | 72% | 37% | $6.35 | 20.6m | 10.2M |
| Claude Code + Sonnet 5.5 (medium) | 46 | 65% | 27% | $0.62 | 8.5m | 1.3M |
| Codex + GPT-5.6 Luna (max) | 43 | 66% | 15% | $0.44 | 23.5m | 14.9M |
| Claude Code + Sonnet 5.5 (low) | 42 | 62% | 25% | $0.48 | 6.3m | 977k |
| Codex + GPT-6 Luna (max) | 41 | 64% | 15% | $0.18 | 21.4m | 10.2M |

Haiku 4.5, Opus 4.8, and GPT-5.6 Terra have no entry.

### 3c. Vals Index v2.1 (2026-10-02)

[I] https://www.vals.ai/benchmarks/vals_index (2026-10-02). Cost is per full index run, so only ratios matter.

| Rank | Model | Score | Cost/run | Duration |
|---|---|---|---|---|
| 2 | Claude Sonnet 5.5 | 67.04% | $21.34 | 1h18m |
| 3 | Claude Opus 5.5 | 66.97% | $32.14 | 1h19m |
| 4 | Claude Fable 5.1 | 65.83% | $28.71 | 1h17m |
| 5 | Claude Opus 5 | 63.67% | $19.31 | 58m |
| 6 | GPT-6 Astra | 63.13% | $18.46 | 28m |
| 7 | Claude Fable 5 | 61.39% | $29.59 | 42m |
| 8 | GPT-6.1 Sol | 61.15% | $3.24 | 43m |
| 10 | GPT-5.6 Sol | 58.01% | $14.24 | 37m |
| 11 | GPT-6 Sol | 57.54% | $7.58 | 29m |
| 13 | Claude Opus 4.8 | 55.10% | $13.14 | 40m |
| 19 | GPT-5.6 Terra | 53.09% | $5.78 | 36m |
| 21 | Claude Sonnet 5 | 51.77% | $13.72 | 54m |
| 22 | GPT-5.6 Luna | 51.69% | $0.82 | 29m |
| 25 | GPT-6 Luna | 51.22% | $0.43 | 31m |

Rank 1 is Gemini 4 Argon, out of scope. Haiku 4.5 is absent.

### 3d. The token-efficiency finding

This is the single most decision-relevant fact in the research, and three independent measurements agree on it:

- Per-token list prices have converged (Opus 5.5 $4/$20 is cheaper per token than Astra $10/$50, Sonnet 5.5 and GPT-6.1 Sol are identical at $2/$10). What differs is tokens spent. At max effort Astra uses ~27k output tokens per AA task, Opus 5.5 ~119k, Sonnet 5.5 ~193k. So Astra costs $3.26 per task against Opus 5.5 $5.98 and Sonnet 5.5 $7.60 despite the lower Claude sticker prices. [I] AA Opus 5.5 and Sonnet 5.5 articles (Sept 22 and 28)
- Same pattern on the Coding Agent Index: Codex + GPT-6.1 Sol (xhigh) reaches 63 for $1.04 and 3.2M tokens, Claude Code + Opus 5.5 (max) reaches 66 for $13.04 and 15.6M tokens. [I] AA coding agents page
- Vals shows the Claude models taking two to three times longer than Astra for a run, consistent with far more tokens. [I] Vals Index (2026-10-02)
- The one measurement that cuts the other way: on Vals, Sonnet 5.5 is cheaper per run than Opus 5.5 ($21 vs $32), while on AA it is more expensive ($7.60 vs $5.98). Both sites ran at max effort. Inference: Sonnet 5.5's verbosity is task-mix dependent, and any single cost number for it is unreliable without naming the workload.
- Effort is a bigger lever than model choice. Opus 5.5 at high (54, $1.82) beats Astra at max (53, $3.26). GPT-6.1 Sol at xhigh beat its own max on the Coding Agent Index (63 vs 60) at two-thirds the cost. [I] AA data via dev.to and AA 6.1 Sol article
- Max effort can fail outright on Claude 5.5 models: Simon Willison's SVG test on Opus 5.5 and Sonnet 5.5 at max thought for the full 128K output tokens and returned nothing, twice. [C] https://simonwillison.net/2026/Sep/22/opus-and-sol-and-luna/ (2026-09-22). Anthropic's own docs say max "adds significant cost for relatively small quality gains" on most workloads. [V] https://platform.claude.com/docs/en/build-with-claude/effort (fetched 2026-10-04)

## 4. Per-model findings

Each entry covers depth (hard, ambiguous, novel problems), execution (long well-specified agentic or terminal loops), cost-to-task, and pricing or effort notes. Independent evidence first, vendor second, inference flagged.

### Anthropic

#### claude-fable-5-1

- Pricing: $10/$50, cache read $0.25, batch 50% off. 1M context, 128K output, default effort high, comparative latency "Slower". No fast mode, no priority tier. Supports per-message effort change (beta) that preserves cache. [V] Fable 5.1 overview; [V] effort page
- Depth: AA 53 at max, now tied with Astra and five points behind Opus 5.5. AA Humanity's Last Exam 59.1% vs Opus 5.5 61.4%. Vals rank 4 overall but rank 1 on LiveCodeBench, MMLU Pro, MMMU Pro, and rank 3 on ProofBench. [I] AA Opus 5.5 article; [I] https://www.vals.ai/models/anthropic_claude-fable-5-1 (fetched 2026-10-04). Vendor: Terminal-Bench-Science 52.6% (vs Opus 5 29.0%), HLE 65% with tools, protein-design and Venus-mapping case studies. [V] Fable 5.1 announcement
- Execution: Coding Agent Index 62 at $12.39, 5.7M tokens, 34.8 min, which is notably fewer tokens and less time than Opus 5.5 or Sonnet 5.5 at max. Vals Terminal-Bench 2.1 85.0% (second to GPT-5.6 Sol at launch). [I] AA coding agents page; [I] Vals Fable 5.1 page
- Refusals and fallback: Vals measured refusal 0.22%, fallback 2.1% overall, but 74% of SRE Bench tasks were fallback-assisted and the score there halves without fallback. Cyber and bio adjacent work triggers it. AA also runs it "with fallback". [I] Vals Fable 5.1 page
- Latency: AA time-to-first-token 259 seconds and 66 tokens/s. CodeRabbit's code-review eval measured 18.6 minutes per review task, 49% slower than Fable 5, and found low effort beat high effort on recall. [I] AA Fable 5.1 model page; [I] CodeRabbit via https://tech-insider.org/claude-fable-5-1-api-setup-2026/ (date not visible, treat as weak)
- Cost-to-task: $7.63 per AA task at max, the most expensive current model on that index. Vals $28.71 per run vs Opus 5.5 $32.14. The cache-read cut is real but AA noted it "only partly offsets higher token usage". [I] AA changelog (2026-09-02)
- Inference: After Sept 22 I found no independent aggregate where Fable 5.1 beats Opus 5.5. Anthropic itself now frames Fable 5.1 as the escalation step when Opus 5.5 at xhigh or max falls short. Its defensible niche is multi-hour autonomous sessions and work where "investigate before acting" pays off, and the evidence for that is vendor positioning plus the lower token count on the coding index, not a benchmark win.

#### claude-opus-5-5

- Pricing: $4/$20, cache read $0.20 (0.05x), fast mode $8/$40. Default effort medium (one level lower than Opus 5's default). Thinking always on and cannot be disabled, forced tool use returns 400. [V] Anthropic pricing; [V] effort page; [V] https://platform.claude.com/docs/en/about-claude/models/choosing-a-model
- Depth: AA 58 at max, rank 1, five points clear of the field, leads six of ten index evals. HLE 61.4%. AA-Briefcase 1822 Elo vs Fable 5.1 1679. Vals rank 3 (66.97%), rank 1 on Terminal-Bench 2.1, Terminal-Bench 4.0, ProofBench, MedScribe, RSI Index. Weak spot: Harvey legal agent 3.75%. [I] AA Opus 5.5 article; [I] https://www.vals.ai/models/anthropic_claude-opus-5-5 (fetched 2026-10-04)
- Execution: AA Terminal-Bench 4.0 59.6% (tied with Astra, well ahead of GPT-6 Sol at 44%). Coding Agent Index 66 at $13.04, 1.1h, 15.6M tokens. Vendor: Terminal-Bench 4.0 66.4%, SWE-bench Pro 89.9%, and a claim that at medium effort it "beats GPT-6 Astra at roughly 20% of the cost per task" on FrontierCode. [I] AA coding agents page; [V] Opus 5.5 announcement
- Community: Claude Code default since Sept 22. Developers on X and HN broadly reported it beating GPT-6 Sol and often Astra on agentic coding ("runs circles around Sol"), with the counter-argument that Sol spam at half the price negates it. One 12-task hands-on had Opus winning 7 of 12 on quality but Astra finishing one task in 32 min for $11 against Opus 40 min for $18. A game-building test found Opus produced the best result both rounds but cost more than twice Astra. [C] https://gist.github.com/swyxio/e8b1d6a32fe816b97aab988ac121783f; [C] https://www.mindstudio.ai/blog/opus-5-5-vs-gpt-6-astra; [C] https://moelueker.com/blog/claude-opus-5-5-vs-gpt-6-astra (all late Sept 2026)
- Cost-to-task: $5.98 at max (level with Opus 5 despite 1.6x the tokens, because of the price cut). The sweet spot is high ($1.82 for 54) or medium ($1.34 for 51). Vendor claims 40% lower cost to run than Opus 5 on typical workloads and half the tokens on Terminal-Bench. [I] AA; [V] announcement
- Effort caveat: Willison's max-effort failure (section 3d). Anthropic warns carrying a high setting over from Opus 5 produces longer turns and more output tokens.

#### claude-sonnet-5-5

- Pricing: $2/$10, cache read $0.20. Default effort high on the API, medium in Claude Code. Effort levels recalibrated relative to Sonnet 5. Lowest thinking setting is `between_tools`, not off. [V] Anthropic pricing; [V] effort page; [I] the-decoder (2026-09-28) for the Claude Code default
- Depth: AA 56 at max, rank 2, two points behind Opus 5.5. Factual knowledge 54% vs Opus 66%. Vals rank 2 (67.04%), effectively tied with Opus 5.5 at two-thirds the cost, rank 1 on Vibe Code Bench, Code Migration, BioMysteryBench. Beats Astra on 14 of 19 shared Vals benchmarks. Code Arena WebDev debut at rank 3, within noise of Astra. [I] AA Sonnet 5.5 article; [I] Vals index; [C] https://www.remio.ai/post/claude-sonnet-5-5-code-arena-debut-lands-two-points-behind-gpt-6-astra (2026-10-01)
- Execution: AA Terminal-Bench 4.0 64%, ahead of both Opus 5.5 and Astra at 60%. Coding Agent Index 68 at max (highest of any entry) but $14.19, 1.5h, 27.7M tokens. At xhigh: 63 for $3.33 and 27 min, which is the Claude-side configuration that matches Codex + 6.1 Sol xhigh on score. Vendor: Terminal-Bench 4.0 70.6% (Sonnet 5 scored 10.3%), SWE-bench Pro 81.3%. [I] AA coding agents page; [V] via https://www.marktechpost.com/2026/09/28/anthropic-releases-claude-sonnet-5-5-70-6-on-terminal-bench-4-0-at-the-same-2-10-price/
- Cost-to-task: this is the model where effort matters most. $0.59 (medium) to $7.60 (max), an 18x spread on one rate card. Anthropic's "up to 30% cheaper per task than Sonnet 5" holds at medium and high (AA: 42% and 44% less) and inverts at max (28% more). AA says it sits off the cost-intelligence Pareto frontier at max. [I] AA Sonnet 5.5 article; [I] https://the-decoder.com/anthropics-claude-sonnet-5-5-nearly-matches-opus-5-5-on-benchmarks-while-costing-up-to-30-percent-less-per-task/ (2026-09-28)
- Inference: for delegation, Sonnet 5.5 at xhigh is the best Claude price-to-execution point found. Never delegate at max without a token budget.

#### claude-haiku-4-5

- Pricing: $1/$5, cache read $0.10. 200K context, 64K output, no effort parameter (extended thinking with budget_tokens), fastest latency. Retirement floor 2026-10-15. [V] Anthropic pricing; [V] models overview
- Depth: AA 17 to 18 (reasoning), below median for its price tier. Not on Vals or the Coding Agent Index. Knowledge cutoff Feb 2025. [I] AA Haiku page via search; [C] wojciech.io (2026-09-23)
- Execution: no independent agentic benchmark on the current suites. Anthropic positions it for "sub-agent tasks" and Claude Code's Explore agent runs on a Haiku-class model. [V] choosing-a-model page; [C] https://www.augmentcode.com/guides/ai-model-routing-guide (2026)
- Cost-to-task: $0.21 to $0.28 per AA task, three to four times GPT-6 Luna's $0.07 for roughly half the score. [I] AA; [C] wojciech.io
- Inference: still the right pick only inside a Claude-only stack (shared caching, same tool conventions). On price and capability it is dominated by GPT-6 Luna. Haiku 5.5 is imminent and should replace it in the reference when it ships.

#### claude-opus-5 (legacy)

- Pricing: $5/$25, cache read $0.50, fast mode $10/$50, default effort high, thinking can be disabled (which Opus 5.5 cannot). [V] pricing; [V] effort page
- AA 51 at max for $5.86, medium 45 for $2.19, low for $1.10. Coding Agent Index 60 at $10.79. Vals rank 5. [I] AA Opus 5 page; [I] AA coding agents; [I] Vals
- Opus 5.5 beats it on every published Anthropic row and costs 20% less per token. One third-party exception: Toolathlon Verified 73.1% vs 72.2%. [I] https://benchlm.ai/compare/claude-opus-5-vs-claude-opus-5-5 (Oct 2026)
- Inference: keep only as a rollback for integrations that disable thinking or force tool calls. Not a delegation target.

#### claude-opus-4-8 (legacy)

- Pricing: $5/$25, retirement floor 2027-05-28. Anthropic recommends xhigh for coding on this model. [V] pricing; [V] effort page
- AA 42 at max for $4.08, 170M tokens (very verbose). Vals rank 13 (55.10%). [I] AA; [I] Vals
- One August source rated it for lower policy-violation rates on tau-bench than GPT-5.5 and recommended it for "high-stakes unattended tool use". That predates every current model. [I] https://www.doit.com/blog/cost-per-task-vs-cost-per-token (Aug 2026)
- Inference: superseded twice. No reason to delegate to it.

#### claude-fable-5 (legacy)

- Pricing: $10/$50 with cache read $1.00, four times Fable 5.1's. No per-message effort. Retirement floor 2027-06-09. [V] pricing; [V] effort page
- AA 50 (max, Opus 4.8 fallback) for $8.75, TTFT 94 s, 64 tokens/s. AA now only benchmarks it at the default workload. Vals rank 7. [I] AA Fable 5 page; [I] Vals
- Inference: strictly dominated by Fable 5.1 at the same price. Remove from active recommendations.

#### claude-sonnet-5 (legacy)

- Pricing: $2/$10 permanent. Retirement floor 2027-06-30. [V] pricing
- AA 38 at max for $5.09 with 370M tokens (the most verbose Claude before Sonnet 5.5), high 32 for $1.79. Vals rank 21. Vendor Terminal-Bench 4.0 was 10.3%. [I] AA Sonnet 5 page; [I] Vals; [V] via marktechpost
- Inference: Sonnet 5.5 beats it at every effort level at the same price. Remove.

### OpenAI

#### gpt-6-astra

- Pricing: $10/$50, cached $1, 272K surcharge, Fast 2x, Ultrafast 6x. 1.05M context, 128K output, knowledge cutoff 2026-04-30. Effort low/medium/high/xhigh/max. Astra Pro variant exists. [V] https://developers.openai.com/api/docs/models/gpt-6-astra (fetched 2026-10-04); [V] OpenAI pricing
- Depth: AA 53 at max, tied with Fable 5.1, behind Opus 5.5 by 5. All five effort levels on AA's cost-intelligence frontier at launch. GDPval-AA regression of ~45 Elo attributed to using 24 turns per task vs 45 for GPT-5.6 Sol. Vals rank 6 (63.13%), fastest run of any frontier model at 28 min. [I] AA Astra article (2026-09-09); [I] Vals. Vendor (via press, openai.com not fetchable): ARC-AGI-3 98.6%, FrontierMath Tier 4 97.6%, Terminal-Bench-Science 64.6%, OSWorld 72.6%, DeepSWE 74.1%, "best model for software engineering to date". [V] via https://thenewstack.io/openai-gpt6-astra-benchmarks/ and https://www.vellum.ai/blog/gpt-6-astra-benchmarks-explained (Sept 2026). Anthropic's table puts Astra's HLE at 57.2% vs Opus 5.5 67.7%. [V] Opus 5.5 announcement
- Execution: AA Terminal-Bench 4.0 59.6% (tie with Opus 5.5). Coding Agent Index 62 at $7.47, 29 min, 3.3M tokens. Vendor Terminal-Bench 4.0 57.7 to 57.9%. Hands-on reviewers describe it as faster and more "obedient" than Opus 5.5, asking more clarifying questions in Codex, stronger on structured technical tasks (BenchCAD 95.9%). [I] AA; [C] mindstudio and geeky-gadgets reviews (late Sept 2026)
- Cost-to-task: $0.82 (low) to $3.26 (max) per AA task. Codex at max $7.47 per coding task. Astra at max uses roughly a third of Fable 5.1's tokens and a quarter of Opus 5.5's. OpenAI's own effort guidance: medium for agentic coding and research, high for complex debugging, xhigh only when evals show gain. [I] AA Astra article; [V] via https://paddo.dev/blog/gpt-6-astra-critical-generally-available/
- Inference: the best choice when wall-clock time matters, when the task is long-context but under 272K, or for the science and math problems where OpenAI's numbers are far ahead and nobody has independently contradicted them. Not the best choice for terminal-heavy loops, where Opus 5.5 and Sonnet 5.5 lead independently.

#### gpt-6.1-sol

- Pricing: $2/$10, cached $0.10, 272K surcharge. Default effort medium. `none` and `minimal` removed. Chat Completions cannot call tools on it. Ultrafast "coming soon". [V] OpenAI 6.1 Sol model page; [I] VentureBeat (2026-09-29)
- Depth: AA 52 at max, one point below Astra, four above GPT-6 Sol. Vals rank 8 (61.15%) at $3.24 per run, the cheapest run among frontier-adjacent models by a factor of five. [I] AA 6.1 Sol article; [I] Vals
- Execution: Coding Agent Index 63 at xhigh for $1.04, 15.5 min, 3.2M tokens, one point above Astra at a seventh of the cost. DeepSWE 73% (best of any entry). Terminal-Bench 4.0 55%, behind Opus 5.5 and Sonnet 5.5. Vendor: DeepSWE 75.2% at high (above Astra), OSWorld 71.4%, beats Opus 5.5 at medium on AutomationBench, $5.47 vs $23.21 (Opus 5.5) per Terminal-Bench-Science task. [I] AA coding agents; [V] via https://x.com/OpenAIDevs/status/2104993067942219873 and Vellum (2026-09-29). Cognition's FrontierCode run: 6.1 Sol in Codex 50.2% at $0.36 vs Opus 5.5 in Claude Code 54.6% at $0.80. [I] via https://www.techrepublic.com/article/news-gpt-6-sol-vs-claude-opus-5-5/ (Oct 2026), second-hand
- Community: HN launch thread read it as "half the price of Opus 5.5" and as fixing GPT-6 Sol's regression. Some developers reported rollout lag in Codex. Nobody has independently confirmed the GPT-6 Sol knowledge-work regression (GDPval) is fixed in 6.1. [C] https://news.ycombinator.com/item?id=49897054 (2026-09-29)
- Cost-to-task: $0.13 to $0.72 per AA task. The cheapest route to a score above 50 on any independent index.
- Inference: the default executor for well-specified agentic coding on cost grounds. Prefer xhigh over max.

#### gpt-6-sol

- Pricing: $2/$10, cached $0.20. Still served, still a deprecation migration target. Codex default on Sept 22. [V] OpenAI pricing; [V] deprecations
- AA 48 at max for $1.06. Regressions vs GPT-5.6 Sol on GDPval-AA (~100 Elo), AA-Briefcase, HLE, GDP.pdf, CritPt. Coding Agent Index 57 at $2.99. Vals rank 11. [I] AA GPT-6 Sol article; [I] AA coding agents; [I] Vals
- Community: HN comments called it "a huge regression compared to Sol 5.6" and reported switching to Opus 5.5 or back to 5.6 Sol within days. [C] HN thread above
- Inference: superseded after seven days. Only pick it over 6.1 Sol if you need effort `none`.

#### gpt-6-luna

- Pricing: $0.10/$0.50, cached $0.01. 1.05M context, 128K output. Named replacement for gpt-5.4-nano. [V] OpenAI pricing; [V] deprecations
- AA 37 to 38 at max for $0.07, 141 tokens/s. Regressions vs 5.6 Luna: GDPval -75 Elo, Briefcase -45 Elo ("omits rubric elements"). Coding Agent Index 41 at $0.18, DeepSWE 64%, Terminal-Bench 4.0 15%. Vals rank 25 at $0.43 per run. [I] AA Luna page; [I] AA GPT-6 Sol and Luna article; [I] AA coding agents; [I] Vals
- Independent reviewer's verdict: "15% on Terminal-Bench is not a model you let near a shell unsupervised, however cheap the task is." Luna generated about twice the tokens of Haiku 4.5 on the index run and was still three times cheaper. [C] wojciech.io (2026-09-23)
- Inference: the cheap executor for classify, extract, transform, summarise, and simple well-specified code edits with cheap verification. Not for terminal loops or anything needing judgement.

#### gpt-5.6-sol

- Pricing: $4/$20 promotional through at least 2026-11-21, cached $0.40. Launched July 9 at $5/$30. Supports effort `none`. [V] OpenAI pricing; [I] DataCamp (July 2026)
- AA 47 at max for $1.99. AA marks it as having a newer alternative. Coding Agent Index 55 at $6.35 with 10.2M tokens (three times Astra's). Vals rank 10. [I] AA 5.6 Sol page; [I] AA coding agents; [I] Vals
- Was the Terminal-Bench 2.1 leader at launch (AA 89.5% at xhigh). Some developers stayed on it when GPT-6 Sol regressed. 6.1 Sol now beats it on every AA and OpenAI number I found at a fraction of the cost. [I] AA; [C] HN
- Inference: legacy. Keep only as a known-good fallback until a deprecation notice appears.

#### gpt-5.6-terra

- Pricing: $2/$12, cached $0.20. No GPT-6 successor. [V] OpenAI pricing
- AA 42 at max for $1.40 (120M tokens), 40 at low for far fewer tokens, non-reasoning 34. A July community analysis of AA data found Terra "never on the intelligence vs cost Pareto frontier". Vals rank 19 at $5.78 per run. No Coding Agent Index entry. [I] AA Terra pages via search; [C] https://gist.github.com/IgorWarzocha/60bfd11731f15cf8802f0b6e80d47ac7 (2026-07-11); [I] Vals
- Inference: dominated by GPT-6.1 Sol (higher score, same input price, cheaper output, cheaper cache). No independent signal beyond AA and Vals. Remove from active recommendations.

#### gpt-5.6-luna

- Pricing: $0.20/$1.20 after a July 30 cut, cached $0.02. ChatGPT free-tier model. [V] OpenAI pricing; [I] DataCamp
- AA 37 at max for $0.18, 129 tokens/s. Coding Agent Index 43 at $0.44 (two points above GPT-6 Luna at 2.4x the cost), Terminal-Bench 4.0 15%. Vals rank 22, slightly above GPT-6 Luna at twice the cost. [I] AA 5.6 Luna page; [I] AA coding agents; [I] Vals
- Inference: GPT-6 Luna is cheaper for the same intelligence. 5.6 Luna is marginally better on deliverable completeness (Briefcase, GDPval), which rarely matters for delegated executor work. Legacy.

## 5. How I would choose

Name the effort level in every recommendation. The same model spans an 8x to 18x cost range depending on it, and the independent data shows effort moves the bill more than the model does.

By task archetype:

1. Hard, ambiguous, or novel problem (depth first). Opus 5.5 at high as the default (AA 54 for $1.82), xhigh if the first pass is weak (56 for $3.46). Escalate to Fable 5.1 at high only when Opus 5.5 at xhigh demonstrably falls short and a slow, possibly refused run is acceptable. Use Astra at high or xhigh when the problem is science or math shaped, or when the answer is needed quickly. GPT-6.1 Sol at xhigh is the budget depth option (51 for $0.39).
2. Long, well-specified agentic or terminal loop (execution first). Codex + GPT-6.1 Sol at xhigh is the cost-efficiency winner (63 for $1.04). Claude Code + Sonnet 5.5 at xhigh is the Claude equivalent (63 for $3.33) and leads on Terminal-Bench 4.0, so prefer it when shell reliability is the bottleneck. Opus 5.5 at medium or high when the loop needs judgement mid-way. Avoid max effort on any Claude 5.5 model for unattended loops without a hard token cap.
3. Cheap bulk executor (cost first). GPT-6 Luna for classify, extract, transform, and small verified edits. Haiku 4.5 only in Claude-only pipelines. Neither for unsupervised shell work (both tiers score 15% on Terminal-Bench 4.0 where measured).
4. Long context. Over 272K input tokens OpenAI doubles input cost for the whole request. Anthropic charges flat across 1M. Route very large contexts to Claude unless Astra's speed is needed.
5. Harness coupling. The coding index numbers are agent plus model pairs. Claude Code and Codex differ in context handling, so the reference should say which CLI each recommendation assumes.

Models to drop from active recommendations: Fable 5, Sonnet 5, Opus 5, GPT-6 Sol, GPT-5.6 Terra. Keep Opus 4.8 and GPT-5.6 Sol and Luna in a legacy list with the reason to ever pick them (compatibility, effort `none`, thinking off).

## 6. How the reference should be organised

- One roster table with the facts that do not need interpretation: ID, status (current, legacy, superseded), release date, retirement floor, price per MTok in and out, cache-read price, context and max output, effort levels and default, latency tier, long-context surcharge yes or no. Date-stamp the table.
- One cost-to-task table with the three independent measurements side by side (AA Intelligence Index, AA Coding Agent Index with harness named, Vals), each row naming effort level and index version. This is the table that stops people reasoning from sticker price. Mark that nearly all of it comes from AA so a reader knows the dependency.
- Per-axis ratings (depth, execution, cost-to-task) are useful only if each cell names the effort level it was rated at. A rating like "Opus 5.5: depth high" is misleading because it is a different model at low.
- A short decision guide by task archetype like section 5, with a primary and a fallback per archetype.
- Per-model notes limited to what the tables cannot carry: refusal and fallback behaviour, breaking API constraints (thinking cannot be disabled, forced tool use errors, effort `none` removed), known failure modes (max effort hitting output cap), and the single independent source that supports the main claim.
- A superseded section listing the dominated models and the one reason each might still be chosen.
- A "watch" line for Haiku 5.5 and GPT-6.1 Sol Ultrafast, both announced and undated.

## 7. Claims resting on a single source

- All AA Intelligence Index per-effort figures, output-tokens-per-task figures, and Coding Agent Index figures: Artificial Analysis. The dev.to and Vellum pages relay AA, they do not corroborate it.
- The Vals rankings and per-run costs: Vals AI.
- GPT-6.1 Astra being scrapped: a WSJ report I could not read, relayed by TechCrunch and others.
- Terminal-Bench-Science, FrontierMath, ARC-AGI-3 numbers: vendor only. No independent run found.
- The CodeRabbit Fable 5.1 latency numbers and the Cognition FrontierCode numbers: single third-party runs relayed by secondary pages.
- Haiku 4.5's current standing: AA plus one blog that cites AA.
- Community sentiment on GPT-6 Sol's regression and Opus 5.5's lead: a few HN and X comments, not a survey.
