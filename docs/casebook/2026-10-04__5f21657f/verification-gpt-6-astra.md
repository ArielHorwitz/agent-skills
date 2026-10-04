Verifier model: `gpt-6-astra`. Verification date: 2026-10-04. Live web search worked. Some page fetches failed or omitted dynamic chart data. Details follow the table.

| Claim | Verdict | Source |
| --- | --- | --- |
| 1. Tool invocation documentation and permission doctrine are in the two files named in the introduction. | **UNSUPPORTED** | The supplied [draft](/tmp/verify.SfRf/gpt-6-astra/models-draft.md), dated 2026-10-04. Neither referenced file was supplied in this workspace. Local claim, not a vendor claim. |
| 2. Models trade places depending on task type. | **HOLDS** | [AA Opus/Astra comparison][A1] and [Vals mechanism results][V2] (independent, n.d. and updated 2026-10-01 respectively). |
| 3. `claude-opus-5-5` is a current model ID, not retired or renamed. | **HOLDS** | [Claude catalog][C1], [lifecycle register][C2] (vendor, n.d.). |
| 4. `claude-sonnet-5-5` is a current model ID. | **HOLDS** | [Claude catalog][C1], [lifecycle register][C2] (vendor, n.d.). |
| 5. `claude-fable-5-1` is a current model ID. | **HOLDS** | [Claude catalog][C1], [lifecycle register][C2] (vendor, n.d.). |
| 6. `claude-haiku-4-5` is a current model selector. | **HOLDS** | [Claude catalog][C1] (vendor, n.d.). It is an alias for `claude-haiku-4-5-20251001`, unlike the newer fixed Claude IDs. |
| 7. `gpt-6-astra` is a current model ID. | **HOLDS** | [Astra model reference][O2], [deprecations][O12] (vendor, n.d.). |
| 8. `gpt-6.1-sol` is a current model ID. | **HOLDS** | [Sol model reference][O3], [deprecations][O12] (vendor, n.d.). |
| 9. `gpt-6-luna` is a current model ID. | **HOLDS** | [Luna model reference][O4], [deprecations][O12] (vendor, n.d.). |
| 10. These model families can be selected through their respective Claude Code and Codex clients. | **HOLDS** | [Claude Code configuration][C4], [Codex configuration][O6] (vendor, n.d.). Account access and client configuration still govern availability. |
| 11. Fable 5.1 costs $10 input / $50 output per million tokens. | **HOLDS** | [Claude pricing][C3] (vendor, n.d.). Standard API rates. |
| 12. Astra costs $10 / $50. | **HOLDS** | [Astra reference][O2] (vendor, n.d.). Standard short-context API rates. |
| 13. Opus 5.5 costs $4 / $20. | **HOLDS** | [Claude pricing][C3] (vendor, n.d.). |
| 14. Sonnet 5.5 costs $2 / $10. | **HOLDS** | [Claude pricing][C3] (vendor, n.d.). |
| 15. Sol 6.1 costs $2 / $10. | **HOLDS** | [Sol reference][O3] (vendor, n.d.). |
| 16. Haiku 4.5 costs $1 / $5. | **HOLDS** | [Claude pricing][C3] (vendor, n.d.). |
| 17. Luna 6 costs $0.10 / $0.50. | **HOLDS** | [Luna reference][O4] (vendor, n.d.). |
| 18. Opus 5.5 is the strongest model on software work. | **FAILS** | [AA coding agents][B1] (independent, n.d.). Sonnet max leads the composite, while Sol xhigh leads this comparison's repository-solving component. |
| 19. Opus 5.5 leads agentic knowledge work. | **HOLDS** | [AA Opus evaluation][A14] (independent, 2026-09-22). Supported on the reported knowledge-work evaluations, not every possible task. |
| 20. Opus should start at medium, with high the sweet spot and xhigh after a failed pass. | **UNSUPPORTED** | [Claude effort guide][C5] (vendor, n.d.), [Opus effort comparison][A6] (independent, n.d.). Medium is documented, but a universal optimum and this precise escalation sequence are not established. |
| 21. Opus max roughly doubles cost for only one or two points. | **HOLDS** | [Opus effort comparison][A6] (independent, n.d.), specifically xhigh to max: $3.46 to $5.98, index 56 to 58. Baseline must be stated. |
| 22. Opus max can run for hours. | **UNSUPPORTED** | [AA coding agents][B1] (independent, n.d.) reports a 1.1-hour average. [Willison's direct trial][W1] (independent, 2026-09-22) took about 20 minutes. Neither establishes the plural-hours claim for an individual run. |
| 23. Opus max can exhaust its output allowance thinking and return no answer. | **HOLDS** | [Willison's direct trial][W1] (independent, 2026-09-22): two 128K-token attempts without the requested SVG. Existence evidence, not a failure-rate estimate. |
| 24. Opus takes two to three times Astra's wall time. | **FAILS** | [Vals terminal results][V1] (independent, updated 2026-10-01) contradict the universal ratio. Some other workloads support it. |
| 25. Sonnet provides Opus-class quality on most work. | **UNSUPPORTED** | [Sonnet announcement][C8] (vendor, 2026-09-28), [AA Sonnet evaluation][A15] (independent, 2026-09-28). Close aggregate scores at max do not establish “most work” at the recommended medium/high settings. |
| 26. Sonnet has the best terminal-loop scores of any model. | **FAILS** | [AA Sonnet evaluation][A15] (independent, 2026-09-28) supports an AA-specific lead. [Vals terminal leaderboard][V1] (independent, updated 2026-10-01) has a different headline ordering. |
| 27. Sonnet is not a budget Claude and generally costs Opus-level amounts per task. | **FAILS** | [Sonnet announcement][C8] (vendor, 2026-09-28), [Vals business tasks][V3] (independent, updated 2026-10-01). Cost depends on effort and task, with meaningful cheaper cases. |
| 28. Sonnet max costs more per benchmark attempt than Opus max. | **HOLDS** | [AA Sonnet/Sol][A2], [AA Opus/Astra][A1] (independent, n.d.). Same Intelligence Index cost metric: $7.67 versus $5.98. |
| 29. Sonnet medium/high are suitable routine starting settings, with higher effort for harder work. | **HOLDS** | [Claude effort guide][C5] and [Sonnet prompting guide][C7] (vendor only, n.d.). A starting recommendation, not a measured universal optimum. |
| 30. Sonnet max must never run unattended, as a model limitation. | **UNSUPPORTED** | [Claude Code effort guidance][C4] (vendor, n.d.) does not impose this restriction. It can be a local budget policy. |
| 31. Fable is positioned above Opus 5.5 for demanding reasoning and long-horizon work. | **HOLDS** | [Claude catalog][C1] (vendor only, n.d.). This verifies positioning, not superiority. |
| 32. Fable does not measurably beat Opus 5.5 on hard problems. | **UNSUPPORTED** | [Vals Fable profile][V7], [Vals Opus profile][V6] (independent, n.d.). Results vary by problem class, including Fable leads. No universal or significance-tested conclusion found. |
| 33. Fable is the slowest model. | **FAILS** | [AA Fable/Opus comparison][A3] (independent, n.d.), [Vals business tasks][V3] (independent, updated 2026-10-01). Both contain counterexamples. |
| 34. Fable is among the most expensive models per task. | **HOLDS** | [AA Fable profile][A11] (independent, n.d.). Supported at max on that evaluation, not as an invariant at every effort. |
| 35. Fable should be reserved until Opus xhigh fails. | **UNSUPPORTED** | [Claude catalog][C1] (vendor, n.d.) supports escalation after higher-effort Opus, but not the precise xhigh threshold or a measured retry policy. |
| 36. Fable has a knowledge-recall edge over Opus 5.5. | **UNSUPPORTED** | [Vals MMLU-Pro][V5] (independent, archived 2026-09-01) lacks Opus 5.5. [AA Fable/Opus][A3] (independent, n.d.) provides no such general recall conclusion. |
| 37. Fable has a competitive-coding edge over Opus 5.5. | **FAILS** | [Vals Fable][V7], [Vals Opus][V6] (independent, n.d.) show the opposite IOI point-estimate ordering. [LiveCodeBench][V4] (independent, archived 2026-09-01) cannot establish the claimed newer-model comparison. |
| 38. Fable uses fewer tokens per coding task than Opus 5.5. | **HOLDS** | [AA coding agents][B1] (independent, n.d.): 5.7M versus 15.6M average total tokens at max. Fable's evaluated configuration includes fallback. |
| 39. Haiku is fast and inexpensive within the Claude lineup. | **HOLDS** | [Claude catalog][C1] (vendor, n.d.), [AA Haiku measurements][A5] (independent, n.d.). |
| 40. Haiku is suitable for simple parsing, classification, and copy. | **HOLDS** | [Claude catalog][C1] (vendor only, n.d.). Broad lightweight-task positioning, not separate accuracy guarantees for these workloads. |
| 41. Haiku is categorically unsuitable for shell work. | **UNSUPPORTED** | [Claude catalog][C1], [AA Haiku measurements][A5] (vendor and independent respectively, n.d.). Neither establishes this blanket prohibition. |
| 42. Luna does more for less than Haiku. | **HOLDS** | [AA Luna][A4], [AA Haiku][A5] (independent, n.d.). At the displayed tested settings, index 38 versus 17 and average attempt cost $0.07 versus $0.28. Not a guarantee for every task. |
| 43. Astra is the strongest model for novel mathematics. | **UNSUPPORTED** | [Epoch's Erdős evaluation][E1] (independent, 2026-09-01), [OpenAI launch][O15] (vendor, 2026-09-03). Strong evidence of capability, but the independent comparison omits later Opus 5.5 and Sol 6.1. |
| 44. Astra is the strongest model for science. | **FAILS** | [AA Opus/Astra][A1] (independent, n.d.). Opus leads SciCode and ties CritPt. The universal science superlative is contradicted. |
| 45. Astra leads figure-out-the-mechanism problems. | **HOLDS** | [Vals MysteryMechanism][V2] (independent, updated 2026-10-01). Supports this specific task family. |
| 46. Astra is the fastest frontier model. | **FAILS** | [AA Sol release evaluation][A17] (independent, 2026-09-29), [Vals MysteryMechanism][V2] (independent, updated 2026-10-01). Sol is faster in relevant comparisons. |
| 47. Astra is frugal with output tokens relative to frontier Claude models. | **HOLDS** | [AA Astra evaluation][A16] (independent, 2026-09-09), [AA Opus evaluation][A14] (independent, 2026-09-22). Supported at the measured efforts. |
| 48. Astra's task cost is moderate despite its high token price. | **HOLDS** | [AA Opus/Astra][A1] (independent, n.d.). Supported relative to the compared max-effort Claudes, not relative to Sol or Luna. “Moderate” itself is editorial. |
| 49. Astra medium is already strong, and high is appropriate for harder debugging. | **HOLDS** | [OpenAI selection guidance][O5] (vendor, n.d.), [ComputingForGeeks' own tests][W2] (independent, updated 2026-09-05). Supports a starting heuristic, not a general optimum. |
| 50. Astra's Codex default is medium. | **UNSUPPORTED** | [Astra reference][O2], [Codex configuration][O6] (vendor, n.d.). The model reference does not explicitly mark an effort default, and client configuration can override it. |
| 51. Astra trails Opus/Sonnet 5.5 on terminal-heavy loops. | **HOLDS** | [AA Opus/Astra][A1], [AA Sonnet/Sol][A2] (independent, n.d.), at the displayed max settings. Not true for every Claude effort. |
| 52. Astra can overthink small tasks. | **HOLDS** | [ComputingForGeeks' own effort experiment][W2] (independent, updated 2026-09-05). One small debugging prompt was already correct at low, while max used much more time and hit the output cap. |
| 53. Sol 6.1 has the best cost-to-quality of any model. | **UNSUPPORTED** | [AA Sol evaluation][A17] (independent, 2026-09-29) supports a cost-performance frontier result at its quality levels, not a unique winner for all budgets and tasks. |
| 54. Sol 6.1 delivers near-Astra capability. | **HOLDS** | [AA Sol evaluation][A17] (independent, 2026-09-29), [Sol reference][O3] (vendor, n.d.). Aggregate evidence, not identical strengths. |
| 55. Sol 6.1 offers top-tier agentic coding. | **HOLDS** | [AA Sol evaluation][A17] (independent, 2026-09-29). |
| 56. Sol costs one fifth to one tenth as much as frontier models per task. | **FAILS** | [AA Sol/Sonnet comparison][A2], [AA Opus/Astra comparison][A1] (independent, n.d.). Ratios vary beyond both ends of this range. |
| 57. Sol is fast. | **HOLDS** | [AA Codex/Devin comparison][B3] (independent, n.d.). Supported for xhigh agentic coding in this comparison, not a universal speed rank. |
| 58. Sol xhigh beats its own max on agentic coding. | **HOLDS** | [AA Sol evaluation][A17] (independent, 2026-09-29), [AA Codex variants][B2] (independent, n.d.). Benchmark-specific, not every task. |
| 59. Sol xhigh costs two thirds as much as max on that coding evaluation. | **HOLDS** | [AA Codex variants][B2] (independent, n.d.): $1.04 / $1.55 = 0.671. |
| 60. Sol xhigh is the coding sweet spot, while medium is adequate for simple work. | **HOLDS** | [AA Codex variants][B2] (independent, n.d.), [OpenAI selection guide][O5] (vendor, n.d.). Defensible starting choices. Medium also performs well beyond simple tasks. |
| 61. Sol trails Opus/Sonnet 5.5 on terminal-heavy loops. | **HOLDS** | [AA Sonnet/Sol][A2] (independent, n.d.), [Vals terminal results][V1] (independent, updated 2026-10-01). Qualify the Claude effort settings. |
| 62. Luna is dramatically inexpensive and suited to classification, extraction, transformation, summarization, and small verifiable edits. | **HOLDS** | [Luna reference][O4], [OpenAI selection guide][O5] (vendor, n.d.), [AA Luna evaluation][A18] (independent, 2026-09-22). |
| 63. Luna is weak at terminal loops relative to the frontier models. | **HOLDS** | [AA Luna evaluation][A18] (independent, 2026-09-22), [Vals terminal results][V1] (independent, updated 2026-10-01). |
| 64. Luna must never drive a shell unsupervised and needs at least medium for anything agentic. | **UNSUPPORTED** | [OpenAI selection guide][O5] (vendor, n.d.) does not establish either universal restriction. These are local operating policies. |
| 65. Effort changes costs by roughly 5x to 18x within a model. | **HOLDS** | [AA Sol effort variants][A8] and [AA Sonnet effort variants][A7] (independent, n.d.). Selected Intelligence Index examples span about 5.5x and 18.3x. Not a universal model or workload range. |
| 66. Effort is a bigger cost lever than model choice. | **FAILS** | [OpenAI pricing][O13] (vendor, n.d.), [AA Luna][A4], [AA Opus/Astra][A1] (independent, n.d.). Switching models can produce larger differences. |
| 67. Max is rarely the best setting. | **UNSUPPORTED** | [Claude effort guide][C5] (vendor, n.d.), [AA Sol effort variants][A8] (independent, n.d.). No representative frequency or definition of “best” was supplied or found. |
| 68. Adjust effort before switching models. | **UNSUPPORTED** | [OpenAI selection guide][O5], [Claude effort guide][C5] (vendor, n.d.). Reasonable policy, but not an established generally optimal ordering. |
| 69. `--effort` and `model_reasoning_effort` are real effort controls. | **HOLDS** | [Claude Code configuration][C4], [Codex configuration][O6] (vendor, n.d.). Different clients and configuration surfaces. |
| 70. Claude Code defaults Opus 5.5 and Sonnet 5.5 to medium, and Fable 5.1 to high. | **HOLDS** | [Claude Code configuration][C4] (vendor only, n.d.), absent explicit overrides. These are not all the API defaults. |
| 71. All listed Codex models default to medium. | **UNSUPPORTED** | [Sol reference][O3], [Luna reference][O4], [Astra reference][O2], [Codex configuration][O6] (vendor, n.d.). Explicit API support for Sol/Luna does not establish Astra's CLI default. |
| 72. Task cost depends on consumed tokens, not just nominal token price. | **HOLDS** | [AA coding-agent cost methodology][B1] (independent, n.d.). Input, cached input, output, and other applicable charges matter. |
| 73. Claude 5.5 models emit four to seven times Astra's output tokens per task. | **HOLDS** | [AA Opus evaluation][A14] (independent, 2026-09-22), [AA Sonnet evaluation][A15] (independent, 2026-09-28). Approximately true for the reported max-effort aggregate, not all efforts or tasks. |
| 74. Sonnet max costs more than Opus, while Astra costs less than either, per finished task. | **UNSUPPORTED** | [AA Opus/Astra][A1], [AA Sonnet/Sol][A2] (independent, n.d.) support the ordering per evaluated attempt, not cost to successful completion. |
| 75. The cost-to-task labels describe realistic costs of getting representative work done. | **UNSUPPORTED** | [AA cost methodology][B1] (independent, n.d.). No project-specific measurements were supplied. |
| 76. Claude flagships take two to three times as long as Astra or Sol on the same work. | **FAILS** | [Vals business tasks][V3], [Vals mechanism tasks][V2] (independent, updated 2026-10-01), [AA coding agents][B1] (independent, n.d.). Neither effort nor workload preserves that range. |
| 77. When time matters, Codex is always the correct route. | **FAILS** | [AA coding agents][B1] (independent, n.d.). Sonnet medium/high can finish faster than Sol xhigh or Astra max, with quality tradeoffs. |
| 78. Listed OpenAI models charge the whole request at 2x input and 1.5x output above 272K input tokens. | **HOLDS** | [Astra][O2], [Sol][O3], [Luna][O4] model references (vendor only, n.d.). This is standard API billing, not a universal statement about subscription quotas. |
| 79. Claude has flat pricing across its 1M context window. | **FAILS** | [Claude pricing][C3] and [catalog][C1] (vendor, n.d.). True for the listed Fable/Opus/Sonnet, but Haiku has 200K context. |
| 80. Very large contexts should go to Claude unless speed is the priority, on the stated cost rationale. | **FAILS** | [Claude pricing][C3], [Sol][O3], [Luna][O4] (vendor, n.d.). Even after the long-input multiplier, Luna remains much cheaper per token. Sol also remains competitive. |
| 81. Opus 5, Opus 4.8, Fable 5, and Sonnet 5 remain callable previous generations. | **HOLDS** | [Claude lifecycle register][C2] (vendor, n.d.). All remain active as of the verification date. |
| 82. GPT-6 Sol remains callable and has been superseded by 6.1 Sol. | **HOLDS** | [GPT-6 Sol reference][O8], [deprecations][O12] (vendor, n.d.), [AA Sol release evaluation][A17] (independent, 2026-09-29). |
| 83. GPT-5.6 Sol remains callable and is a previous generation. | **HOLDS** | [5.6 Sol reference][O9], [deprecations][O12] (vendor, n.d.). |
| 84. GPT-5.6 Terra remains callable and is a previous generation. | **HOLDS** | [5.6 Terra reference][O10], [deprecations][O12] (vendor, n.d.). |
| 85. GPT-5.6 Luna remains callable and is a previous generation. | **HOLDS** | [5.6 Luna reference][O11], [deprecations][O12] (vendor, n.d.). |
| 86. Each omitted Claude model is beaten on both quality and task cost by a listed Claude model. | **UNSUPPORTED** | [Vals terminal results][V1] (independent, updated 2026-10-01) support specific examples, not general dominance across workloads. |
| 87. Each omitted OpenAI model is beaten on both quality and task cost by a listed OpenAI model. | **FAILS** | [AA Luna evaluation][A18] (independent, 2026-09-22), [AA Codex variants][B2] (independent, n.d.). GPT-5.6 Luna supplies a counterexample on coding cost versus quality. |
| 88. The draft was last updated on 2026-10-04. | **UNSUPPORTED** | The supplied [draft](/tmp/verify.SfRf/gpt-6-astra/models-draft.md) asserts this date. No version history was supplied to independently establish it. |

**How to read the verdicts**

All URLs were checked through live search or fetched pages on 2026-10-04. “n.d.” means the page shows no publication date, not that it was published today. Dates marked “updated” or “archived” are those shown by the source. Vendor documentation is authoritative for advertised IDs, rates, configuration, and lifecycle. It does not independently prove performance. “Current/callable” means documented as available, not that I ran authenticated paid calls against each model or tested the local delegate CLI.

Repeated factual claims in the notes are consolidated with the corresponding table rows. Prices mean USD per million standard API input/output tokens, before discounts, cache treatment, long-context premiums, or special service tiers. Recommendations are identified separately from empirical model limitations. The depth/execution/cost ratings are judgments and have not been assigned verdicts.

Most effort and economic comparisons here depend on Artificial Analysis. Its release articles, model profiles, and comparison pages are different presentations of its evaluations, not independent replications. Vals provides another evaluator and often another harness. Willison and ComputingForGeeks provide small firsthand experiments. None establishes performance on this project's actual delegated tasks.

**Corrections and unresolved claims**

**1 and 88: unavailable local history and references.** The referenced introduction files cannot be checked here. Their implied locations are `/tmp/verify.SfRf/gpt-6-astra/tools.md` and `/tmp/verify.SfRf/gpt-6-astra/SKILL.md`. The supplied draft date is plausible but cannot establish an editing event without history. These are limitations of the supplied material, not evidence that the statements are false.

**18, 25, 26, and 51/61: qualify the task, harness, and effort.** “Strongest on software” is too broad for Opus. Sonnet's terminal leadership is supported by AA's max-effort evaluation, where its score is 64 versus Opus's 60. That does not establish leadership at medium/high or across harnesses. Its AA Intelligence Index score moves from 41 at medium to 47 at high and 56 at max. The row blends different operating points. [AA Sonnet evaluation][A15], [medium profile][A9], [high/max comparison][A10].

Vals's headline Terminal-Bench ordering is Opus 65.15%, Sonnet 64.14%, Astra 59.60%, and Sol 55.05%. However, some Claude attempts used provider fallback. Counting those attempts as failures changes Opus to 58.08% and Sonnet to 62.63%. Thus this is neither a clean contradictory intrinsic-model ranking nor support for an unconditional winner. Use a scoped performance statement. This methodological caveat belongs in the verification report, not the shipped reference. [Vals terminal results][V1].

**20, 21, 22, 30, and 35: separate observed behavior from operating policy.** Opus's “roughly doubles for a point or two” is supportable only relative to xhigh. Relative to high, the same AA table moves from $1.82 and 54 points to $5.98 and 58 points, about 3.3x for four points. Say which step is being compared. A score point is an index point, not a percentage of successfully completed work. [Opus variants][A6].

I found slow Opus runs and an hour-scale coding average, but no sufficiently specific source establishing the draft's individual plural-hours assertion. Keep the demonstrated possibility of exhausting output without an answer, and avoid attaching an unsupported duration. The firsthand empty-answer observation concerns a bounded SVG request, so it should not imply that most max-effort coding runs fail this way. [Willison][W1].

Anthropic recommends choosing effort for the task and positions Fable as an escalation after higher-effort Opus. It does not establish high as universally optimal or require the exact xhigh-then-Fable ladder. Its Claude Code documentation even presents max as an option for difficult work pursued without the user. “Never max unattended” can be an explicit project budget rule, but should not masquerade as a vendor restriction or a measured reliability boundary. [Claude effort][C5], [Claude Code configuration][C4].

**27: Sonnet is expensive at some settings, not categorically.** Anthropic explicitly distinguishes economical lower-effort operation from expensive higher-effort behavior. In Vals's business-task evaluation, Sonnet averages $8.79 per test versus Opus's $11.02. The draft's recommended medium/high settings do not justify importing a max-effort cost label. Retain the max-specific warning, and make the ordinary-cost label conditional. [Sonnet announcement][C8], [Vals business tasks][V3].

**32, 33, 36, and 37: Fable's proposed niche needs revision.** Fable's current Vals TaxEval point estimate is 77.64%, compared with Opus's 70.50%. Its PublicBenefitsEval score is 74.90% versus 70.64%. These are counterpressure against “doesn't measurably beat” across all hard problems. They are not a substitute for a paired statistical test or a general reasoning ranking. [Fable profile][V7], [Opus profile][V6].

Fable is not the slowest. Vals business tasks take about 29m32s for Fable, 35m06s for Opus, and 36m45s for Sonnet. AA's model comparison also gives Fable a shorter calculated generation time than Opus. [Vals business tasks][V3], [AA Fable/Opus][A3].

The archived MMLU-Pro and LiveCodeBench pages place Fable above earlier Opus models, but date from September 1 and omit Opus 5.5. They do not verify the present comparison. Current Vals IOI point estimates favor Opus 5.5, 95.06% versus Fable's 90.78%, with overlapping uncertainty intervals. Correct “competitive-coding edge” to task-dependent results, and remove the claimed recall edge unless a current direct comparison supports it. [MMLU-Pro][V5], [LiveCodeBench][V4], [Opus][V6], [Fable][V7].

**41 and 64: shell restrictions are policies.** Low overall or terminal benchmark scores support limiting task difficulty and requiring verification. They do not prove that a model cannot execute a simple supervised shell workflow, nor that medium is a universal minimum for any agentic action. Luna's vendor guidance expressly includes simple edits at low effort. Keep a supervision rule if that is the project's policy, with wording that identifies it as such. [OpenAI selection guide][O5].

**43 and 44: Astra is a strong specialist, but the global superlatives exceed the evidence.** Epoch's initial Erdős evaluation tested five models and only Astra solved problems, at 3%. It did not include Opus 5.5 or Sol 6.1. That establishes a notable result among the tested models, not a current all-model mathematics ranking. [Epoch][E1]. On AA's comparison, Opus leads Astra on SciCode, 67% versus 56%, while CritPt is tied at 32%. “Science” is too broad to give Astra an unconditional lead. [AA Opus/Astra][A1]. Mechanism discovery is the cleanest independently supported narrow claim: Astra leads the current Vals MysteryMechanism table. [Vals mechanisms][V2].

**24, 33, 46, 57, 76, and 77: no single speed ordering holds.** Vals's terminal durations are about 64 minutes for Opus, 82 for Sonnet, 60 for Fable, 35.7 for Astra, and 45.2 for Sol. Several ratios are below 2x. [Vals terminal results][V1]. On MysteryMechanism, Sol is faster than Astra, whereas the business-task table reverses them. Effort, task, provider, and harness must be specified. [Vals mechanisms][V2], [Vals business tasks][V3].

AA's coding-agent table illustrates the effort effect: Sonnet high takes 12.3 minutes, Sonnet medium 8.5, Sol xhigh 15.5, and Astra max 29.4. Sonnet's cheaper settings score lower. Routing solely by vendor loses that tradeoff. [AA coding agents][B1].

There are also two distinct time metrics. AA's ordinary model comparisons calculate generation time from output volume and throughput, excluding time to first token. Its coding-agent comparison measures active agent wall time, excluding setup and verification overhead. Do not relabel calculated generation time as end-to-end wall clock. [AA Fable/Opus][A3], [AA coding-agent methodology][B1].

**50 and 71: configure the desired default explicitly.** Sol and Luna's API pages explicitly mark medium as their reasoning default. Astra's page lists its supported levels without the same default annotation. That gap does not prove Astra defaults elsewhere, but it leaves the universal assertion unverified. API defaults also do not independently establish Codex client defaults, which can be overridden. Write medium as the reference's chosen starting setting, or verify a particular installed client catalog. [Sol][O3], [Luna][O4], [Astra][O2], [Codex configuration][O6].

**53 and 56: narrow Sol's economic claim.** AA places Sol on its cost-performance frontier. That means strong value at given capability levels, not a unique optimum across all work. At max, its $0.72 Intelligence Index attempt cost is about 22% of Astra's $3.26, 12% of Opus's $5.98, and 9% of Sonnet's $7.67. The draft's fixed 10%-20% interval is not a general range. State the comparator and effort, or say “substantially cheaper on the measured workloads.” [AA Sol evaluation][A17], [Sol/Sonnet][A2], [Opus/Astra][A1].

**65 through 68: effort matters, but the proposed universal rules do not follow.** The 5x-18x statement works as rounded examples: Sol low/max costs $0.13/$0.72 and Sonnet low/max $0.42/$7.67. Astra's corresponding published range is $0.82/$3.26, only about 4x. These are suite averages, not immutable model properties. [Sol variants][A8], [Sonnet variants][A7], [Astra evaluation][A16].

Model selection can be a larger lever. Standard Astra token rates are 100 times Luna's. Their measured AA attempt costs differ by roughly 47x, larger than the advertised effort range. Effort should be calibrated alongside model choice, not declared categorically more influential. [OpenAI pricing][O13], [AA Astra][A12], [AA Luna][A4].

Max being “rarely best” requires a workload distribution and a definition of best. Max can maximize score while failing a cost or latency objective. Sol's xhigh coding advantage is real in the cited evaluation, but its general Intelligence Index still rises from 51 at xhigh to 52 at max. Do not generalize the coding result to all tasks. No supplied evidence tests the proposed universal order of adjusting effort before switching models. [Sol variants][A8], [OpenAI selection guide][O5].

**73 through 75: benchmark attempts are not finished work.** The output-token comparison is supportable for max-effort AA aggregates: roughly 119K for Opus, 193K for Sonnet, and 27K for Astra, about 4.4x and 7.1x. It should not be carried over to the recommended medium/high defaults. [AA Opus evaluation][A14], [AA Sonnet evaluation][A15].

Costs average attempts, including failures, rather than successful completion after retries and review. Input and caching also matter. Replace “per finished task” with a defined attempt metric or measure completion costs. [AA cost methodology][B1].

**78 through 80: fix the context scope and routing inference.** The premium is documented for the three listed OpenAI models and applies to the whole request above the input threshold. The flat 1M-window statement applies to Fable 5.1, Opus 5.5, and Sonnet 5.5, not Haiku 4.5, whose window is 200K. [Astra][O2], [Sol][O3], [Luna][O4], [Claude catalog][C1], [Claude pricing][C3].

After the premium, standard Sol rates are $4/$15 and Luna's are $0.20/$0.75 per million tokens. Compare with flat Claude rates: Sonnet $2/$10, Opus $4/$20, and Fable $10/$50. Thus large context alone does not make Claude cheapest. Input/output mix, task capability, effort, and caching affect the choice. Remove the categorical routing rule or narrow it to a specific capable-model comparison. This calculation concerns unit prices, not proven task completion costs. [Sol][O3], [Luna][O4], [Claude pricing][C3].

**86 and 87: previous generation does not imply universal dominance.** The older Claudes remain active. Vals terminal results support their replacement on this task suite, not universal dominance. Narrow the wording. [Claude lifecycle][C2], [Vals terminal results][V1].

For OpenAI, the blanket claim has a direct coding counterexample. AA reports GPT-5.6 Luna at index 43 and $0.44 per attempt versus GPT-6 Luna at 41 and $0.18. New Luna is cheaper but scores lower. Sol 6.1's lowest tested effort costs $0.50, so it does not dominate old Luna on both dimensions in this table either. By contrast, Sol 6.1 does improve the measured quality/cost tradeoff over GPT-6 Sol and GPT-5.6 Sol. Evidence for those replacements must not be silently extended to every model and workload, including Terra. [AA Luna evaluation][A18], [AA Codex variants][B2], [AA Sol evaluation][A17].

**Ratings and recommendations, without verdicts**

The clearest mismatch is Sonnet's execution 5 and high cost label paired with medium/high instructions. Its terminal performance and cost move sharply with effort. On AA's model comparison, Sonnet high scores 44 on terminal tasks versus max's 64. Treating the max operating point as the row's medium/high capability overstates that row. [AA Sonnet high/max][A10].

The other numeric ratings are not demonstrably wrong on this coarse scale. They remain interpretations rather than calibrated measurements. In particular, Sol's execution 5 can be defensible for overall coding efficiency while trailing the Claudes at max on terminal tasks. Astra's depth 5 can express a specialist preference without proving a universal science lead. “Lowest” for Luna is defensible within the listed set, not a claim about every available model.

Default routing to Sol for implementation, Opus for demanding engineering, Astra for novel technical reasoning, and Sonnet as an alternative is a usable editorial policy. The evidence does not establish those choices as universal winners, an optimal parallel fan-out strategy, or the best retry ladder. Keep them as starting choices, as the notes already say.

**Material that must not enter the shipped reference**

I found no source names, named studies, account of the research process, or “this used to say” wording in the draft. I also found no notes about honesty, evaluation gaming, outages, or silent model substitution. The output-window failure and unattended-effort restrictions describe operational behavior and policy, not those prohibited subjects. The update date is maintenance metadata, not a research narrative.

Some cited evidence does contain fallback and evaluation limitations. They affect how confidently a result can be used and are recorded here where necessary. Do not copy that methodology discussion, source attribution, or evaluator names into the shipped reference. Instead weaken or omit any claim that cannot survive without it.

**Access limitations**

Live search succeeded throughout. Some guessed page locations failed to fetch, and some benchmark charts did not expose their scores as text, including the dynamic FrontierMath Tier 4 v2 view. I continued using accessible official documentation, evaluator tables, dated articles, and firsthand tests. A fetch failure was not treated as evidence that a model or claim was false. No paid inference tests, authenticated client-availability tests, or local project workload measurements were performed. I worked independently, without agents or coordination, and did not edit the draft.

[C1]: https://platform.claude.com/docs/en/models/overview
[C2]: https://platform.claude.com/docs/en/about-claude/model-deprecations
[C3]: https://platform.claude.com/docs/en/about-claude/pricing
[C4]: https://code.claude.com/docs/en/model-config
[C5]: https://platform.claude.com/docs/en/build-with-claude/effort
[C7]: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-sonnet-5-5
[C8]: https://www.anthropic.com/claude-sonnet-5-5
[O2]: https://developers.openai.com/api/docs/models/gpt-6-astra
[O3]: https://developers.openai.com/api/docs/models/gpt-6.1-sol
[O4]: https://developers.openai.com/api/docs/models/gpt-6-luna
[O5]: https://developers.openai.com/api/docs/guides/model-selection
[O6]: https://learn.chatgpt.com/docs/config-file/config-reference
[O8]: https://developers.openai.com/api/docs/models/gpt-6-sol
[O9]: https://developers.openai.com/api/docs/models/gpt-5.6-sol
[O10]: https://developers.openai.com/api/docs/models/gpt-5.6-terra
[O11]: https://developers.openai.com/api/docs/models/gpt-5.6-luna
[O12]: https://developers.openai.com/api/docs/deprecations
[O13]: https://developers.openai.com/api/docs/pricing
[O15]: https://openai.com/index/gpt-6-astra/
[A1]: https://artificialanalysis.ai/models/comparisons/claude-opus-5-5-vs-gpt-6-astra
[A2]: https://artificialanalysis.ai/models/comparisons/claude-sonnet-5-5-vs-gpt-6-1-sol
[A3]: https://artificialanalysis.ai/models/comparisons/claude-opus-5-5-vs-claude-fable-5-1
[A4]: https://artificialanalysis.ai/models/gpt-6-luna
[A5]: https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning
[A6]: https://artificialanalysis.ai/models/releases/claude-opus-5-5
[A7]: https://artificialanalysis.ai/models/releases/claude-sonnet-5-5
[A8]: https://artificialanalysis.ai/models/releases/gpt-6-1-sol
[A9]: https://artificialanalysis.ai/models/claude-sonnet-5-5-medium
[A10]: https://artificialanalysis.ai/models/comparisons/claude-sonnet-5-5-high-vs-claude-sonnet-5-5
[A11]: https://artificialanalysis.ai/models/claude-fable-5-1
[A12]: https://artificialanalysis.ai/models/gpt-6-astra
[A14]: https://artificialanalysis.ai/articles/claude-opus-5-5
[A15]: https://artificialanalysis.ai/articles/claude-sonnet-5-5
[A16]: https://artificialanalysis.ai/articles/benchmarking-gpt-6-astra
[A17]: https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence
[A18]: https://artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier
[B1]: https://artificialanalysis.ai/agents/coding-agents/comparisons/claude-code-vs-codex
[B2]: https://artificialanalysis.ai/agents/coding-agents/comparisons/antigravity-cli-vs-codex
[B3]: https://artificialanalysis.ai/agents/coding-agents/comparisons/codex-vs-devin-fusion-cli
[V1]: https://www.vals.ai/benchmarks/terminal-bench-4
[V2]: https://www.vals.ai/benchmarks/mysterymechanism
[V3]: https://www.vals.ai/benchmarks/emb
[V4]: https://www.vals.ai/benchmarks/lcb
[V5]: https://www.vals.ai/benchmarks/mmlu_pro
[V6]: https://www.vals.ai/models/anthropic_claude-opus-5-5
[V7]: https://www.vals.ai/models/anthropic_claude-fable-5-1
[W1]: https://simonwillison.net/2026/Sep/22/opus-and-sol-and-luna/
[W2]: https://computingforgeeks.com/gpt-6-astra-released-features-benchmarks/
[E1]: https://epoch.ai/latest/announcing-frontiermath-erdos
