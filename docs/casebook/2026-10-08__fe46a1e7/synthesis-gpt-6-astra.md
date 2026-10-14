# Model ID: `gpt-6-astra`

This is the synthesis assignment's model ID. The session identifies the GPT-6
family but does not expose independently verifiable exact runtime metadata.
Date: 2026-10-08.

## Decision

Replace Haiku 4.5 with Haiku 5.5 at **depth 2 / execution 2 / cost lowest**,
with the cost band explicitly conditioned on bounded work, moderate effort,
and prompts up to 100K tokens. Keep the other six rows and all their ratings.
Update Sonnet's cost wording and the shared pricing, effort, and starting-choice
notes. Haiku changes the cheap Claude choice, not the frontier choices.

The principal uncertainty is Haiku versus Luna on completed-task economics.
There is no supported universal winner. The recommendation is a compact
shortlist judgment, not proof of dominance on every workload.

## Evidence trail and researcher relationships

Current reports, all dated October 8:

- H-O: [Opus research](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/research-claude-opus-5-5.md).
- H-S: [Sol 6.1 research](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/research-gpt-6-1-sol.md).
- H-A: [Astra research](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/research-gpt-6-astra.md).
- D: [merged drift](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/drift-report.md), with
  [Opus detail](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/drift-models-claude-opus-5-5.md) and
  [Sol detail](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/drift-models-gpt-6-1-sol.md).

October 4 evidence for existing rows:

- P-O: [Opus](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/research-claude-opus-5-5.md).
- P-N: [Sonnet](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/research-claude-sonnet-5-5.md).
- P-F: [Fable](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/research-claude-fable-5-1.md).
- P-A: [Astra](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/research-gpt-6-astra.md).
- P-S: [Sol 6.1](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/research-gpt-6-1-sol.md).
- P-6: [Sol 6](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/research-gpt-6-sol.md).

The previous [Astra synthesis](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/synthesis-gpt-6-astra.md) and
[Fable synthesis](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/synthesis-claude-fable-5-1.md) provide the earlier
reasoning. The final user correction in
[rating reconciliation](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/rating-reconciliation.md) takes precedence
over their initial cost bands: Fable highest, Opus high, Sonnet and Astra
medium-high, Sol low, Haiku 4.5 low, Luna lowest. The
[user decisions](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-04__5f21657f/user-decisions.md) remain binding.

| Researchers | Own-vendor judgments | Self-judgments |
| --- | --- | --- |
| H-O and P-O, Claude Opus 5.5 | All Claude placements and recommendations | Opus 5.5 |
| P-N, Claude Sonnet 5.5 | All Claude placements and recommendations | Sonnet 5.5 |
| P-F, Claude Fable 5.1 | All Claude placements and recommendations | Fable 5.1 |
| H-S and P-S, GPT-6.1 Sol | All GPT placements and recommendations | GPT-6.1 Sol |
| H-A and P-A, GPT-6 Astra | All GPT placements and recommendations | GPT-6 Astra |
| P-6, GPT-6 Sol | All GPT placements and recommendations | GPT-6 Sol |

These marks apply to each report's interpretations throughout this synthesis,
not to ownership of independent measurements it cites. My GPT recommendations
are also own-vendor judgments and the Astra row is a self-judgment under the
assigned ID. H-O's Haiku upgrade and H-S/H-A's retention of Sol and Luna
therefore have explicit own-vendor relationships. They require evidence,
not an extra vote because several researchers agree.

## Evidence weighting

Artificial Analysis supplies most comparable capability, consumption, and
effort data. All its model pages and articles are one evaluator. LiveBench
adds a distinct task mix, but the researchers obtained its rows through
search-indexed text. Plotly's original 43-question run and DataCamp's original
24-invoice exercise are separate, narrow experiments. These do more to test
blanket claims than repeated launch coverage does.

Vendor documentation has priority for rates and defaults. Vendor evaluations
support direction but do not replace independent tests. Cognition's
FrontierCode observations in H-O were obtained through secondary coverage,
and Cognition was a launch partner. The reported Vals Haiku observations were
also secondhand. They receive less weight than directly inspected primary
measurements. Community examples illustrate possible outcomes without
establishing their frequency.

For existing rows, the previous reports' AA and Vals observations remain the
main execution and cost evidence. Epoch, ARC Prize, Scale, CodeRabbit, and
Endor Labs add narrower depth or engineering comparisons. Repeated citations
to each evaluator remain one source family. Benchmark costs usually mean
spend per attempted test, not delivery including review, repairs, and retries.
No local capability tests were run or proposed as a prerequisite.

I formed the Haiku role from the new reports before reading the current
catalog. I did not consult the other current synthesizer's output. The
[run log](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/run-log.md) was used only as an invocation record, not
capability or cost calibration. Narrow live source checks on October 8
confirmed the material billing and comparison changes below.

## Convergent findings and their basis

**Haiku 5.5 earns the small Claude row.** All three new reports support the
replacement. H-A records AA's Haiku 4.5 reasoning index at 17 and $0.28 per
attempt, compared with Haiku 5.5 high at 38 and $0.08. These are different
reasoning controls, not equal-compute tests. More directly relevant to bounded
work, H-S records Plotly at 37/43 versus 27/43 passes and $0.38 versus $3.27
for the full run. H-A and H-O record DataCamp's equal 24/24 invoice results at
$0.0098 versus $0.25. These narrow runs support meaningful savings and useful
capability, without claiming every migration is cheaper.

**The larger models retain their depth and execution roles.** H-A and H-S
record Haiku high at 22% Terminal-Bench against Sol high at 52%. Haiku max
reaches about 33%, still well below Sonnet max at 64%. The broad index is 43
versus 52 for Sol and 56 for Sonnet at max. Those results and the previous
scientific, migration, and mechanism tests support keeping ordinary complex
execution on Sol/Sonnet and difficult investigations on Opus/Astra. The live
[Haiku/Sonnet comparison](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-claude-sonnet-5-5)
confirmed the terminal and index gap. It does not establish a medium-effort
Haiku success rate from max results.

**Effort can consume the rate saving.** H-S records Haiku medium/high/xhigh/max
at AA scores 34/38/41/43 and costs $0.05/$0.08/$0.12/$0.21 per attempted
index task. H-O's FrontierCode Main figures put Haiku medium near Luna max
on score and spend, while Haiku max is worse and dearer than Sol medium.
The latter comparison is secondary evidence, not the sole basis of a rating.
The independent effort curve and direct
[Haiku prompting guidance](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-haiku-5-5)
support medium as the starting point, high for longer tool work, explicit
completion checks, and comparison with a larger model before xhigh/max.

**Sonnet's cache change matters without forcing a new cost band.** D records
cache reads falling from $0.20 to $0.10/M on October 7, with other prices
unchanged. The live
[release notes](https://platform.claude.com/docs/en/release-notes/overview)
confirm this. The resulting task saving depends on the share of spending
attributable to cache reads. Halving one billing component does not halve
total cost. The existing medium-high band already distinguishes Sonnet from
Opus, consistent with the binding user correction.

## Disagreements and what remains unresolved

1. **Haiku versus Luna quality.** H-O calls Haiku clearly smarter and broadly
   better. H-S/H-A qualify this. AA max favors Haiku on its broad index and
   terminal tasks, but Luna wins AutomationBench 53% to 35%. LiveBench is
   effectively tied, 72.1 versus 72.0 at Haiku xhigh and Luna max. Plotly
   slightly favors Luna, 38/43 versus 37/43. Prefer a terminal-specific
   advantage over a universal superiority claim. The live
   [AA Haiku/Luna comparison](https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-luna)
   confirms the opposing terminal and automation directions.
2. **Haiku versus Luna cost.** H-O emphasizes approximate parity at matched
   quality. H-S records Plotly spending about 2.9 times more on Haiku, while
   search-indexed LiveBench reports lower cost per successful task for Haiku
   xhigh, $0.019 versus Luna max $0.026. AA max favors Luna $0.07 to $0.21,
   but Haiku high approximately matches Luna max's index at $0.08. These
   workloads and denominators cannot be averaged into a universal ordering.
   Both earn the lowest band for their bounded roles, with Haiku's conditions
   and often greater consumption stated prominently.
3. **Execution 2 or 3 for Haiku.** Its max terminal result could justify a 3
   if the axis meant peak terminal score alone. The catalog instead asks
   about efficient sustained loops. Medium/high results, the automation
   reversal, and weak long-run evidence favor 2. It is a substantial upgrade
   over Haiku 4.5's 1, with more terminal headroom than Luna despite sharing
   Luna's band. No need to populate every integer on the scale.
4. **Sonnet at max is no longer categorically dearer than Opus.** The previous
   reports recorded roughly $7.60 to $7.67 versus $5.98 on AA. All three new
   reports record Sonnet at $5.46, below Opus's $5.98, and the live comparison
   confirmed $5.46 and the new cache rate. Older coding-agent and terminal
   costs still show workloads where Sonnet costs more. The cause of the full
   AA difference is not established. Do not attribute it entirely to the
   cache reduction or mechanically reprice historical boards. Replace the
   universal claim with effort- and workload-dependent wording.
5. **High-effort cost estimates remain imperfect.** The reports could not
   establish whether AA fully includes Haiku's long-prompt surcharge. H-O's
   secondary Vals account even reports more spending than Haiku 4.5 on some
   long tasks. This limits strict dominance claims. The bounded-task
   replacement is supported without resolving every long-loop comparison.
6. **Speed is workload dependent.** H-O's fastest-model claim relies heavily
   on token throughput. H-A records Haiku xhigh producing tokens faster than
   Luna while taking longer per task. Avoid an unqualified fastest-worker
   claim. The same caution applies to early customer testimonials.
7. **Luna has long-input pricing too.** H-O found no surcharge, but H-S, H-A,
   and D document the 272K threshold. The live
   [official Luna page](https://developers.openai.com/api/docs/models/gpt-6-luna)
   confirms whole-request doubling of input/cache rates and 1.5x output.
   The draft states both vendors' thresholds, avoiding a false flat-price
   contrast. H-O's uncertainty about October Luna capability changes is
   resolved for this catalog by D and H-S/H-A: the described conversation
   updates do not change the Work/Codex comparators.

The independent Haiku evidence is one day old. No repeated representative
repository study establishes total accepted-delivery cost, and no independent
long-horizon result warrants promoting it into the frontier execution group.

## Every current row reconsidered

Triples are depth / execution / cost. An unchanged rating is a positive
comparison against the new model and the previous evidence, not an assumption
that relative ratings never move.

| Row | Current | Draft | Reason and evidence |
| --- | --- | --- | --- |
| claude-opus-5-5 | 5 / 5 / high | unchanged | P-O/P-S/P-A support broad depth and strong migration/terminal work. H-A/H-S leave Haiku far below it on difficult execution. Neither Haiku's cheap bounded role nor Sonnet's cache reduction invalidates Opus's quality role or high cost band. |
| claude-sonnet-5-5 | 4 / 5 / medium-high | unchanged | P-F/P-S/P-A support leading terminal and migration execution. H-A/H-S confirm a large gap over Haiku. Cache savings reinforce the existing cost separation from Opus, but do not establish the general savings needed for low or medium. Revise cost wording, not cells. |
| claude-fable-5-1 | 4 / 4 / highest | unchanged | P-F/P-6/P-S preserve narrower reasoning and software strengths, without an overall lead over Opus. The user correction preserves its greater representative cost. Haiku brings no evidence about the difficult classes that retain Fable's alternative role. |
| claude-haiku-4-5 | 1 / 1 / low | removed, superseded | H-A/H-S supply AA, Plotly, and DataCamp evidence for replacing the bounded Claude worker. No demonstrated general role remains beside Haiku 5.5. This is not a promise of savings on every long task. |
| gpt-6-astra | 5 / 4 / medium-high | unchanged | P-S/P-6/P-A and the previous synthesis support distinct scientific and novel-mechanism depth through ARC, Epoch/Scale, and Vals. Haiku has no comparable evidence. Its lower easy-task cost cannot displace that role. Own-vendor and self-judgment as marked above. |
| gpt-6.1-sol | 4 / 5 / low | unchanged | P-F/P-S/P-A support efficient coding, migration, and scientific execution. H-A's matched-high comparison preserves a large execution advantage over Haiku. Secondary FrontierCode supports the warning that expensive Haiku reasoning need not be cheaper. Own-vendor judgment. |
| gpt-6-luna | 2 / 2 / lowest | unchanged | H-S/H-A show meaningful automation and analytics strengths alongside weaker terminal results than Haiku. Cost wins and losses are workload dependent. A competitor's terminal gain does not justify downgrading all Luna capability or raising its cost band. Own-vendor judgment. |
| claude-haiku-5-5 | new | 2 / 2 / lowest, see notes | Bounded useful depth and execution, a substantial predecessor upgrade, material frontier gap. AA moderate-effort costs and the narrow original task runs support the cheapest tier for short work, with explicit qualifications. |

Whole-column ordering remains coherent: Opus/Astra anchor depth, the
Opus/Sonnet/Sol group anchors execution, Haiku/Luna anchor bounded cheap work,
and Sol remains the low-cost capable executor. Fable highest, Opus high,
Sonnet/Astra medium-high is preserved exactly. Adding a second lowest-cost
worker does not require inflating every other band.

## Roster and every note change

Only Haiku 5.5 is added and only Haiku 4.5 is dropped. D identifies no other
new general delegation model. Sonnet, Opus, and Fable retain their higher
capability roles. The older eight exclusions remain unchanged because the
new reports offer no evidence restoring their general roles. The previous
synthesis already records their workload-specific exceptions.

| Location | Change | Reason |
| --- | --- | --- |
| Rating introduction | Condition ratings on task as well as effort, describe order-of-magnitude effort effects, clarify ties | Haiku's cheapest band is not a long-loop promise. Existing and new effort curves do not support one universal 4x-to-18x range. |
| Haiku row | Replace ID, 1/1/low with 2/2/lowest, rewrite all guidance | Supersession evidence above. Medium/high guidance, named checks, limited long-loop support, and price/effort conditions replace the obsolete near-zero-shell and universal Luna advantage claims. |
| Sonnet row | Retain cells and recommended efforts, qualify cost comparison | Current AA costs contradict the categorical maximum-effort cost order. Previous task studies still justify warning about heavy reasoning. |
| Luna row | Add workload-dependent cost comparison with Haiku | Plotly and AA often favor Luna on spend, LiveBench can favor Haiku. Retain bounded scope and medium-or-higher effort. |
| Starting choices | Add Haiku medium and Luna for small checked tasks | Haiku now earns a real cheap-worker role. Larger-model starting choices remain supported. |
| Effort note | Add Haiku's Claude Code medium default and compare larger models before xhigh/max | D and the direct prompting guide establish the default. Independent effort curves support the economic qualification. Existing defaults remain. |
| Cost-to-task note | Name Opus/Sonnet rather than every Claude 5.5 model, soften numerical and universal cost claims, add Haiku consumption and completion-time caveats | Haiku makes the old family-wide statement misleading. Current Sonnet measurements change the old cost ordering. Throughput and completion time differ. |
| Sticker-price note | Replace Haiku 4.5 $1/$5 with Haiku 5.5 $0.10/$0.50, label short-prompt rates, add Sonnet $0.10/M cache reads | Vendor facts in D and the live release notes. Other base rates unchanged. |
| Long-input note | Add Haiku's whole-request 100K tier at $0.50/$2.50, retain GPT 272K modifiers and specify cache rates, give Luna $0.20/$0.75, name the three flat-priced Claude models | Fix the false all-Claude-flat claim and the unjustified vendor-wide cost preference. The two tokenizers and consumption patterns also matter. |
| Not listed | Add Haiku 4.5, remove the incidental callable-status wording | Record same-vendor supersession while keeping the note about selection. |
| Footer | Date becomes 2026-10-08 | Date of this incremental assessment. |

Opus, Fable, Astra, and Sol row text is unchanged. The three axes, table
columns, section structure, and source-free shipped voice are preserved.
Only the two requested output files are written. No commit is made, as the
specific handoff requires.
