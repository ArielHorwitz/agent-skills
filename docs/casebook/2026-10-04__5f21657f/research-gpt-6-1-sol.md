# Researcher model ID: gpt-6.1-sol

The ID above is the assignment label in the research brief. An independently verifiable runtime model ID was not exposed to this session.

Research date: 2026-10-04. Scope: evidence for choosing delegated research and execution agents, with priority on changes since 2026-08-05.

Live search worked. Some guessed model/comparison URLs failed to fetch. I continued with accessible primary pages and live search results. The quantitative recommendations below use fetched sources, rather than treating failed pages as evidence. I did not coordinate with other researchers.

## Recommendation to the reference writer

**Inference:** Make `gpt-6.1-sol` at high or xhigh the first candidate for general execution where cost matters. Keep `gpt-6-astra` for difficult novel or scientific investigations, and `claude-opus-5-5` for demanding professional work and a second route through difficult problems. Treat `claude-sonnet-5-5` at medium/high as a scoped execution candidate, not as an automatically cheaper version of Opus. Preserve `claude-fable-5-1` as an alternative for difficult investigations, with a substantial cost warning. Use `gpt-6-luna` for bounded subtasks with inexpensive validation.

These are conditional recommendations, not a universal ordering. The evidence below shows why: migration, scientific terminal work, and mixed professional evaluations produce different winners. Independent evidence is concentrated in Artificial Analysis and Vals. Their many pages are two evaluators, not dozens of independent confirmations.

## Source and measurement conventions

Each citation identifies the source as **vendor** or **independent** and gives its publication date when available. For continuously updated documentation and leaderboards, I explicitly distinguish an update date from a publication date. Every undated citation was observed on **2026-10-04**. An undated page is not evidence that the information was published that day.

Artificial Analysis, abbreviated AA, and Vals are independent of the model manufacturers, but commercial evaluation businesses. ARC Prize operates its own benchmark. Cursor is a downstream commercial tool vendor with an interest in the models it integrates. Manufacturer-hosted customer testimonials remain vendor-selected evidence, even when attributed to customers. Community results below are firsthand reports with weaker controls.

Dollar figures are USD. Token rates are billing inputs, not task costs. Evaluation costs are the source's reported mean cost per test or task, generally including unsuccessful attempts. They do not establish what one successful task in this repository will cost. Reasoning tokens, repeated tool calls, cache behavior, retries, and the harness can change that substantially.

## Current IDs, availability, and omissions

All eight requested Claude families are active in Anthropic's status table. Haiku's canonical snapshot is `claude-haiku-4-5-20251001`, and `claude-haiku-4-5` is an accepted alias. The older requested Claude models being described as legacy does not mean they are retired. [Vendor, publication undated: model status](https://platform.claude.com/docs/en/about-claude/model-deprecations), [vendor, publication undated: Haiku overview](https://platform.claude.com/docs/en/models/haiku-4-5/overview).

OpenAI has current documentation for every requested GPT ID. I found no deprecation notice for those IDs in the checked deprecation page. `gpt-5.6` is an alias for the Sol model, rather than evidence that `gpt-5.6-sol` was renamed. This is a documentation check, not a claim that every account has access. [Vendor, publication undated: deprecations](https://developers.openai.com/api/docs/deprecations), [vendor, publication undated: GPT-5.6 Sol](https://developers.openai.com/api/docs/models/gpt-5.6-sol). Individual model pages are linked in the pricing table.

Missing current models worth flagging:

- `claude-mythos-5-1` and `claude-mythos-5` are active but belong to restricted access programs. Older active models outside the brief include Opus 4.7, 4.6, 4.5 and Sonnet 4.6. I would put these in an availability appendix, not expand the ordinary dispatch shortlist merely because they exist. [Vendor, publication undated: status table](https://platform.claude.com/docs/en/about-claude/model-deprecations), [vendor, published 2026-09, exact day not displayed: Fable/Mythos announcement](https://www.anthropic.com/claude-fable-and-mythos-5-1).
- Anthropic announced Haiku 5.5 for the coming weeks. I did not establish a released, generally available ID as of this research date. Do not invent one or replace Haiku 4.5 preemptively. [Vendor, published 2026-09-28: Sonnet launch](https://www.anthropic.com/claude-sonnet-5-5).
- OpenAI's catalog also lists specialized and modality-specific models outside this terminal-agent shortlist. Relevant omitted IDs include `gpt-5.6-cyber`, `gpt-daybreak-red-latest`, and `gpt-daybreak-blue-latest`. [Vendor, publication undated: Cyber](https://developers.openai.com/api/docs/models/gpt-5.6-cyber), [Red](https://developers.openai.com/api/docs/models/gpt-daybreak-red-latest), [Blue](https://developers.openai.com/api/docs/models/gpt-daybreak-blue-latest). The changelog identifies `gpt-rosalind-research` as available to approved organizations from September 8 and `gpt-live-1` from September 10. The catalog also lists image and realtime models. [Vendor, publication undated: catalog](https://developers.openai.com/api/docs/models), [vendor, entries dated 2026-09-08 and 2026-09-10: changelog](https://developers.openai.com/api/docs/changelog).

## Pricing and changes since the previous refresh

Standard API rates per million tokens follow. Cached input is a read price. These are not subscription usage limits, and they do not include faster service premiums or external tool charges. Every row's source is **vendor, publication undated, observed 2026-10-04**.

| Model ID | Input | Cached input | Output | Official model source |
|---|---:|---:|---:|---|
| `claude-fable-5-1` | $10 | $0.25 | $50 | [Overview](https://platform.claude.com/docs/en/models/fable-5-1/overview) |
| `claude-opus-5-5` | $4 | $0.20 | $20 | [Overview](https://platform.claude.com/docs/en/models/opus-5-5/overview) |
| `claude-sonnet-5-5` | $2 | $0.20 | $10 | [Overview](https://platform.claude.com/docs/en/models/sonnet-5-5/overview) |
| `claude-haiku-4-5` | $1 | $0.10 | $5 | [Overview](https://platform.claude.com/docs/en/models/haiku-4-5/overview) |
| `claude-opus-5` | $5 | $0.50 | $25 | [Overview](https://platform.claude.com/docs/en/models/opus-5/overview) |
| `claude-opus-4-8` | $5 | $0.50 | $25 | [Overview](https://platform.claude.com/docs/en/models/opus-4-8/overview) |
| `claude-fable-5` | $10 | $1 | $50 | [Overview](https://platform.claude.com/docs/en/models/fable-5/overview) |
| `claude-sonnet-5` | $2 | $0.20 | $10 | [Overview](https://platform.claude.com/docs/en/models/sonnet-5/overview) |
| `gpt-6-astra` | $10 | $1 | $50 | [Model page](https://developers.openai.com/api/docs/models/gpt-6-astra) |
| `gpt-6.1-sol` | $2 | $0.10 | $10 | [Model page](https://developers.openai.com/api/docs/models/gpt-6.1-sol) |
| `gpt-6-sol` | $2 | $0.20 | $10 | [Model page](https://developers.openai.com/api/docs/models/gpt-6-sol) |
| `gpt-6-luna` | $0.10 | $0.01 | $0.50 | [Model page](https://developers.openai.com/api/docs/models/gpt-6-luna) |
| `gpt-5.6-sol` | $4 | $0.40 | $20 | [Model page](https://developers.openai.com/api/docs/models/gpt-5.6-sol) |
| `gpt-5.6-terra` | $2 | $0.20 | $12 | [Model page](https://developers.openai.com/api/docs/models/gpt-5.6-terra) |
| `gpt-5.6-luna` | $0.20 | $0.02 | $1.20 | [Model page](https://developers.openai.com/api/docs/models/gpt-5.6-luna) |

Recent changes that materially affect the old reference:

| Date | Sourced change | Consequence I infer |
|---|---|---|
| 2026-08-21 | GPT-5.6 Sol cut to $4 input/$20 output, promotional through at least November 21. [Vendor, dated changelog entry](https://developers.openai.com/api/docs/changelog) | Old price comparisons need replacement, and this rate should carry an expiry/recheck marker. |
| 2026-09-01 | Fable 5.1 released. Cached reads fell from Fable 5's $1 to $0.25. [Vendor, undated overview with release date](https://platform.claude.com/docs/en/models/fable-5-1/overview) | Long repeated-context loops benefit, but output-heavy tasks may not become cheaper. |
| 2026-09-03 | Astra released. [Vendor, dated changelog entry](https://developers.openai.com/api/docs/changelog) | Add a new deep-investigation option. |
| 2026-09-22 | GPT-6 Sol/Luna and Opus 5.5 released. [Vendor, dated OpenAI changelog](https://developers.openai.com/api/docs/changelog), [vendor, published 2026-09-22: Opus announcement](https://www.anthropic.com/claude-opus-5-5) | Reassess both medium-cost and inexpensive task routing. |
| 2026-09-28 | Sonnet 5.5 released at $2/$10. [Vendor, published 2026-09-28](https://www.anthropic.com/claude-sonnet-5-5) | Sonnet 5's behavior and effort settings are poor proxies for the new release. |
| 2026-09-29 | GPT-6.1 Sol released, with cached reads $0.10 instead of GPT-6 Sol's $0.20. [Vendor, dated changelog entry](https://developers.openai.com/api/docs/changelog), [vendor, undated model page](https://developers.openai.com/api/docs/models/gpt-6.1-sol) | GPT-6 Sol has a very short tenure as the preferred current Sol. |

Sonnet 5's June launch evaluation described $2/$10 as a promotion ending September 1, against nominal $3/$15. Its current official page still shows $2/$10. I could verify today's rate, but not whether or when the promotion was extended or made permanent. Do not automatically restore $3/$15 from the older article. [Independent, published 2026-06-30: AA Sonnet 5 evaluation](https://artificialanalysis.ai/articles/claude-sonnet-5-agentic-cost), [vendor, publication undated: current overview](https://platform.claude.com/docs/en/models/sonnet-5/overview).

Other billing conditions can change a long agent run's economics. GPT-6 model pages specify that inputs exceeding 272K tokens incur doubled input/cached-input rates and 1.5 times output rates for the request. Claude 4.6 and newer have no corresponding long-context surcharge. Anthropic cache writes cost 1.25 times input for five minutes or twice input for one hour. [Vendor, publication undated: Astra](https://developers.openai.com/api/docs/models/gpt-6-astra), [Sol](https://developers.openai.com/api/docs/models/gpt-6.1-sol), [Luna](https://developers.openai.com/api/docs/models/gpt-6-luna), [Claude pricing](https://platform.claude.com/docs/en/about-claude/pricing).

OpenAI Fast costs twice standard, while Astra Ultrafast costs six times standard. Opus 5.5's launch describes a fast mode costing twice standard. Treat these as latency purchases, not inherent model task efficiency. [Vendor, publication undated: OpenAI pricing](https://developers.openai.com/api/docs/pricing), [vendor, published 2026-09-22: Opus launch](https://www.anthropic.com/claude-opus-5-5).

## Comparable observations: task costs and capabilities

### Broad intelligence is a screening signal

AA's current Intelligence Index values below are from its v4.3.2 pages. Costs are its reported index cost per task at the stated configuration. This index combines multiple evaluations, so it does not directly measure success in a long coding session or pure novel-problem depth. Citations in this table are **independent, publication undated, observed 2026-10-04**, except where a publication date appears in the source cell. Most rows use max effort. Haiku is a thinking configuration, not a comparable max effort setting.

| Model | Configuration | Index | Reported cost/task | AA source |
|---|---|---:|---:|---|
| Opus 5.5 | max | 58 | $5.98 | [Release page](https://artificialanalysis.ai/models/releases/claude-opus-5-5) |
| Sonnet 5.5 | max | 56 | $7.67 | [Comparison](https://artificialanalysis.ai/models/comparisons/claude-sonnet-5-5-vs-claude-sonnet-5) |
| Fable 5.1 | max | 53 | $7.63 | [Release page](https://artificialanalysis.ai/models/releases/claude-fable-5-1) |
| GPT-6 Astra | max | 53 | $3.26 | [Comparison](https://artificialanalysis.ai/models/comparisons/gpt-6-1-sol-vs-gpt-6-astra) |
| GPT-6.1 Sol | max | 52 | $0.72 | [Release page](https://artificialanalysis.ai/models/releases/gpt-6-1-sol) |
| Opus 5 | max | 51 | $5.86 | [Release page](https://artificialanalysis.ai/models/releases/claude-opus-5) |
| Fable 5 | max | 50 | $8.75 | [Model page](https://artificialanalysis.ai/models/claude-fable-5) |
| GPT-6 Sol | max | 48 | $1.04 | [Comparison](https://artificialanalysis.ai/models/comparisons/gpt-6-luna-vs-gpt-6-sol) |
| GPT-5.6 Sol | max | 47 | $1.99 | [Release analysis, published 2026-09-22](https://artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier) |
| Opus 4.8 | max | 42 | $4.08 | [Model page](https://artificialanalysis.ai/models/claude-opus-4-8) |
| GPT-5.6 Terra | max | 42 | $1.40 | [Release page](https://artificialanalysis.ai/models/releases/gpt-5-6-terra) |
| GPT-6 Luna | max | 38 | $0.07 | [Comparison](https://artificialanalysis.ai/models/comparisons/gpt-6-luna-vs-gpt-6-sol) |
| Sonnet 5 | max | 38 | $5.09 | [Comparison](https://artificialanalysis.ai/models/comparisons/claude-sonnet-5-5-vs-claude-sonnet-5) |
| GPT-5.6 Luna | max | 37 | $0.18 | [Release page](https://artificialanalysis.ai/models/releases/gpt-5-6-luna) |
| Haiku 4.5 | thinking | 17 | $0.28 | [Model page](https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning) |

Small discrepancies between launch articles and current pages, such as Sonnet's $7.60 versus $7.67, are snapshots, not meaningful precision. Fable's September launch index used a different version and much lower absolute cost figures. I have not spliced that old index into this current table. [Independent, published 2026-09-28: AA Sonnet article](https://artificialanalysis.ai/articles/claude-sonnet-5-5), [independent, published 2026-09-01: AA Fable article](https://artificialanalysis.ai/articles/claude-fable-5-1).

### Well-specified repository execution

Vals Code Migration, **independent, publication undated, updated 2026-10-01**, reports scores and mean cost/test, including unsuccessful attempts. [Source and methodology](https://www.vals.ai/benchmarks/code-migration).

| Model | Score | Cost/test |
|---|---:|---:|
| Sonnet 5.5 | 69.83% | $75.83 |
| GPT-6 Astra | 67.74% | $44.36 |
| Opus 5.5 | 66.65% | $112.97 |
| GPT-6.1 Sol | 65.12% | $6.51 |
| Opus 5 | 57.47% | $60.51 |
| GPT-6 Sol | 57.20% | $15.68 |
| Fable 5 | 55.06% | $112.10 |
| Fable 5.1 | 54.61% | $70.97 |
| GPT-5.6 Sol | 52.92% | $24.54 |
| GPT-5.6 Terra | 47.80% | $8.13 |
| Opus 4.8 | 47.25% | $30.51 |
| GPT-5.6 Luna | 44.55% | $1.88 |
| Sonnet 5 | 44.39% | $35.31 |

**Inference:** Try Sol first and Sonnet as a migration alternative. Fable's research positioning does not establish superior execution. Haiku and GPT-6 Luna entries were absent, not zero.

### Difficult scientific terminal loops

Vals Terminal-Bench-Science, **independent, publication undated, updated 2026-10-02**, covers 70 scientific tasks. These rows use Mini-SWE-agent. I use the dated leaderboard where summary prose disagrees. [Source and methodology](https://www.vals.ai/benchmarks/terminal-bench-science).

| Model | Score | Cost/test |
|---|---:|---:|
| GPT-6 Astra | 62.86% | $20.80 |
| GPT-6.1 Sol | 52.86% | $3.44 |
| Opus 5.5 | 47.14% | $19.12 |
| Sonnet 5.5 | 45.71% | $30.43 |
| Fable 5.1 | 40.00% | $38.01 |
| GPT-6 Sol | 30.00% | $5.82 |
| Opus 5 | 27.14% | $32.54 |
| GPT-5.6 Sol | 20.00% | $7.32 |
| Fable 5 | 15.71% | $51.99 |
| GPT-5.6 Terra | 10.00% | $5.19 |
| Sonnet 5 | 5.71% | $28.28 |
| GPT-6 Luna | 4.29% | $0.24 |
| Opus 4.8 | 4.29% | $23.14 |
| GPT-5.6 Luna | 0.00% | $0.58 |

**Inference:** Astra shows scientific headroom, Sol offers value, and Luna's low cost cannot compensate for frequent failure here. This does not establish a universal scientific ranking.

### Novel mechanisms and mixed professional work

Vals MysteryMechanism asks models to infer hidden mechanisms through active experimentation. Its **independent, publication-undated leaderboard, updated 2026-10-01**, reports Astra 53.15%/$1.56, Opus 5.5 49.55%/$4.62, Sonnet 5.5 49.10%/$3.45, Fable 5.1 47.75%/$5.63, and Sol 6.1 46.40%/$0.28. Earlier Sol 6 scores 30.18%/$0.46, Sol 5.6 33.33%/$0.96, Luna 6 19.37%/$0.03, and Luna 5.6 14.41%/$0.11. [Source](https://www.vals.ai/benchmarks/mysterymechanism).

**Inference:** This bounded novelty test supports Astra's depth role and Sol 6.1's value. It does not support an assumption that the premium Claude model is always the strongest investigator, or that newer Sol's improvement is only routine coding.

Vals Index v2.1, **independent, publication undated, updated 2026-10-02**, aggregates legal, financial, tax, and coding tasks. Sonnet 5.5 scores 67.04% at $21.34/test, Opus 5.5 66.97%/$32.14, Fable 5.1 65.83%/$28.71, Astra 63.13%/$18.46, and Sol 6.1 61.15%/$3.24. Its September 25 version change means older launch figures should not be mixed with this board. [Source](https://www.vals.ai/benchmarks/vals_index).

**Inference:** Sonnet's lower-cost, near-Opus result here is real evidence against making Opus the unconditional professional-work choice. The roughly seven-hundredths-point Sonnet/Opus gap is not a basis for declaring a quality winner.

## Model-by-model interpretation

The observations in this section add detail to the comparable tables. Recommendations are my inferences. Where direct independent evidence for ambiguous, open-ended work is missing, I say so rather than equating a composite score with deep insight.

### gpt-6.1-sol

**Observed:** AA's September 29 evaluation places max near Astra on broad intelligence. For agentic coding, xhigh beats Sol's own max by three index points and Astra by one, at under 15% of Astra's reported cost. Sol 6.1 emits 10 to 30% more output than Sol 6 at matched effort, despite lower task cost. [Independent, published 2026-09-29](https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence).

**Inference:** Strong general executor and economical first investigator. The Vals scientific and mechanism results give more relevant depth support than the broad index alone. Prefer high/xhigh for demanding coding. Reserve max for tasks where its additional reasoning demonstrably helps. I lack controlled production evidence for unattended, multi-day work.

### gpt-6-astra

**Observed:** ARC Prize tested Astra on novel interactive environments. Its standard harness reached 62.7% at max, with $26,098 spent across the suite. A provider-adapted harness reached 99.9% at high/$18,817 and 98.6% at max/$17,332. In the standard harness, medium cost $48,090 and low $38,166 despite lower scores. These are suite costs and distinct harnesses, not interchangeable model-only results. [Independent, published 2026-09-03: ARC Prize](https://arcprize.org/blog/astra).

**Inference:** Best-supported candidate here for novel scientific investigation, combining ARC with the Vals scientific/mechanism results. Also a strong executor, but too expensive as the routine default when Sol meets the quality requirement. The ARC result demonstrates that more effort can reduce total cost through fewer actions. It does not prove unlimited general problem-solving ability or transfer of the near-perfect score to a different harness.

### claude-opus-5-5

**Observed:** AA reports max HLE 61.4%, SciCode 66.9%, Terminal-Bench 4.0 59.6%, and strong professional-work results. It also measures about 119K output tokens per index task, versus roughly 73K for Opus 5 and 27K for Astra. Its max task cost is roughly unchanged from Opus 5 despite lower token rates. [Independent, published 2026-09-22](https://artificialanalysis.ai/articles/claude-opus-5-5).

Cursor reports Opus 5.5 leading its CursorBench at launch and recommends high thinking. This is independent of Anthropic but comes from a commercial integration provider, not a neutral production audit. [Independent, publication undated: Cursor](https://cursor.com/docs/models/claude-opus-5-5).

**Inference:** A strong quality-first generalist, including harder reasoning and professional deliverables. Medium/high is a better initial operational choice than assuming max. Sol is substantially cheaper in the examined execution tasks, and Astra leads the scientific ones. Anthropic's claim of approximately 40% lower typical task cost is a vendor workload estimate, not a universal result. [Vendor, published 2026-09-22](https://www.anthropic.com/claude-opus-5-5).

### claude-sonnet-5-5

**Observed:** AA reports Terminal-Bench 4.0 at 64%, above roughly 60% for Opus/Astra, but max task cost at $7.60 in its launch snapshot. It reports about 193K output tokens per index task, versus 119K for Opus, with weaker HLE/SciCode results. It also flags a prerelease structured-output issue, fixed for public release with a rerun pending in that article. [Independent, published 2026-09-28](https://artificialanalysis.ai/articles/claude-sonnet-5-5).

**Inference:** Strong for scoped coding, migrations, and routine professional execution. Depth is substantially improved over Sonnet 5, but the evidence does not make it the universal premium investigator. At max, output volume can erase the rate advantage. Vals' mixed-work and migration results nevertheless show workloads where it costs less than Opus. Both observations belong in the reference.

### claude-fable-5-1

**Observed:** AA's September launch analysis reports approximately 1.7 times Fable 5's output volume. Its then-current max task cost increased despite the cached-input price reduction. Those absolute costs belong to an older index version and are not the current table above. [Independent, published 2026-09-01](https://artificialanalysis.ai/articles/claude-fable-5-1).

Anthropic's announcement contains customer accounts of difficult investigations and long unattended runs. These support a plausible research role, but are selected testimonials rather than independent comparative trials. [Vendor, published 2026-09, day not displayed](https://www.anthropic.com/claude-fable-and-mythos-5-1).

**Inference:** Keep as an alternative thinker when initial approaches stall, especially if local experience demonstrates distinct strengths. Independent current science and migration results do not justify making it the automatic depth or execution leader. High is a reasonable starting point, and escalation should be tied to measured benefit.

### gpt-6-luna

**Observed:** AA finds major cost savings over Luna 5.6, but some coding regressions: Coding Agent Index 41 versus 43, SWE-Atlas 44 versus 49, and DeepSWE 64 versus 66. Its broad reasoning improvement does not translate into better scores on every execution benchmark. [Independent, published 2026-09-22](https://artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier).

**Inference:** Excellent candidate for inexpensive focused work, especially extraction, mechanical transformations, and small tasks with a clear validator. Not a substitute for Astra/Sol on scientific investigations or complex unattended loops. Do not retire Luna 5.6 solely because this model is newer if a task-specific coding evaluation favors the older model. I found no strong comparative production study of token efficiency for the proposed routine tasks.

### claude-haiku-4-5

**Observed:** AA's thinking configuration gives modest broad capability and low benchmark cost, as tabulated above. Official documentation supports extended thinking, a 200K context, and 64K maximum output, rather than the adaptive five-level effort interface of the newer Claude families. [Independent, publication undated: AA](https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning), [vendor, publication undated: overview](https://platform.claude.com/docs/en/models/haiku-4-5/overview).

**Inference:** Keep for simple Anthropic-native execution, classification, and bounded subtasks where compatibility matters. I did not find enough recent independent evidence to estimate its real cost against GPT-6 Luna on comparable routine tasks, or to endorse it for difficult ambiguous research. Its low price alone does not establish efficient completion of long loops.

### gpt-6-sol

**Observed:** AA finds cheaper coding execution than Sol 5.6, alongside regressions in some professional deliverables. Its September 29 evaluation improves relevant comparisons again with Sol 6.1. [Independent, published 2026-09-22](https://artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier), [independent, published 2026-09-29](https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence).

**Inference:** Useful compatibility baseline, not the preferred new Sol dispatch. The mechanism results favor 6.1 for depth. Keep only where local tests, reproducibility, or a particular output preference justify it.

### gpt-5.6-sol

**Observed:** The September AA article notes some professional-deliverable advantages over Sol 6. [Independent, published 2026-09-22](https://artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier). The tables separately show its broad reasoning and execution cost position.

**Inference:** Retain for validated task-specific strengths rather than generic default delegation. A new reference should not infer that every older-model advantage persists against 6.1. I lack recent controlled evidence of a general depth advantage over the new frontier candidates.

### gpt-5.6-terra

**Observed:** Terra's AA max index/cost and the Vals execution costs above put it in an awkward position against newer Sol. A firsthand repository tested Terra/Luna routing on July 31 using 14 tasks, initially one run per configuration plus targeted repetitions. Luna max exceeded Terra high on its reported aggregate, while Terra high was faster. Its cost measure was relative quota, not dollars. [Independent community, publication undated, test dated 2026-07-31: README](https://github.com/ruyari-cupcake/terra-luna-routing-benchmark).

**Inference:** No clear general-purpose slot remains without task-specific evidence. Preserve as an established executor where already validated. The community test is a useful warning against inferring depth solely from the tier name, but too small and dated to settle current routing.

### gpt-5.6-luna

**Observed:** AA finds coding advantages over Luna 6, despite higher broad evaluation costs. [Independent, published 2026-09-22](https://artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier).

**Inference:** Keep for established small coding tasks where its measured advantage matters. Start new high-volume routine evaluations with Luna 6. Neither cheap rates nor the small community study establishes deep investigation or reliable long-loop execution.

### claude-opus-5

**Observed:** AA's current broad index favors Opus 5.5 over Opus 5. [Independent, publication undated: Opus 5](https://artificialanalysis.ai/models/releases/claude-opus-5), [Opus 5.5](https://artificialanalysis.ai/models/releases/claude-opus-5-5). The migration table supplies a counterexample to assuming every upgrade lowers task spending.

**Inference:** Keep as a compatibility or validated-workflow baseline. Choose 5.5 for new demanding work unless local cost-to-success testing supports 5. I found no recent direct independent open-ended-depth result establishing an advantage over 5.5.

### claude-opus-4-8

**Observed:** Its current broad index trails the latest premium candidates. [Independent, publication undated: AA](https://artificialanalysis.ai/models/claude-opus-4-8). Token rates match Opus 5 and exceed Opus 5.5, as sourced in the pricing table.

**Inference:** Historical compatibility, reproducible experiments, or a demonstrated task-specific preference are the remaining reasons to choose it. It is not supported as the general deep investigator or efficient new executor. There is little recent independent long-run evidence beyond these benchmark comparisons.

### claude-fable-5

**Observed:** Its current AA max task cost exceeds Fable 5.1's, while its broad index is lower. [Independent, publication undated: Fable 5](https://artificialanalysis.ai/models/claude-fable-5), [Fable 5.1](https://artificialanalysis.ai/models/releases/claude-fable-5-1).

**Inference:** Preserve existing workflows, not a default new delegation slot. Do not label it the deepest model merely because it was a prior flagship. I found no current independent evidence of a broad novel-problem advantage over Fable 5.1, Astra, or Opus 5.5.

### claude-sonnet-5

**Observed:** AA's current comparison shows Terminal-Bench 4.0 rising from 14% to 64% with Sonnet 5.5, and the current max index from 38 to 56. Sonnet 5.5 also consumes more output and costs more on the broad max evaluation, despite the same current official token rates. [Independent, publication undated: comparison](https://artificialanalysis.ai/models/comparisons/claude-sonnet-5-5-vs-claude-sonnet-5).

**Inference:** There is a strong execution-upgrade case, not an unconditional cost reduction. Keep Sonnet 5 only for verified workflows or tasks where lower consumption matters. I found insufficient recent open-ended-depth evidence to support a new investigator role.

## Effort is part of the model choice

**Official controls:** Astra and Sol 6.1 expose low, medium, high, xhigh, max, without a none mode. GPT-6 Sol/Luna and the requested GPT-5.6 models additionally support none. Sol 6.1 and those latter models default to medium in the API. This does not establish the default of every hosting CLI or app. [Vendor, publication undated: model pages linked in the pricing table](https://developers.openai.com/api/docs/models/gpt-6.1-sol).

The newer requested Claude models other than Haiku expose low through max. Opus 5.5 defaults to medium in the API, and the other requested adaptive families default to high. Fable and Opus 5.5 keep adaptive thinking enabled. Haiku uses extended thinking instead. Anthropic describes effort as a behavioral signal affecting reasoning, text, and tool arguments, not a strict token cap. [Vendor, publication undated: effort documentation](https://platform.claude.com/docs/en/build-with-claude/effort), [model-specific vendor overviews linked above](https://platform.claude.com/docs/en/models/opus-5-5/overview).

**Observed effort/cost curve:** Sol 6.1's AA index changes from 48/$0.21 at medium to 50/$0.32 at high, 51/$0.39 at xhigh, and 52/$0.72 at max. Opus 5.5 ranges from index 42/$0.55 at low to 58/$5.98 at max, with medium/high/xhigh indexes 51/54/56. These are broad-index tradeoffs, not measured coding success at every effort. [Independent, publication undated: Sol release page](https://artificialanalysis.ai/models/releases/gpt-6-1-sol), [Opus release page](https://artificialanalysis.ai/models/releases/claude-opus-5-5).

Anthropic recommends medium Sonnet 5.5 for specified coding and high for harder work. Its launch evaluation found max below xhigh on FrontierCode, with inspected failures involving extra review work and timeouts. This is vendor evidence but agrees with the independent Sol coding result that max need not win. [Vendor, publication undated: effort guidance](https://platform.claude.com/docs/en/build-with-claude/effort), [vendor, published 2026-09-28: launch](https://www.anthropic.com/claude-sonnet-5-5).

**Inference:** Begin with an effort matched to ambiguity, not a blanket maximum. Increase effort when the task demands insight, and check whether fewer failed attempts compensate for additional thinking. ARC supplies a concrete example of total spend falling at higher effort. Conversely, AA supplies examples where extra output dominates the bill. The optimum is model, task, and harness dependent.

## How to interpret cost-to-task

Do not turn a token price table into a cost ranking. A complete measurement should record uncached input, cached reads/writes, reasoning output, answer output, tool fees, elapsed time, success under an explicit validator, retries, and any repair or review agent. The task budget includes all attempts needed to produce an acceptable result.

**Proposed measurement:** Compare total spend per accepted completion, including failed attempts and repair. Dividing mean attempt cost by success rate is only a rough model if retries are independent. Repeated failures may be correlated, so benchmark averages do not justify assuming unlimited retries will produce acceptance.

A firsthand Sonnet/Opus comparison on one Three.js scene reports Sonnet spending $0.96 with 10 calls and 31.8K output tokens, versus Opus $4.79 with 23 calls and 99.8K output tokens. Both produced demos. This is useful task-level signal, but effort, grading, and repeated trials are insufficiently controlled. Publication date was not exposed in the fetched page. [Independent community, publication undated, observed 2026-10-04](https://www.reddit.com/r/ClaudeCode/comments/1wspepd/same_prompt_same_setup_claude_sonnet_55_vs_opus/).

**Inference:** The Sonnet anecdote and Vals' mixed-work result support a cheaper scoped-execution role. AA's max-output result supports the opposite cost ordering on its workload. The reference should preserve this disagreement instead of averaging unlike costs or silently selecting the friendliest benchmark.

## Suggested organization of the eventual reference

I would use three layers:

1. A short task decision guide: routine bounded subtask, specified implementation, difficult professional deliverable, novel investigation, and second opinion after failure. Each entry recommends a model plus effort and names an escalation condition.
2. A compact model table with separate depth, execution, and measured cost-to-task descriptions. Include evidence confidence and the tested harness/effort, rather than unsupported numerical star ratings. Token rates belong in a distinct billing column.
3. Dated evidence notes and an availability/legacy appendix. Preserve conflicting evaluations and the conditions that explain them. Keep a pricing recheck marker for promotions and newly released models.

My proposed starting choices are Sol 6.1 high/xhigh for general execution, Sonnet 5.5 medium/high as a scoped Claude alternative, Opus 5.5 medium/high for demanding professional work, Astra for novel scientific depth, Fable 5.1 as an alternative research route, and Luna 6 for bounded inexpensive subtasks. These remain hypotheses for a local evaluation, not guaranteed production winners.

The most useful next experiment would run identical real repository tasks at the proposed efforts, with the same tools, acceptance checks, and budgets. Measure total spending through accepted completion and a few repeated runs. That would resolve more uncertainty than collecting additional launch benchmark claims.

## Limits of this research

- The strongest quantitative signal comes from two commercial independent evaluators. AA's articles and live model pages are one source family. Vals' four boards are another. ARC adds separate novelty evidence only for Astra in the examined article.
- These sources do not establish real production success rates for multi-day unattended engineering or months-long research. Scientific terminal tasks and hidden-mechanism tests are useful proxies, not substitutes for that evidence.
- Comparisons are sometimes close, benchmark versions change, and effort/harness configurations differ. I do not interpret small score gaps as resolved superiority without suitable uncertainty estimates.
- Current rates were verified, but some price-change histories and publication dates were unavailable. I did not fabricate them. Community anecdotes and vendor-selected testimonials receive less weight than controlled independent evaluations.
- Routine-task token efficiency is particularly underdocumented for Haiku versus Luna. Lower sticker prices are insufficient to fill that gap.
- The report intentionally excludes the topics the brief ruled out and does not research invocation syntax.
