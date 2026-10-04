Verifier model ID: `gpt-6.1-sol`. Verification date: 2026-10-04.

| Claim in the draft | Verdict | Source |
| --- | --- | --- |
| 01. `claude-opus-5-5` is a current model ID. | HOLDS | [V1], vendor, n.d. |
| 02. `claude-sonnet-5-5` is a current model ID. | HOLDS | [V1], vendor, n.d. |
| 03. `claude-fable-5-1` is a current model ID. | HOLDS | [V1], vendor, n.d. |
| 04. `claude-haiku-4-5` is a current model alias. | HOLDS | [V1], vendor, n.d. Alias differs from the dated API ID. |
| 05. `gpt-6-astra` is a current model ID. | HOLDS | [V10], vendor, n.d. |
| 06. `gpt-6.1-sol` is a current model ID. | HOLDS | [V9], vendor, n.d. |
| 07. `gpt-6-luna` is a current model ID. | HOLDS | [V11], vendor, n.d. |
| 08. The four Claude models can be selected in Claude Code. | HOLDS | [V6], vendor, n.d. Subject to client version, provider and access. |
| 09. The three GPT models can be selected in Codex. | HOLDS | [V20], vendor, n.d. Subject to account and rollout. |
| 10. Opus 5.5 costs $4/$20 per million input/output tokens. | HOLDS | [V2], vendor, n.d., [I8], independent, 2026-09-22. |
| 11. Sonnet 5.5 costs $2/$10. | HOLDS | [V3], vendor, n.d., [I9], independent, 2026-09-28. |
| 12. Fable 5.1 costs $10/$50. | HOLDS | [V4], vendor, n.d. |
| 13. Haiku 4.5 costs $1/$5. | HOLDS | [V1], vendor, n.d., [I14], independent, n.d. |
| 14. Astra costs $10/$50. | HOLDS | [V10], vendor, n.d. |
| 15. 6.1 Sol costs $2/$10. | HOLDS | [V9], vendor, n.d. |
| 16. 6 Luna costs $0.10/$0.50. | HOLDS | [V11], vendor, n.d., [I13], independent, n.d. |
| 17. The named Claude models support their recommended `medium`, `high`, `xhigh` and `max` settings. | HOLDS | [V6], vendor, n.d. Haiku is not given an effort recommendation. |
| 18. Astra, 6.1 Sol and Luna support the effort levels named in their rows. | HOLDS | [V9], [V10], [V11], vendor, n.d. |
| 19. Opus 5.5 starts at `medium` in Claude Code. | HOLDS | [V6], vendor, n.d. |
| 20. Sonnet 5.5 starts at `medium` in Claude Code. | HOLDS | [V6], vendor, n.d. Its API default is `high`, [V3]. |
| 21. Fable 5.1 starts at `high` in Claude Code. | HOLDS | [V6], vendor, n.d. |
| 22. All the Codex models default to `medium`. | UNSUPPORTED | [V18], vendor, n.d., explicitly says defaults depend on client/account. API defaults are a separate matter. |
| 23. Astra's API default is `medium`. | HOLDS | [V12], vendor, n.d. |
| 24. 6.1 Sol and Luna have API defaults of `medium`. | HOLDS | [V9], [V11], vendor, n.d. |
| 25. Effort can change cost per task by approximately 5x to 18x within one model. This appears twice. | HOLDS | [I5], [I6], independent, n.d. Supported examples, not a universal bound. |
| 26. Effort is a bigger cost lever than model choice. | FAILS | [I1], independent, n.d. Between-model differences can exceed within-model differences. |
| 27. Opus 5.5 is strongest on software and agentic knowledge work. | HOLDS | [I8], independent, 2026-09-22, [I10], independent, update 2026-09-22. Supported leadership on named evaluations, not every task. |
| 28. Opus `max` roughly doubles cost for a point or two. | HOLDS | [I1], independent, n.d. Approximately true for `xhigh` to `max` on its Intelligence Index. |
| 29. Opus 5.5 can run for hours. | HOLDS | [V8], vendor, 2026-09-22. Reports a 9.5-hour coding run. Only vendor support for that particular example. |
| 30. Opus `max` can consume the entire output window thinking and return no answer. | HOLDS | [I11], independent first-hand observation, 2026-09-22. |
| 31. Opus takes two to three times Astra's wall clock. | FAILS | [I15], independent, n.d. Ratio varies with metric, task and effort. |
| 32. Sonnet delivers Opus-class quality on most work. | UNSUPPORTED | [I9], independent, 2026-09-28, [I12], independent, update 2026-09-28, support closeness mainly at `max`, not the recommended `medium`/`high`. |
| 33. Sonnet has the best terminal-loop scores of any model. | HOLDS | [I7], independent, n.d. Highest on this Terminal-Bench 4.0 board at `max`. Requires that scope. |
| 34. Sonnet's token appetite puts its cost per task at Opus level. | UNSUPPORTED | [I12], independent, update 2026-09-28, gives a substantially cheaper Sonnet result. Relative cost depends on evaluation and effort. |
| 35. Sonnet at `max` costs more per task than Opus at `max`. Repeated in the cost note. | HOLDS | [I9], independent, 2026-09-28, [I3], independent, n.d. Holds on AA suites, not universally. |
| 36. Fable is positioned as the escalation for demanding reasoning and long-horizon work. | HOLDS | [V4], [V6], vendor, n.d. Only vendor positioning supports this. |
| 37. Fable does not measurably beat Opus 5.5 on hard problems. | UNSUPPORTED | [I16], independent, n.d., supports lower aggregate results, not absence of wins on all hard-problem categories. |
| 38. Fable is the slowest model. | FAILS | [I3], independent, n.d. Its coding run average is shorter than both Claude 5.5 models at `max`. |
| 39. Fable is among the most expensive models per task. | HOLDS | [I1], independent, n.d. At `max` on this Intelligence Index. |
| 40. Fable has an edge in knowledge recall. | HOLDS | [I17], independent, n.d. Raw recall accuracy is 67% versus Opus 5.5's 66% at `max`. This is a small observed edge, not established significance. |
| 41. Fable has an edge in competitive coding over Opus 5.5. | FAILS | [I18], independent, updated 2026-10-01. Current IOI results favor Opus 5.5. |
| 42. Fable uses fewer tokens per coding task than Opus 5.5. | HOLDS | [I3], independent, n.d. At `max` on the AA coding-agent suite. |
| 43. Haiku is fast and cheap for simple parsing, classification and copy. | HOLDS | [V6], vendor, n.d., supports simple-task positioning. [I14], independent, n.d., supports speed and relatively low task cost. |
| 44. Haiku is unsuitable for shell work. | HOLDS | [I19], independent, n.d. Its measured Terminal-Bench score is 0%. Suitability remains a conservative recommendation. |
| 45. GPT-6 Luna does more for less than Haiku 4.5. | HOLDS | [I13], [I14], independent, n.d. Higher aggregate score and lower task cost in these configurations. |
| 46. Astra is strongest on novel mathematics. | HOLDS | [I20], independent, n.d., [I21], independent, n.d. Supports leadership on particular math/reasoning evaluations. |
| 47. Astra is strongest on science and mechanism-discovery problems. | UNSUPPORTED | [I15], independent, n.d., shows mixed science results. [V8], vendor, 2026-09-22, gives Astra a higher scientific-terminal result. No single general winner is established. |
| 48. Astra is the fastest frontier model. | FAILS | [I15], [I22], independent, n.d. Claude models emit tokens faster and some lower-effort configurations complete work faster. |
| 49. Astra is frugal with tokens compared with the Claude 5.5 pair. | HOLDS | [I15], [I22], independent, n.d. At `max` in the Intelligence Index. |
| 50. Astra's task cost is moderate despite a top sticker price. | HOLDS | [I15], [I22], independent, n.d. Lower task cost than Claude 5.5 at `max`, despite higher input/output rates. The adjective is judgment. |
| 51. Astra trails the Claude 5.5 pair on terminal-heavy loops. | HOLDS | [I2], independent, n.d. Comparing the evaluated high-performing configurations. |
| 52. Astra can overthink small tasks. | UNSUPPORTED | [V10], vendor, n.d., establishes effort controls, not this behavioral claim. No direct Astra-specific evidence found. |
| 53. Astra at `medium` is already strong. | HOLDS | [I1], independent, n.d. Its measured Intelligence Index score is 50. The threshold for strong is judgment. |
| 54. 6.1 Sol has the best cost-to-quality of any model. | UNSUPPORTED | [I5], independent, n.d., supports a favorable frontier position, not a unique winner for every quality target and workload. |
| 55. 6.1 Sol has near-Astra depth. | HOLDS | [V9], vendor, n.d., [I1], independent, n.d. Close aggregate scores at upper efforts. |
| 56. 6.1 Sol has top-tier agentic coding. | HOLDS | [I2], independent, n.d. |
| 57. 6.1 Sol costs a fifth to a tenth of frontier models per task. | UNSUPPORTED | [I2], [I1], independent, n.d. Some comparisons fit, others fall outside that interval. |
| 58. 6.1 Sol is fast. | HOLDS | [I2], independent, n.d. Faster task completion than the frontier `max` configurations in this coding comparison. Not a token-speed superlative. |
| 59. 6.1 Sol at `xhigh` beats its own `max` on agentic coding. Repeated in the effort note. | HOLDS | [I2], independent, n.d. A measured mean, without evidence here of statistical significance. |
| 60. 6.1 Sol `xhigh` costs two-thirds of `max` on agentic coding. | HOLDS | [I2], independent, n.d. $1.04/$1.55 is approximately 0.67. |
| 61. 6.1 Sol trails both Claude 5.5 models on terminal-heavy loops. | HOLDS | [I2], independent, n.d. At the compared frontier configurations. Fails if applied to Sonnet's recommended `medium`/`high`. |
| 62. Luna is dramatically cheap. | HOLDS | [V11], vendor, n.d., [I13], independent, n.d. Relative description, supported by low listed and measured costs. |
| 63. Luna suits classification, extraction, transformation, summarization and small verifiable coding changes. | HOLDS | [V19], [V20], vendor, n.d. Vendor workload guidance only, not verified equal reliability on every category. |
| 64. Luna is weak at terminal loops. | HOLDS | [I2], independent, n.d. 15% on Terminal-Bench 4.0 at `max`. |
| 65. The Claude 5.5 pair emits four to seven times Astra's output tokens per task. | HOLDS | [I15], [I22], independent, n.d. At `max` on the Intelligence Index, approximately 4.4x and 7.3x. |
| 66. Astra at `max` costs less per task than either Claude 5.5 model at `max`. | HOLDS | [I15], [I22], independent, n.d. On the Intelligence Index. |
| 67. The Claude flagships take two to three times as long as Astra or 6.1 Sol on the same work. | FAILS | [I3], [I2], independent, n.d. Neither the fixed ratio nor an effort-independent vendor ordering holds. |
| 68. Codex models bill the full request at 2x input and 1.5x output above 272K input tokens. | HOLDS | [V9], [V10], [V11], vendor, n.d. Applies to the three listed GPT models at the documented API rates. |
| 69. Claude bills flat across its 1M window. | HOLDS | [V5], vendor, n.d. For the listed 1M models. Haiku 4.5 has only 200K context, [V1]. |
| 70. Opus 5 is still callable and precedes Opus 5.5. | HOLDS | [V7], vendor, n.d. Active model, not retired. |
| 71. Opus 4.8 is still callable and precedes Opus 5.5. | HOLDS | [V7], vendor, n.d. Active model, not retired. |
| 72. Fable 5 is still callable and precedes Fable 5.1. | HOLDS | [V7], [V4], vendor, n.d. |
| 73. Sonnet 5 is still callable and precedes Sonnet 5.5. | HOLDS | [V7], [V3], vendor, n.d. |
| 74. GPT-6 Sol is still callable and precedes 6.1 Sol. | HOLDS | [V14], vendor, n.d. |
| 75. GPT-5.6 Sol is still callable and is an older release. | HOLDS | [V15], vendor, n.d. |
| 76. GPT-5.6 Terra is still callable and is an older release. | HOLDS | [V16], vendor, n.d. |
| 77. GPT-5.6 Luna is still callable and is an older release. | HOLDS | [V17], vendor, n.d. |
| 78. Every omitted model is beaten on both quality and task cost by a listed same-vendor model. | UNSUPPORTED | [I2], [I10], [I23], independent. Broad aggregate improvements exist, but task-specific dominance is not established. |
| 79. Invocation and permission flags are documented in the referenced tools file. | UNSUPPORTED | Local draft only. That project file was not supplied and cannot be verified through public web search. |
| 80. Permission doctrine is documented in the referenced skill file. | UNSUPPORTED | Local draft only. That project file was not supplied and cannot be verified through public web search. |
| 81. Table and notes were last updated on 2026-10-04. | UNSUPPORTED | Local draft prints the date, but no revision history or public source verifies when substantive research was updated. |

Web search worked. Verdicts reflect sources retrieved on 2026-10-04. A HOLDS verdict means a source supports the claim in the stated scope, not that it generalizes to every workload. Prices above are standard API input/output rates, excluding cache reads/writes, alternate service tiers and tool charges. Availability is documented availability, not an authenticated smoke test of the delegate CLI.

## Details for claims that are not HOLDS

**22: Codex defaults.** The OpenAI API model pages support `medium` defaults. Codex App Server documentation says actual model defaults and supported effort levels depend on client and account, and instructs clients to read the model-list response. Its illustrative `medium` example does not establish a universal Codex default. The delegate's model resolver and local configuration were not supplied. Correction: say API default where that is what was verified, and explicitly set effort in delegated runs. [V18]

**26: Effort versus model choice.** There is no universal ordering of these levers. The Intelligence Index lists Astra `max` at $3.26 versus Luna `medium` at $0.02, a 163x between-model difference. The verified 5x to 18x examples concern particular models and suites. Correction: effort substantially affects cost, and comparisons must hold effort and task conditions explicit. [I1]

**31, 48 and 67: Speed.** Distinguish output throughput, time to first answer, modeled decode time and actual agent wall time. These are different measurements. For example, the Opus/Astra `max` comparison reports 92 versus 61 tokens/second, while response times are 721 versus 294 seconds. A lower token appetite can offset lower throughput. These numbers do not make Astra the fastest frontier model or establish a fixed ratio for all work. [I15]

Coding averages are Sonnet `max` 1.5 hours, Opus `max` 1.1 hours, Fable `max` 34.8 minutes, Sonnet `high` 12.3 minutes and Sonnet `medium` 8.5 minutes. Correction: specify effort and suite, since changing effort can reverse vendor speed ordering. [I3]

**32 and 34: Sonnet quality and cost.** The close Opus comparison comes mostly from `max` evaluations. Vals reports Sonnet's aggregate result only 0.47 points below Opus, but its cost is $20.80 versus $32.77 per test. This directly shows that Opus-level task cost is not a general Sonnet property. [I12]

The lower recommended efforts also produce materially different results. The AA comparison gives Sonnet `high` an Intelligence Index of 47 against `max` at 56, and a Terminal-Bench result of 44% against 64%. Correction: separate the capability observed at `max` from the capabilities and costs of routine effort settings. [I24]

**37: No measurable Fable advantage on hard problems.** The broad AA comparison favors Opus 5.5, but this cannot establish that Fable never does better on hard tasks. Fable has a small raw recall lead, and task-specific scores sometimes differ in direction. Correction: Fable trails Opus 5.5 on the cited aggregate evaluations, while its value on other tasks needs direct evaluation. [I16], [I17]

**38: Fable slowest.** Fable's `max` coding average is shorter than both Claude 5.5 `max` averages, as shown above. Vendor descriptions of Fable as slower describe relative product latency, not every complete task. Correction: avoid a universal slowest-model claim. [I3], [V4]

**41: Fable competitive coding edge.** The current Vals IOI board gives Opus 5.5 95.06% and Fable 5.1 90.78%. Fable beats older Opus 5 at 84.33%, which is a different comparison. Correction: do not transfer an advantage over Opus 5 to Opus 5.5. A historical or separate competitive-programming board needs its own version and comparison. [I18]

**47: Astra science and mechanisms.** The evidence supports specialization, not a universal science winner. In the AA Opus/Astra comparison, Astra leads GDP.pdf, ties CritPt and trails SciCode and Humanity's Last Exam. Anthropic's scientific-terminal comparison favors Astra. These evaluate different abilities. Correction: identify the scientific workload, and keep the proposed routing choice as judgment. [I15], [V8]

**52: Astra overthinking.** I found no direct first-hand observation or controlled evaluation of Astra overthinking small tasks that establishes this claim. Higher effort spending more tokens is not equivalent evidence. Correction: remove the behavioral assertion or retain it explicitly as local experience only if logs exist. [V10]

**54: Best cost-to-quality of any model.** The observed efficient frontier is evidence for a good tradeoff, not a single universal optimum. Quality, acceptable failure rate, latency and task mix change the choice. Correction: describe 6.1 Sol as a strong low-cost coding option. [I5]

**57: A fifth to a tenth of frontier cost.** Sol `xhigh` costs $1.04 versus Astra `max` $7.47, fitting the range. Against Sonnet `max` $14.19 or `xhigh` $3.33 it does not. Correction: name the comparison. [I2]

**78: All older models strictly dominated.** AA gives older 5.6 Luna a higher coding score than 6 Luna at `max`, at higher cost. Vals identifies tasks where Opus 5.5 trails Opus 5. Neither comparison supports universal task-specific dominance. [I2], [I10]

There are also gaps in direct like-for-like data across efforts and tasks for the entire omitted list. Epoch's FrontierCode page gives Fable 5 a higher result than Fable 5.1 in different configurations. That is evidence against assuming every version upgrade improves every task, not proof that Fable 5 beats every listed model. Correction: older models usually offer less attractive aggregate tradeoffs, with exceptions and incomplete evidence. [I23]

**79, 80 and 81: Local provenance.** The draft is supplied at [models-draft.md](/tmp/verify.SfRf/gpt-6-1-sol/models-draft.md). The referenced project invocation/permission documents and revision history are absent. Web search cannot prove their contents or the update date. The date is an assertion in the draft, not independent verification.

## Qualification needed even where a claim HOLDS

Claim 25 has Intelligence Index support: Sol $0.13 to $0.72, roughly 5.5x, and Sonnet $0.42 to $7.67, roughly 18x. These are examples, not universal bounds. Sonnet's coding range is wider. Cost-to-task must not imply cost per successful real-world job: the metric averages benchmark attempts, including failures, and omits engineering and supervision costs. [I5], [I6], [I4], [I3]

Claims 33, 35, 39, 42, 49, 50, 51, 59, 60, 61, 65 and 66 need their effort and evaluation scope. The draft currently turns these observations into durable behavioral properties. Several results also concern a model plus a particular harness, rather than model capability in isolation. [I4]

Claim 28 means `xhigh` to `max`: Opus rises from index 56 at $3.46 to 58 at $5.98. It does not mean `high` to `max`, which rises from 54 at $1.82. No evidence here establishes that a two-point gain is statistically significant. [I1]

Claim 40 is a small raw-recall advantage. It should not be described as a broader factual-reliability advantage: the same board ranks Opus higher on its combined knowledge index. [I17]

Claims 10 to 16 and 68 to 69 need an API billing label. A CLI authenticated to a subscription does not necessarily charge the user's account at those token rates. OpenAI also lists other processing tiers. Long-context premiums do not automatically make Claude cheaper: long-context 6.1 Sol is $4/$15, while Fable is $10/$50. Haiku cannot accept a 1M-token request. The blanket large-context routing rule is therefore a policy choice with a weak price rationale. [V13], [V4], [V1], [V5]

No claim is classified STALE here. Some assertions may have been inherited from older comparisons, but I did not find evidence establishing both their original truth and a later change for the exact wording. Unsupported is preferable to inventing that history.

## Ratings and recommendations

I have not assigned verdicts to the numerical depth/execution ratings or the low/high cost categories.

Sonnet's execution 5 with `medium`/`high` guidance looks misleading: coding scores are 46/55, versus Sol `xhigh` 63 and Sonnet `max` 68. Specify the rating effort. [I3], [I2]

The Sonnet high-cost label deserves reconsideration at the recommended efforts. Vals measures lower cost than Opus, while AA's exceptionally high Sonnet costs mainly concern `max`. The label currently conceals the very effort dependence the introduction emphasizes. [I12], [I24]

Other ratings do not look clearly refuted by this evidence. Astra's math specialization has support, and weak terminal performance supports the conservative Haiku/Luna routing choices. A subjective three-axis scale cannot be derived uniquely from the cited benchmarks. [I20], [I19], [I2]

The following are editorial policies, not checkable model facts: default to Opus for ambiguity, use `high` as a sweet spot, try `xhigh` after a failed pass, never run Sonnet `max` unattended, reserve Fable for escalation, prefer Sol for execution/fan-out, use Luna for small verifiable work, set Luna to at least `medium`, use Sol `medium` for simple work, use Astra `high` for debugging, prefer Sonnet `medium`/`high` for routine loops, treat `max` as rarely best, raise effort before changing models, and lower effort before choosing a cheaper model. The associated supported observations are covered above. There is no evidence here proving those policies always minimize successful-task cost. Sonnet's first-hand output-exhaustion observation makes the unattended-`max` caution reasonable without making it a universal prohibition. [I25]

The claim that model rankings depend on task shape is supported by the differing task breakdowns, but the definitions of Depth, Execution and Cost-to-task, and the decision to use three axes, are the author's taxonomy. They need no factual verdict. [I4]

## Research-history and excluded-content scan

No research source names, study names, descriptions of research methodology, or explicit old-wording commentary occur in the supplied draft. The last-updated line is maintenance metadata. The omitted-model paragraph is selection/lifecycle content, not a statement about how the draft was researched.

No notes on honesty, evaluation gaming, outages or silent substitution occur in the draft. The output-exhaustion note concerns an answer failing to appear after reasoning, rather than a service outage or substitution. It is supported by first-hand reports and is not automatically excluded by the stated categories. I would retain a short operational caution, without naming the researcher in the shipped model reference. [I11], [I25]

Some consulted evaluations enable server-side fallback and explicitly name the resulting configurations. Those benchmark qualifications matter to this verification, but the handoff says the shipped reference must not contain substitution commentary. Do not import it there, and do not attribute composite configuration scores to a pure model without qualification. Keep full methodology in the verification record. [I8], [I10], [I12]

## Source register and limitations

All links below were searched or fetched live on 2026-10-04. `n.d.` means the fetched page shows no reliable publication date for its current contents. Release dates and crawl dates are not substituted for publication dates. An explicit update date is labeled as such.

Sources V1 to V20 are vendor sources. Claims relying only on them have vendor-only support in this audit. Sources I1 to I25 are independent of OpenAI and Anthropic. Artificial Analysis, Vals and Epoch are primary evaluators, although some individual comparisons use vendor-reported results or vendor-supported early access. Their independence does not imply every data point is independently reproduced.

Many verdicts rest on a single evaluator: AA supplies most cost, effort and token-use comparisons. Different AA URLs are not independent corroboration. Vals provides a separate quality/cost comparison and the competitive-coding correction. Epoch provides separate mathematical evidence. Willison provides direct observations of output exhaustion, not a controlled estimate of failure frequency.

| Source | Publication/update date | Type and scope |
| --- | --- | --- |
| [V1] Claude model overview | n.d. | Vendor. IDs, aliases, context and current lineup. |
| [V2] Opus 5.5 documentation | n.d. | Vendor. Specifications and pricing. |
| [V3] Sonnet 5.5 documentation | n.d. | Vendor. Specifications, pricing and API effort default. |
| [V4] Fable 5.1 documentation | n.d. | Vendor. Specifications, positioning and pricing. |
| [V5] Claude pricing | n.d. | Vendor. Long-context billing. |
| [V6] Claude Code model configuration | n.d. | Vendor. CLI support, defaults and effort selection. |
| [V7] Claude model deprecations | n.d. | Vendor. Active versus retired model status. |
| [V8] Opus 5.5 announcement | 2026-09-22 | Vendor. Hours-long example and scientific-terminal comparison. |
| [V9] GPT-6.1 Sol documentation | n.d. | Vendor. Current ID, effort and billing. |
| [V10] GPT-6 Astra documentation | n.d. | Vendor. Current ID, effort and billing. |
| [V11] GPT-6 Luna documentation | n.d. | Vendor. Current ID, effort and billing. |
| [V12] Using GPT-6 | n.d. | Vendor. Model positioning and defaults. |
| [V13] OpenAI API pricing | n.d. | Vendor. Processing tiers and long-context prices. |
| [V14] GPT-6 Sol documentation | n.d. | Vendor. Older model still documented and selectable. |
| [V15] GPT-5.6 Sol documentation | n.d. | Vendor. Older model still documented and selectable. |
| [V16] GPT-5.6 Terra documentation | n.d. | Vendor. Older model still documented and selectable. |
| [V17] GPT-5.6 Luna documentation | n.d. | Vendor. Older model still documented and selectable. |
| [V18] Codex App Server | n.d. | Vendor. Discoverable, account/client-dependent defaults. |
| [V19] OpenAI model selection | n.d. | Vendor. Task and effort guidance. |
| [V20] ChatGPT/Codex model availability | n.d. | Vendor. Access and CLI model selection. |
| [I1] AA model leaderboard | n.d., live board | Independent primary evaluator. Intelligence, cost and efforts. |
| [I2] AA Claude Code versus Codex | n.d., live board | Independent primary evaluator. Agent quality, task costs and effort comparison. |
| [I3] AA Claude Code versus Muse Code | n.d., live board | Independent primary evaluator. Claude variants, time, cost and tokens. |
| [I4] AA coding-agent methodology/leaderboard | n.d. | Independent primary evaluator. Metric definitions and limitations. |
| [I5] AA GPT-6.1 Sol release comparison | n.d. | Independent primary evaluator. Effort/cost range. |
| [I6] AA Sonnet 5.5 release comparison | n.d. | Independent primary evaluator. Effort/cost range. |
| [I7] AA Terminal-Bench 4.0 | n.d., live board | Independent primary evaluator. Terminal ranking. |
| [I8] AA Opus 5.5 launch evaluation | 2026-09-22 | Independent primary evaluator. Software/knowledge leadership. |
| [I9] AA Sonnet 5.5 launch evaluation | 2026-09-28 | Independent primary evaluator. Maximum-effort costs and quality. |
| [I10] Vals Opus 5.5 model evaluation | update 2026-09-22 | Independent primary evaluator. Aggregate quality and task exceptions. |
| [I11] Willison's Opus/Sol/Luna test | 2026-09-22 | Independent first-hand report. Two observed Opus output-window failures. |
| [I12] Vals Sonnet 5.5 model evaluation | update 2026-09-28 | Independent primary evaluator. Separate quality and cost comparison. |
| [I13] AA GPT-6 Luna analysis | n.d. | Independent primary evaluator. Aggregate quality, price and speed. |
| [I14] AA Haiku reasoning analysis | n.d. | Independent primary evaluator. Aggregate quality, price and speed. |
| [I15] AA Opus 5.5 versus Astra | n.d. | Independent primary evaluator. Cost, output tokens and speed. |
| [I16] AA Opus 5.5 versus Fable 5.1 | n.d. | Independent primary evaluator. Aggregate/category comparison. |
| [I17] AA-Omniscience board | n.d., live board | Independent primary evaluator. Raw recall and combined knowledge scores. |
| [I18] Vals IOI v2 | updated 2026-10-01 | Independent primary evaluator. Current competition-programming results. |
| [I19] AA MiniMax versus Haiku breakdown | n.d. | Independent primary evaluator. Haiku terminal score. |
| [I20] Epoch FrontierMath tiers 1 to 3 v2 | benchmark released 2026-06-12, page n.d. | Independent primary evaluator. Mathematics leadership. |
| [I21] ARC Prize GPT-6 results | n.d. | Independent primary evaluator. Novel abstraction/reasoning evidence. |
| [I22] AA Sonnet 5.5 versus Astra | n.d. | Independent primary evaluator. Output, cost and speed comparison. |
| [I23] Epoch FrontierCode | n.d. | Independent compiler of Cognition's primary benchmark results. |
| [I24] AA Sonnet high versus max | n.d. | Independent primary evaluator. Effort-conditioned quality and costs. |
| [I25] Willison's Sonnet 5.5 test | 2026-09-28 | Independent first-hand report. Observed output-window failure. |

Some page fetches failed. These included guessed Claude per-model URLs, several AA comparison URLs, an incorrect AA coding-leaderboard path, and the Vals LiveCodeBench page. Correct official Claude pages and AA coding/comparison pages were subsequently fetched where available. I did not infer results from inaccessible pages. The current IOI page was used for the competitive-coding comparison. No authenticated API calls, CLI benchmarks or local delegate tests were run. No coordination or subagents were used.

[V1]: https://platform.claude.com/docs/en/models/overview
[V2]: https://platform.claude.com/docs/en/models/opus-5-5/overview
[V3]: https://platform.claude.com/docs/en/models/sonnet-5-5/overview
[V4]: https://platform.claude.com/docs/en/models/fable-5-1/overview
[V5]: https://platform.claude.com/docs/en/about-claude/pricing
[V6]: https://code.claude.com/docs/en/model-config
[V7]: https://platform.claude.com/docs/en/about-claude/model-deprecations
[V8]: https://www.anthropic.com/claude-opus-5-5
[V9]: https://developers.openai.com/api/docs/models/gpt-6.1-sol
[V10]: https://developers.openai.com/api/docs/models/gpt-6-astra
[V11]: https://developers.openai.com/api/docs/models/gpt-6-luna
[V12]: https://developers.openai.com/api/docs/guides/latest-model
[V13]: https://developers.openai.com/api/docs/pricing
[V14]: https://developers.openai.com/api/docs/models/gpt-6-sol
[V15]: https://developers.openai.com/api/docs/models/gpt-5.6-sol
[V16]: https://developers.openai.com/api/docs/models/gpt-5.6-terra
[V17]: https://developers.openai.com/api/docs/models/gpt-5.6-luna
[V18]: https://learn.chatgpt.com/docs/app-server
[V19]: https://developers.openai.com/api/docs/guides/model-selection
[V20]: https://learn.chatgpt.com/docs/models
[I1]: https://artificialanalysis.ai/leaderboards/models
[I2]: https://artificialanalysis.ai/agents/coding-agents/comparisons/claude-code-vs-codex
[I3]: https://artificialanalysis.ai/agents/coding-agents/comparisons/claude-code-vs-muse-code
[I4]: https://artificialanalysis.ai/agents/coding-agents
[I5]: https://artificialanalysis.ai/models/releases/gpt-6-1-sol
[I6]: https://artificialanalysis.ai/models/releases/claude-sonnet-5-5
[I7]: https://artificialanalysis.ai/evaluations/terminalbench-4-0
[I8]: https://artificialanalysis.ai/articles/claude-opus-5-5
[I9]: https://artificialanalysis.ai/articles/claude-sonnet-5-5
[I10]: https://www.vals.ai/models/anthropic_claude-opus-5-5
[I11]: https://simonwillison.net/2026/Sep/22/opus-and-sol-and-luna/
[I12]: https://www.vals.ai/models/anthropic_claude-sonnet-5-5
[I13]: https://artificialanalysis.ai/models/gpt-6-luna
[I14]: https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning
[I15]: https://artificialanalysis.ai/models/comparisons/claude-opus-5-5-vs-gpt-6-astra
[I16]: https://artificialanalysis.ai/models/comparisons/claude-opus-5-5-vs-claude-fable-5-1
[I17]: https://artificialanalysis.ai/evaluations/omniscience
[I18]: https://www.vals.ai/benchmarks/ioi
[I19]: https://artificialanalysis.ai/models/comparisons/minimax-m3-vs-claude-4-5-haiku-reasoning
[I20]: https://epoch.ai/benchmarks/frontiermath-tiers-1-3-v2
[I21]: https://arcprize.org/results/openai-gpt-6
[I22]: https://artificialanalysis.ai/models/comparisons/claude-sonnet-5-5-vs-gpt-6-astra
[I23]: https://epoch.ai/benchmarks/frontiercode
[I24]: https://artificialanalysis.ai/models/comparisons/claude-sonnet-5-5-high-vs-claude-sonnet-5-5
[I25]: https://simonwillison.net/2026/Sep/28/claude-sonnet-5-5/
