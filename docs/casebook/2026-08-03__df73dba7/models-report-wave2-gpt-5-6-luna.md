# Model-capability research, wave 2

**Research date:** 2026-08-03  
**Scope:** publicly available Anthropic Claude and OpenAI GPT/Codex models relevant to delegation; emphasis on GPT-5.6 Luna and on capability, speed, and cost to complete work rather than token price alone.

## Executive findings

1. **GPT-5.6 Luna is not merely a copy/summarization model.** Independent Artificial Analysis testing gives the max-effort configuration an Intelligence Index score of 51, with 1M-token context and 177.8 output tokens/second. In an independent repository-level coding benchmark, Codex + Luna resolved 75.4% of 23 eligible tasks before contamination adjustment and 65.2% after adjustment. That places it in a useful agentic-coding tier, although well below the frontier on difficult, ambiguous work.

2. **Luna is the best candidate for high-volume delegation, not for unconditional defaulting.** Its current API price is $0.20/M input and $1.20/M output after OpenAI's July 30, 2026 80% cut. That is unusually cheap, but reasoning tokens, long trajectories, cache writes, retries, and failed tasks still determine cost per completed task. One independent six-turn API test found Luna used fewer output tokens than GPT-5.4 mini but cost nearly twice as much because most input was billed as cache writes. Treat the price cut as an opportunity to benchmark, not as proof that every workload is cheap.

3. **The frontier is close and task-dependent rather than a single ladder.** Artificial Analysis currently scores Claude Opus 5 at 61, GPT-5.6 Sol at 59, Claude Fable 5 at 60, GPT-5.6 Terra at 55, Claude Sonnet 5 at 53, and Luna at 51. Those scores are useful directional evidence, not universal capability ratings. Independent TUA-Bench results show that the harness can reverse model rankings: GPT-5.5 and Opus 4.8 were almost tied across fixed open-source scaffolds, while the best Claude Code configuration beat the best Codex configuration.

4. **For delegation, model + harness + effort setting is the unit to evaluate.** RuBench measured deployed Claude Code/Codex configurations rather than bare API calls, and found strong results for Opus 4.8, Sonnet 5, GPT-5.5, and Luna. It also found model substitution in Fable 5 and oracle-hunting contamination in the GPT-5.6 rows. A model table should therefore report the available CLI and effort mode, and should recommend a small acceptance-test suite before a permanent routing choice.

## Current roster and routing signal

Prices below are first-party API list prices per million tokens as checked on 2026-08-03. Claude Sonnet 5's $2/$10 introductory price runs through August 31, 2026; its standard price is $3/$15. Subscription quotas and Codex/Claude Code usage credits are separate economics.

| Model | Current role | Independent capability signal | Speed signal | Cost-to-accomplish interpretation | Suggested delegation use |
| --- | --- | --- | --- | --- | --- |
| `gpt-5.6-sol` | OpenAI flagship | Artificial Analysis Index 59; coding-agent index 80; independent numbers are close to Claude's top tier | 65.9 output tokens/s at max effort | $5/$30; expensive by token, but OpenAI and Artificial Analysis report better token/task efficiency than prior GPT models. Verify on the local task before paying the premium. | Hard coding, architecture, research, high-risk review, ambiguous multi-step work, or a second opinion against Claude. |
| `gpt-5.6-terra` | OpenAI balanced tier | Artificial Analysis Index 55; current independent coding coverage is thinner than for Sol/Luna | 135.7 output tokens/s at max effort | $2.50/$15; likely the practical general-purpose Codex workhorse. | Normal feature work, code review, scoped research, and tasks whose failure is costly but not catastrophic. |
| `gpt-5.6-luna` | OpenAI cost-sensitive tier | Artificial Analysis Index 51. RuBench Codex/Luna: 75.4% raw, 65.2% honest, N=23; the honest score is the one to use. | 177.8 output tokens/s after generation, but max-effort time-to-first-answer was 143.5s in Artificial Analysis; “fast” does not mean low wall-clock latency at high effort. | $0.20/$1.20; raw price is excellent. Effective cost can rise sharply if Luna loops, emits lengthy reasoning, writes cache entries, or needs escalation/retry. | Default for well-specified, low-risk subagent work: extraction, transformation, classification, test/lint passes, simple fixes, implementation after a plan, and high-volume background jobs. |
| `claude-fable-5` | Anthropic highest generally available tier | Artificial Analysis Index 60; Fable's benchmark cell can include an Opus 4.8 fallback. RuBench found fallback on 20% of its hors-concours tasks. | 73.5 output tokens/s; slower and costly at max effort | $10/$50; Artificial Analysis's Fable configuration cost $22.30 per AA-Briefcase task, versus $17.79 for Opus 5. | Highest-stakes or longest-horizon work when the capability ceiling matters more than spend; do not assume the requested model actually ran without trajectory checks. |
| `claude-opus-5` | Anthropic frontier workhorse | Artificial Analysis Index 61, currently the highest listed; AA-Briefcase 1720 Elo, 146 above Fable 5 in that evaluation | 54.8 output tokens/s at max effort; AA-Briefcase max averaged 36.2 minutes/task and 103 turns | $5/$25. Artificial Analysis reports $17.79/AA-Briefcase task at max, 20% below Fable, but still slow and verbose. | Difficult coding, orchestration, and enterprise work when Claude's long-horizon behavior is preferred and the latency/cost are acceptable. |
| `claude-opus-4-8` | Previous-generation Claude frontier | Artificial Analysis Index 56; strong independent TUA-Bench and RuBench results, but do not infer that it is universally below Opus 5 from vendor positioning alone | Generally slower than economy tiers; exact speed varies by effort/provider | $5/$25. Real-task efficiency can remain attractive if its trajectories are shorter or more reliable on the target codebase. | Keep as a serious option where it is a known-good daily driver; use local evidence rather than automatically replacing it with Opus 5. |
| `claude-sonnet-5` | Anthropic speed/intelligence middle tier | Artificial Analysis Index 53; AA reports it slightly ahead of Opus 4.8 on its agentic knowledge-work tasks but behind Opus on heavy reasoning; RuBench scored 74.7% on 25 tasks, statistically indistinguishable from Opus 4.8 at that sample size | 76.1 output tokens/s at max effort, but very high token/turn use; AA reports about 3x the agentic turns of Sonnet 4.6 on some suites | $2/$10 introductory, then $3/$15. Despite the lower tariff, AA measured $2.29/task at standard pricing—about 15% above Opus 4.8 in that suite—because of increased token usage. | Strong general coding, orchestration, analysis, and tool use; choose it when quality matters but Opus-level spend does not, and measure trajectory length. |
| `claude-haiku-4-5` | Anthropic economy tier | Artificial Analysis Index 24 non-reasoning / 30 reasoning; RuBench scored 53.3%, clearly below the top three configurations | About 95 output tokens/s non-reasoning and low first-token latency | $1/$5. Much cheaper, but it resolves a materially smaller class of repository tasks; success-adjusted cost can be worse if it needs repair or escalation. | High-volume extraction, routing, formatting, simple subagents, and mechanical work with strong validation. |

Anthropic's limited-access `claude-mythos-5` is not included as a normal routing row: Anthropic documents it as invitation-only defensive-cyber access rather than a generally available model.

## GPT-5.6 Luna in more detail

### Capability

OpenAI describes Luna as the cost-sensitive, high-volume member of the GPT-5.6 family and gives it a 1,050,000-token context window, 128,000-token maximum output, image input, tool use, and reasoning-token support. Those are useful product facts, but not evidence by themselves that it is suitable for every agent task.

The strongest independent evidence I found is:

- **Artificial Analysis:** Luna max scores 51 on its v4.1 Intelligence Index, which combines GDPval-AA v2, banking tool use, Terminal-Bench 2.1, SciCode, Humanity's Last Exam, GPQA Diamond, CritPt, AA-Omniscience, and AA-LCR. It generated 130M output tokens over the suite, which Artificial Analysis labels very verbose relative to its median. That verbosity is important for real cost.
- **RuBench v2:** on 23 eligible repository-level tasks specified in Russian and judged by withheld maintainer tests, Codex + Luna scored 75.4% raw and 65.2% after the contamination audit. The audit found 8 hard contamination records and 2 borderline records in Luna's column; seven passing hard-contamination cells were deducted. The honest score is therefore much more credible than the raw score, but the sample is still small and task-specific.
- **OpenAI's release evaluation:** Luna is listed at 62.7% on SWE-Bench Pro, 67.2% on DeepSWE v1.1, 84.7% on Terminal-Bench 2.1, 83.3% on BrowseComp, 45.6% on OSWorld 2.0, 92.3% on GPQA Diamond, and 51.2% on LifeSciBench. These are useful coverage indicators, but they are vendor-published or vendor-hosted comparisons; they should not outweigh the independent evidence above.

The practical conclusion is “competent agentic worker with a low floor and a real ceiling,” not “cheap frontier replacement.” Luna can carry out a carefully specified patch or background subtask, but the evidence does not justify routing open-ended architecture, novel debugging, or high-consequence research to it without a stronger planner/reviewer and hard validation.

### Speed

Artificial Analysis measured 177.8 output tokens/second for Luna max, ahead of Terra (135.7), Sonnet 5 (76.1), Sol (65.9), Fable 5 (73.5), and Opus 5 (54.8) in the cited snapshots. This is decode throughput after the model begins its answer. For reasoning models, the model may spend substantial time thinking before the first answer token; Luna max's measured first-answer latency was 143.5 seconds. Use low or medium effort for interactive/short tasks and reserve max for cases where the extra reasoning is worth the wait.

A small community report from a Hermes Agent user described Luna as “smart but slow” in practice, with repeated 5–6-step iterations versus a different low-cost model's one-shot behavior. This is anecdotal and not a benchmark, but it is consistent with the more reliable observation that Luna is unusually verbose on Artificial Analysis. It is a reason to measure wall time and turns, not just tokens/second.

### Cost to accomplish a task

The current tariff is exceptionally low: $0.20/M uncached input, $0.02/M cached input, $0.25/M cache write, and $1.20/M output. OpenAI's pricing documentation also says requests above 272K input tokens are charged at higher multipliers for the full request. A long-running delegation can therefore have a very different bill from a short prompt's sticker-price estimate.

Artificial Analysis's Luna max run cost $174.06 for its full Intelligence Index evaluation and used 130M output tokens. That is not a per-task quote, but it demonstrates why “$1.20/M output” is not enough to predict spend. The independent RuBench release exposes per-cell cost, tokens, turns, and wall-clock fields, but its headline table does not provide a clean cross-model cost-per-success comparison because eligible task counts differ and Luna's raw cells include contamination.

An independent OpenAI Developer Community test is a useful warning: in a six-turn Responses API conversation at low effort, Luna used 3% fewer input tokens and 29% fewer output tokens than GPT-5.4 mini, yet the estimated conversation cost was $0.0651 versus $0.0332 because roughly 70% of Luna's input was billed as cache writes. This is one workload, not a universal Luna property, but it directly supports charging the delegation policy by completed-task cost rather than by advertised token rate.

## Cross-vendor comparisons that matter for routing

### Coding and repository work

RuBench is more informative than a static SWE-Bench claim because it measures a deployed CLI agent on fresh repository tasks with withheld tests. Its top results were:

| Deployed configuration | Pass@1 | Caveat |
| --- | ---: | --- |
| Claude Code + Opus 4.8 | 78.7% (N=25) | Three-run mean; no superiority over Sonnet was statistically established. |
| Claude Code + Sonnet 5 | 74.7% (N=25) | Four points below Opus, within the reported bootstrap interval. |
| Codex CLI + GPT-5.6 Luna | 75.4% raw / 65.2% honest (N=23) | Contamination adjustment is essential. |
| Codex CLI + GPT-5.5 | 66.7% (N=25) | Older baseline in the same benchmark. |
| Claude Code + Haiku 4.5 | 53.3% (N=25) | Clear economy-tier drop on this task class. |

The scores do not establish a universal winner: Luna's honest score is below the Claude top rows, while its raw score is close; the task set is only 25 tasks, and the harnesses differ. The correct routing inference is that Luna is viable for repository work with validation, while Opus/Sonnet remain safer defaults for ambiguous brownfield work.

### Knowledge work and orchestration

Artificial Analysis's independent AA-Briefcase evaluation favors Claude Opus 5 on quality (1720 Elo at max) and reports a lower cost per task than Fable 5, but also reports 103 turns and 36.2 minutes per task at max. OpenAI's GPT-5.6 release page claims strong professional-work results for Sol and says Luna approaches GPT-5.5's peak at less than half the estimated cost; because that comparison is vendor-published, treat it as a hypothesis to test.

For orchestration, Sonnet 5 is not simply “cheap Opus.” Artificial Analysis found it matched or slightly exceeded Opus 4.8 on two agentic knowledge-work evaluations while trailing larger models on heavy reasoning, and also found that its max-effort behavior consumed around three times as many agentic turns as Sonnet 4.6. That may improve thoroughness, but it can erase the apparent price advantage. Luna is a better fit for execution of a clear plan than for discovering the plan.

### Harness effects

TUA-Bench fixed the model inside several agent scaffolds and found GPT-5.5 at 61.3% mean versus Opus 4.8 at 60.2% across three open-source agents; GPT won by 5 points with Mini-SWE-Agent, Opus won by 2 with OpenHands, and they were effectively tied with Terminus-2. With product-specific scaffolds, Claude Code + Opus 4.8 reached 65.8% and Codex + GPT-5.5 64.7%. This is strong evidence that a `delegate` reference table should not treat raw model capability as independent of the CLI, tools, context management, and effort setting.

## Recommended selection policy

Use four separate axes instead of a single 1–5 capability score:

1. **Task success under the target harness:** does the agent produce a tested, acceptable result?
2. **Supervision burden:** how often does it need correction, clarification, or escalation?
3. **Wall-clock behavior:** include first useful token, number of turns, retries, and tool calls—not only decode speed.
4. **Cost per accepted result:** count all input, cache-write, reasoning, output, retry, and escalation tokens divided by successful deliverables.

Practical routing:

- **Clear, bounded, low-risk, high-volume task:** start with GPT-5.6 Luna or Haiku 4.5. Prefer Luna when a shell/tool loop or modest reasoning is needed; prefer Haiku when the task is mostly extraction, classification, or formatting and Claude is already the operationally convenient tool.
- **Normal coding, review, research, or orchestration:** use GPT-5.6 Terra or Claude Sonnet 5. Terra is the more attractive current API-cost/throughput candidate; Sonnet is a strong alternative when Claude Code's behavior and tooling are a better fit. Benchmark both on the repository and prompt style.
- **Ambiguous architecture, difficult debugging, long-horizon work, or high cost of error:** use GPT-5.6 Sol, Claude Opus 5, or a known-good Opus 4.8. Sol has a strong independent coding signal and higher measured decode speed; Opus 5 currently leads Artificial Analysis's general/agentic index but is slower and expensive. Pick based on the target harness and local acceptance tests.
- **Exceptional stakes or a hard capability ceiling:** consider Fable 5, but verify model identity in the trajectory and account for its $10/$50 tariff, slow runs, and safety fallback behavior.
- **Planner/executor pattern:** use Sol/Opus for the plan and uncertainty reduction, Luna/Terra/Sonnet for well-specified implementation and validation, then a stronger model for review when the result is consequential. This is a recommendation, not a claim that every task benefits from multi-model routing.

For the `delegate` reference file, I recommend recording the model ID, vendor, role, qualitative capability band, speed caveat, current price date, and a short task-routing note. Keep benchmark numbers and source links in a dated research appendix so later model refreshes do not silently turn temporary prices or vendor claims into permanent capability facts.

## Sources and evidence notes

- [OpenAI: GPT-5.6 launch and evaluation table](https://openai.com/index/gpt-5-6/) — official availability, tier descriptions, published evaluations, and pre-price-cut prices.
- [OpenAI: July 30 GPT-5.6 price update](https://openai.com/index/advancing-the-price-performance-frontier-with-gpt-5-6/) — current Luna/Terra pricing and the cache/usage caveats.
- [OpenAI API: GPT-5.6 Luna](https://developers.openai.com/api/docs/models/gpt-5.6-luna) — context, output limit, modalities, and model positioning.
- [Anthropic model overview](https://platform.claude.com/docs/en/about-claude/models/overview) — current Claude IDs, availability, context, and list prices.
- [Artificial Analysis: model comparison](https://artificialanalysis.ai/models/) — independently run cross-vendor Intelligence Index, speed, token-use, and cost methodology.
- [Artificial Analysis: GPT-5.6 Luna](https://artificialanalysis.ai/models/gpt-5-6-luna/) — Luna's independent score, throughput, verbosity, and evaluation cost.
- [Artificial Analysis: GPT-5.6 Sol](https://artificialanalysis.ai/models/gpt-5-6-sol) and [Terra](https://artificialanalysis.ai/models/gpt-5-6-terra) — cross-tier comparisons.
- [Artificial Analysis: Claude Opus 5](https://artificialanalysis.ai/models/claude-opus-5) and [Opus 5 agentic-work report](https://artificialanalysis.ai/articles/claude-opus-5-leader-agentic-knowledge-work) — independent quality, speed, turns, and cost-per-task evidence.
- [Artificial Analysis: Claude Sonnet 5 cost report](https://artificialanalysis.ai/articles/claude-sonnet-5-agentic-cost) — token-use and cost-to-task warning.
- [RuBench paper](https://arxiv.org/abs/2607.06411) and [released benchmark data/card](https://huggingface.co/datasets/eugeneshilow/rubench) — fresh repository-level tasks, deployed CLI results, contamination audit, and per-cell accounting fields.
- [TUA-Bench paper](https://arxiv.org/abs/2606.28480) — direct evidence that agent scaffold changes model rankings and cost/performance.
- [OpenAI Developer Community controlled cost report](https://community.openai.com/t/gpt-5-6-luna-costs-96-more-than-gpt-5-4-mini-in-a-controlled-multi-turn-responses-api-test/1386460) — one workload showing cache-write effects on actual Luna cost.

The independent evidence is still young for GPT-5.6 Terra/Luna, especially outside coding and terminal tasks. Claims about cost per accepted task should therefore be treated as provisional until the delegation project runs its own small, representative benchmark with the exact CLI, prompt format, effort setting, validation, and retry policy it will deploy.
