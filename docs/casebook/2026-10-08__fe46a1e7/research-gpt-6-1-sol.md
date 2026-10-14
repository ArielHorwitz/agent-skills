Model ID: `gpt-6.1-sol` (handoff-assigned identity, not independently introspected).
Research date: 2026-10-08.

Live web search worked. Some page fetches failed, including the Haiku overview initially and the linked system card. LiveBench's fetched page requires JavaScript, so its results below come from the live search index. I did not run models, coordinate with other researchers, or inspect their reports.

## Placement recommendation

My inference: replace Haiku 4.5 as the normal Anthropic choice for bounded, inexpensive delegation. Use Haiku 5.5 for extraction, summaries, schema exploration, localized changes with explicit checks, and small tool workflows. Start at medium, consider high for longer or stricter tasks. Keep Sonnet 5.5, Opus 5.5, and GPT-6.1 Sol for difficult diagnosis, novel problems, and sustained execution. Do not describe Haiku 5.5 as categorically cheaper or better than GPT-6 Luna. Independent results support different winners across workloads. Evidence: the independent comparisons and task measurements below.

The material caveat is request size: Haiku's fivefold price increase above 100k prompt tokens can change the choice in a growing agent conversation. A large supported context window is not an economical default working size. [Anthropic overview, vendor, publication date unavailable, retrieved 2026-10-08](https://platform.claude.com/docs/en/models/haiku-5-5/overview).

## Independent evidence: depth and execution

Artificial Analysis (AA) provides the following same-provider comparison pages. Publication dates are unavailable. All were retrieved 2026-10-08. These are independent measurements, but they are ONE evaluator, not four independent corroborations. Scores are rounded as displayed. Claude Sonnet and Opus configurations are labeled "Max, Default Fallback" by AA, so this is not a pure comparison of unqualified model names or default settings.

| Configuration | AA Intelligence Index | HLE | Terminal-Bench 4.0 | AutomationBench-AA | AA weighted cost per task | Independent source and date |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| Haiku 5.5 max | 43 | 44% | 33% | 35% | $0.21 | [AA versus Luna](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-luna), undated, retrieved 2026-10-08 |
| GPT-6 Luna max | 38 | 39% | 13% | 53% | $0.07 | [Same AA comparison](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-luna), undated, retrieved 2026-10-08 |
| GPT-6.1 Sol max | 52 | 53% | 56% | 65% | $0.72 | [AA versus Sol](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-1-sol), undated, retrieved 2026-10-08 |
| Sonnet 5.5 max with fallback | 56 | 55% | 64% | 72% | $5.46 | [AA Sonnet profile](https://artificialanalysis.ai/models/claude-sonnet-5-5) and [comparison](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-claude-sonnet-5-5), undated, retrieved 2026-10-08 |
| Opus 5.5 max with fallback | 58 | 61% | 60% | 70% | $5.98 | [AA versus Opus](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-claude-opus-5-5), undated, retrieved 2026-10-08 |

Inference on depth: Haiku has useful reasoning ability, but these results leave a substantial gap to the larger comparators. HLE is only a proxy for hard reasoning, not proof of success on novel engineering problems. Opus's stronger overall reasoning does not make it the terminal winner in this particular comparison. Haiku's advantage over Luna is task-specific: it wins AA's terminal evaluation while losing its SaaS workflow evaluation. Sources: the AA comparisons above.

An independent cross-check moderates the small-model ranking. LiveBench's current dataset is dated 2026-06-25, but individual result publication dates are unavailable. Its search-indexed rows show Haiku 5.5 xhigh at 72.1 overall, Luna max at 72.0, Sol max at 81.6, and Opus max at 83.2. Haiku versus Luna: reasoning 81.2 versus 81.8, agentic coding 51.4 versus 51.2, language 63.5 versus 73.8, instruction following 66.5 versus 55.9. Inference: nearly tied overall, with different strengths. The settings differ and the tiny aggregate gap is not evidence of a meaningful winner. [LiveBench, independent, result publication dates unavailable, retrieved 2026-10-08 through search](https://livebench.ai/?orgid=145).

Plotly's 43-question analytics exam holds agent/tools/prompts constant. Haiku 5.5 passed 37 questions, Haiku 4.5 passed 27, and Luna passed 38. Median times were 14, 17, and about 18 seconds respectively. Haiku 5.5 resolved five ambiguity questions but only two of five hidden-pattern and statistical-trap questions each. Inference: bounded analysis looks stronger than discovery. Effort and repeated-run uncertainty were not reported. [Plotly, independent, published 2026-10-07, date confirmed by its blog listing](https://plotly.com/blog/claude-haiku-5-5-plotly-data-analytics-bench/), [dated listing](https://plotly.com/blog/).

Vendor evidence should be kept separate. Anthropic's October 7 table reports Terminal-Bench 4.0 at 39.2% for Haiku 5.5, 0% for Haiku 4.5, 16.4% for Luna, and 70.6% for Sonnet. Its no-tools HLE comparison is 45.9%, 10.2%, and 56.9% for the two Haikus and Sonnet. These support improvement over the predecessor, but do not duplicate AA's independent terminal run. Do not combine scores across these configurations as though they were one leaderboard. [Anthropic launch, vendor, published 2026-10-07](https://www.anthropic.com/claude-haiku-5-5).

## Cost to complete work, rather than sticker price

Plotly's full-run costs were $0.38 for Haiku 5.5, $3.27 for Haiku 4.5, and $0.13 for Luna. My arithmetic: Haiku 5.5 costs 2.9 times Luna here. Amortized cost per passed question is approximately $0.010, $0.121, and $0.0034 respectively, including failed-question spend but excluding retries. Accuracy, speed, and cost all rest on this one run. [Plotly, independent, published 2026-10-07](https://plotly.com/blog/claude-haiku-5-5-plotly-data-analytics-bench/).

AA's costs above are weighted evaluation spend per attempted task, not cost per successful terminal fix. Token-efficiency signal exists: its max profiles report 440M total output tokens for Haiku, approximately 140M for Luna, and 67M for Sol. Inference: substantial token-use differences shrink or reverse apparent savings based on token rates. AA's displayed pricing uses Haiku's short-prompt rate, and I could not establish that its cost calculation accounts for the new long-prompt tier. Treat these as evaluator estimates, not invoices for arbitrary long-context sessions. [AA Haiku profile](https://artificialanalysis.ai/models/claude-haiku-5-5), [Luna release profile](https://artificialanalysis.ai/models/releases/gpt-6-luna), [Sol profile](https://artificialanalysis.ai/models/gpt-6-1-sol), independent, undated, retrieved 2026-10-08.

LiveBench displays cost per successful task of $0.019 for Haiku xhigh versus $0.026 for Luna max, $0.142 for Sol max, and $0.799 for Opus max. This contradicts a universal "Luna is cheaper" claim as much as Plotly contradicts a universal "Haiku is cheaper" claim. Different workloads and settings matter. Billing assumptions were not recoverable from the fetched JavaScript page. [LiveBench, independent, result publication dates unavailable, retrieved 2026-10-08 through search](https://livebench.ai/?orgid=145).

A lower-confidence community data point reports a voxel-building run at xhigh costing $24.96 for Haiku and $1.96 for Luna, with 4.46M versus 1.18M output tokens and large cached inputs. This was API-equivalent accounting from subscription runs in atomic.chat, not a controlled, repeated API experiment. I would use it only as a warning to measure long agent loops, not as a 12-times cost forecast. [Reddit user report, independent anecdote, published 2026-10-08 according to live search](https://www.reddit.com/r/ClaudeAI/comments/1x0agoh/claude_haiku_55_cost_12x_more_than_gpt6_luna_for/).

Anthropic estimates an average 75% reduction versus Haiku 4.5 based on its historical request mix and tokenization changes. This is vendor workload accounting, not evidence that every delegated task gets that reduction. Independent Plotly measurements support a large reduction on one workload. I found no representative repeated headless repository-maintenance study measuring retries, review, and repair for all six models. [Anthropic launch, vendor, published 2026-10-07](https://www.anthropic.com/claude-haiku-5-5).

## Specifications and effort

All prices below are standard USD per million tokens, not task costs. Dynamic documentation does not expose reliable publication dates, so each entry explicitly uses retrieval date 2026-10-08. Sources are vendor documentation.

| Model | Context / max output | Input / output rates | Reasoning control | Vendor source |
| --- | --- | --- | --- | --- |
| Haiku 5.5 | 1M / 128k | $0.10 / $0.50 through 100k prompt tokens, $0.50 / $2.50 above | Adaptive, medium default, five effort levels | [Haiku overview](https://platform.claude.com/docs/en/models/haiku-5-5/overview), undated, retrieved 2026-10-08 |
| Haiku 4.5 | 200k / 64k | $1 / $5 | Manual extended thinking, no effort parameter | [Haiku 4.5 overview](https://platform.claude.com/docs/en/models/haiku-4-5/overview), undated, retrieved 2026-10-08 |
| Sonnet 5.5 | 1M / 128k | $2 / $10 | Adaptive, high API default | [Current lineup table](https://platform.claude.com/docs/en/models/haiku-4-5/overview), undated, retrieved 2026-10-08 |
| Opus 5.5 | 1M / 128k | $4 / $20 | Adaptive always on, medium API default | [Current lineup table](https://platform.claude.com/docs/en/models/haiku-4-5/overview), undated, retrieved 2026-10-08 |
| GPT-6 Luna | 1,050,000 / 128k | $0.10 / $0.50 through 272k input tokens, $0.20 / $0.75 above | none, low, medium default, high, xhigh, max | [OpenAI Luna page](https://developers.openai.com/api/docs/models/gpt-6-luna), undated, retrieved 2026-10-08 |
| GPT-6.1 Sol | 1,050,000 / 128k | $2 / $10 through 272k input tokens, $4 / $15 above | low, medium default, high, xhigh, max | [OpenAI Sol page](https://developers.openai.com/api/docs/models/gpt-6.1-sol), undated, retrieved 2026-10-08 |

Haiku cache reads are $0.01/$0.05, five-minute writes $0.125/$0.625, and one-hour writes $0.20/$1 across the two prompt tiers. Batch halves input/output rates. The same text counts as approximately 30% more tokens than on Haiku 4.5. These are billing and tokenization facts, not a guarantee of the model's total task-token consumption. [Anthropic overview, vendor, publication date unavailable, retrieved 2026-10-08](https://platform.claude.com/docs/en/models/haiku-5-5/overview).

For Luna and Sol the higher input tier applies to the whole request, doubling input/cache rates and multiplying output rates by 1.5. Their short-prompt cache read/write rates are $0.01/$0.125 and $0.10/$2.50 respectively. [OpenAI Luna page](https://developers.openai.com/api/docs/models/gpt-6-luna), [Sol page](https://developers.openai.com/api/docs/models/gpt-6.1-sol), vendor, publication dates unavailable, retrieved 2026-10-08.

Independent effort sweep:

| Haiku 5.5 effort | AA index | Weighted cost per task | Total output tokens on index | Independent source, publication date unavailable, retrieved 2026-10-08 |
| --- | ---: | ---: | ---: | --- |
| medium | 34 | $0.05 | 54M | [AA medium](https://artificialanalysis.ai/models/claude-haiku-5-5-medium) |
| high | 38 | $0.08 | 97M | [AA high](https://artificialanalysis.ai/models/claude-haiku-5-5-high) |
| xhigh | 41 | $0.12 | 180M | [AA xhigh](https://artificialanalysis.ai/models/claude-haiku-5-5-xhigh) |
| max | 43 | $0.21 | 440M | [AA max](https://artificialanalysis.ai/models/claude-haiku-5-5) |

Inference: higher effort buys quality, with steeply diminishing returns at max. This is still one evaluator. Do not attach max scores to medium-default cost claims, or assume matching effort names mean equal compute across vendors.

Anthropic supports low, medium, high, xhigh, and max. Thinking is enabled by default and consumes the output allowance. It can be disabled at high or below, but not at xhigh/max. Its prompting guide reports early stopping on long prompts at low effort, and omitted code checks at low/medium. Moving low to medium roughly halved early stopping while more than doubling output tokens in its test. Inference: for headless delegation, specify observable completion checks and favor medium/high over blindly choosing low. [Anthropic prompting guide, vendor, publication date unavailable, retrieved 2026-10-08](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-haiku-5-5).

## Supersession and changes since October 4

My recommendation is same-vendor supersession of Haiku 4.5 for ordinary bounded delegation: the new model offers materially better demonstrated task performance and lower measured cost on Plotly's workload. This is a default-selection recommendation, not proof of dominance on every task. Preserve a legacy option where an established prompt or integration requires it. The larger Claude models remain justified by independent reasoning and terminal results. Luna remains justified by analytics cost and SaaS execution results. Sol remains justified by stronger hard-task performance. Evidence: the comparisons above.

I found no additional newly named Anthropic Claude or OpenAI GPT delegation model released from October 5 through October 8. This is a bounded search finding, not a guarantee of exhaustive release discovery. Anthropic's release notes identify Haiku on October 7, and OpenAI's API changelog lists its most recent newly named general model, GPT-6.1 Sol, on September 29. October 6's Decisions API entry uses existing Luna. [Anthropic release notes, vendor, entries dated 2026-10-05 through 2026-10-08](https://platform.claude.com/docs/en/release-notes/overview), [OpenAI changelog, vendor, entries dated 2026-09-29 and 2026-10-05 through 2026-10-07](https://developers.openai.com/api/docs/changelog).

A relevant comparator change did occur: Sonnet 5.5 cache reads fell from $0.20 to $0.10 per million tokens on October 7. Update comparisons using the current rate. [Anthropic release notes, vendor, entry dated 2026-10-07](https://platform.claude.com/docs/en/release-notes/overview).

An additional release needs distinguishing: October 7's GPT-6 Chat rollout uses conversation-tuned Sol and Luna and adds interactive responses. OpenAI explicitly says Work and Codex models are unchanged by this release. Depth: vendor claims improved everyday-task performance, without a directly comparable independent evaluation found here. Execution: no headless terminal-loop evidence found for these Chat variants. Cost-to-task, separate token pricing, context limits, and effort-to-cost curves: not established by the announcement. Inference: record the release, but do not add a new delegation candidate or transfer these claims to the API comparison models. [OpenAI Chat launch, vendor, published 2026-10-07](https://openai.com/index/gpt-6-for-everyone/).

Confidence: good evidence for replacing Haiku 4.5 on bounded work, moderate evidence for its placement below larger models on hard work, limited evidence for the cheapest successful long coding loop. Independent signal is already useful but only a day old, and the broad numerical comparisons rely heavily on AA. Plotly and LiveBench add different workloads, not blanket corroboration of the launch framing.
