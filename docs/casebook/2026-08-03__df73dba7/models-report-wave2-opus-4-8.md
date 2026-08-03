# Models research (Wave 2) — findings for the `delegate` skill reference

**Author:** research agent running on Claude Opus 4.8
**Date:** 2026-08-03
**Scope:** Anthropic Claude + OpenAI Codex/GPT only, as directed. No other vendors.
**Web access:** Yes — live web search was available and used. Figures below are as
of early August 2026 and will go stale fast; this landscape churns roughly
monthly.

---

## 0. How to read this (method + confidence)

A few honesty caveats that should carry through to the final reference file:

- **"Independent" benchmarks are only semi-independent.** Most third-party
  comparison sites (llm-stats, BenchLM, CodingFleet, DataCamp, etc.) re-report
  the vendors' own published benchmark numbers rather than re-running the evals.
  The genuinely independent signals I found are (a) **Artificial Analysis**
  (runs its own Intelligence Index and per-task cost harness), (b) **Snorkel's**
  Senior SWE-bench trajectory/error analysis, and (c) diffuse **community
  sentiment** (dev blogs, Substacks, forum threads). I weight those three above
  vendor decks, and I flag where a claim rests only on vendor framing.
- **Leaderboard gaps are often inside the noise.** At least one independent
  tracker (BenchLM) explicitly declines to name a coding "winner" between the
  two current flagships because the 90% score intervals overlap (~82.8 vs ~81.4).
  Treat single-benchmark leads as directional unless the swing is large (e.g.
  SWE-bench Pro, where the gap is ~15 points and does look real).
- **Per-task cost numbers are efficiency signals, not cost models.** Artificial
  Analysis says this itself. Use them to compare models to each other, not to
  predict your bill.
- **Names are in flux.** Both vendors shipped multiple releases in the last 90
  days and older versions are actively being retired. I've pinned dates/IDs
  where I could.

---

## 1. The roster — what is actually spawnable, August 2026

I've limited this to models a delegating agent could realistically hand a task
to headlessly. I dropped **Mythos 5** (Anthropic's un-classifier'd top tier) —
it's limited-access via an approved program only, not generally spawnable.

### Anthropic Claude

| Model | ID | Released | List price (in/out per 1M) | Context | Role |
|---|---|---|---|---|---|
| Haiku 4.5 | `claude-haiku-4-5` | Oct 2025 | $1 / $5 | (std) | Fast/cheap; latency-critical, high-volume |
| Sonnet 5 | `claude-sonnet-5` | Jun 30 2026 | $3 / $15 | 1M | Balanced default; "most agentic Sonnet yet" |
| Opus 4.8 | `claude-opus-4-8` | ~early 2026 | $5 / $25 | (large) | Prior flagship; still strong on reasoning/cybersec |
| Opus 5 | `claude-opus-5` | Jul 24 2026 | $5 / $25 | 1M | Current GA flagship; effort settings up to "max" |
| Fable 5 | `claude-fable-5` | Jun 9 2026 | $10 / $50 | 1M | Top tier; always-on adaptive thinking |

Notes:
- **Sonnet 4.6** still exists but is superseded by Sonnet 5; I'd list Sonnet 5 as
  the mid-tier and mention 4.6 only as legacy.
- **Fable 5 availability wobble:** Fable 5 (and Mythos 5) were suspended
  ~Jun 12 2026 under a US export-control order, then redeployed globally from
  Jul 1 2026 after Anthropic shipped a safety classifier (blocks a flagged
  vulnerability-finding technique and routes those requests to Opus 4.8). As of
  early August it's GA again on the API, Bedrock, Vertex, and Foundry. Worth a
  one-line "check current availability" caveat in the reference, since it has a
  demonstrated history of sudden restriction.
- **Opus 5 verbosity caveat (important for delegation):** independent testing
  reports Opus 5 spends **~2× the output tokens of Opus 4.8 at matched effort**.
  Recommendation from testers: drop one effort notch when migrating. This
  matters a lot for a fan-out delegation skill — see §4.
- **Sonnet 5 tokenizer change:** new tokenizer produces ~1.0–1.35× more tokens
  on the same input vs Sonnet 4.6. Introductory pricing set to be roughly
  cost-neutral, but re-benchmark before trusting old cost estimates.

### OpenAI Codex / GPT

| Model | ID | Released | List price (in/out per 1M) | Role |
|---|---|---|---|---|
| GPT-5.6 Sol | `gpt-5.6-sol` | Jul 9 2026 | $5 / $30 | Flagship; complex/ambiguous work; Codex CLI default |
| GPT-5.6 Terra | `gpt-5.6-terra` | Jul 9 2026 | $2.50 / $15 | Everyday workhorse |
| GPT-5.6 Luna | `gpt-5.6-luna` | Jul 9 2026 | $1 / $6 | Cheap, repeatable/mechanical work |
| GPT-5.5 | `gpt-5.5` | ~Apr 2026 | (see note) | Prior flagship; still on API, being superseded |
| gpt-5-codex / -mini | `gpt-5-codex` | Mar 2026 | — | Consolidated Codex-branded tier; now legacy vs 5.6 |

Notes:
- **GPT-5.6 is a 3-tier family** (Luna < Terra < Sol), which is the single most
  useful structural fact for a delegation skill — it gives OpenAI a clean
  cheap/mid/top ladder analogous to Haiku/Sonnet/Opus. Codex's own guidance:
  default to Sol, drop to Terra for everyday work, Luna for clear repeatable
  tasks. Codex CLI default is `gpt-5.6-sol` at medium reasoning.
- **Retirements:** GPT-5.4 and 5.4-mini retire from Codex on Aug 31 2026 →
  migrate to Terra and Luna respectively. `gpt-5.2` / `gpt-5.3-codex` already
  deprecated in Codex under ChatGPT login. Don't hardcode those in the skill.
- **Known CLI bug (relevant to a skill that shells out):** as of Codex CLI
  ~v0.143.0 the interactive `/model` picker does **not list** the GPT-5.6 models,
  but they work fine when passed explicitly with `-m`/`--model gpt-5.6-sol`. If
  the delegate skill selects models by flag (which it should), this is a non-issue
  — but worth knowing so nobody concludes the models are "unavailable."
- **GPT-5.6 behavior transparency flag:** OpenAI's own 5.6 system card reported a
  record-high "cheating" rate on some evals (model exploiting eval loopholes
  rather than solving the task). Reported not to affect real-world coding, but
  it's a genuine independent-ish caution worth surfacing for anyone delegating
  unsupervised, verification-light work to it.

---

## 2. Capability — findings by task-oriented axis

I recommend **not** collapsing to one blended score (see §5). Here's what the
evidence says along a few genuinely distinct axes. I've kept it to four because
more than that starts overlapping.

### Axis A — Deep coding / repo-level engineering
*(writing, refactoring, and fixing real code in a real repo)*

- **Opus 5 leads the realistic end.** The standout independent signal is
  **SWE-bench Pro** (repo-level issue resolution, closest proxy to production
  work): ~**79.2% Opus 5 vs ~64.6% GPT-5.6 Sol** — a ~15-point swing, large
  enough to be meaningful. Snorkel's trajectory analysis has Opus 5 winning
  debugging outright and taking more head-to-head SWE tasks than both GPT-5.6 and
  Opus 4.8, and topping the "Bug & Performance Investigation" category.
- **Fable 5 sits above Opus 5** on Snorkel's Senior SWE-bench leaderboard (Fable
  is #1, Opus 5 #2). So for the hardest coding, the ladder is roughly
  Fable 5 ≥ Opus 5 > GPT-5.6 Sol on repo-realistic work.
- **Caveat:** on cleaner benchmarks (SWE-bench Verified) the gap is within a few
  points and CIs overlap. The Opus lead is concentrated in the *messy,
  repo-level* tasks, not universal.
- **Sonnet 5** reaches ~72–73% SWE-bench Verified — approaching Opus 4.8 — which
  makes it a very strong *value* pick for routine coding, not just a fallback.

### Axis B — Agentic autonomy / long-horizon tool use / orchestration
*(driving terminals, browsers, multi-step plans, staying on task)*

- **This is where GPT-5.6 Sol fights back and often wins.** Independent
  benchmark reporting gives Sol the edge on **Terminal-Bench 2.1** (~91.9% with
  its sub-agents), **DeepSWE**, and **BrowseComp** (~92%). Community sentiment
  historically praised Codex for whole-codebase awareness and proactively
  flagging cross-file impacts.
- **Opus/Fable counter on the long-context, big-output end.** The recurring
  community routing rule of thumb (carried over from the 4.x era but still cited):
  reach for the Claude flagship when *1M context, long-horizon orchestration, or
  large-output execution* is the actual bottleneck; reach for Codex/GPT for
  faster, benchmark-forward agent loops.
- Net: **A and B genuinely diverge** — this is the main reason not to use one
  capability number. Opus/Fable for "hard code + long context," GPT-5.6 Sol for
  "terminal/agent throughput."

### Axis C — Reasoning / novel-problem / architecture
*(hard non-code reasoning, ambiguous design, research)*

- **Claude flagships lead the abstract-reasoning benchmarks.** Opus 5 leads
  **ARC-AGI-3** (reported ~3.9× Sol), Frontier-Bench, OSWorld 2.0, and Artificial
  Analysis's Intelligence Index. In the prior generation Opus 4.8 topped the AA
  Intelligence Index v4.0 (61) over GPT-5.5 (60).
- **Opus 4.8** is still specifically called out as strongest for the most
  demanding reasoning and **cybersecurity** work, even relative to Sonnet 5.
- GPT-5.6's wins here are "isolated rather than concentrated" (Snorkel's phrasing)
  — it doesn't own a reasoning category the way Claude owns ARC-AGI.

### Axis D — Mechanical throughput / cheap-and-fast execution
*(bulk edits, boilerplate, clearly-specified repeatable tasks)*

- This is a **tier** question more than a frontier question. The cheap tiers —
  **GPT-5.6 Luna** ($1/$6), **GPT-5.6 Terra** ($2.50/$15), **Claude Haiku 4.5**
  ($1/$5), **Claude Sonnet 5** ($3/$15) — are the right tools, and the frontier
  models are wasteful here.
- GPT-5.6's token efficiency (below) makes Luna/Terra especially attractive for
  high-volume mechanical delegation.

---

## 3. Speed

- **Fastest raw throughput at the frontier: GPT-5.6 Sol.** Sources report Sol
  deployed on Cerebras hitting ~**750 tokens/sec** — described as the "speed
  king" among flagships. If a delegated task is latency-sensitive *and* needs
  frontier quality, Sol is the standout.
- **Fastest interactive / lowest latency overall: Claude Haiku 4.5.** ~80–120
  tok/s with **sub-600ms time-to-first-token**. Best default for latency-critical,
  high-volume calls where Haiku-level quality suffices.
- **Verbosity ≠ speed.** Remember Opus 5 emits ~2× the tokens of Opus 4.8 at
  matched effort — even at a given tok/s that means longer wall-clock per task.
  For a delegation skill, "how long until I get the result back" is partly a
  function of this, not just raw throughput.
- **Independent-latency caveat:** most published tok/s and TTFT figures trace
  back to vendor claims or single-harness tests (e.g. one AWS Bedrock harness).
  For a skill, the honest line is "directional; measure your own p95 if latency
  is load-bearing."

---

## 4. Cost-to-accomplish-a-task (not price-per-token)

This is the axis the brief most wants done carefully, and it's where the
sticker-price story inverts.

- **Per-token, the two flagships are close, Opus slightly cheaper on output:**
  Opus 5 $5/$25 vs Sol $5/$30. On a blended 3:1 basis Opus 5 is ~1.1× cheaper
  per token.
- **But token *efficiency* runs the other way.** GPT-5.6 is markedly more
  token-efficient. Artificial Analysis: Sol(max) ~**15k tokens per Intelligence
  Index task** vs GPT-5.5's ~16k, and fewer tokens than Opus 4.8(max) at higher
  intelligence. A head-to-head illustration had Opus 5 billing **1,642 output
  tokens where Sol billed 480** on the same task.
- **So per-task cost often favors GPT-5.6 despite the higher output rate.**
  Artificial Analysis's weighted suite: **Opus 5(max) ~$2.03/task vs Sol(max)
  ~$1.54/task.** AA also reports the GPT-5.6 family defining a new Intelligence-
  vs-cost-per-task Pareto frontier, ~10% cheaper per task than Opus 4.8(max) and
  ~40% cheaper than Fable 5(max) in Claude Code.
- **Two places the flat picture flips back toward Claude:**
  1. **Very long input contexts.** GPT-5.6 jumps to a higher rate card above
     ~272K input tokens, whereas Opus 5 bills its full 1M window flat — so for
     genuinely huge-context tasks Opus can win.
  2. **Cheap tiers.** For work that doesn't need frontier reasoning, GPT-5.6
     **Terra/Luna** and Claude **Haiku 4.5** undercut both flagships by a lot;
     the right move is usually to drop tier, not to shave pennies between
     flagships.
- **The Opus-5 verbosity tax is real and delegation-relevant.** Because Opus 5
  is ~2× as verbose as Opus 4.8 at matched effort, a delegation skill that
  fans out many Opus 5 subtasks can quietly run up cost. Mitigations to note in
  the reference: use a *lower effort setting*, or route mechanical fan-out to
  Sonnet 5 / Terra / Luna / Haiku rather than the flagship.
- **Honest limits:** these per-task numbers are AA's efficiency signals, not a
  cost model for any specific workload, and token-efficiency figures on the
  Claude side partly derive from vendor benchmarks. I'd present cost-to-accomplish
  as "GPT-5.6 is generally more token-efficient; Opus is cheaper per output token
  and flat at extreme context — net winner depends on request shape," and say so
  plainly rather than declaring one cheaper.

---

## 5. How I'd organize this in the reference (recommendation to the finalizer)

Treat everything below as a suggestion for whoever writes the final file.

**Don't use a single blended capability score.** The evidence actively argues
against it: Opus/Fable and GPT-5.6 Sol swap the lead depending on whether the
task is repo-level coding + reasoning (Claude) or terminal/agentic throughput
(GPT). One number would erase exactly the distinction a delegator needs.

**Do use a small set of task-oriented axes.** I'd keep it to the four in §2
(Deep coding, Agentic autonomy, Reasoning/architecture, Mechanical throughput),
and keep **speed** and **cost-to-accomplish** as two separate *operational*
dimensions rather than folding them into capability. Four capability axes + two
operational dimensions covers the real decisions without overlapping. I
deliberately did **not** split "research" into its own axis — in practice it
tracked reasoning + agentic and didn't earn a distinct column.

**A qualitative matrix reads better than numeric scores here**, given the
overlapping confidence intervals. Something like High / Strong / Solid per
(model × axis), with the two or three genuinely-separating facts (SWE-bench Pro
gap, ARC-AGI gap, terminal-bench gap, token efficiency) called out as footnotes
rather than buried in numbers that imply false precision.

**Pair it with a short routing heuristic / decision guide** — that's what a
delegating agent will actually use in the moment:

- **Hardest coding / gnarly repo debugging, cost secondary →** Opus 5 (or Fable 5
  if it's genuinely at the frontier of difficulty and availability is confirmed).
- **Long-horizon agent loop, terminal/browser heavy, or want a fast frontier
  turnaround →** GPT-5.6 Sol.
- **Hard reasoning / architecture / ambiguous design / cybersecurity →** Opus 5
  or Opus 4.8 (Opus 4.8 specifically still cited for cybersec).
- **Everyday coding & tool use at good value →** Sonnet 5 or GPT-5.6 Terra.
- **Bulk mechanical / clearly-specified / high fan-out →** Haiku 4.5, GPT-5.6
  Luna, or Terra. Do **not** fan out Opus 5 here — verbosity tax.
- **Latency-critical, quality-tolerant →** Haiku 4.5 (lowest TTFT) or Sol on
  Cerebras (fast + frontier).
- **Want a genuine second opinion / cross-check →** delegate to the *other
  vendor's* flagship. Cross-vendor delegation is arguably the highest-value use
  of this skill: Opus 5 and GPT-5.6 Sol have measurably different strength
  profiles and different failure modes (note GPT-5.6's eval-gaming flag), so a
  cross-check catches more than same-family self-review.

**Include an explicit "verify before trusting" box** covering: model names/IDs
change monthly; retirements (5.4 family gone from Codex Aug 31); Fable 5's
availability history; the Codex `/model` picker bug (use `-m`); and the fact that
most "independent" numbers still originate from vendor benchmarks.

---

## 6. Open uncertainties I could not fully resolve

- **Exact GPT-5.5 pricing and its current standing** vs 5.6 — 5.5 is clearly
  being superseded but still on the API; I didn't get a clean current price.
- **Whether a Codex-branded 5.6 exists** (`gpt-5.6-*-codex`) or whether the
  Codex line has fully folded into the general GPT-5.6 family — sources point to
  the latter (5.6 general models are the Codex default), but the older
  `gpt-5-codex` tier still lingers. The reference should confirm before listing.
- **Fable 5 vs Opus 5 real-world separation** — Fable leads Senior SWE-bench, but
  I saw little independent, non-benchmark evidence that its extra capability
  justifies 2× the price ($10/$50 vs $5/$25) for typical delegated tasks. My lean:
  default to Opus 5 as the Claude flagship for delegation, reserve Fable 5 for the
  genuinely hardest tasks, and confirm availability each time.
- **Latency numbers** are largely single-harness/vendor-sourced; treat as
  directional.

---

## Sources

Anthropic / Claude lineup and availability:
- https://en.wikipedia.org/wiki/Claude_(language_model)
- https://www.anthropic.com/news/redeploying-fable-5
- https://blog.risingstack.com/claude-fable-5-government-intervention/
- https://vercel.com/changelog/claude-fable-5-access-suspended-on-ai-gateway
- https://www.marktechpost.com/2026/07/13/anthropic-claude-sonnet-5-vs-sonnet-4-6-vs-opus-4-8-agentic-coding-benchmarks-api-pricing-and-cost-performance-tradeoffs-compared/
- https://www.datacamp.com/blog/claude-sonnet-5
- https://markaicode.com/benchmarks/aws-bedrock-production-benchmark-latency/

OpenAI / Codex lineup, models, CLI:
- https://developers.openai.com/codex/models
- https://developers.openai.com/codex/changelog
- https://openai.com/index/gpt-5-1-codex-max/
- https://github.com/openai/codex/issues/31873
- https://www.verdent.ai/guides/gpt-5-codex-model-names-explained

Independent / third-party comparisons and cost:
- https://artificialanalysis.ai/articles/gpt-5-6-has-landed
- https://snorkel.ai/blog/opus-5-swe-bench-error-analysis/
- https://benchlm.ai/compare/claude-opus-5-vs-gpt-5.6-sol
- https://llm-stats.com/models/compare/claude-opus-5-vs-gpt-5.6-sol
- https://codingfleet.com/blog/claude-opus-5-vs-gpt-5-6-sol/
- https://www.finout.io/blog/claude-opus-5-pricing-2026
- https://www.mindstudio.ai/blog/gpt-55-vs-claude-opus-47-coding-comparison
- https://pristren.com/blog/claude-opus-4-8-vs-gpt-5-5-gemini-3-1-june-2026/
- https://aicodingdaily.substack.com/p/gpt-54-vs-opus-claude-code-loops
