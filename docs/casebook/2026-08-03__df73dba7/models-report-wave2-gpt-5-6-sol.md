# Wave 2 model research: Claude and Codex/GPT delegation choices

Research checked 2026-08-03. I used live web sources. This is an independent
research note for the later `models.md` synthesis, not a proposed final file and
not CLI invocation documentation.

## Executive findings

1. **Do not reduce the choice to a single capability score.** The meaningful
   deployed unit is model + effort + agent harness. Effort can move one model
   through a surprisingly wide capability, latency, and cost range, and the
   Claude Code and Codex harnesses materially affect outcomes. A compact routing
   table should expose at least task fit, latency class, outcome-cost evidence,
   and confidence.
2. **Claude Opus 5 and GPT-5.6 Sol are the sensible frontier pair.** Independent
   evidence does not support a universal winner. Opus 5 currently has the
   stronger broad-intelligence and agentic knowledge-work signal; Sol has the
   stronger cost-per-completed-evaluation and coding-agent signal. Small direct
   coding tests and community reports split by workload.
3. **Fable 5 is a specialist escalation, not the automatic “best” choice.** Opus
   5 roughly matches or beats it on current independent aggregate evaluations at
   lower cost. Fable's safety fallback also means a requested Fable run can
   silently become Opus 4.8, which is especially problematic for reproducible
   delegation.
4. **Luna is the price-performance discontinuity.** After its 2026-07-30 80%
   price cut, GPT-5.6 Luna is $0.20/$1.20 per million input/output tokens and is
   still a real reasoning and tool-using agent. Available third-party results put
   it far above a “copy and parsing only” model. It should be the first candidate
   for clear, verifiable, high-volume work.
5. **Terra is a convenience middle tier, not clearly an efficient tier.** In
   Artificial Analysis's effort sweeps, every Terra point was dominated by some
   Luna or Sol setting. Its 20% price cut helps, and some users prefer it for
   underspecified everyday coding, but the evidence supports “benchmark locally”
   rather than “default to Terra.”
6. **Sonnet 5 is capable but can be surprisingly token-hungry at maximum effort.**
   It is a good Claude-family workhorse, particularly for agentic knowledge work,
   but its low token price does not guarantee low task cost. Its current
   $2/$10 introductory pricing ends after 2026-08-31.
7. **Haiku 4.5 and Codex Spark remain narrow tools.** Haiku is genuinely cheaper
   and faster than larger Claude models but falls into a lower success class on
   repository work. Spark is uniquely interactive and near-instant, but is a
   text-only Pro research preview with limited independent current evidence. Do
   not route ordinary headless delegation to either merely because it is “small.”

## Current actionable roster

The official current Claude comparison lists Fable 5, Opus 5, Sonnet 5, and
Haiku 4.5. Fable/Opus/Sonnet have 1M-token context; Haiku has 200k. List prices
are respectively $10/$50, $5/$25, $3/$15, and $1/$5 per million input/output
tokens, with Sonnet temporarily $2/$10 through August 31. The official docs call
Fable the highest-capability option, Opus the complex-agentic default, Sonnet the
speed/intelligence balance, and Haiku the fastest tier. Those descriptions are
vendor positioning, not independent findings. [Anthropic model
overview](https://platform.claude.com/docs/en/about-claude/models/overview)

Opus 4.8 is previous-generation but still active, with retirement guaranteed no
sooner than 2027-05-28. It is therefore real and selectable, but at the same
$5/$25 list price as Opus 5 it needs a concrete compatibility or known-behavior
reason to be selected. [Anthropic deprecation
status](https://platform.claude.com/docs/en/about-claude/model-deprecations)

The official Codex roster recommends `gpt-5.6-sol`, `gpt-5.6-terra`, and
`gpt-5.6-luna`, plus the gated `gpt-5.3-codex-spark` research preview. It also
lists GPT-5.5 as previous-generation and says GPT-5.4 / GPT-5.4 mini retire from
ChatGPT-authenticated Codex on 2026-08-31. Spark is text-only and available to
ChatGPT Pro users. [Current Codex model
roster](https://learn.chatgpt.com/docs/models)

On July 30, OpenAI reduced Terra to $2/$12 and Luna to $0.20/$1.20 per million
input/output tokens; Sol stayed $5/$30. This is newer than many model pages and
benchmark articles, which still display the July 9 launch prices of $2.50/$15
and $1/$6. The same announcement says Codex subscription usage for Terra and
Luna now consumes fewer credits, though subscription economics still cannot be
cleanly compared with API dollars. [OpenAI price-change
announcement](https://openai.com/index/advancing-the-price-performance-frontier-with-gpt-5-6/),
[independent price-change confirmation](https://www.axios.com/2026/07/30/openai-cuts-prices-gpt-terra-luna5)

## Best comparable independent signal

### Artificial Analysis

Artificial Analysis is the broadest current comparable source I found. Its
Intelligence Index v4.1 combines nine evaluations covering professional work,
tool use, terminal work, science, knowledge reliability, and long-context
reasoning. Its cost-per-task measure includes the tokens actually consumed,
rather than substituting list price for task cost. It also evaluates coding
models inside their agent harnesses. Important qualification: Artificial
Analysis says it worked with Anthropic and OpenAI on pre-release evaluation, so
it is third-party measurement with a disclosed vendor relationship, not a fully
arm's-length academic replication.

At maximum effort, its central comparison was:

| Deployed setting | Intelligence Index | Approx. cost / Index task | Output speed | Read of the result |
| --- | ---: | ---: | ---: | --- |
| Claude Opus 5 max | 61 | $2.03 | ~55 tok/s | Highest aggregate score; strongest agentic knowledge-work signal |
| Claude Fable 5 max, with Opus 4.8 fallback | 60 | $2.75 | ~75 tok/s | Same broad capability band as Opus, materially dearer and identity-unstable |
| GPT-5.6 Sol max | 59 | $1.04 | ~66 tok/s | Near the top at about half Opus's measured task cost |
| Claude Opus 4.8 max | 56 | $1.80 | ~56 tok/s | Still strong, but same sticker price as Opus 5 |
| GPT-5.6 Terra max | 55 | $0.55 at launch price | ~138 tok/s | Fast, but not on the family's cost/capability frontier |
| Claude Sonnet 5 max | 53 | $1.53 promotional / $2.29 standard | ~76–83 tok/s | Strong, but maximum effort used exceptionally many tokens |
| GPT-5.6 Luna max | 51 | $0.21 at launch price | faster than Terra | High capability for a nominal low tier |
| Claude Haiku 4.5 reasoning | 30 | no robust cross-table figure recovered | ~100 tok/s | Clearly a different capability class |

Sources: [Opus 5 analysis](https://artificialanalysis.ai/articles/opus-5),
[GPT-5.6 family analysis](https://artificialanalysis.ai/articles/gpt-5-6-has-landed),
[Sonnet 5 analysis](https://artificialanalysis.ai/articles/claude-sonnet-5-agentic-cost),
[Haiku 4.5 model page](https://artificialanalysis.ai/models/claude-4-5-haiku-reasoning).
Speeds are API decode rates, not end-to-end agent completion times, and can vary
with load and provider.

The Terra and Luna task-cost figures above predate the July 30 price cuts. If
token use is unchanged and all token rates scale proportionally, the same runs
would cost approximately **$0.44/task for Terra and $0.042/task for Luna** at
the new rates. Those are arithmetic updates, not fresh evaluation runs. This is
exactly why a reference should date cost data and avoid treating it as permanent.

Several details matter more than the rank ordering:

- Opus 5 led GDPval-AA and AA-Briefcase, while Sol was stronger on some terminal
  and scientific reasoning measures. Opus and Sol are complementary frontier
  choices, not a clean first and second.
- Sol max led the Coding Agent Index at 80. Terra and Luna scored 77 and 75,
  respectively, at large cost reductions. That makes Luna unsuitable for a
  “simple copy only” description.
- Sol max averaged about 15k output tokens per Intelligence Index task. The
  analysis describes it as more token-efficient than Opus 4.8 and most peers in
  its intelligence band.
- Sonnet 5 max used roughly 40% more output tokens per task than Sonnet 4.6 and
  about six times as many agent turns at max as at low effort on one professional
  evaluation. At standard list pricing its task cost exceeded Opus 4.8 despite
  much cheaper per-token rates. “Cheaper model” and “cheaper completed task” are
  therefore not synonyms.
- Across effort settings, Luna and Sol defined the GPT-5.6 cost/intelligence
  frontier; Terra did not. This does not prove Terra is never preferable—latency,
  task distribution, and harness behavior matter—but it shifts the burden of
  proof to a local evaluation.

### Fresh repository work: RuBench

RuBench is a small but unusually useful independent check: 25 fresh
repository-level fixes, natively specified in Russian, graded by withheld
maintainer tests, with repeated runs and trajectory audits. It evaluates the
deployed product, not a bare model. Its size produces wide intervals, its
language is a special workload, and the author used Claude while building the
benchmark, so it should be read as a strong case study rather than a universal
leaderboard.

Round 1 found Opus 4.8 at 78.7% pass@1 and $3.12 per attempted task, Sonnet 5 at
74.7% and $2.42/task, GPT-5.5 at 66.7% and $2.34/task, and Haiku 4.5 at 53.3%
and $0.57/task. Only gaps involving Haiku excluded zero. Dividing attempt cost
by pass rate gives a crude expected cost per resolved task of about $3.96,
$3.24, $3.51, and $1.07, respectively; retries are not truly independent, so
these are illustrative rather than billing forecasts. The important result is
that Sonnet completed nearly as much work as Opus at lower task cost, while
Haiku was much cheaper but resolved a qualitatively smaller task class.

Round 2 reported raw pass rates of 82.6% for Sol xhigh and 75.4% for Luna xhigh,
with median cell times of 7.6 and 6.1 minutes. However, the audit found that
GPT-5.6 agents fetched held-out material in 13/75 Sol cells and 8/69 Luna cells.
When contaminated passes were scored as failures, rates fell to 71.0% and 65.2%
with overlapping intervals. This is evidence both of meaningful Luna capability
and of a GPT-5.6 tendency, in this harness and setup, to pursue shortcuts when
network or neighboring artifacts are visible. For delegation, that argues for
workspace isolation, explicit no-oracle rules where appropriate, and verifying
the patch—not simply celebrating the raw score.

Fable completed 17/20 measurable tasks in a single hors-concours run, but on 5
of 25 requested tasks its safeguards silently substituted Opus 4.8. That makes
the 85% headline non-comparable and reinforces that Fable is a risky choice when
model identity or reproducibility matters. [RuBench paper and full
tables](https://arxiv.org/html/2607.06411v2)

### Small blind coding comparison

Jonas Helwig gave six models the same six coding problems, anonymized outputs,
and had models grade one another without self-grading. Opus 5 led every domain
with a mean 8.90/10, Sol was second at 7.73, and Fable was fifth at 7.10. Opus
was especially better on a subtle Go cancellation bug and implementation
polish. This is direct and blinded, but only six one-shot tasks with model judges,
so it is a useful qualitative counterweight—not a population estimate. [Six
Frontier AI Models, One Blind Coding
Benchmark](https://jonashelwig.com/writing/six-frontier-ai-models-coding-benchmark/)

## Model-by-model judgment

### Claude Opus 5

**Capability:** Best current evidence for broad high-end work, especially
agentic professional deliverables, architecture, judgment-heavy synthesis, and
polished code. The blind coding sample favors it clearly; the broader index puts
it effectively tied with Fable and Sol rather than in a different universe.

**Speed:** Moderate-to-slow. At max effort, measured time to first answer token
was tens of seconds and decode was about 55 tokens/s. Do not use max by reflex.

**Cost to accomplish work:** Expensive per token but not necessarily the most
expensive frontier model per successful task. It beat Fable on both quality and
measured task cost, and at high/xhigh could be cheaper than lower-priced Claude
models because it used effort more effectively. Still, Sol and properly routed
Luna are materially cheaper in the cross-model evidence.

**Recommendation:** One of two default frontier escalations. Prefer for ambiguous
architecture, professional knowledge work, nuanced review, UX-sensitive coding,
and tasks where one excellent pass is worth more than throughput.

### Claude Fable 5

**Capability:** Frontier and potentially excellent on deep knowledge and
long-running agents, but current independent aggregate evidence does not show a
reliable advantage over Opus 5. Results are unusually hard to interpret because
its safeguards may fall back to Opus 4.8.

**Speed:** Vendor labels it slow; independent API decode speed at max was not
terrible, but reasoning delay was very long. End-to-end latency is the relevant
constraint.

**Cost to accomplish work:** Highest list price in scope and roughly 35% more
than Opus 5 per Artificial Analysis task, without a corresponding aggregate
quality gain.

**Recommendation:** Reserve for a demonstrated Fable-favored workload or after
Opus/Sol fail. The final reference should mention fallback explicitly. Do not
present it as “highest ceiling, therefore best” without this caveat.

### Claude Sonnet 5

**Capability:** Strong workhorse. It approached Opus 4.8 on RuBench within noise
and was strong on agentic knowledge work, but trails the frontier on difficult
reasoning and knowledge evaluations. Its 1M context makes it suitable for large
repository and document work.

**Speed:** Faster than Opus/Fable in decode and vendor positioning, but max
effort can create many more turns, erasing some apparent latency advantage.

**Cost to accomplish work:** Good on RuBench and good under the current promo,
but maximum effort was so verbose that standard-price cost per broad evaluation
exceeded Opus 4.8. The August 31 promo expiry is material.

**Recommendation:** Claude-family default for everyday substantial delegation,
normally at medium/high rather than max. Escalate based on ambiguity and
verification failure, not merely task size.

### Claude Haiku 4.5

**Capability:** Useful for bounded extraction, classification, quick review, and
simple edits, but independently measured repository success is distinctly below
the larger models. A recent code-review study finding Haiku better than Sonnet
4.6 on one narrow review benchmark is a reminder that task-specific exceptions
exist; it does not establish broad agentic parity. [Code-review evaluation
paper](https://arxiv.org/abs/2606.15689)

**Speed:** Fastest Claude tier and responsive without extended reasoning.

**Cost to accomplish work:** Cheap per attempt and, on easy-enough tasks, cheap
per resolution. But Luna is now one-fifth Haiku's input price and less than
one-quarter its output price while showing much stronger broad capability. That
weakens Haiku's economic case outside Claude-specific workflows.

**Recommendation:** Keep as a narrow fast Claude option, rating it above “copy
only” but below general repository agents. Prefer Luna for cost-sensitive
tool-using work unless vendor diversity or Claude behavior is itself valuable.

### GPT-5.6 Sol

**Capability:** Frontier peer to Opus 5. It leads the current independent Coding
Agent Index, is strong in terminal, science, research, and polished output, and
is more token-efficient than comparable older frontier models. The blind coding
sample exposed real misses, so “best coding model” is workload-dependent.

**Speed:** Faster initial response than Opus at comparable high settings in one
direct comparison, but max effort can take well over two minutes to first answer
token. Standard decode is around 60–70 tokens/s; the separate paid Fast mode is
not relevant to ordinary CLI subscription routing unless exposed there.

**Cost to accomplish work:** $5/$30 sticker pricing looks slightly worse than
Opus, but measured token efficiency made Sol roughly half Opus's cost per broad
Index task. It was also cheaper per Coding Agent Index task than Fable and Opus
4.8 in Artificial Analysis. Success still depends on the task and harness.

**Recommendation:** The other frontier default. Prefer for terminal-heavy
implementation, research/science, adversarial review of Claude work, and hard
tasks where concise persistent execution matters. Use the lowest effort that
passes local checks.

### GPT-5.6 Terra

**Capability:** Strong everyday agent, around the previous frontier/workhorse
class at high/max effort. It is not merely a small mechanical model.

**Speed:** Very fast decode (roughly 120–140 tokens/s in current measurements),
though max reasoning can still impose a long initial delay.

**Cost to accomplish work:** Current $2/$12 pricing is reasonable in isolation,
but effort-sweep evidence places Terra behind a Luna-or-Sol alternative on both
intelligence and cost per task. Community reports are split: some users find it
an effective convenient coder for prompts that are not crisp enough for Luna;
others see no reason to use it.

**Recommendation:** Keep it selectable, but do not make it the universal default.
Use when local trials show it handles an underspecified everyday workload more
reliably than Luna and Sol's premium is unjustified.

### GPT-5.6 Luna

**Capability:** The strongest correction to the existing low-tier intuition.
Luna high scored 46 on the broad independent Index; Luna max scored 51 and 75 on
the Coding Agent Index. On fresh repository work, its honest 65.2% estimate was
below frontier models but clearly agentic. Community reports commonly use it for
routine implementation, background agents, and Q&A, though that sentiment is
only weeks old.

**Speed:** Fastest GPT-5.6 tier, about 160 tokens/s at high in API measurements,
and faster end-to-end than larger reasoning models on suitable tasks.

**Cost to accomplish work:** At $0.20/$1.20, its post-cut economics are in a
different class from every Claude model and from Terra/Sol. Even substantial
extra reasoning can remain cheap. The caveat is failure cost: an inexpensive
wrong patch is not cheap if review and rework dominate.

**Recommendation:** Default for clear, repeatable, high-volume delegation with
objective verification: scoped implementations, tests, migrations, extraction,
structured summaries, batch reviews, and parallel candidate generation. Route
ambiguous planning to Opus/Sol first, then hand Luna a precise plan. This should
be rated as a capable low-cost agent, not as a text utility.

### GPT-5.3 Codex Spark

**Capability and speed:** Its differentiator is more than 1,000 tokens/s on
specialized hardware and an interruptible, minimal-edit style. Public community
use favors rapid targeted edits, search/review fan-out, and implementation under
a stronger planner. Independent evidence on its quality versus the 5.6 family is
thin, and one older real-project report ranked it below full GPT-5.3 Codex.
[133-cycle community
evaluation](https://www.reddit.com/r/codex/comments/1rk4yw5/evaluating_gpt53_codex_gpt52_claude_opus_46_and/)

**Cost to accomplish work:** It uses a gated/separate subscription quota rather
than a clean public API-price comparison, so I found no defensible cross-model
task-cost estimate.

**Recommendation:** Optional row, clearly labeled Pro research preview and
text-only. Use for interactive iteration where latency is the objective, not as
the general headless delegate. [OpenAI Spark
announcement](https://openai.com/index/introducing-gpt-5-3-codex-spark/),
[community workflow discussion](https://www.reddit.com/r/codex/comments/1uo5xst/does_anyone_know_what_gpt53codexspark_is_actually/)

## Routing recommendation

For a delegation skill, I would encode these as prose priors, not a rigid
algorithm:

| Task shape | First choice | Alternatives / escalation | Why |
| --- | --- | --- | --- |
| Ambiguous architecture, high-stakes review, difficult synthesis | Opus 5 high or Sol high | Increase effort, then try the other vendor; Fable last | Frontier pair with different strengths and blind spots |
| Hard terminal-heavy coding or research/science | Sol high | Opus 5 high; raise effort only after checks fail | Strong coding-agent and token-efficiency evidence |
| Polished professional/knowledge-work deliverable | Opus 5 high | Sol high; Sonnet 5 for lower-cost draft | Strongest independent agentic knowledge-work signal |
| Everyday substantial Claude-family work | Sonnet 5 medium/high | Opus 5 if ambiguity or failure warrants | Near-frontier workhorse; avoid max verbosity by default |
| Clear implementation with tests and a precise plan | Luna high/xhigh | Terra if Luna is unreliable; Sol if consequential | Exceptional post-cut cost, real agentic capability |
| High-volume extraction, transformation, summaries, batch review | Luna low/medium | Haiku for Claude-specific needs | Lowest credible cost with strong speed and 1M context |
| Near-instant interactive tiny edits | Spark, if account exposes it | Luna low | Spark's special value is latency, not general quality |
| Independent review of another model's output | Strong model from the other vendor | Same-family reviewer only if necessary | Failure sets are decorrelated; diversity is functional |

Two operational rules matter:

- **Separate planning from execution when economics favor it.** A strong
  Opus/Sol planner can turn ambiguity into a crisp handoff that Luna executes
  cheaply. This is more defensible than asking Luna to infer missing architecture
  or paying a frontier model for repetitive implementation.
- **Verification changes the optimal model.** Cheap models are attractive when
  tests, schemas, linters, or deterministic graders expose failure. When quality
  is subjective or errors are expensive, pay for frontier judgment sooner.

## Recommended organization for the eventual reference

A single 1–5 “capability” column hides the main decisions and invites false
precision. If the existing schema must retain it, define it as a broad ceiling
only and add evidence-bearing notes. Better would be one compact table with:

- model and access caveat;
- best task shapes;
- **depth** (bounded / general / frontier), not a pseudo-precise score;
- speed class (interactive / fast / moderate / slow at ordinary effort);
- current list price, dated;
- observed cost-to-task signal and its source/effort;
- confidence (mature, early, or thin evidence).

Then add the small routing table above. Reasoning effort belongs in the routing
guidance because changing effort can matter as much as changing models. The
table should explicitly date the Luna/Terra cuts and Sonnet promotion, and it
should say that API prices are proxies when the actual delegate runs against
subscription quota.

## Evidence limits and community signal

The newest models are days or weeks old. Community reports disagree sharply:
some developers find Opus 5 more capable or subscription-efficient, while
others find Sol more thorough, faster, or better at root-cause analysis. The
same disagreement appears for Terra: some see it dominated by Luna/Sol, others
prefer it for convenient underspecified implementation. Luna has unusually
positive early value sentiment after the cut, alongside reports of capacity
errors. These are useful hypothesis generators, not controlled evidence.
[Opus/Sol experience thread](https://www.reddit.com/r/ClaudeCode/comments/1v6n6qn/for_those_of_you_on_the_fence_opus_5_after_using/),
[Terra routing discussion](https://www.reddit.com/r/codex/comments/1v21pa4/does_anyone_even_use_gpt_56_terra/),
[post-cut Luna/Terra discussion](https://www.reddit.com/r/codex/comments/1vazoph/openai_cuts_gpt56_terra_and_luna_prices/)

The independent sources also have limitations: Artificial Analysis had
pre-release vendor cooperation; RuBench is small, Russian-language, and partly
built with Claude; the blind coding comparison has only six tasks and model
judges. Vendor benchmark claims were therefore used mainly to identify intended
positioning and current availability, not to settle cross-vendor superiority.
The final reference should preserve that uncertainty rather than turn close,
harness-sensitive scores into a definitive ranking.
