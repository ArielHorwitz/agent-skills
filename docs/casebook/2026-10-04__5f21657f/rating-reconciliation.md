# Rating reconciliation (phase 4, lead)

Both synthesizers (claude-fable-5-1, gpt-6-astra) independently kept the same
seven rows and dropped the same eight (each listed model is beaten on quality
and cost by a listed model from its own vendor). Depth agrees on every row.
Six cells disagreed:

| row | axis | fable-5-1 | astra | resolved | why |
| --- | --- | --- | --- | --- | --- |
| claude-opus-5-5 | cost | high | medium-high | **high** | On the agentic boards closest to delegate work (Vals Index, Terminal-Bench 4.0, Code Migration, TB-Science) Opus costs 1.4x to 2.5x Astra per task. AA at `high` puts it level with Astra, but AA is a broad non-agentic index. |
| claude-sonnet-5-5 | cost | high | medium-high | **high** | Cheaper than Opus at `high` on AA, dearer at `max`; on Vals boards between Astra and Opus, on Terminal-Bench above Opus. Not cheap enough to separate from Opus. |
| claude-fable-5-1 | cost | highest | high | **high** | AA has it costliest at every effort, but on Vals Index and Code Migration it is cheaper than Opus 5.5. Mixed evidence does not support a band of its own. |
| gpt-6.1-sol | cost | low | low-medium | **low** | 5x to 10x cheaper than the frontier per task on every board, and about Haiku's cost on AA at `high`. |
| claude-haiku-4-5 | execution | 1 | 2 | **1** | AA terminal score 0%; no agentic board measures it at all. |
| gpt-6-luna | execution | 2 | 3 | **2** | Terminal-Bench 4.0 13.6% vs 6.1 Sol 55%; Coding Agent Index 41 vs 63; small regressions vs 5.6 Luna. "Don't let it drive a shell unsupervised" needs a 2. |

Evidence: `synthesis-claude-fable-5-1.md` section 4 (cost backbone, all
independent: Artificial Analysis and Vals), and `synthesis-gpt-6-astra.md`
"Rating method". AA is one evaluator however many reports cite it.

Direction of bias: the Claude synthesizer rated the Claude models *more*
expensive than the OpenAI one did. No self-vendor favoring in the disagreements.

Merged draft: Fable's draft as the base (richer notes, explicit "not listed"
line), cells resolved as above, Fable 5.1's "most expensive" wording softened
to match, and Astra's starting-choice guidance added as a note.

## Revision after user review (2026-10-04)

The user questioned flattening every Claude flagship to "high". On review the
lead had overridden the research: both synthesizers independently ranked Fable
5.1 above Opus 5.5 on cost (fable: highest vs high; astra: high vs medium-high),
and independent data agrees (AA costlier at every effort; Endor Labs: Opus uses
about a third of Fable's output tokens per coding task). Pairwise cell
resolution on the agentic boards alone had lost that ordering. The user also
cautioned against weighting our own run's spend (an anecdote) over research.

Resolved: Fable 5.1 **highest**, Opus 5.5 **high**, Sonnet 5.5 **medium-high**
(cheaper than Opus below `max`, confirmed by both Claude verifiers), Astra
medium-high, 6.1 Sol low, Haiku low, Luna lowest. Word bands kept (user
preference over a 1-5 scale whose direction would be ambiguous), with the band
order stated in the file.

**Lesson for the skill:** reconcile each cell against the whole column's
ordering, not cell by cell, and keep orderings both synthesizers agree on.
