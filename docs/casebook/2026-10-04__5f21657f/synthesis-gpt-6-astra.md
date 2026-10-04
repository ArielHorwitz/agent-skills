# Model ID: `gpt-6-astra`

This is the model ID assigned by the synthesis handoff. The session identifies
the GPT-6 family but does not independently expose a verifiable exact runtime
ID. Synthesis date: 2026-10-04.

## Decision

Keep seven rows: Opus 5.5, Sonnet 5.5, Fable 5.1, Haiku 4.5, Astra, Sol 6.1,
and Luna 6. Sol 6.1 is the economical general executor, Opus 5.5 the demanding
engineering choice, and Astra the novel mathematical/scientific choice.
Sonnet remains a serious execution alternative. Fable remains an alternative
investigator, without an automatic claim to the highest depth. Haiku fills a
narrow Claude-specific simple-task role. Luna fills the general cheap-worker
role.

This is a selection judgment, not proof that every omitted model is dominated
on every task. Opus 5 and Luna 5.6 have measured counterexamples. Their omission
is the most contestable part of the compact shortlist. The analysis below
preserves those exceptions rather than relabeling them as obsolete evidence.

I read the six research reports and formed this role split before reading the
current catalog. No capability tests were run. Only the two assigned output
files were written. The draft preserves the current document's introduction,
Models section, relative-rating table, Notes section, and dated footer.

## Report attribution and researcher relationships

These identifiers refer to the supplied reports, all researched on 2026-10-04:

| Key | Report | Judgments about the researcher's own vendor | Judgment about itself |
| --- | --- | --- | --- |
| A | [Astra research](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/research-gpt-6-astra.md) | Every GPT recommendation | Astra |
| Q | [Sol 6.1 research](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/research-gpt-6-1-sol.md) | Every GPT recommendation | Sol 6.1 |
| S | [Sol 6 research](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/research-gpt-6-sol.md) | Every GPT recommendation | Sol 6 |
| O | [Opus research](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/research-claude-opus-5-5.md) | Every Claude recommendation | Opus 5.5 |
| F | [Fable research](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/research-claude-fable-5-1.md) | Every Claude recommendation | Fable 5.1 |
| N | [Sonnet research](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/research-claude-sonnet-5-5.md) | Every Claude recommendation | Sonnet 5.5 |

In per-model attribution below, `*` marks an own-vendor judgment and `**` a
self-judgment. This applies to the researcher's interpretation, not to the
ownership of a cited independent measurement. My own GPT recommendations also
carry an own-vendor relationship, and the Astra recommendation a self
relationship under the assigned identity. These are reasons to trace the
evidence, not grounds to discard it.

Binding scope comes from [user decisions](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/user-decisions.md).
The candidate set comes from [the drift report](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/drift-report.md).
For dates, prices, and controls, I prefer the direct vendor-document evidence in
[Sol's drift research](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/drift-models-gpt-6-1-sol.md)
and [Opus's drift research](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/docs/casebook/2026-10-04__5f21657f/drift-models-claude-opus-5-5.md)
over secondary price histories in the capability reports.

## Weight of evidence

- **Artificial Analysis (AA)** supplies most effort curves, token consumption,
  and coding-agent comparisons. Six researchers repeating an AA result are
  reporting one evaluator. AA's Intelligence Index and Coding Agent Index are
  distinct measurements from that same organization. Mirrors and news reports
  of either do not add independent confirmation.
- **Vals** supplies a second evaluator, with mixed professional work,
  migration, terminal, science, and hidden-mechanism tasks. Its multiple boards
  are not independent organizations, and shared benchmark tasks can overlap
  with other evaluators. They still help distinguish domain-specific results
  from one broad index.
- **ARC Prize, Epoch, and Scale** add different depth or software evidence.
  ARC's directly fetched experiment is particularly relevant to unfamiliar
  mechanisms. Epoch's overlapping intervals argue against a universal depth
  winner. S notes that Epoch flags DeepSWE v1.1 as flawed, so I do not let a
  coding index containing it decide an execution rating alone.
- **Vendor documentation** establishes prices and settings more authoritatively
  than comparison blogs. Vendor evaluations and selected customer stories are
  weaker evidence for relative capability. In particular, Fable's proposed
  long-horizon advantage is not independently established just because the
  vendor recommends it for that role.
- **Small original experiments and practitioner reports** illustrate possible
  failure modes and task-specific advantages. CodeRabbit's 13-issue review
  sample in N is useful narrow evidence. A single web demo, an unfetched
  headline, or anecdotes about a different Sol version cannot establish a
  general routing rule.

Prefer directly fetched, dated, like-for-like measurements over summaries.
AA v4.3.2 snapshots and Vals v2.1 supply the main current comparisons. Earlier
AA launch scores and costs must not be spliced into those tables. Effort,
harness, and workload remain part of each observation. The draft's ratings
are editorial bands, not a numerical transformation of composite scores.

## Convergent findings and their foundations

### Sol 6.1 has the strongest general value case

A, Q, S, O, F, and N converge, but their agreement mostly repeats AA. Stronger
support comes from agreement across AA and Vals: Q records migration at
65.12%/$6.51 for Sol 6.1 versus 66.65%/$112.97 for Opus 5.5, and science at
52.86%/$3.44 versus Astra's 62.86%/$20.80. These are costs per attempted test,
not prices for a successful repository assignment. They support starting
ordinary execution on Sol while preserving quality-sensitive alternatives.

I directly checked [AA's September 29 analysis](https://artificialanalysis.ai/articles/gpt-6-1-sol-replaces-gpt-6-sol-after-just-7-days-with-near-astra-intelligence).
It confirms that Sol 6.1 xhigh outperformed its own max by three Coding Agent
Index points, and Astra by one at under 15% of Astra's task cost. That is a
specific coding configuration, not a universal quality advantage. The
[official model page](https://developers.openai.com/api/docs/models/gpt-6.1-sol)
also confirms $2/$10 standard input/output per million tokens and medium as
the API default. Cheap token rates are not the basis of the rating.

### Opus 5.5 and Astra earn different top-depth roles

A/Q/O/F emphasize Opus's leading AA broad and professional-work results. Q's
Vals migration and A's terminal tables support serious execution competence,
not just question answering. O's Epoch evidence adds software strength, but
some of its details come through search summaries. This supports Opus as the
quality-oriented engineering starting point without accepting O's stronger
claim that it leads every independent aggregate.

A/Q give Astra's science and hidden-mechanism evidence. S adds Epoch's math
versus software split and Scale's HLE Diamond results. O's novel-math claims
are supplementary, not essential to the rating. I directly checked
[ARC Prize's Astra experiment](https://arcprize.org/blog/astra): 62.7% at max
with the Standard harness versus 99.9% at high with a Provider Adapter.
These are separate harness results. They support novel-problem depth and
show why a near-perfect adapted score cannot become a model-only rating.
Neither the science tasks nor the broad composites settle all architecture
and research problems.

### Sonnet 5.5 is a strong executor with conditional economics

A/Q supply directly fetched terminal and migration observations. F supplies
the most detailed coding-agent effort table. N's code-review sample supports
keeping Sonnet below Opus on depth, while remaining too small to settle all
review tasks. Sonnet's substantial improvement over Sonnet 5 is supported
across AA and Vals, not just the vendor's launch comparison.

The cost disagreement is real. AA's broad max-effort workload favors Opus on
cost, while the [October 2 Vals Index](https://www.vals.ai/benchmarks/vals_index)
shows Sonnet at 67.04%/$21.34 and Opus at 66.97%/$32.14 per test. The scores
are effectively tied. I checked the live table: its unit is **Cost / Test**,
not F's cost per full index run. A/Q/O's unit is the one to use. No single
Sonnet-versus-Opus task-cost order belongs in the draft.

### Effort and consumption matter more than tier names suggest

All six reports connect token volume to real spending. This convergence is
principally AA evidence, with Vals providing a second workload family. A/Q/O
record Sol 6.1 at $0.21/$0.32/$0.39/$0.72 per broad-index task for
medium/high/xhigh/max. A/Q/O show Sonnet high around $1.12 and max around
$7.67. These curves justify selective escalation, not a blanket maximum.
ARC supplies the converse: extra reasoning can reduce total actions and cost.

The capability evidence often uses max even when the operational suggestion
is medium/high. The draft therefore explicitly separates capability at a
suitable effort from a guarantee at its suggested starting setting. It does
not imply that Sonnet medium reproduces Sonnet max's terminal score.

### The small-model role must remain bounded

A/Q/S/O/F/N agree on Luna for focused inexpensive work. Q/S/F/N also record
Luna 6's small coding regressions against Luna 5.6. A/Q's scientific-terminal
results show that neither is a cheap substitute for frontier investigation.
Haiku's current difficult-task evidence is much weaker than Luna's, but
neither a broad index nor token prices settle easy Claude-specific tasks.
Keep Haiku for that narrow role, not as a competing general default.

## Disagreements, corrections, and remaining uncertainty

1. **Fable's depth ceiling.** N calls it the highest-depth Claude while its own
   evidence favors Opus 5.5 on current aggregates. O rejects the automatic
   hierarchy. A/Q/S/F keep a conditional alternative role. I choose depth 4
   and execution 4. A distinct difficult-task advantage remains plausible but
   unproven, so the draft does not call Fable the obligatory escalation rung.
2. **Astra's economics.** O calls Astra dominated by Sol 6.1 and Opus xhigh,
   but its quoted pairs do not demonstrate strict dominance: Sol scores
   slightly lower, while Opus costs slightly more. Domain-specific science
   and novelty results are a further reason to retain Astra. Its general
   execution premium over Sol is well supported.
3. **Fable is not the most expensive everywhere.** O's categorical statement
   conflicts with its own Vals table and F's coding-agent table, where Opus or
   Sonnet can cost more. Retain a high cost band, not a universal highest-cost
   claim. Old versus current AA versions also produce opposite Fable
   5-versus-5.1 cost comparisons. Cache-heavy savings do not settle the general
   ordering, and the draft promises none.
4. **Latency is not token throughput.** N favors Sonnet for latency-sensitive
   loops partly from tokens/second and anecdotes. F's coding-agent table has
   Sol xhigh completing faster than Sonnet xhigh, while Vals mixed-work
   observations differ again. No universal fastest model is established.
   The draft avoids a latency ranking.
5. **Independent depth evidence exists beyond what some researchers found.**
   F treats ARC/science figures as vendor-only. Q directly fetched ARC and
   A/Q fetched Vals science, which I distinguish from vendor launch claims.
   S's claim of little Sol 6.1 evidence outside AA describes its search limits,
   not the full six-report corpus.
6. **Historical prices and defaults.** N leaves the Sol 5.6 promotion date
   uncertain and A/Q leave Sonnet 5's permanent price history unresolved.
   The drift reports' vendor changelogs resolve August 21 for the Sol
   promotion and August 10 for Sonnet's permanent $2/$10 price. Sonnet 5.5's
   API high default and Claude Code medium default describe different
   surfaces. The draft gives recommendations rather than mixing defaults.
7. **Overstated dominance.** F's migration evidence, as recorded by Q, includes
   Fable 5 slightly above Fable 5.1 in score, at higher cost. Opus 5 is cheaper
   than Opus 5.5 on some measured tasks. Luna 5.6 beats Luna 6 on some coding
   measures. Those are real exceptions, not reasons to retain every older row.
8. **Unmeasured delivery economics.** Published costs generally include failed
   attempts, but do not establish spend through acceptance on this project's
   workload. Mean cost divided by pass rate is not a valid forecast of retry
   cost when failures recur. No new calibration is proposed or performed.

Other unresolved questions include multi-day autonomous work, the best effort
for each repository task, easy-task Haiku versus Luna efficiency, and whether
Sonnet's pending reruns change the observed rankings. They lower confidence
in universal rules. They do not justify importing secondary speculation into
the shipped reference.

## Rating method

Depth and execution use the existing 1-to-5 scale. Five means a leading role
in the current candidate set, four a strong frontier alternative, three useful
but materially limited, two bounded work, and one very limited depth. Execution
includes effective progress and resource use, so Sol can earn 5 without the
highest raw terminal pass rate. Astra's excellent science execution does not
automatically make it the most efficient general executor.

Cost bands are qualitative, conditioned on a task the model can complete.
Luna anchors lowest, Haiku low, Sol 6.1 low-medium, and the premium generalists
medium-high or high. The bands intentionally overlap. They are not dollar
thresholds or an assertion that every task favors the same ordering. Fable's
high band reflects its substantial spend even below max. Opus, Sonnet, and
Astra span medium-high because effort and task mix materially change their
relative cost.

## Every candidate, with per-model evidence and disposition

The triples below are **depth / execution / cost-to-task**. For omitted models,
the reassessment is recorded here to show that their ratings were reconsidered
rather than silently inherited. These are not extra rows proposed for the
shipped file. Report relationship marks follow the attribution legend above.

| Candidate | Reassessment | Evidence attributed to reports | Decision and reason |
| --- | --- | --- | --- |
| claude-opus-5-5 | 5 / 5 / medium-high | A/Q: AA broad/professional lead, Vals terminal and migration strength. O** adds Epoch software results. F*/N* document output and effort costs. | Keep. Strong evidence for both demanding reasoning and execution, with effort-sensitive spending. |
| claude-sonnet-5-5 | 4 / 5 / medium-high | A/Q: Vals migration and terminal strength. F*: coding-agent effort table. N**: narrower review result below Opus. O*: cost order differs between AA and Vals. | Keep. Leading execution role, with less convincing broad novel-problem depth than Opus/Astra. |
| claude-fable-5-1 | 4 / 4 / high | A/Q: current science/migration results do not lead. S: Epoch software strengths. F** acknowledges no current aggregate win over Opus. N* proposes the higher ceiling mainly from vendor guidance. | Keep as a conditional alternative. Neither a universal depth leader nor universally the most expensive model. |
| claude-haiku-4-5 | 1 / 2 / low | A/Q: AA thinking index 17 and weak difficult-task evidence. S/O*/F*/N*: bounded Claude-specific work, with little recent easy-task comparison. | Keep narrowly. The existing low capability ratings remain appropriate, but no general advantage over Luna is implied. |
| gpt-6-astra | 5 / 4 / medium-high | A**/Q*: Vals science/mechanism strength. S*: Epoch/Scale depth split. O/F: competitive coding with a premium over Sol. ARC independently supports novelty. | Keep. Its domain headroom is meaningful despite a near tie with Sol on a broad index. |
| gpt-6.1-sol | 4 / 5 / low-medium | A*/Q**/S*: AA execution and effort evidence. Q**: Vals migration, mechanisms, science. O/F/N reach the same value conclusion from AA/Vals. | Keep. Broad enough for investigation, and unusually economical for capable execution. Evidence is still very recent. |
| gpt-6-luna | 2 / 3 / lowest | A*/Q*: very low cost, weak difficult science/terminal performance. Q*/S*/F/N record coding regressions against Luna 5.6. | Keep for bounded checked work. Lowest spend does not establish lowest cost on difficult assignments. |
| claude-opus-5 | 4 / 4 / high | A/Q: AA 51 and weaker terminal/science than 5.5. O*/F*/Q: lower spending than 5.5 on some coding/migration or mixed tasks. | Drop from the compact shortlist, not as strictly dominated. Its measured savings are worth preserving here, but newer Sonnet/Opus and Sol provide clearer general roles. |
| claude-opus-4-8 | 3 / 3 / high | A/Q: AA 42 and weak current terminal/science results. S/O*/F*/N* mainly identify historical or specific-workflow uses. | Drop. No evidence-supported general depth or execution role distinct from the retained rows. |
| claude-fable-5 | 4 / 3 / high | A/Q: substantial broad capability, weaker current terminal/science, high spend. Q: migration slightly ahead of 5.1 at greater cost. S/F*/N*: task-sensitive consumption. | Drop. The retained Fable alternative has stronger general support. Neither equal token rates nor a small migration-score difference establishes a general reason to keep both. |
| claude-sonnet-5 | 2 / 2 / high | A/Q: AA 38, low terminal and science results. Q/S/F*/N*: substantial successor improvement, without universal cost savings at max. | Drop. Its old execution-default role is contradicted by the newer comparisons. Sonnet 5.5 at suitable effort is the stronger shortlist choice. |
| gpt-6-sol | 3 / 4 / low-medium | A*/Q*/S**: lower depth/coding than 6.1, with some latency advantages in A. O/F/N: no clear general slot beside 6.1. | Do not add. Same base rates as 6.1 with poorer measured completion economics. A possible speed preference is not a demonstrated broad role. |
| gpt-5.6-sol | 3 / 4 / medium | A*/Q*/S*: competent older model, weaker and more costly than 6.1 on current comparisons. Q*/S*/F/N: some professional-work strengths over Sol 6. | Drop. Advantages over Sol 6 cannot be assumed to survive against 6.1. The promotion does not restore a general value lead. |
| gpt-5.6-terra | 3 / 3 / medium | A*/Q*/S*: AA 42/$1.40 at max, weaker execution economics than 6.1. O/F/N likewise find no general middle-tier role. | Drop. The tier name is not a reason to retain it when Sol 6.1 supplies stronger work at lower measured cost. |
| gpt-5.6-luna | 2 / 3 / low | Q*/S*/F/N: coding-agent 43 versus Luna 6's 41, at greater cost. A*: low terminal/science scores for both. | Drop with moderate confidence. The coding edge is real, but insufficiently broad to outweigh Luna 6's substantial savings for the narrow cheap-worker role. |

The seven retained rows are a practical shortlist rather than the mathematical
Pareto frontier of any single benchmark. Fable and Haiku retain explicit
conditional roles. Opus 5 and Luna 5.6 have stronger measured exceptions than
some other omissions, but do not receive general default recommendations.

## Complete audit against the current catalog

Baseline: [current models.md](/mnt/black/prog/agent-skills/.worktrees/refresh-delegate-catalog/skills/delegate/models.md).
These comparisons use the literal existing cells, not an inferred successor
mapping. A new model's rating is not a change to an older model's rating.

| Existing row | Old triple | Reassessed triple | Changed cells and rationale |
| --- | --- | --- | --- |
| claude-opus-5 | 5 / 4 / high | 4 / 4 / high, omitted | Depth 5 to 4: newer candidates establish stronger broad and domain headroom. Execution and cost retained after review. |
| claude-opus-4-8 | 4 / 4 / high | 3 / 3 / high, omitted | Depth 4 to 3 and execution 4 to 3: current AA and Vals evidence puts it materially below the new frontier. Cost stays high. |
| claude-fable-5 | 5 / 3 / highest | 4 / 3 / high, omitted | Depth 5 to 4: no current general ceiling lead. Highest to high: workload-dependent costs do not support a unique highest band. Execution remains 3. |
| claude-sonnet-5 | 3 / 4 / high | 2 / 2 / high, omitted | Depth 3 to 2 and execution 4 to 2: current terminal/science and broad results no longer support its former default role. High cost remains warranted at demanding effort. |
| claude-haiku-4-5 | 1 / 2 / low | 1 / 2 / low, retained | No numerical change after review. Its role narrows to simple Claude-specific work rather than competing with Luna on general value. |
| gpt-5.6-sol | 4 / 5 / medium | 3 / 4 / medium, omitted | Depth 4 to 3 and execution 5 to 4: newer Sol/Astra and Claude models move the relative frontier. Medium cost remains defensible. |
| gpt-5.6-terra | 3 / 3 / low-medium | 3 / 3 / medium, omitted | Cost low-medium to medium: Sol 6.1 establishes much cheaper completion at greater capability. Capability ratings remain 3 after review. |
| gpt-5.6-luna | 2 / 3 / lowest | 2 / 3 / low, omitted | Cost lowest to low: Luna 6 takes the cheapest bounded-work role. Capability ratings remain, preserving the older model's small coding edge. |

New retained rows and their reasons are fully rated in the candidate table:
Opus 5.5 (5/5/medium-high), Sonnet 5.5 (4/5/medium-high), Fable 5.1
(4/4/high), Astra (5/4/medium-high), Sol 6.1 (4/5/low-medium), and Luna 6
(2/3/lowest). The seventh new candidate, Sol 6, is assessed but not added.

The draft removes the fourth axis and its associated notes as instructed. It
uses no research narrative or source names. It does not transplant the
researchers' proposed extra columns, numerical benchmark costs, compatibility
appendices, or local testing programs. The date is exactly 2026-10-04.
