# Independent model research

Researcher model ID: `gpt-6-astra` (the identity assigned by this brief, not independently introspected).
Research date: 2026-10-04. Coverage baseline: 2026-08-05.

Live web search worked. Most HTML pages opened successfully. OpenAI Markdown endpoints failed with unsupported-content-type errors, one guessed Anthropic announcement URL failed, and an Artificial Analysis Haiku release URL failed. Alternative HTML documentation and evaluator pages supplied the relevant evidence. No models were run locally and no other agents were consulted.

## Recommendation to the reference author

My recommendation is a task decision guide backed by separate depth, execution, and measured-cost evidence. Start evaluation with GPT-6.1 Sol for general delegation, Opus 5.5 for demanding coding and professional artifacts, Astra for difficult scientific or novel technical investigations, and GPT-6 Luna for bounded, readily checked work. Keep Sonnet 5.5 and Fable 5.1 as workload-dependent alternatives. These are routing hypotheses, not universal winners. The independent measurements below are the basis.

The consequential caveat: a cheaper token rate does not establish a cheaper completed task. In particular, the evidence does not support calling Sonnet 5.5 uniformly cheaper than Opus 5.5 or Astra. Nor does a vendor's flagship positioning establish the strongest depth on every problem.

## How to read the evidence

Every source below is identified as vendor or independent. `U` means publication/update date is not exposed by the fetched page, accessed 2026-10-04. A release date inside a page is not treated as that page's publication date. Dated announcements and evaluator updates carry their actual displayed dates. Where search and fetched content differ, I use the fetched table and identify its update date.

Artificial Analysis (AA) supplies most effort comparisons and broad capability measurements. Its many model pages are **one evaluator**, not independent corroboration. Vals supplies the two terminal workload tables and additional coding evidence. Those are **one second evaluator**, and its use of overlapping benchmark datasets is not an independent test of an entirely different problem distribution. ComputingForGeeks supplies a small original practical experiment. Vendor documentation is used primarily for rates, identifiers, and supported settings.

The AA Intelligence Index is a mixed capability index. Its cost per task weights constituent evaluations and accounts for input, cached input, cache writes, reasoning, and answer tokens. It is not the price of an arbitrary coding ticket. Source: [AA GPT-6 Luna release and methodology notes](https://artificialanalysis.ai/models/releases/gpt-6-luna), independent, U.

All benchmark results describe the evaluator's published endpoint configurations. They do not isolate model weights from effort, tools, context handling, or harness behavior. Unknown configuration details should remain unknown in the reference.

## Availability, identifiers, and changes since August

OpenAI's dated changelog records Astra on September 3, Sol and Luna on September 22, and 6.1 Sol on September 29. On August 21, GPT-5.6 Sol's rates changed from $5/$30 to $4/$20 per million input/output tokens, promotional through at least November 21. Newer models replacing older recommendations should not be described as renamings. Sources: [OpenAI changelog](https://developers.openai.com/api/docs/changelog), vendor, entries 2026-08-21, 2026-09-03, 2026-09-22, 2026-09-29.

Anthropic's lifecycle table lists all eight requested Claude models as active, including Haiku's dated API ID `claude-haiku-4-5-20251001`. Its model overview also lists `claude-haiku-4-5` as the alias. Some individual model pages call older models legacy, and AA calls some deprecated. The vendor's pages therefore disagree on active versus legacy terminology, but neither establishes retirement of a requested model. Haiku's “not sooner than October 15, 2026” is a minimum commitment, not a scheduled shutdown. Sources: [Claude lifecycle](https://platform.claude.com/docs/en/about-claude/model-deprecations), vendor, U, latest dated notice 2026-09-30, and [Claude overview](https://platform.claude.com/docs/en/models/overview), vendor, U.

For OpenAI, I found current model pages for all seven requested IDs and no retirement notice for them in the fetched [deprecations page](https://developers.openai.com/api/docs/deprecations), vendor, U, latest notices 2026-10-01. That page instead schedules GPT-5.3-Codex, GPT-5.1, and GPT-5.4-Nano for April 1, 2027. This is a documentation finding, not proof of access through every account or CLI. The `gpt-5.6` alias maps to `gpt-5.6-sol`: [Sol model page](https://developers.openai.com/api/docs/models/gpt-5.6-sol), vendor, U.

Missing models worth explicitly acknowledging:

- `claude-mythos-5-1` and `claude-mythos-5` are restricted-access offerings. Mythos 5.1 is documented as sharing Fable 5.1's capabilities and pricing, available to Project Glasswing participants. Do not put it in the ordinary available-model shortlist. [Fable 5.1 documentation](https://platform.claude.com/docs/en/models/fable-5-1/overview), vendor, U, and [Claude lifecycle](https://platform.claude.com/docs/en/about-claude/model-deprecations), vendor, U.
- `gpt-5.6-cyber`, `gpt-daybreak-red-latest`, and `gpt-daybreak-blue-latest` appear in the August 7 changelog. `gpt-rosalind-research` appears on September 8 with restricted life-sciences access. Treat specialized eligibility separately from general delegation. [OpenAI changelog](https://developers.openai.com/api/docs/changelog), vendor, 2026-08-07 and 2026-09-08.
- Other older Claude models remain listed, including Opus 4.7, 4.6, 4.5 and Sonnet 4.6. They are omissions from an exhaustive inventory, not demonstrated omissions from a useful current shortlist. [Claude lifecycle](https://platform.claude.com/docs/en/about-claude/model-deprecations), vendor, U. This report does not attempt to inventory image, audio, or every historical GPT model.

## Current sticker rates, kept separate from task cost

USD per million tokens, standard first-party rates. Input means uncached input. These rates are accounting inputs only.

| Model | Input | Output | Cache read |
| --- | ---: | ---: | ---: |
| claude-fable-5-1 | 10 | 50 | 0.25 |
| claude-opus-5-5 | 4 | 20 | 0.20 |
| claude-sonnet-5-5 | 2 | 10 | 0.20 |
| claude-haiku-4-5 | 1 | 5 | 0.10 |
| claude-opus-5 | 5 | 25 | 0.50 |
| claude-opus-4-8 | 5 | 25 | 0.50 |
| claude-fable-5 | 10 | 50 | 1.00 |
| claude-sonnet-5 | 2 | 10 | 0.20 |

All Claude rate cells: [Claude pricing](https://platform.claude.com/docs/en/about-claude/pricing), vendor, U. Notable differences: Fable 5.1 has one quarter of Fable 5's cache-read rate. Opus 5.5 has 20% lower base rates and 60% lower cache-read rates than Opus 5. These are replacement-model comparisons, not reductions to Opus 5 itself. [AA Opus 5.5 announcement analysis](https://artificialanalysis.ai/articles/claude-opus-5-5), independent, 2026-09-22. Sonnet 5's current $2/$10 differs from the $3/$15 in an [older indexed overview](https://platform.claude.com/docs/en/about-claude/models/whats-new-claude-4-5), vendor, U, search crawl approximately two months old. I did not establish the exact effective date of that earlier price change.

| Model | Input | Output | Cache read | Vendor source, publication date U |
| --- | ---: | ---: | ---: | --- |
| gpt-6-astra | 10 | 50 | 1.00 | [Astra](https://developers.openai.com/api/docs/models/gpt-6-astra) |
| gpt-6.1-sol | 2 | 10 | 0.10 | [6.1 Sol](https://developers.openai.com/api/docs/models/gpt-6.1-sol) |
| gpt-6-sol | 2 | 10 | 0.20 | [6 Sol](https://developers.openai.com/api/docs/models/gpt-6-sol) |
| gpt-6-luna | 0.10 | 0.50 | 0.01 | [6 Luna](https://developers.openai.com/api/docs/models/gpt-6-luna) |
| gpt-5.6-sol | 4 | 20 | 0.40 | [5.6 Sol](https://developers.openai.com/api/docs/models/gpt-5.6-sol) |
| gpt-5.6-terra | 2 | 12 | 0.20 | [Terra](https://developers.openai.com/api/docs/models/gpt-5.6-terra) |
| gpt-5.6-luna | 0.20 | 1.20 | 0.02 | [5.6 Luna](https://developers.openai.com/api/docs/models/gpt-5.6-luna) |

OpenAI model pages specify long-input surcharges above 272K tokens and separately billed cache writes. For example, 6.1 Sol doubles input/cache rates and multiplies output rates by 1.5 for the full long-context request, charges cache writes at 1.25 times base input, and prices Fast at twice Standard and Batch/Flex at half Standard. [6.1 Sol](https://developers.openai.com/api/docs/models/gpt-6.1-sol), vendor, U. These modifiers must be recorded when comparing long agents. Do not apply a discount just because the underlying API offers it.

Anthropic documents a newer tokenizer producing approximately 30% more tokens for the same text on Claude 4.7 and later, with workload variation. Its 5-minute and 1-hour cache-write prices also differ. [Claude pricing](https://platform.claude.com/docs/en/about-claude/pricing), vendor, U. This is another reason not to equate token counts across families.

## Measured cost on representative terminal work

The following table preserves published values from two Vals boards. Both use Mini-SWE-agent for these rows. TB4 is terminal artifact completion. Science is scientific research workflow completion. Cost is average dollars per attempted test, **not dollars per successful completion**. N/A means no row found, not zero.

| Model | TB4 success | TB4 $/test | Science success | Science $/test |
| --- | ---: | ---: | ---: | ---: |
| gpt-6-astra | 59.60% | 9.58 | 62.86% | 20.80 |
| gpt-6.1-sol | 55.05% | 1.72 | 52.86% | 3.44 |
| gpt-6-sol | 44.44% | 5.79 | 30.00% | 5.82 |
| gpt-6-luna | 13.64% | 0.35 | 4.29% | 0.24 |
| gpt-5.6-sol | 37.88% | 7.98 | 20.00% | 7.32 |
| gpt-5.6-terra | 22.73% | 5.60 | 10.00% | 5.19 |
| gpt-5.6-luna | 11.62% | 0.73 | 0.00% | 0.58 |
| claude-fable-5-1 | 58.08% | 17.18 | 40.00% | 38.01 |
| claude-opus-5-5 | 65.15% | 13.20 | 47.14% | 19.12 |
| claude-sonnet-5-5 | 64.14% | 16.51 | 45.71% | 30.43 |
| claude-haiku-4-5 | N/A | N/A | N/A | N/A |
| claude-opus-5 | 53.53% | 18.60 | 27.14% | 32.54 |
| claude-opus-4-8 | 23.23% | 17.14 | 4.29% | 23.14 |
| claude-fable-5 | 41.41% | 30.34 | 15.71% | 51.99 |
| claude-sonnet-5 | 9.60% | 26.33 | 5.71% | 28.28 |

TB4 cells: [Vals Terminal-Bench 4.0](https://www.vals.ai/benchmarks/terminal-bench-4), independent, updated 2026-10-01. Science cells: [Vals Terminal-Bench Science](https://www.vals.ai/benchmarks/terminal-bench-science), independent, updated 2026-10-02. Science covers 70 tasks and one scored run per model, with some infrastructure-error reattempts. The TB4 table covers a different task set. Do not compare percentages between columns as equivalent difficulty.

Inference: this is useful evidence for realistic multi-step delegation bills, but an intentionally hard workload is a poor estimator of a ten-minute documentation edit. Equally, inexpensive failed runs do not establish cheap delivery. I would collect actual repository-task completion costs before encoding numerical task-cost estimates in the skill.

For accounting, measure total spend divided by accepted deliverables across a fixed task sample, including failures, repair attempts, and escalation. Separately record elapsed time and human review effort. This is my proposed measurement rule. Dividing a benchmark's mean cost by its pass fraction can describe its aggregate spend per solved item, but does not predict retries until success on a particular task. Failures can recur for the same underlying reason.

## Depth and execution assessment by model

The judgments in this section are my interpretations. Evidence is stated first, then the proposed role. Confidence is relative to this source set, not a calibrated probability.

### GPT-6 Astra

AA's matched max-effort comparison gives Astra 53 versus 6.1 Sol's 52 on its broad index, with 59% versus 56% Terminal-Bench 4.0 and $3.26 versus $0.72 per index task. [AA comparison](https://artificialanalysis.ai/models/comparisons/gpt-6-1-sol-vs-gpt-6-astra), independent, U. Combined with the scientific-work table, I would use Astra for depth-sensitive investigations and expensive-to-miss solutions. It is also a credible executor. Its additional cost needs a task-specific quality benefit. Confidence: moderate to high.

### GPT-6.1 Sol

AA's September 29 analysis reports lower cost per index task than 6 Sol and 5.6 Sol, and observes that xhigh exceeds max on its Coding Agent Index. [AA release analysis](https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence), independent, 2026-09-29. My general-delegation starting point: enough depth to avoid treating it as merely an implementation worker, strong execution evidence, and a good measured cost position. Try medium/high first, xhigh for difficult coding. Confidence: moderate to high, with only days of post-release evidence.

### GPT-6 Sol

AA compares high effort at index 42 and $0.37/task with 6.1 Sol high at 50 and $0.32. Its measured time per task favors 6 Sol in that snapshot. [AA high-effort comparison](https://artificialanalysis.ai/models/comparisons/gpt-6-1-sol-high-vs-gpt-6-sol-high), independent, U. My interpretation: capable execution with less depth than its successor, worth retaining for measured latency or compatibility advantages. Do not make it the default merely because 6.1 is newer and unfamiliar. Confidence: moderate.

### GPT-6 Luna

AA records index 38 and $0.07/task at max, versus index 22 at low and $0.0045/task. [AA Luna release](https://artificialanalysis.ai/models/releases/gpt-6-luna), independent, U. I would use it for extraction, inventories, mechanical edits, and small tasks with objective checks. The evidence supports economical bounded work, not difficult autonomous research. Long tool-loop competence on easy repository tasks remains insufficiently measured here. Confidence: moderate for the narrow role.

### GPT-5.6 Sol

AA's dated comparison gives max-effort index-task cost $1.99, versus $0.72 for 6.1 Sol, and places its broad score five points behind. [AA 6.1 analysis](https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence), independent, 2026-09-29. My interpretation: a capable older deep-work and execution model, retained for demonstrated regressions or established workflows, with no general economic preference over 6.1 Sol in this evidence. Confidence: moderate.

### GPT-5.6 Terra

AA reports max index 42 at $1.40/task and medium index 30 at $0.18/task. [AA Terra release](https://artificialanalysis.ai/models/releases/gpt-5-6-terra), independent, U, indexed snapshot approximately three weeks old. This is moderate-depth capacity whose historical middle-price role needs reevaluation. I would not select it for new long execution work without a local advantage over 6.1 Sol. Its lower-effort cost does not by itself establish better value. Confidence: moderate, weaker freshness.

### GPT-5.6 Luna

AA records max index 37 at $0.18/task. [AA older Luna release](https://artificialanalysis.ai/models/releases/gpt-5-6-luna), independent, U. My interpretation: use only where a known bounded workflow favors it. Evaluate 6 Luna first for new cheap-worker tasks. Neither Luna should inherit a “long autonomous executor” rating from fast token generation. Confidence: moderate.

### Claude Opus 5.5

AA's September 22 evaluation gives max index 58, HLE 61.4%, SciCode 66.9%, and leading professional-artifact results. It reports roughly 119K output tokens per index task, versus 73K for Opus 5, with approximately level task cost despite lower rates. [AA Opus analysis](https://artificialanalysis.ai/articles/claude-opus-5-5), independent, 2026-09-22. I would shortlist it for both depth and sustained execution, particularly substantial code changes and polished analytical deliverables. Its evidence challenges a simple Fable-above-Opus hierarchy. Confidence: moderate to high.

### Claude Sonnet 5.5

Vals' September 28 report records 92.39% on Vibe Code Bench and 69.83% on Code Migration. Most evaluations used max effort, while its older Terminal-Bench 2.1 run used high. [Vals Sonnet report](https://www.vals.ai/models/anthropic_claude-sonnet-5-5), independent, update 2026-09-28. I would shortlist it for implementation and web work, with stronger depth than a generic “cheap worker” label suggests. Cost efficiency is effort- and workload-sensitive. Confidence: moderate to high for coding potential, moderate for expected task cost.

### Claude Fable 5.1

AA records max index 53 at $7.63/task. [AA Fable 5.1](https://artificialanalysis.ai/models/claude-fable-5-1), independent, U. Anthropic positions it for demanding reasoning and long-horizon agents, but that positioning is vendor evidence: [Fable documentation](https://platform.claude.com/docs/en/models/fable-5-1/overview), vendor, U. I would retain it as an alternative for unusually difficult tasks and cross-model review, rather than automatically escalating all Opus work to it. It needs a demonstrated workload advantage. Confidence: moderate.

### Claude Haiku 4.5

AA's reasoning configuration scores 17, including 0% Terminal-Bench 4.0 and 3% AutomationBench-AA, at $0.28/index task. [AA Haiku comparison](https://artificialanalysis.ai/models/comparisons/claude-4-5-haiku-vs-claude-4-5-haiku-reasoning), independent, U. I would reserve it for simple Claude-native work with checks. The data does not support frontier-depth or difficult sustained-execution claims. Its easy-task token efficiency versus 6 Luna is not established by this hard-task sample. Confidence: moderate.

### Claude Opus 5

AA records max index 51 at $5.86/task. [AA Opus 5](https://artificialanalysis.ai/models/claude-opus-5), independent, U. My interpretation: still a capable reasoning and execution option, but usually displaced by Opus 5.5 for new work. Preserve it for measured task-specific advantages and compatibility. Confidence: moderate.

### Claude Opus 4.8

AA records max index 42 at $4.08/task and limits ongoing benchmarking of this older entry. [AA Opus 4.8](https://artificialanalysis.ai/models/claude-opus-4-8), independent, U. I would retain it as a compatibility option, not a default deep solver or executor. Evidence for modern cost competitiveness is poor. Confidence: moderate for that recommendation, low for unmeasured niche strengths.

### Claude Fable 5

AA records max index 50 at $8.75/task. [AA Fable 5](https://artificialanalysis.ai/models/claude-fable-5/), independent, U, search snapshot older than the latest pages. My interpretation: substantial depth remains, but little general reason to choose it over Fable 5.1 or the newer alternatives for sustained work. Do not mistake availability for a recommendation. Confidence: moderate.

### Claude Sonnet 5

AA records max index 38 at $5.09/task, with a very large total output volume in its index evaluation. [AA Sonnet 5](https://artificialanalysis.ai/models/claude-sonnet-5), independent, U. I would keep it for known compatibility or measured local behavior. Its current token price does not establish an economical execution role, and the successor warrants fresh comparison. Confidence: moderate.

## Effort is part of the model choice

OpenAI documents low, medium, high, xhigh, and max for Astra and 6.1 Sol. Neither supports none. The other five requested GPT models also support none and default to medium. These are API settings, not claims about every CLI's exposed menu. Sources: the seven vendor model pages linked in the rate table, all U.

Anthropic supports low through max, including xhigh, on all requested Fable, Opus, and Sonnet models. Opus 5.5 defaults to medium, the other effort-capable models default to high. Effort influences tool calls and ordinary output as well as thinking. Haiku instead has extended thinking without that effort parameter. Sources: [Claude effort](https://platform.claude.com/docs/en/build-with-claude/effort) and [model overview](https://platform.claude.com/docs/en/models/overview), vendor, U.

Two independent effort comparisons are especially useful:

- 6.1 Sol low/medium/high/xhigh/max scores 42/48/50/51/52 at $0.13/$0.21/$0.32/$0.39/$0.72 per AA index task. [AA 6.1 release](https://artificialanalysis.ai/models/releases/gpt-6-1-sol/), independent, U. My inference: max's small aggregate improvement deserves explicit justification over high or xhigh.
- Sonnet 5.5 high versus max costs $1.12 versus $7.67 per AA index task, with approximately 37K versus 197K output tokens per task. [AA Sonnet effort comparison](https://artificialanalysis.ai/models/comparisons/claude-sonnet-5-5-high-vs-claude-sonnet-5-5), independent, U. My inference: a max-effort Sonnet delegate should not be advertised as a reliably inexpensive worker.

The effort labels are not calibrated across vendors. My proposed default is medium/high for well-specified execution, followed by selective escalation on difficult decisions. For novel reasoning, test xhigh/max when the added chance of success is worth the cost. Raising effort and switching model are separate interventions. Do not assume either always improves the result.

## Practical signal beyond the two major evaluators

ComputingForGeeks ran three DevOps prompts through Fable 5.1, Fable 5, and Opus 5, using validators. All passed its gates. For Bash log rotation, Fable 5.1 cost $0.304 and took 73.5 seconds, versus Opus 5's $0.097 and 40.1 seconds. Kubernetes and OpenTofu costs were much closer. [Original practical evaluation](https://computingforgeeks.com/claude-fable-5-1-released-features-benchmarks/), independent, updated/tested 2026-09-03. My inference: useful evidence of task-sensitive spending, but three code-generation prompts and lint/validation gates cannot establish production correctness or long-agent reliability.

A community author reports a Three.js planet build at $0.96 and 10.8 minutes for Sonnet 5.5 versus $4.79 and 22.7 minutes for Opus 5.5, with linked artifacts. [Original Tiny World report](https://www.reddit.com/r/ClaudeCode/comments/1wspepd/same_prompt_same_setup_claude_sonnet_55_vs_opus/), independent anecdote, exact publication date unverified: search metadata suggests 2026-09-29, while rendered relative timestamps are inconsistent. I give this low weight. It is an existence example for Sonnet efficiency, not corroboration of a universal ranking.

Anthropic estimates Fable 5.1 workload savings of about 25%, up to about 45% for highly agentic usage, using four weeks of August workloads at default effort. [Fable launch](https://www.anthropic.com/claude-fable-and-mythos-5-1), vendor, September 2026, day not displayed in fetched article. I would not turn that into a generic discount: it is conditional on workload shape, cache reuse, and the vendor's sample. The independent effort evidence is at least equally important.

## Source disagreements and remaining limits

- Vals' Sonnet model page retains a September 28 narrative with 69.22% Vals Index and $20.80/test, while its fetched live header shows 67.04% and $21.34/test. [Vals Sonnet page](https://www.vals.ai/models/anthropic_claude-sonnet-5-5), independent, narrative 2026-09-28, live-header update date unstated. Do not mix narrative and live scores into a single comparison.
- The Science board's prose retains older Sonnet figures while its October 2 table differs. This report uses table values. [Vals Science](https://www.vals.ai/benchmarks/terminal-bench-science), independent, updated 2026-10-02.
- AA's broad index and coding measures have different outcomes, and its rolling pages vary in cost/latency snapshots. Preserve index version, effort, and retrieval date. I did not reconstruct raw token logs or independently reproduce any evaluator's bills.
- The terminal boards are much closer to real delegation than fixed-token calculators, but they do not establish this repository's task distribution. Full effort settings for every terminal row were not exposed in the fetched boards. Subscription allowance consumption and CLI-specific economics were not measured.
- Independent evidence for simple Haiku-versus-Luna workflows, unusual legacy-model strengths, and long-run behavior in this exact harness remains thin. Leave those fields uncertain rather than filling them with vendor positioning.

## Proposed reference structure

Use three layers:

1. A short routing guide with starting candidates and escalation triggers: bounded/checkable work, ordinary implementation, difficult investigation, and artifact-heavy knowledge work. Include a preferred effort alongside each model.
2. A compact table separating depth, execution, measured cost on named workloads, and evidence confidence. Avoid invented 1-to-10 ratings and a single overall winner. Keep older compatible models in a secondary table.
3. Evidence notes with URLs, publication/update dates, retrieval dates, benchmark/harness versions, effort, and uncertainty. Keep the rate card separate from task-cost observations and mark promotions for rechecking.

My suggested first local comparison would use a small fixed sample of completed repository tasks, with clear acceptance criteria, repeated runs where affordable, and the same tool access. Compare 6.1 Sol medium/high, Opus 5.5 medium/high, Sonnet 5.5 high, and Astra high/xhigh. Add Fable 5.1 for tasks where those struggle, and 6 Luna for the easiest subset. The outcome should be accepted work per dollar and per elapsed hour, with depth failures recorded separately from execution failures. This is a proposed experiment, not work performed for this report.
