# Synthesis: model research for the 2026-10-04 refresh

Synthesizer model ID: `claude-fable-5-1` (Anthropic). Date: 2026-10-04.

Disclosure: I am an Anthropic model, and I am the same model as one of the rows
I rate (Fable 5.1). Every judgment I make about a Claude model is a self-vendor
judgment, and the Fable 5.1 row is a self-judgment. I mark the places where
that matters most (section 7, Fable 5.1 depth) and lay out the case both ways
so the lead can reconcile against the other synthesizer.

Inputs: the six research reports, the drift report and its two detail reports,
`user-decisions.md`, and the current `models.md` (read last). Output: this file
and `models-draft-claude-fable-5-1.md`.

## Report labels

| label | report | researcher's vendor | self-rows |
| --- | --- | --- | --- |
| F | research-claude-fable-5-1.md | Anthropic | Fable 5.1 (self), all Claude rows (self-vendor) |
| O | research-claude-opus-5-5.md | Anthropic | Opus 5.5 (self), all Claude rows |
| S | research-claude-sonnet-5-5.md | Anthropic | Sonnet 5.5 (self), all Claude rows |
| S61 | research-gpt-6-1-sol.md | OpenAI | GPT-6.1 Sol (self), all GPT rows |
| A | research-gpt-6-astra.md | OpenAI | GPT-6 Astra (self), all GPT rows |
| S6 | research-gpt-6-sol.md | OpenAI | GPT-6 Sol (self), all GPT rows |

Where a judgment below is a researcher's own-vendor or own-model judgment, it is
tagged `[self]`. Where several reports cite the same page, I count one source.

## 1. Evidence base and how I weighed it

Independent evaluators that actually measured something, in order of how much
of the ratings rests on them:

1. **Artificial Analysis (AA).** Intelligence Index v4.3.2 (score and cost per
   task, per effort level, output tokens per task) and the Coding Agent Index
   (agent plus model, DeepSWE v1.1, Terminal-Bench 4.0, SWE-Atlas-QnA, with cost,
   time and tokens per task). Every report leans on AA. F relayed the full
   Coding Agent Index table; O had it partially via mirrors. Caveat raised by F,
   O, S, S61: AA rescaled its index three times in September, so anything
   quoted before mid-September is on a different scale. All AA numbers here are
   v4.3.2. Second caveat (O, S61): AA's Sonnet 5.5 run hit a pre-release
   structured-output bug that Anthropic says is fixed, and AA said it would
   re-run. Third (F): AA runs Claude models "with fallback".
2. **Vals AI.** Vals Index v2.1 (F, O, S61), Terminal-Bench 4.0 (A),
   Terminal-Bench-Science (S61, A), Code Migration (S61), MysteryMechanism
   (S61), with cost per test. The OpenAI researchers brought the per-board
   Vals data, the Claude researchers the aggregate. Both are one evaluator.
3. **Epoch AI.** Capabilities Index and FrontierMath (O, S6). Caveat (O):
   OpenAI funded FrontierMath and has access to part of it. S6's Epoch numbers
   are from 2026-09-16, before Opus 5.5 existed, so they rank Astra against
   Fable 5.1 only.
4. **ARC Prize** (ARC-AGI-3, Astra only, O and S61), **Scale Labs** (HLE
   Diamond, SWE Atlas, S6 only), **CodeRabbit** (code review eval, S and F),
   **Cursor** (CursorBench, S61, commercially interested), **Endor Labs**
   (Astra in Codex, O), **Firecrawl** (Fable 5.1 vs Fable 5 tokens, O),
   **ComputingForGeeks** (three DevOps prompts, A). Each is a single run or a
   single board. Useful for direction, not for ratings on their own.
5. **Hands-on and community**: Simon Willison (max-effort failure, F, O),
   Every.to (Opus 5.5 runs long, O), Zvi roundup (S), HN and X threads (F, O),
   a Reddit Sonnet-vs-Opus anecdote (S61, A). Anecdotes, days old.

Vendor sources (model pages, pricing, effort docs, announcements) are used for
facts (price, defaults, effort levels, release dates) and for positioning. No
rating rests on a vendor benchmark claim. Where vendor and independent numbers
disagree, the pattern is consistent: vendor Terminal-Bench 4.0 runs about 6
points above AA and Vals for Opus 5.5 (66.4 vs 59.6 and 65.2) and Sonnet 5.5
(70.6 vs 64 and 64.1). OpenAI's $5.47 vs $23.21 Sol-vs-Opus science cost claim
does not match the Vals ratio ($3.44 vs $19.12), though the direction holds.

Overall quality: strong on cost-to-task and execution (two evaluators with
task-level costs across nearly every model), moderate on depth (aggregate
indices plus a few domain boards), thin on the two newest models (6.1 Sol is
five days old, Sonnet 5.5 six). Nothing independent on Haiku 4.5 beyond AA's
index entry. No METR-style time-horizon data for anything.

## 2. Convergent findings

Each finding names the reports that reached it and what it rests on.

**C1. GPT-6.1 Sol is the cost-to-task outlier.** All six reports. On AA it
scores 52 for $0.72 at max against Opus 5.5's 58 for $5.98 and Astra's 53 for
$3.26. On the Coding Agent Index, Codex plus 6.1 Sol at xhigh scores 63 for
$1.04 and 15 minutes, against Claude Code plus Opus 5.5 at 66 for $13.04 and
1.1 hours. On Vals it is 4 to 10 times cheaper per run than every frontier
model for 2 to 6 fewer points. Terminal-Bench-Science 52.9% for $3.44 (second
only to Astra). Rests on AA and Vals, two evaluators, same direction on every
board. The three OpenAI reports recommend it as the default executor `[self]`,
and so do F and O, so the recommendation is not a vendor artefact.

**C2. Opus 5.5 leads the independent aggregates.** All six. AA index 58, five
clear of the field, leading six of ten component evals. Vals Index 66.97%,
within 0.07 of Sonnet 5.5 and above everything else. Epoch Capabilities Index
167.35 vs Astra 166.51, overlapping intervals (O). Coding Agent Index 66, Vals
Terminal-Bench 4.0 65.15% (best). Anthropic's own positioning flipped to "start
with Opus 5.5 for most workloads" (F, O, S `[self]`). Rests on AA, Vals, Epoch.

**C3. Fable 5.1 has no independent case as the deepest model.** F, O, S
`[self]`, S61, A. S6 is the partial dissent (section 3). AA 53 (tied with
Astra, five behind Opus 5.5), Vals Index rank 4, Epoch 165 (tied with Sonnet
5.5), FrontierMath Tier 4 88% vs Opus 5.5 95% and Astra 98%, Terminal-Bench-
Science 40% vs Opus 5.5 47%, MysteryMechanism 47.8% vs Opus 5.5 49.6%, HLE
Diamond 51.3% vs Opus 5.5 55.0%. Most expensive per task on AA ($7.63) and
Terminal-Bench-Science ($38). Its measurable edges: Vals rank 1 on
LiveCodeBench, MMLU Pro and MMMU Pro (F), a 24-point SimpleQA lead over Sonnet
5.5 (O), fewer tokens than Opus 5.5 per coding-agent task (5.7M vs 15.6M, F).
Vendor positions it as the escalation above Opus 5.5. The three Anthropic
researchers rated it down, against self-interest, which strengthens the
finding.

**C4. Sticker price misleads, and effort is the bigger lever.** All six. At
max effort Sonnet 5.5 emits about 193k output tokens per AA task, Opus 5.5
119k, Fable 5.1 78k, Astra 27k. So Sonnet 5.5 at $2/$10 costs $7.60 per AA task
against Opus 5.5's $5.98 at $4/$20, and Astra at $10/$50 costs $3.26. Within a
model, Opus 5.5 spans $0.55 (low) to $5.98 (max), Sonnet 5.5 $0.41 to $7.60,
6.1 Sol $0.13 to $0.72. 6.1 Sol at xhigh beats its own max on the Coding Agent
Index (63 vs 60) at two-thirds the cost. Rests on AA, corroborated in direction
by Vals durations (Claude flagships 77 to 79 minutes per run vs Astra 28, Sol
43).

**C5. Astra is the depth pick for novel math and science, and the fastest
frontier model.** O, S, S61, A `[self]`, S6 `[self]`, with F agreeing on
"science or math shaped" problems. FrontierMath Tier 4 98% (Epoch), the only
model to solve any open Erdős problems (Epoch, O), ARC-AGI-3 62.7% standard
harness (ARC Prize), Terminal-Bench-Science 62.9% vs next-best 52.9% (Vals),
MysteryMechanism 53.2% (Vals, best). Vals run time 28 minutes vs 77 for the
Claude flagships. Rests on Epoch, ARC Prize, Vals, AA token counts. Caveat:
Epoch's FrontierMath has an OpenAI funding tie (O).

**C6. Max effort is the wrong default on the Claude 5.5 models.** F, O, S, S61,
A. Simon Willison's test had Opus 5.5 and Sonnet 5.5 at max think through the
full 128K output and return nothing, twice (F, O). Every.to saw Opus 5.5 run a
single prompt for 1h52m and run out a timebox on side work (O). Anthropic's own
effort doc says max adds significant cost for small gains (F, S61). Anecdotes
plus vendor doc, but consistent with the AA token data.

**C7. GPT-6 Luna dominates Haiku 4.5 on independent data, and neither belongs
near a shell.** F, O, S, S61, A, S6. AA: Luna 38 for $0.07 vs Haiku 17 for
$0.21 to $0.28. Terminal-Bench 4.0: Luna 13.6% (Vals), Haiku 0% (AA, A). Luna
also has a 1.05M context vs Haiku's 200K. Haiku's only reason to exist in the
table is a Claude-only pipeline (F, O, S, S6).

**C8. The previous generation is dominated.** All six on the Claude legacy
rows and GPT-6 Sol. The OpenAI reports hedge on GPT-5.6 Sol, Terra and Luna
(section 3). Numbers in section 6.

## 3. Real disagreements, unresolved

**D1. Is Sonnet 5.5 cheaper than Opus 5.5 per task?** The evaluators split, not
the researchers. AA: Opus 5.5 is cheaper at every matched score (Opus high 54
for $1.82 vs Sonnet xhigh 52 for $2.75; Opus xhigh 56 for $3.46 vs Sonnet max
56 for $7.60). Vals Index: Sonnet $21.34 vs Opus $32.14 for equal accuracy.
Vals Code Migration: Sonnet $75.83 vs Opus $112.97, Sonnet ahead. Vals
Terminal-Bench 4.0: Sonnet $16.51 vs Opus $13.20, equal score. Vals
Terminal-Bench-Science: Sonnet $30.43 vs Opus $19.12, equal score. Coding
Agent Index at max: $14.19 vs $13.04. Three workloads each way. O concludes
"Opus-class quality at Opus-class task cost, not half" `[self]`. F concludes
Sonnet at xhigh is the best Claude price-to-execution point `[self]`. S says
Sonnet is cheaper below max `[self]`. S61 and A say "workload-dependent, not
automatically cheaper". The Reddit anecdote (S61, A) has Sonnet at $0.96 vs
Opus $4.79 on one task. My draft rates both "high" and says so in the notes.
AA's pending re-run of Sonnet 5.5 may move this.

**D2. Fable 5.1: escalation rung or dominated?** S6 cites Epoch's 2026-09-16
breakdown where Fable 5.1 led Astra on the software-engineering subset with
overlapping intervals, and Scale SWE Atlas where Fable 5.1 led on test writing.
Both predate Opus 5.5 or do not include it. S61 and A call it "an alternative
thinker when initial approaches stall" and "needs a demonstrated workload
advantage". F, O, S `[self]` say keep only as an escalation rung, on vendor
positioning plus narrow edges. Nobody found an independent aggregate where it
beats Opus 5.5. What is unresolved is whether its vendor-claimed niche
(multi-hour autonomous sessions, investigate-before-acting) is real: the only
independent hint is its lower token count and shorter time than Opus 5.5 on
the Coding Agent Index (5.7M tokens, 35 min vs 15.6M, 1.1h) for 4 fewer
points. I rate depth 4 (section 7) and flag it as the most contestable call.

**D3. Astra vs Opus 5.5 on depth.** Both lead somewhere. Astra: FrontierMath,
Erdős, ARC-AGI-3, Terminal-Bench-Science, MysteryMechanism, Scale HLE Diamond
(60.6 vs 55.0, S6). Opus 5.5: AA index by 5, AA's HLE (61.4%, with Anthropic
claiming 67.7 vs 57.2), SciCode, Epoch MirrorCode 77% vs 47% (O), Vals Index
by 4. The two HLE variants point opposite ways. Domain split: Astra for math,
science and novel mechanisms, Opus 5.5 for software and ambiguous professional
work. Both get depth 5 in the draft, with the domain in the notes. O (Anthropic)
reached the same split `[self]`, as did S61 and A (OpenAI) `[self]`, so the
split itself is cross-vendor convergent.

**D4. Sol 6.1 on execution: 4 or 5?** Its Coding Agent Index 63 at xhigh ties
Sonnet 5.5 at xhigh (63) at a third of the cost and half the time, and beats
Astra (62) and Fable 5.1 (62). DeepSWE 73% is the best of any entry. But
Terminal-Bench 4.0 is 55% against Sonnet 5.5's 64% and Opus 5.5's 65%, and its
max (60) is below the Claude pair's max (66, 68). S and O say "trails on
terminal-heavy work"; S61 and A say "strong execution evidence" `[self]`. I rate
5 because the axis definition includes "efficiently" and the cost axis is
separate, and I put the terminal gap in the notes. A lead who reads execution
as pure capability ceiling would rate 4.

**D5. Keep Opus 5?** O calls it borderline `[self]`: on Vals it is 40% cheaper
per run than Opus 5.5 for 3.3 fewer points, it was cheaper per Coding Agent
Index task at max ($10.79 vs $13.04), and Firecrawl found it faster than Fable
5.1. F, S `[self]`, S61, A, S6 say displaced. The Vals cost gap is at max
effort, and Opus 5.5 at high (54 for $1.82 on AA) is far cheaper than Opus 5 at
max (51 for $5.86), so the cost argument is an effort artefact. Dropped.

**D6. GPT-6 Luna vs GPT-5.6 Luna.** 6 Luna is half the price and tied or
ahead on AA (38 vs 37) and Vals (51.2 vs 51.7). 5.6 Luna is slightly ahead on
the Coding Agent Index (43 vs 41) and on AA's deliverable-completeness evals
(F, S61, S6 `[self]`). Not worth a row. Dropped.

**D7. Default effort for Sonnet 5.5.** The API default is high, the Claude
Code default is medium (drift report, both vendor docs). I treat the CLI
default as medium since the delegate skill drives CLIs.

Data conflicts between reports, resolved by taking the value fetched live by the
most reports: Vals Index Opus 5.5 66.97% (F, O, S61) over 69.69% (S, via a
mirror, older board version). Opus 5.5 Vals cost $32.14 over $32.77. Sonnet 5.5
AA max cost $7.60 (launch article) vs $7.67 (current page), same thing. Haiku
AA cost $0.21 vs $0.28, two snapshots. Fable 5.1 vs Fable 5 token increase:
AA 1.7x, Firecrawl 1.1 to 1.4x, The New Stack 1.7x. All agree on direction.

## 4. Cost-to-task backbone

Independent measurements only. Score / cost per task or per run. AA and
Coding Agent Index rows at max effort unless marked. Vals costs are per full run
so only ratios matter. n/a means not measured.

| model | AA index (max) | Coding Agent Index (effort) | Vals Index v2.1 | Vals Terminal-Bench 4.0 | Vals Terminal-Bench-Science |
| --- | --- | --- | --- | --- | --- |
| claude-opus-5-5 | 58 / $5.98 | 66 / $13.04 (max) | 66.97% / $32.14 | 65.15% / $13.20 | 47.14% / $19.12 |
| claude-sonnet-5-5 | 56 / $7.60 | 68 / $14.19 (max), 63 / $3.33 (xhigh), 55 / $1.24 (high) | 67.04% / $21.34 | 64.14% / $16.51 | 45.71% / $30.43 |
| claude-fable-5-1 | 53 / $7.63 | 62 / $12.39 (max) | 65.83% / $28.71 | 58.08% / $17.18 | 40.00% / $38.01 |
| claude-haiku-4-5 | 17 / $0.21 to $0.28 (thinking) | n/a | n/a | n/a (AA: 0%) | n/a |
| gpt-6-astra | 53 / $3.26 | 62 / $7.47 (max) | 63.13% / $18.46 | 59.60% / $9.58 | 62.86% / $20.80 |
| gpt-6.1-sol | 52 / $0.72 | 63 / $1.04 (xhigh), 60 / $1.55 (max), 61 / $0.70 (medium) | 61.15% / $3.24 | 55.05% / $1.72 | 52.86% / $3.44 |
| gpt-6-luna | 38 / $0.07 | 41 / $0.18 (max) | 51.22% / $0.43 | 13.64% / $0.35 | 4.29% / $0.24 |
| claude-opus-5 | 51 / $5.86 | 60 / $10.79 (max) | 63.67% / $19.31 | 53.53% / $18.60 | 27.14% / $32.54 |
| claude-opus-4-8 | 42 / $4.08 | n/a | 55.10% / $13.14 | 23.23% / $17.14 | 4.29% / $23.14 |
| claude-fable-5 | 50 / $8.75 | n/a | 61.39% / $29.59 | 41.41% / $30.34 | 15.71% / $51.99 |
| claude-sonnet-5 | 38 / $5.09 | n/a | 51.77% / $13.72 | 9.60% / $26.33 | 5.71% / $28.28 |
| gpt-6-sol | 48 / $1.04 | 57 / $2.99 (max) | 57.54% / $7.58 | 44.44% / $5.79 | 30.00% / $5.82 |
| gpt-5.6-sol | 47 / $1.99 | 55 / $6.35 (max) | 58.01% / $14.24 | 37.88% / $7.98 | 20.00% / $7.32 |
| gpt-5.6-terra | 42 / $1.40 | n/a | 53.09% / $5.78 | 22.73% / $5.60 | 10.00% / $5.19 |
| gpt-5.6-luna | 37 / $0.18 | 43 / $0.44 (max) | 51.69% / $0.82 | 11.62% / $0.73 | 0.00% / $0.58 |

Sources: AA index from F, O, S61, A, S6 (one evaluator). Coding Agent Index from
F (full table, fetched), O (partial, via mirrors). Vals Index from F, O, S61.
Terminal-Bench 4.0 from A. Terminal-Bench-Science from S61 and A. Also used:
Vals Code Migration (S61): Sonnet 5.5 69.8% / $75.83, Astra 67.7% / $44.36,
Opus 5.5 66.7% / $112.97, 6.1 Sol 65.1% / $6.51, Opus 5 57.5% / $60.51, 6 Sol
57.2% / $15.68, Fable 5 55.1% / $112.10, Fable 5.1 54.6% / $70.97, 5.6 Sol
52.9% / $24.54, Terra 47.8% / $8.13, Opus 4.8 47.3% / $30.51, 5.6 Luna 44.6% /
$1.88, Sonnet 5 44.4% / $35.31. Vals MysteryMechanism (S61): Astra 53.2% /
$1.56, Opus 5.5 49.6% / $4.62, Sonnet 5.5 49.1% / $3.45, Fable 5.1 47.8% /
$5.63, 6.1 Sol 46.4% / $0.28, 5.6 Sol 33.3%, 6 Sol 30.2%, 6 Luna 19.4%, 5.6
Luna 14.4%.

Per-effort AA rows (F, O, S, S61, A, all AA):

| effort | Opus 5.5 | Sonnet 5.5 | Fable 5.1 | Astra | 6.1 Sol | 6 Luna |
| --- | --- | --- | --- | --- | --- | --- |
| low | 42 / $0.55 | 36 / $0.41 | 47 / $2.37 | 46 / $0.82 | 42 / $0.13 | 22 / $0.005 |
| medium | 51 / $1.34 | 41 / $0.59 | 49 / $2.98 | 50 / $1.54 | 48 / $0.21 | 30 / $0.02 |
| high | 54 / $1.82 | 47 / $1.08 | 51 / $3.91 | 51 / $1.73 | 50 / $0.32 | 33 / $0.03 |
| xhigh | 56 / $3.46 | 52 / $2.74 | 53 / $5.98 | 52 / $2.31 | 51 / $0.39 | 35 / $0.04 |
| max | 58 / $5.98 | 56 / $7.60 | 53 / $7.63 | 53 / $3.26 | 52 / $0.72 | 38 / $0.07 |

Fable 5.1 per-effort rows come from O only (one fetch), the others from two or
more reports.

## 5. Per-model evidence

### claude-opus-5-5 (Anthropic, $4/$20, cache read $0.20)

- Leads AA (58), Epoch ECI (167.35), Vals Terminal-Bench 2.1 and 4.0,
  ProofBench, MedScribe. Vals Index rank 3 within noise of rank 2. [F, O
  `[self]`, S61, A, S6]
- Software: Epoch MirrorCode 77% vs Astra 47%. Coding Agent Index 66. Vals Code
  Migration 66.7%, third. [O `[self]`, S61]
- Weak spots: Harvey legal agent 3.75% (F `[self]`). Terminal-Bench-Science
  47% vs Astra 63% (S61, A).
- Token use: 119k output per AA task, 1.6x Opus 5, 4.4x Astra. Cost per task
  level with Opus 5 despite the 20% price cut. Coding Agent Index 15.6M tokens
  and 1.1 hours per task. [F, O, S, S61, A, S6, all AA]
- Effort: API default medium. High (54 / $1.82) and medium (51 / $1.34) are
  the sweet spots. Max fails outright on occasion (Willison, F and O) and runs
  long (Every.to, O). Anthropic warns against carrying a high setting over
  from Opus 5 (F `[self]`).
- Hands-on: Every.to "about 90% as capable as Fable at coding", pulling Codex
  users back (O `[self]`). A 12-task comparison had Opus winning 7 of 12 on
  quality but Astra finishing one task in 32 min for $11 vs 40 min for $18 (F
  `[self]`). CodeRabbit review eval 8 of 13 issues at 66.7% precision vs Sonnet
  5.5 6 of 13 at 41.2% (S `[self]`). Cursor recommends high thinking (S61).
- Vendor claims not independently confirmed: Terminal-Bench 4.0 66.4%,
  SWE-bench Pro 89.9%, "beats Astra at 20% of the cost" on FrontierCode at
  medium.

### claude-sonnet-5-5 (Anthropic, $2/$10, cache read $0.20)

- AA 56 (rank 2). Vals Index 67.04% (rank 2, effectively tied with Opus 5.5).
  Vals rank 1 on Vibe Code Bench (92.4%), Code Migration (69.8%),
  BioMysteryBench. Beats Astra on 14 of 19 shared Vals boards. Epoch ECI 165
  from 11 evals. [F, O, S `[self]`, S61, A]
- Terminal: AA Terminal-Bench 4.0 64% (above Opus 5.5 and Astra at ~60%). Vals
  64.1%. Coding Agent Index 68 at max (highest entry), 63 at xhigh. [F, O, S61,
  A]
- Depth gap to Opus 5.5: factual knowledge 54% vs 66%, HLE and SciCode about 6
  points lower, CodeRabbit review depth lower. Anthropic itself says Opus 5.5
  is clearly stronger on complex open-ended work. [O, S `[self]`]
- Token appetite: 193k output per AA task at max, the most AA has measured,
  seven times Astra. 27.7M tokens and 1.5 hours per Coding Agent Index task at
  max. 18x cost spread across effort ($0.41 to $7.60). AA says it is off the
  cost frontier at max. [F, O, S, S61, A, S6]
- Faster per token than anything else frontier (139 t/s vs 61 for 6.1 Sol per
  S, 95 to 130 t/s per O) but long runs.
- Effort: API default high, Claude Code default medium (drift report). Anthropic
  recommends medium for specified coding, high for harder work, and found max
  below xhigh on FrontierCode (S61). Lowest thinking setting is
  `between_tools`, not off (F).
- Hands-on: Reddit Three.js task $0.96 and 10.8 min vs Opus 5.5 $4.79 and 22.7
  min (S61, A, low weight). Dreasays: "brilliant, confusing, very hungry" (O,
  S).

### claude-fable-5-1 (Anthropic, $10/$50, cache read $0.25)

- Aggregates: AA 53 (tied Astra, 5 behind Opus 5.5). Vals Index 65.83% rank 4.
  Epoch ECI 165 from 20 evals. [F `[self]`, O, S, S61, A]
- Depth boards: FrontierMath T4 88% (vs 95, 98). HLE Diamond 51.3% (Scale, S6).
  AA HLE 59.1% vs Opus 5.5 61.4%. Terminal-Bench-Science 40%. MysteryMechanism
  47.8%. Vals rank 1 on LiveCodeBench, MMLU Pro, MMMU Pro, rank 3 ProofBench.
  SimpleQA 24 points above Sonnet 5.5. [F `[self]`, O, S6, S61]
- Execution: Coding Agent Index 62 at $12.39, 5.7M tokens, 35 min (fewer tokens
  and less time than Opus 5.5 or Sonnet 5.5 at max). Vals Terminal-Bench 4.0
  58.1%, Terminal-Bench 2.1 85%, Code Migration 54.6% (below Fable 5's 55.1%).
  Endor Labs: Claude Code plus Fable 5.1 9.5 min per task vs Astra in Codex
  16.8 min with 29 timeouts, near pass-rate parity (O). [F `[self]`, O, S61, A]
- Cost: most expensive per AA task ($7.63) and per Terminal-Bench-Science task
  ($38). 1.7x Fable 5's output tokens (AA), 1.1 to 1.4x (Firecrawl, 57 runs),
  so the cache-read cut only partly offsets. Vendor claims 25% savings on
  typical workloads, up to 45% on highly agentic ones, from its own August
  sample. [F `[self]`, O, S, S61, A]
- Latency: AA time to first token 259 s, 66 t/s. CodeRabbit 18.6 min per
  review, 49% slower than Fable 5, and low effort beat high on recall (F
  `[self]`, weak source).
- Epoch 2026-09-16 (pre Opus 5.5): Astra 166, Fable 5.1 164, software subset
  favoured Fable 5.1, overlapping intervals (S6). Zvi roundup: strong on hard
  agentic coding and long jobs, 3x token burn complaints (S).
- Vendor positioning: escalation when Opus 5.5 at higher effort falls short.
  The S report `[self-vendor]` also relays that Anthropic points to Fable 5.1
  for security research because Opus 5.5 reroutes cyber work. That is a
  substitution topic and is excluded by user decision.

### claude-haiku-4-5 (Anthropic, $1/$5, cache read $0.10, 200K context)

- AA 17 (thinking config), $0.21 to $0.28 per task, 0% Terminal-Bench 4.0, 3%
  AutomationBench. Not on Vals or the Coding Agent Index. [F, O, S, S61, A, S6,
  one AA page plus blogs citing it]
- Three to four times GPT-6 Luna's cost per AA task for roughly half the score,
  while using about a third of Luna's tokens. [F, O, S]
- No effort parameter (extended thinking only). Knowledge cutoff early 2025.
- All six reports: keep only inside a Claude-only pipeline.

### gpt-6-astra (OpenAI, $10/$50, cache read $1.00)

- Depth: FrontierMath T4 98%, Tiers 1 to 3 94/91/90. Only model solving any
  open Erdős problems (2 official, 5 with retries, at over $220k). ARC-AGI-3
  62.7% standard harness, 98.6 to 99.9% in a provider-adapted harness, with
  higher effort reducing total suite cost. Terminal-Bench-Science 62.9%
  (best by 10 points). MysteryMechanism 53.2% (best). HLE Diamond 60.6% (Scale,
  best). [O, S61 `[self]`, A `[self]`, S6 `[self]`]
- Aggregates: AA 53, five behind Opus 5.5. Vals Index 63.13% rank 6. Epoch ECI
  166.51, second by a hair. Epoch MirrorCode 47% vs Opus 5.5 77%. GDPval-AA
  dropped ~45 Elo vs GPT-5.6 Sol, attributed to fewer turns. [F, O, S, S61, A]
- Execution: Coding Agent Index 62 at $7.47, 29 min, 3.3M tokens. Vals
  Terminal-Bench 4.0 59.6%, Code Migration 67.7% (second). Endor Labs: slower
  than Fable 5.1 in Claude Code with timeouts, better on hard cross-file bugs
  (57.1% vs 47.6% vs 5.6 Sol). Practitioners: overthinks small tasks, more
  "obedient", asks clarifying questions. [F, O, S, A `[self]`]
- Tokens and time: 27k output per AA task, a quarter of Opus 5.5's. Vals run 28
  minutes, fastest frontier model. All five effort levels on AA's frontier at
  launch. [F, O, S, S61, A]
- Effort: medium default, no `none`. OpenAI guidance: medium for agentic coding
  and research, high for complex debugging, xhigh only when evals show gain
  (F). Codex may cap it at xhigh (drift report).
- Vendor claims not independently confirmed: ARC-AGI-3 98.6% (that is the
  adapted harness), OSWorld 72.6%, DeepSWE 74.1%, "best model for software
  engineering to date".

### gpt-6.1-sol (OpenAI, $2/$10, cache read $0.10)

- AA 52 at max, one below Astra. Per effort 42/48/50/51/52 at $0.13/$0.21/
  $0.32/$0.39/$0.72. Vals Index 61.15% at $3.24 per run. [F, O, S, S61 `[self]`,
  A `[self]`, S6 `[self]`]
- Execution: Coding Agent Index 63 at xhigh ($1.04, 15.5 min, 3.2M tokens),
  60 at max, 61 at medium ($0.70). DeepSWE 73% (best entry). Terminal-Bench 4.0
  55% (AA and Vals), behind the Claude 5.5 pair. Code Migration 65.1% at $6.51
  (vs $76 to $113 for the Claude pair). Terminal-Bench-Science 52.9% at $3.44
  (second). MysteryMechanism 46.4% at $0.28. [F, O, S61, A]
- Cognition FrontierCode: 50.2% at $0.36 vs Opus 5.5 54.6% at $0.80
  (second-hand, F). DataCamp single-task: more careful than Sonnet 5.5, slower,
  refused a bad-input case Sonnet completed (S).
- Downsides: slow at high effort (AA 569 s per task at max, S), 10 to 30% more
  output tokens than GPT-6 Sol (F, S61), hallucination rate still high on
  AA-Omniscience (S), rollout lag reports (F). Chat Completions cannot call
  tools on it (F). No `none` effort.
- Community: HN read it as "half the price of Opus 5.5" and as fixing GPT-6
  Sol's regression. Nobody has independently confirmed the GDPval regression is
  fixed (F).
- Five days old. Everything above is AA, Vals and launch-week anecdotes.

### gpt-6-luna (OpenAI, $0.10/$0.50, cache read $0.01)

- AA 37 to 38 at $0.07, 141 t/s. Vals Index 51.22% at $0.43. Coding Agent
  Index 41 at $0.18, DeepSWE 64%, Terminal-Bench 4.0 13.6 to 15%. Terminal-
  Bench-Science 4.3%. [F, O, S, S61 `[self]`, A `[self]`, S6 `[self]`]
- Regressions vs 5.6 Luna: GDPval -75 Elo, Briefcase -45 ("omits rubric
  elements"), Coding Agent Index 41 vs 43, SWE-Atlas 44 vs 49. Verbose at max
  (140M tokens on the index). [F, S, S61]
- Reviewer: "15% on Terminal-Bench is not a model you let near a shell
  unsupervised" (F). Unusable at low for agentic work (S, one report).
- Replacement target for gpt-5.4-nano. 1.05M context.

### Dropped candidates

- **claude-opus-5** ($5/$25). AA 51 / $5.86, Coding Agent Index 60 / $10.79,
  Vals 63.67% / $19.31, Terminal-Bench 4.0 53.5%, Code Migration 57.5%,
  Terminal-Bench-Science 27%. Opus 5.5 beats it on every Anthropic row and
  every independent board except Toolathlon (73.1 vs 72.2, F). Only reasons to
  pick: thinking can be disabled, and it is a safeguard fallback target (O, S,
  excluded topic). [F, O, S `[self]`, S61, A, S6]
- **claude-opus-4-8** ($5/$25). AA 42 / $4.08 with 170M tokens, Vals 55.1%,
  Terminal-Bench 4.0 23%, Code Migration 47%, Terminal-Bench-Science 4.3%. One
  August source liked its tau-bench policy adherence (F). It is the cyber
  reroute target (O, S, excluded). [all six]
- **claude-fable-5** ($10/$50, cache read $1.00). AA 50 / $8.75, Vals 61.4%,
  Terminal-Bench 4.0 41%, Code Migration 55.1% (ties 5.1), Terminal-Bench-
  Science 15.7% / $52. No per-message effort. [all six]
- **claude-sonnet-5** ($2/$10). AA 38 / $5.09 with 370M tokens, Vals 51.8%,
  Terminal-Bench 4.0 9.6%, Code Migration 44%. [all six]
- **gpt-6-sol** ($2/$10, cache read $0.20). AA 48 / $1.04, Coding Agent Index
  57 / $2.99, Vals 57.5%, Terminal-Bench 4.0 44%, Code Migration 57%,
  MysteryMechanism 30%. Regressed vs 5.6 Sol on knowledge work (GDPval ~100
  Elo); HN called it "a huge regression". Superseded after seven days. Only
  edge: supports effort `none`. A `[self]` says "do not make 6.1 the default
  merely because newer" but cites no board where 6 Sol wins except time per
  task at high. [all six]
- **gpt-5.6-sol** ($4/$20 promotional through at least 2026-11-21, list
  $5/$30). AA 47 / $1.99, Coding Agent Index 55 / $6.35 with 10.2M tokens,
  Vals 58.0%, Terminal-Bench 4.0 37.9%, Code Migration 52.9%. Was the
  Terminal-Bench 2.1 leader at launch. 6.1 Sol beats it everywhere at a third
  of the cost. S61 `[self]` and A `[self]` say retain for "validated
  task-specific strengths", naming none. [all six]
- **gpt-5.6-terra** ($2/$12). AA 42 / $1.40, Vals 53.1%, Terminal-Bench 4.0
  22.7%, Code Migration 47.8%. "Never on the Pareto frontier" (July community
  analysis, F). No GPT-6 Terra exists. Dominated by 6.1 Sol at high (50 /
  $0.32). A `[self]`: "needs reevaluation". [all six]
- **gpt-5.6-luna** ($0.20/$1.20). AA 37 / $0.18, Vals 51.7% / $0.82, Coding
  Agent Index 43 / $0.44, Terminal-Bench 4.0 11.6%. Marginally better than 6
  Luna on deliverable completeness and small coding, at twice the cost. S61
  `[self]` and S6 `[self]` would keep it as a coding fallback. [all six]

Not candidates (drift report, confirmed by all reports): gpt-5.5 (leaves Codex
2026-10-14), claude-mythos-5-1 and -5 (invite only), gpt-5.6-cyber, the
daybreak models, gpt-rosalind-research (restricted). GPT-6.1 Astra was
reportedly cancelled and never shipped (O, S, F, second-hand press).

## 6. Roster decision

Seven rows: claude-opus-5-5, claude-sonnet-5-5, claude-fable-5-1,
claude-haiku-4-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna.

Eight dropped, each beaten on both quality and cost-to-task by a listed model
from the same vendor (section 5, "Dropped candidates"). The only non-dominance
reasons to pick any of them are pinning, effort `none`, thinking off, or the
safeguard fallback routing. None of those is a delegation-time capability
reason, and the last is excluded by user decision.

Haiku 4.5 stays despite being dominated cross-vendor by GPT-6 Luna, because the
table is organised per tool and a Claude-only pipeline needs a cheap tier. Its
note says Luna does more for less. O and S suggest cutting the table to seven
or eight rows, F suggests a legacy list with one reason each. I went with a
single "not listed" note rather than a legacy section, since every reason to
pick a legacy model is either a non-capability reason or excluded.

## 7. Ratings and every change from the current file

Scale: depth and execution 1 to 5, relative across the table. Cost-to-task in
words, relative, at the effort named in the row's notes.

| row | axis | current | draft | reason |
| --- | --- | --- | --- | --- |
| claude-opus-5-5 | depth | (new) | 5 | C2, D3. Leads AA, Epoch, Vals Terminal-Bench, MirrorCode. `[self-vendor]` |
| claude-opus-5-5 | execution | (new) | 5 | Coding Agent Index 66, Vals Terminal-Bench 4.0 65% (best), Code Migration 67%. Slow and token-heavy, which the cost axis carries |
| claude-opus-5-5 | cost | (new) | high | $5.98 AA max, $13 per coding task, $32 Vals, 5 to 15x Sol. Cheaper than Astra on AA at matched effort, dearer on agentic boards |
| claude-sonnet-5-5 | depth | (new) | 4 | AA 56, Vals 67% (tied Opus) but 6 points behind on HLE/SciCode, weaker review depth, vendor says Opus clearly stronger open-ended. `[self-vendor]` |
| claude-sonnet-5-5 | execution | (new) | 5 | Best Terminal-Bench 4.0 (64%), Coding Agent Index 68 max / 63 xhigh, Code Migration 69.8% best, Vibe Code 92% |
| claude-sonnet-5-5 | cost | (new) | high, see notes | D1. Parity with Opus 5.5 across six workloads, three each way. Above Opus at max (193k tokens). Rated at high/xhigh |
| claude-fable-5-1 | depth | (new) | 4 | C3, D2. Below Opus 5.5 on every aggregate and domain board, tied with Sonnet 5.5 on Epoch, below it on AA and Vals. Edges on knowledge recall and competitive coding. **`[self]`, most contestable call: the case for 5 is AA parity with Astra (53), Vals rank 1 on three boards, Epoch's pre-Opus-5.5 software lead, and vendor positioning** |
| claude-fable-5-1 | execution | (new) | 4 | Coding Agent Index 62 (equal Astra), Terminal-Bench 4.0 58%, Code Migration 54.6% (below Fable 5). Fewer tokens and faster than Opus 5.5 on the coding index, slower to first token. `[self]` |
| claude-fable-5-1 | cost | (new) | highest | Most expensive per AA task ($7.63) and Terminal-Bench-Science task ($38). Only Opus 5.5 at max exceeds it on Vals Index and the coding index, by small margins |
| claude-haiku-4-5 | depth | 1 | 1 | AA 17, lowest in the table |
| claude-haiku-4-5 | execution | 2 | 1 | 0% Terminal-Bench 4.0 (AA), no agentic board entry. The old 2 sat against Luna 5.6 at 3; the top of the table moved up and Luna 6 (Coding Agent Index 41) is now the 2 |
| claude-haiku-4-5 | cost | low | low | $0.21 to $0.28 per AA task, three to four times Luna 6 |
| gpt-6-astra | depth | (new) | 5 | C5, D3. FrontierMath, Erdős, ARC-AGI-3, Terminal-Bench-Science and MysteryMechanism leads. Below Opus 5.5 on AA by 5 and Vals by 4 |
| gpt-6-astra | execution | (new) | 4 | Coding Agent Index 62, Terminal-Bench 4.0 59.6%, Code Migration 67.7%. Behind the Claude pair on terminal work, timeouts and overthinking reported in Codex |
| gpt-6-astra | cost | (new) | medium-high | $3.26 AA max (half Opus 5.5), $7.47 per coding task, $18 Vals (0.6x Opus), $9.58 Terminal-Bench 4.0. 27k tokens per task. Still 4 to 7x Sol |
| gpt-6.1-sol | depth | (new) | 4 | AA 52 (one below Astra), Vals 61%, Terminal-Bench-Science 52.9% second, MysteryMechanism near Fable 5.1. Cross-vendor convergent |
| gpt-6.1-sol | execution | (new) | 5 | D4. Coding Agent Index 63 at xhigh ties Sonnet xhigh, beats Astra and Fable, DeepSWE 73% best, fastest and cheapest. Terminal-Bench 4.0 55% is the gap, in the notes |
| gpt-6.1-sol | cost | (new) | low | C1. $0.39 to $0.72 per AA task, $1.04 per coding task, $3.24 Vals, $1.72 Terminal-Bench 4.0. 5 to 15x under the Claude flagships |
| gpt-6-luna | depth | (new) | 2 | AA 38, Vals 51%. Twice Haiku, two-thirds of Sol 6.1 |
| gpt-6-luna | execution | (new) | 2 | Coding Agent Index 41, DeepSWE 64%, Terminal-Bench 4.0 14%. Fine for small verified edits, not loops |
| gpt-6-luna | cost | (new) | lowest | $0.07 AA, $0.18 coding, $0.43 Vals |
| claude-opus-5 | all | 5 / 4 / high | dropped | D5. Dominated by Opus 5.5 at lower price and lower effort |
| claude-opus-4-8 | all | 4 / 4 / high | dropped | AA 42, Terminal-Bench 4.0 23%. Superseded twice |
| claude-fable-5 | all | 5 / 3 / highest | dropped | Same price as 5.1, lower on every board, dearer per AA task |
| claude-sonnet-5 | all | 3 / 4 / high | dropped | Same price as 5.5, AA 38 vs 56, Terminal-Bench 4.0 10% vs 64% |
| gpt-5.6-sol | all | 4 / 5 / medium | dropped | 6.1 Sol: same role, half the price, higher on every board, a third of the task cost |
| gpt-5.6-terra | all | 3 / 3 / low-medium | dropped | Dominated by 6.1 Sol at high (50 / $0.32 vs 42 / $1.40) |
| gpt-5.6-luna | all | 2 / 3 / lowest | dropped | D6. 6 Luna: half the price, tied on AA and Vals |
| gpt-6-sol | all | (candidate) | not added | Superseded by 6.1 Sol after seven days at the same price |

Structural changes to the file: fidelity column and its two notes removed (user
decision, not mine to justify). Title em-dash replaced with a colon. Intro
rewritten for three axes, plus one sentence saying ratings assume the effort in
the notes (every report asked for this). Notes section rewritten: the effort
note is kept and strengthened with defaults, the cost-to-task note is kept with
new examples, and three notes added (sticker prices for reference, wall clock,
long-context billing, not-listed line). The gaming and Fable substitution notes
are gone (user decision).

## 8. Excluded by user decision, deliberately left out of the draft

- Safeguard rerouting: Opus 5.5 and Sonnet 5.5 hand most cyber requests to
  Opus 4.8 and bio-adjacent requests to Opus 5, and the raw API can return
  empty content (O, S, F; also Vals measured 2.1% fallback on Fable 5.1 with
  74% of SRE Bench tasks fallback-assisted). Substitution topic, excluded.
- Haiku 4.5's retirement floor of 2026-10-15 and the announced but unshipped
  Haiku 5.5. Availability topic, excluded from the file. Watch item below.
- GPT-5.6 Sol's promotional price expiry. Irrelevant once the row is dropped.
- Codex-side effort oddities (ultra is orchestration, Astra possibly capped at
  xhigh in Codex, a 272K default context for 6.1 Sol in the Codex cache). These
  are tools.md material for phase 6, not models.md.

## 9. For the lead

Contestable calls, in order of how much I would expect the other synthesizer
to differ:

1. **Fable 5.1 depth 4** (self-judgment, D2). If the other draft says 5, the
   evidence for 5 is listed in section 7. I would hold at 4 on the independent
   aggregates alone.
2. **6.1 Sol execution 5** (D4). A reading of execution as ceiling rather than
   efficient completion gives 4.
3. **Sonnet 5.5 cost "high"** (D1). "medium-high" is defensible if the lead
   weights Vals Index and Code Migration over AA and the terminal boards.
4. **Astra cost "medium-high"**. "medium" if weighting AA, "high" if weighting
   the coding index.
5. **Dropping Opus 5** (D5). O wanted it borderline.

Structural suggestions from the reports that I did not take, for the lead to
weigh: a dedicated "sweet-spot effort" column (F, O, S6; I put effort in the
notes to keep the structure), a wall-clock band column (O), a decision guide by
task archetype ahead of the table (all six; the SKILL.md may already carry
this), and a cost-to-task table with named benchmarks (F; it would churn weekly
and belongs in the case, where section 4 of this file now is).

Watch items for the next refresh: Haiku 5.5 (announced 2026-09-22, "coming
weeks"), AA's re-run of Sonnet 5.5 after the structured-output fix, GPT-6.1 Sol
Ultrafast, whether 6.1 Sol's GDPval regression is fixed, independent ARC-AGI-3
scores for Opus 5.5 and Fable 5.1, and any Terminal-Bench 4.0 entry for Haiku.
