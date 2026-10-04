# Research report: model capabilities for the delegate skill

**Author model ID:** claude-sonnet-5-5
**Date of research:** 2026-10-04
**Web search:** worked. WebFetch worked for most pages. Fetch failed (HTTP 403) for openai.com/index/introducing-gpt-6-1-sol and rollingout.com, so for OpenAI first-party claims I rely on third-party coverage of them.

Method caveats you should know before using any number below:

- WebFetch passes pages through a small summarizer model, and WebSearch answers are also model-written summaries. Where I quote a number I note whether I saw it in a fetched page or only in a search summary. A few summaries disagreed with each other and I flag those.
- Artificial Analysis (AA) re-bases its Intelligence Index between versions. Fable 5.1 scored 66 on 2026-09-01, but the same model is described as 53 (tied with Astra) on 2026-09-09, and GPT-5.6 Sol went from 59 (Jul) to about 47 now. **Only compare AA index scores that come from the same article date or version (currently v4.3.2).** Costs per task shift with them (Fable 5.1 max: $3.76 on Sep 1, $7.63 on Sep 9).
- "Independent" below means a third party measured it. Many "independent" aggregator blogs (codersera, kingy.ai, emergent.sh, eesel.ai, myclaw, benchlm) mostly re-quote AA, Vals and vendor numbers. Treat them as one source family, not corroboration.

## 1. Catalog changes that matter (since 2026-08-05)

| Date | Change | Source (kind) |
|---|---|---|
| Aug 5 | claude-opus-4-1 retired | https://platform.claude.com/docs/en/about-claude/model-deprecations (undated page, shows entries to 2026-09-30; vendor) |
| Aug 10 | Sonnet 5 $2/$10 made permanent (was introductory, $3/$15 planned from Sep 1) | search summary citing Anthropic changelog; neomanex.com/news/claude-sonnet-5-price-cut-made-permanent (secondary, date not seen). Many pages still show the old $3/$15 schedule |
| Aug 21-28 | GPT-5.6 Sol cut from $5/$30 to $4/$20 (sources disagree on exact date and whether "promotional") | eesel.ai, improvado.io via search (secondary, ~Sep) |
| Sep 1 | claude-fable-5-1 released. Same $10/$50, cache read cut $1.00 to $0.25. claude-fable-5 still callable | AA https://artificialanalysis.ai/articles/claude-fable-5-1 (2026-09-01, independent) |
| Sep 3 | GPT-6 Astra to limited orgs, wider over following days. $10/$50 | lindy.ai, codersera via search (secondary) |
| Sep 22 | claude-opus-5-5 released ($4/$20, down from Opus 5 $5/$25; cache read $0.20) | https://www.anthropic.com/news/claude-opus-5-5 (2026-09-22, vendor) |
| Sep 22 | gpt-6-sol and gpt-6-luna released. Sol $2/$10 (was $4/$20 for 5.6 Sol), Luna $0.10/$0.50 (was $0.20/$1.20). No "GPT-6 Terra" exists | codersera, requesty, The New Stack via search (secondary, Sep 22-23) |
| Sep 24 | Anthropic began billing some pre-output refusals (bio, frontier_llm, reasoning_extraction; cyber still free) | search summary of support/analysis pages (secondary) |
| Sep 28 | claude-sonnet-5-5 released, $2/$10 unchanged | https://www.the-decoder.com/ (2026-09-28, news) and https://www.vals.ai/models/anthropic_claude-sonnet-5-5 |
| Sep 29 | gpt-6.1-sol replaces gpt-6-sol after 7 days. $2/$10, cache read discount 90% to 95% | AA https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence (2026-09-29, independent); vellum.ai (2026-09-29) |
| Sep 30 | claude-sonnet-4-5 deprecated, retires 2026-11-30, replacement named as claude-sonnet-5-5 | deprecations page (vendor) |
| ~Sep 28 | OpenAI reportedly cancelled "GPT-6.1 Astra". Astra (gpt-6-astra) remains the top OpenAI tier, no successor | CNBC https://www.cnbc.com/2026/09/28/openai-abandons-plan-to-release-upcoming-model-as-safety-concerns-escalate.html (via search, news) |

### Lifecycle and ID status of the briefed models

From the Anthropic deprecations page (vendor, fetched live 2026-10-04): claude-fable-5-1, claude-fable-5, claude-opus-5-5, claude-opus-5, claude-opus-4-8, claude-sonnet-5-5, claude-sonnet-5 are all **Active**, with earliest retirement 2027-06-09 to 2027-09-28. claude-haiku-4-5-20251001 is **Active**, "not sooner than October 15, 2026" (that is a floor, with at least 60 days' notice promised, so earliest realistic retirement is late Nov/Dec).

- **Haiku:** no newer Haiku exists. Anthropic said on 2026-09-22 that "Claude Haiku 5.5" is coming "in the coming weeks". As of the latest pages I found (about Sep 29) it was unreleased, with no ID or price. Worth re-checking right before shipping the doc. (Sources: x.com/mikeyk/status/2102441803253535060, cellcog.ai, secondary.)
- **Missing from your list, current on Anthropic's page:** `claude-mythos-5-1` and `claude-mythos-5` (Active). Sources describe them as restricted-access siblings of Fable, not generally available, so probably leave out of the catalog but mention they exist. Also still Active but legacy: claude-opus-4-7, claude-opus-4-6, claude-sonnet-4-6, claude-opus-4-5-20251101 (retires not sooner than 2026-11-24).
- **OpenAI:** all listed IDs exist per search, but note: (a) `gpt-6-sol` was superseded by `gpt-6.1-sol` after 7 days. OpenAI's deprecations page (https://developers.openai.com/api/docs/deprecations, undated) still names gpt-6-sol as a replacement target (shutdown Apr 1, 2027 for the models it replaces), so it is alive but there is little reason to pick it. (b) `gpt-5.6-sol/terra/luna` have no retirement date, and OpenAI points several older retiring models to them (shutdowns Oct 23 to Dec 11, 2026). (c) **Name reuse hazard:** GPT-6 Sol and Luna are different models from GPT-5.6 Sol and Luna with the same tier names. Several comparison blogs mix them up. (d) There is no gpt-6-terra and no GPT-6.1 Luna.
- I found no model from Anthropic or OpenAI missing from your list other than the Mythos pair.

## 2. Pricing (USD per 1M tokens, standard API)

| Model | Input | Output | Cache read | Notes |
|---|---|---|---|---|
| claude-fable-5-1 | 10 | 50 | 0.25 | batch 5/25. Fable 5 same but cache read 1.00 |
| claude-opus-5-5 | 4 | 20 | 0.20 | fast mode 8/40. Efforts: low, medium (default), high, xhigh, max |
| claude-opus-5 | 5 | 25 | 0.50 | same price as Opus 4.8 |
| claude-opus-4-8 | 5 | 25 | n/f | |
| claude-sonnet-5-5 | 2 | 10 | 0.20 | batch 1/5 |
| claude-sonnet-5 | 2 | 10 | n/f | tokenizer yields 1.0-1.35x more tokens than older models |
| claude-haiku-4-5 | 1 | 5 | 0.10 | 200K context. Others are 1M |
| gpt-6-astra | 10 | 50 | 1.00 | |
| gpt-6.1-sol / gpt-6-sol | 2 | 10 | 0.10 (6.1) / 0.20 (6) | |
| gpt-6-luna | 0.10 | 0.50 | 0.01 | |
| gpt-5.6-sol | 4 (disputed, was 5) | 20 (disputed, was 30) | | |
| gpt-5.6-terra | 2 | 12 | | cut 20% Jul 30 |
| gpt-5.6-luna | 0.20 | 1.20 | | cut 80% Jul 30 |

Sources: Anthropic Opus 5.5 page (vendor, 2026-09-22); the-decoder and codersera Sonnet 5.5 coverage (2026-09-28); AA Fable 5.1 article (2026-09-01); OpenAI-side figures from codersera https://codersera.com/blog/gpt-6-sol-luna-complete-guide-2026/ and vellum (secondary, Sep 22-29); Haiku/Luna comparison via llm-stats and orcarouter (secondary). I could not read OpenAI's own pricing page. OpenAI modifiers (per codersera): prompts over 272K input tokens bill 2x input and 1.5x output on the whole request. Batch and Flex are 50%. Fast mode is 2x.

## 3. Cost-to-task (the main point)

Sticker price is a poor guide. Output tokens per AA Intelligence Index task at max effort (AA, independent): **Sonnet 5.5 about 193k (highest AA has measured), Opus 5.5 about 119k, Opus 5 about 73k, Fable 5.1 about 78k (max, with fallback), GPT-6 Astra about 27k**. AA says Sonnet 5.5 uses about 7x Astra's tokens. So Sonnet 5.5 at half Opus's price is *more* expensive per task at max effort.

Source: https://artificialanalysis.ai/articles/claude-sonnet-5-5 (2026-09-28) and https://artificialanalysis.ai/articles/claude-opus-5-5 (2026-09-22), both fetched. Independent. Astra figure: https://artificialanalysis.ai/articles/benchmarking-gpt-6-astra (2026-09-09, independent).

AA cost per index task and score by effort. These tables come from third-party captures of AA data (eesel.ai, via search), not from AA pages I could read, so treat the per-effort numbers as probable but unverified. Max-effort numbers match AA's own articles.

| Effort | Opus 5.5 score / $ | Sonnet 5.5 score / $ | GPT-6.1 Sol score / $ |
|---|---|---|---|
| low | 42 / 0.55 | 36 / 0.41 | 42 / 0.13 |
| medium | 51 / 1.34 | 41 / 0.59 | 48 / 0.21 |
| high | 54 / 1.82 | 47 / 1.08 | 50 / 0.32 |
| xhigh | 56 / 3.46 | 52 / 2.74 | 51 / 0.39 |
| max | 58 / 5.98 | 56 / 7.60 | 52 / 0.72 |

Other max-effort points (AA, independent): GPT-6 Astra 53 / $3.26 (Sep 9). Fable 5.1 53 / $7.63 on the same index, or $3.91 at high with score 51 (emergent.sh quoting AA, 2026-09-24). GPT-6 Sol $1.05, GPT-5.6 Sol $1.99 (AA 6.1 Sol article). GPT-6 Luna index 37-38, about $0.07/task. Haiku 4.5 (reasoning) index 17, about $0.21/task, about 18.5k tokens/task vs Luna's 50.5k (AA via llm-stats/orcarouter, secondary). I did not find AA per-effort data for Opus 5, Opus 4.8, Fable 5 or Sonnet 5 on the current index version.

**Inferences from this:**

1. Opus 5.5 at medium (51 for $1.34) matches Fable 5.1 at high (51 for $3.91), about a third of the cost. Opus 5.5 effort levels are mostly on AA's cost frontier. Sonnet 5.5 at max is not.
2. Sonnet 5.5 is cheaper than Opus 5.5 at every effort below max, but Opus 5.5 at medium (51) beats Sonnet 5.5 at high (47) for $0.26 more. If quality matters, Opus medium may dominate Sonnet high. Pick Sonnet when the task is easy enough that its medium/high suffices.
3. The cost ordering flips by benchmark. On Vals (independent), Sonnet 5.5 cost per test is $21.34 vs Opus 5.5 $32.77 (vals.ai Sonnet page; kingy.ai quotes $20.80, small discrepancy), with both within error on the Vals Index (Sonnet 67.04 to 69.22 depending on source, Opus 69.69). On AA at max, Sonnet costs more. Effort level and workload decide.
4. GPT-6.1 Sol is the cheapest by far per index task: about $0.39 at xhigh for about 51, versus $3.26 for Astra and $3.46 for Opus 5.5 at xhigh. AA says the best coding setting for Sol is xhigh, not max, with the Coding Agent Index 1 point above Astra at under 15% of Astra's cost (the AA article text I fetched says xhigh beat max by 3 points on that index). Caveat: Sol uses 10-30% more output tokens than GPT-6 Sol, and it is slow (see below).
5. Astra's real cost depends on the task: low-token for its score, but at $10/$50 and with a 272K surcharge it only pays off when mistakes are costly. One reported developer test (ilikekillnerds / search summary, single anecdote) had Sol-high at $31.79 and 75 minutes vs Astra-medium at $25.67 and 51 minutes for comparable work. On ARC-AGI-3 Astra at max was the cheapest run overall because it needed fewer actions. On OpenAI-reported Terminal-Bench Science, Sol costs $5.47 per task vs about $23 for Astra with Astra still scoring highest (vendor claim, via search).
6. Luna vs Haiku 4.5: Luna is 10x cheaper per token, about 3x cheaper per task (AA, via secondary), and about 2x the index score (37-38 vs 17). Haiku wins only for staying inside Anthropic or compliance terms. Luna at low effort was reported unusable for agentic work (one hands-on report, secondary), so budget for medium or higher.
7. Fable 5.1 vs Fable 5: cheaper cache reads do not mean cheaper tasks. AA measured Fable 5.1 at 1.7x the output tokens and 20% more per task than Fable 5 (max). The New Stack's four-task test found equal quality (24/24), 70% more tokens and 34% more cost for 5.1 (https://thenewstack.io/claude-fable-upgrade-tested/, search summary only, I could not fetch the page). Long cache-heavy agents are the exception that can come out cheaper.

## 4. Depth and execution, by model

Ratings are my inference from the evidence cited. Independent signal is thinner than vendor signal for everything except the AA/Vals/CodeRabbit data.

**claude-fable-5-1** (depth: highest Anthropic, execution: good but expensive)
- AA ranked it #1 at launch (score 66 on the old index, Sep 1), but on the Sep 22 index Opus 5.5 leads "by several points" (AA Opus 5.5 article). On Anthropic's own nine launch benchmarks Opus 5.5 beats Fable 5.1 on every row (vendor, via emergent.sh 2026-09-24).
- Community: Zvi's roundup (2026-09-05, https://thezvi.substack.com/p/claude-mythos-51-and-fable-51-capabilities, fetched, aggregation of social posts) reports strong feedback on hard agentic coding and long jobs, plus complaints of 3x token burn "given free rein" versus Fable 5.0. Early impressions there split between "Astra a bit more capable" and Fable. Anecdotal.
- Anthropic's own guidance via the emergent.sh write-up: start on Opus 5.5, escalate to Fable 5.1 only when a hard open-ended problem defeats Opus at higher effort, and Fable is the one for security vulnerability research since Opus 5.5 reroutes most cyber work. Treat as vendor framing.

**claude-opus-5-5** (best all-round Anthropic model; depth: high, execution: very strong)
- Highest AA index score measured (58). AA's own harness gave Terminal-Bench 4.0 59.6% (level with Astra) versus Anthropic's reported 66.4%, so vendor numbers run about 7 points above independent for this benchmark (compare Astra: vendor-run 57.9 in one comparison, AA 59).
- Terminal-Bench 4.0 on Sonnet 5.5 shows the same pattern: vendor 70.6%, Vals 64.1%, AA 64%.
- Anthropic's launch notes cite customer anecdotes of finishing in fewer turns and tokens. Vendor-sourced, not independently checked.
- CodeRabbit (vendor of a review product, but runs its own set; https://www.coderabbit.ai/blog/sonnet-5-5-model-review, 2026-09-28): Opus 5.5 caught 8/13 known issues at 66.7% precision vs Sonnet 5.5 6/13 at 41.2%. Independent of Anthropic.
- Practical constraint: cyber safeguards reroute most offensive-cyber requests to Opus 4.8, bio-adjacent to Opus 5. On the raw API a flagged request can return HTTP 200 with empty content unless the `fallbacks` option is set (analysis pages, secondary). A delegated agent doing security work may silently get a different or empty answer.

**claude-sonnet-5-5** (execution workhorse; depth: good, below Opus on hard work)
- AA index 56 (#2). Vals Index 67.04, #2 of 43, #1 on several Vals leaderboards (Vibe Code Bench, Code Migration, ProofBench). Independent.
- Anthropic itself says Opus 5.5 stays clearly stronger on complex open-ended work (the-decoder). CodeRabbit agrees on review depth. Sonnet 5.5 is a large jump over Sonnet 5 (CodeRabbit: 6 vs 4 of 13 issues, about 40% of the cost, 5:27 vs 9:55 review time).
- Fast: AA reports 139 tokens/s vs 61 for GPT-6.1 Sol (max), per aitoolsreview.co.uk quoting AA (secondary).
- Cost trap: token hunger at high effort (see section 3). Reviewers advise medium for everyday work and high for complex coding (dreasays substack, 2026-09-29, one author). Sonnet 5.5 also has the new cyber safeguards, with Sonnet 5 as the fallback model.
- One caution: the vendor figure "Terminal-Bench 4.0: 70.6% vs 10.3% for Sonnet 5" looks like a large harness-related jump, and the 10.3 figure appeared in two summaries I could not verify against Anthropic's page.

**claude-opus-5** (legacy; little reason to choose)
- Released 2026-07-24 at $5/$25 (same as Opus 4.8). Was AA #1 at 61 on the older index. Opus 5.5 is 20% cheaper per token and better on every Anthropic launch benchmark (Anthropic page, vendor: Terminal-Bench 66.4 vs 52.3, CursorBench 57.8 vs 46.6, GDPval-AA 1846 vs 1708). AA noted that Opus 5.5 uses more tokens (119k vs 73k) so cost per task is about the same ($5.98 vs $5.86 at max). Reasons to keep Opus 5: reproducibility pinning, and it is the fallback model for some safeguard categories. Also the cheaper-token-per-task choice if you only need its quality level. Independent head-to-head data between Opus 5 and 5.5 was thin.

**claude-opus-4-8** (legacy)
- Released 2026-05-28, $5/$25. Index 56 on the July index vs Opus 5 at 61 (Developers Digest quoting AA, secondary). It is where Anthropic routes flagged cyber work, so it is the one to use for security tasks that Opus 5.5 and Fable 5.1 reroute (threatfrontier.com and others, secondary). Outside that, superseded.

**claude-fable-5** (legacy)
- Released 2026-06-09, $10/$50. AA July index 60. Fable 5.1 has the same price and higher scores but the same-or-more tokens per task. Fable 5 stays Active (not sooner than 2027-06-09 retirement). Use only for pinning or if 5.1's token appetite or API changes (a forced-tool-use breaking change was reported by one source) cause trouble.

**claude-sonnet-5** (legacy)
- 2026-06-30, $2/$10. Strictly dominated by Sonnet 5.5 at the same price on every source I found, aside from keeping it as the cyber-safe fallback.

**claude-haiku-4-5** (cheap, old)
- 2025-10-15 release, $1/$5. AA index 17 (reasoning), far below Luna 37-38. Still current Haiku; Haiku 5.5 announced but unreleased. Only independent comparison data was AA via aggregators.

**gpt-6-astra** (depth: top OpenAI, especially science and maths)
- AA index 53 (v4.3.2) when Fable 5.1 was 53 on the same index; now behind Opus 5.5 (58) and Sonnet 5.5 (56). AA coding agent index 62 (tied with Fable 5.1 in Claude Code, Sep 9). Terminal-Bench 4.0 AA 59%.
- Vendor claims: FrontierMath Tier 4 97.6%, GPQA Diamond 96%. Independent signal for those: none that I found. AA found it led Terminal-Bench Science, and that Sol trails it most on hard science and computer-use tasks (via kingy.ai / AA text).
- AA caveats: GDPval-AA dropped about 45 Elo vs GPT-5.6 Sol, and presentation quality fell.
- Vellum (comparison blog) frames Astra as stronger at deep architectural refactoring. Opus 5.5 vs Astra: coding benchmarks roughly tied, Opus ahead on Terminal-Bench by vendor numbers, Astra ahead on science (codingfleet, vellum, benchlm, mostly re-quoting vendor numbers; no controlled hard-bug head-to-head found).
- Token-efficient (27k/task vs 119k Opus, 78k Fable), which is its real cost advantage over Fable.

**gpt-6.1-sol** (execution value leader)
- AA: 1 point below Astra on the index, Coding Agent Index 1-2 points off Astra depending on effort, $0.72 vs $3.26 at max, 12-point Terminal-Bench 4.0 gain over GPT-6 Sol (AA 6.1 Sol article, 2026-09-29, fetched). Trails Sonnet 5.5 and Opus 5.5 on the AA index (52 vs 56 vs 58, via datacamp and aitoolsreview quoting AA, with one fetch summary giving 59/60 for Sol/Astra that I believe reflects a different index version).
- Sol vs Sonnet 5.5 (AA via aitoolsreview): Terminal-Bench 4.0 64% vs 56%, SciCode 61% vs 54%. One hands-on test (DataCamp, single task, Dijkstra visualizer, OpenCode harness): Sol more careful (rubric 5.0 vs 4.7), Sonnet faster and fewer turns (4 vs 5). Sol refused a bad-input case that Sonnet caveated and completed.
- OpenAI-reported DeepSWE v1.1 75.2% (vs Astra 74.8%, Vellum) and AutomationBench, OSWorld 2.0 71.4% (vendor numbers, via vellum 2026-09-29). Independent verification pending beyond AA.
- Downsides: slow. AA max-effort time per task about 569s, far above lower efforts. A Codex GitHub issue (https://github.com/openai/codex/issues/47656, user report on GPT-6 Sol) says tasks went from about 20 to about 50 minutes versus GPT-5.6 Sol, and a Threads user called 6.1 Sol "sooooo slow". These are anecdotes, plausibly load related. AA also found hallucination rate improved 60% to 54% but is still high (AA-Omniscience, relative to the field I cannot say).

**gpt-6-sol** (superseded by 6.1 Sol)
- AA index 48 at max, $1.05/task, Terminal-Bench 4.0 44% (AA via search summaries). Same price as 6.1 Sol, strictly worse on every comparison. Only reason: pinning.

**gpt-6-luna** (cheap tier)
- AA index 37-38 at max, 34 at xhigh, 32 at high, 21-22 low. Agentic coding mixed: Coding Agent Index 41 vs 43 for GPT-5.6 Luna, Terminal-Bench 4.0 13% vs 12%, DeepSWE 64% vs 66% (breakdown quoting AA, secondary). A cost improvement over 5.6 Luna, not a capability one. Verbose at max (140M tokens on the index).
- Same context (1.05M) and reasoning controls as Sol and Astra.

**gpt-5.6-sol / terra / luna** (previous generation, still available)
- AA at launch (2026-07-09, https://artificialanalysis.ai/articles/gpt-5-6-has-landed, fetched, on the July index): Sol 59 / $1.04, Terra 55 / $0.55, Luna 51 / $0.21. Sol led the Coding Agent Index in Codex at 80 (Terra 77, Luna 75). Those index values are pre-rebase, don't compare with Sep numbers. AA later said Sol, not Terra, and Luna sit on the cost frontier, "Luna and Sol are ahead of Terra at every point" (AA tweet via search, July).
- Now: GPT-5.6 Sol costs 2x GPT-6.1 Sol per token and scores lower on the current index (about 47 vs 52), so there is little reason to use it. **Terra has no GPT-6 successor** and sits between Sol and Luna in price. AA says it is dominated, so skip it unless you need a mid-price OpenAI pin. Several retiring OpenAI models point to the 5.6 family, so it will stay alive through at least Dec 2026.

## 5. How I would choose

Ranked by role, with the evidence quality noted:

1. **Hard, ambiguous, or high cost-of-error work:** claude-opus-5-5 at high or xhigh first. Escalate to claude-fable-5-1 (Anthropic's guidance) or gpt-6-astra (science and maths, plus token efficiency) only if Opus fails. Fable 5.1 is not clearly better than Opus 5.5 on independent data (AA index, CodeRabbit-style evals favour Opus), so treat "Fable = deeper" as a vendor claim plus anecdotes. Astra is the stronger pick for science, maths and computer use, per OpenAI-reported and AA Terminal-Bench Science results.
2. **Well-specified agentic or terminal execution:** claude-sonnet-5-5 at medium or high (fast, strong on Vals/AA coding) or gpt-6.1-sol at xhigh (far cheaper per task, slower, more literal). Sol suits cache-heavy, reusable-prefix, acceptance-test-driven work. Sonnet suits latency-sensitive loops. If an Opus-quality answer is needed on a moderate task, Opus 5.5 at medium costs about $0.75 more per index task than Sonnet at high but scores 4 points higher.
3. **Bulk, trivial, or fan-out subtasks:** gpt-6-luna at medium or higher, about $0.07 per index task. Haiku 4.5 only when OpenAI is off the table. Don't use Luna at low for agentic work.
4. **Security-sensitive tasks:** claude-opus-4-8 (or Opus 5 with verification) is where Anthropic routes them, since Opus 5.5, Fable 5.1 and Sonnet 5.5 reroute or refuse. OpenAI models were not reported to have this behavior, but I did not look for OpenAI-side cyber limits.
5. **Avoid unless pinned:** gpt-6-sol (use 6.1), claude-sonnet-5 (use 5.5), claude-opus-5 (use 5.5), claude-fable-5 (use 5.1 unless token appetite bites), gpt-5.6 family (cost more per capability).

Practical rules the doc should state:
- Default effort matters more than model choice. Sonnet 5.5 at max is the single worst cost choice found. Sol's best coding setting is xhigh, not max. Opus 5.5 medium is the default and sits on the frontier.
- Cost warnings: Sonnet 5.5 and Fable 5.1 burn many tokens at high effort. Opus 5.5 uses 1.6x the tokens of Opus 5. Astra and Sol are token-lean (but Sol uses more tokens than GPT-6 Sol).
- Latency warnings: Sol at high effort can be several times slower than Sonnet; both Sonnet 5.5 (139 tok/s) and Opus 5.5 (>30% faster than Opus 5, vendor) are faster.
- Known unknown: I found no independent token-efficiency data for Opus 4.8, Opus 5 (current index), Fable 5, Sonnet 5, Haiku 4.5 beyond a single AA number, nor any controlled hard-bug head-to-head across vendors.

### Recommended document shape

A **decision guide first, a compact catalog table second**. Per-axis star ratings would mislead: depth and execution scores move with effort level, and AA index values are not stable across versions. Suggested layout:

1. A role-based chooser (hard problem, execution, bulk, security) naming one default plus one escalation per role, with the recommended effort setting.
2. A catalog table: ID, status (current, legacy, avoid), price in/out/cache, context window, notes (verbosity, speed, safeguards). Mark the dated facts ("verified 2026-10-04").
3. A short "cost per task, not per token" note with 3 or 4 headline facts (Sonnet 5.5 at max costs more than Opus 5.5, Sol at xhigh is the cheapest strong option, Luna is about 3x cheaper than Haiku per task not 10x).
4. A "name hazards" note: GPT-6 Sol/Luna vs GPT-5.6 Sol/Luna, no GPT-6 Terra, no GPT-6.1 Astra, Haiku 5.5 pending, Sonnet 4.5 retiring 2026-11-30.
5. Stable guidance (relative roles) separated from volatile facts (prices, scores), so the next refresh only touches the latter.

## 6. Source concentration

- Most Anthropic and OpenAI cost-per-task, token, and index numbers trace to **Artificial Analysis** (five articles plus model pages and tweets). That is one evaluator, not several. Its harness gave lower Terminal-Bench scores than vendors.
- **Vals.ai** is the only second independent evaluator I found for Sonnet 5.5 and Opus 5.5 (Vals Index, cost per test). I found nothing from Vals for OpenAI models or the older Anthropic ones.
- **CodeRabbit** is a third independent source (code review only).
- Everything else (codersera, kingy.ai, emergent.sh, eesel.ai, vellum, benchlm, myclaw, datacamp, lindy and others) mostly re-quotes AA, Vals or vendor numbers. DataCamp's single-task test and the New Stack's four-task test are the only small hands-on experiments I found.
- First-party vendor pages read directly: Anthropic Opus 5.5 announcement and model deprecations page. I could not read any OpenAI first-party page.

## 7. Key source list (date, kind)

- https://platform.claude.com/docs/en/about-claude/model-deprecations (live 2026-10-04, vendor)
- https://www.anthropic.com/news/claude-opus-5-5 (2026-09-22, vendor)
- https://artificialanalysis.ai/articles/claude-opus-5-5 (2026-09-22, independent)
- https://artificialanalysis.ai/articles/claude-sonnet-5-5 (2026-09-28, independent)
- https://artificialanalysis.ai/articles/claude-fable-5-1 (2026-09-01, independent)
- https://artificialanalysis.ai/articles/benchmarking-gpt-6-astra (2026-09-09, independent)
- https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence (2026-09-29, independent)
- https://artificialanalysis.ai/articles/gpt-5-6-has-landed (2026-07-09, independent)
- https://www.vals.ai/models/anthropic_claude-sonnet-5-5 (about 2026-09-28 onward, independent)
- https://www.coderabbit.ai/blog/sonnet-5-5-model-review (2026-09-28, independent, review-only)
- https://www.the-decoder.com/anthropics-claude-sonnet-5-5-nearly-matches-opus-5-5-on-benchmarks-while-costing-up-to-30-percent-less-per-task/ (2026-09-28, news relaying vendor claims)
- https://thezvi.substack.com/p/claude-mythos-51-and-fable-51-capabilities (2026-09-05, community roundup)
- https://dreasays.substack.com/p/claude-55-is-brilliant-confusing (2026-09-29, single author)
- https://emergent.sh/learn/claude-fable-5-1-vs-opus-5-5 (2026-09-24, secondary, relays AA and vendor)
- https://codersera.com/blog/claude-opus-5-5-complete-guide-2026/ (2026-09-22, updated 2026-09-30, secondary)
- https://www.vellum.ai/blog/gpt-6-1-sol-benchmarks-explained (2026-09-29, secondary, relays OpenAI numbers)
- https://developers.openai.com/api/docs/deprecations (undated, vendor)
- https://www.cnbc.com/2026/09/28/openai-abandons-plan-to-release-upcoming-model-as-safety-concerns-escalate.html (2026-09-28, news, via search only)
- https://github.com/openai/codex/issues/47656 (user report, via search only)
- https://www.datacamp.com/blog/gpt-6-1-sol-vs-claude-sonnet-5-5 (about 2026-10, single hands-on test, via search only)
- https://thenewstack.io/claude-fable-upgrade-tested/ (via search only, page not fetchable)

Items cited "via search" were not read in full by me. Verify them before relying on them.
