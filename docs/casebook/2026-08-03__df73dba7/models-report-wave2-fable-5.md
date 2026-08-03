# Models research report — wave 2 (researcher: Claude Fable 5)

Research date: 2026-08-03. Scope per handoff: Anthropic Claude models and OpenAI
Codex/GPT models only, with independent opinion weighted at least as heavily as
vendor claims. Live web search was available and used; where a claim rests on
vendor numbers or thin third-party coverage, that is flagged inline.

## Confidence and sourcing caveats (read first)

- **Anthropic lineup, IDs, and pricing are high-confidence** — cross-checked
  against Anthropic's own API reference material and current trackers.
- **OpenAI lineup and pricing are medium-high confidence.** OpenAI's pricing
  page wasn't fetched directly; figures below come from third-party trackers
  (OpenRouter, pricepertoken, modelpricing.ai, Artificial Analysis) that
  agree with each other but can lag. Verify against OpenAI's rate card before
  hardcoding numbers.
- **Benchmark margins are mostly vendor-reported.** Multiple independent
  comparisons explicitly warn that launch-day scores come from each vendor's
  own harness, and scaffold differences shift results — small gaps (a few
  points) should be treated as ties.
- **Claude Opus 5 is ~10 days old** (released 2026-07-24). Deep community
  verdicts on it are still forming; treat its entries as provisional.

## Current model lineups (as of 2026-08-03)

### Anthropic

| Model | ID | Context / max out | $/MTok in / out | Notes |
|---|---|---|---|---|
| Claude Fable 5 | `claude-fable-5` | 1M / 128K | $10 / $50 | Mythos-class tier above Opus; GA 2026-06-09. Thinking always on; requires 30-day data retention (no ZDR); safety classifiers can refuse (cyber/bio) |
| Claude Opus 5 | `claude-opus-5` | 1M / 128K | $5 / $25 | Released 2026-07-24; drop-in at Opus 4.8 pricing; strongest Anthropic model for agentic coding |
| Claude Opus 4.8 / 4.7 / 4.6 | `claude-opus-4-8` etc. | 1M / 128K | $5 / $25 | Prior Opus generations, still served; 4.8 is the recommended refusal-fallback for Opus 5/Fable 5 |
| Claude Sonnet 5 | `claude-sonnet-5` | 1M / 128K | $3 / $15 (intro $2 / $10 through 2026-08-31) | Near-Opus coding quality at Sonnet cost |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | 1M / 128K | $3 / $15 | Prior Sonnet |
| Claude Haiku 4.5 | `claude-haiku-4-5` | 200K / 64K | $1 / $5 | Fastest/cheapest Anthropic tier |

(Claude Mythos 5 exists but is restricted to Project Glasswing participants —
not relevant for a general delegation skill.)

All current Claude models take an `effort` parameter (`low`→`max`) that is a
major cost/latency lever — independent reviews note Opus 5 at `low`/`medium`
effort "punches well above its weight," often matching prior-generation
models at `xhigh`. A delegation skill should treat model choice and effort
choice as two coupled knobs, not just model choice. Opus 5 and 4.8 also have
a "fast mode" (~2.5× output speed at $10/$50, Claude API only, beta).

### OpenAI

| Model | Context / max out | $/MTok in / out | Notes |
|---|---|---|---|
| GPT-5.6 family (Sol / Terra / Luna) | ~1.05M | Sol: $5 / $30 | Current flagship generation; long-context pricing jumps above a 272K-token breakpoint (Claude bills its 1M window flat) |
| GPT-5.5 (+ 5.5 Pro) | 400K-class | ~$5 / $30 (Pro higher) | Previous flagship; strong SWE-bench Verified and Terminal-Bench numbers |
| GPT-5.4 / 5.4 Pro | 400K | $2.50 / $15 | Mid-tier generalist |
| GPT-5.3-Codex | 400K | $1.75 / $14 | Current coding specialist (2026-02-24); SOTA-class SWE-Bench Pro at release, ~25% faster and more token-efficient than prior Codex models |
| GPT-5.4 mini | 400K | $0.75 / $4.50 | ~166 tok/s; Artificial Analysis Intelligence Index 30 (medium) / 40 (xhigh) |
| GPT-5.4 nano | 400K | $0.20 / $1.25 | ~164 tok/s; OpenAI positions it for classification/extraction/subagents |
| GPT-5.1 Codex mini | — | $0.25 / $2.00 | Budget coding model |

Cached input is discounted ~90% on GPT-5.4/5.5/5.6 families; batch tier is
−50%, priority tier 2×. Note an upcoming churn point: GPT-5.4/-mini retire
inside Codex-with-ChatGPT-login on 2026-08-31 (API keys unaffected) —
OpenAI's Codex lineup moves fast, so any reference doc should date-stamp its
OpenAI rows.

## Capability — independent signal

**Frontier tier (Fable 5, Opus 5, GPT-5.6):**

- Fable 5 held the #1 spot on Artificial Analysis's Intelligence Index at
  launch (64.9) — an independent ranking. Every's "Senior Engineer" benchmark
  (independent) scored Fable 91 vs 63 for Opus 4.8 on hard, long-horizon
  coding. Its documented edge is specifically *long-horizon autonomous work*:
  small per-step reliability advantages compound over thousands of steps.
- Counter-signal: Andon Labs' independent extended business-simulation
  testing found the Mythos-class model made *less* money than both Opus 4.7
  and GPT-5.5 — a reminder the frontier edge is domain-specific, not uniform.
- Opus 5 (per launch coverage and early third-party charts) leads ARC-AGI-3,
  Frontier-Bench terminal coding (43.3%, ~2× Opus 4.8 — and ahead of Fable 5's
  33.7%), OSWorld 2.0, and the AA Intelligence Index; GPT-5.6 Sol leads
  DeepSWE. Early Reddit charts show Opus 5 and GPT-5.6 "nearly tied" on
  coding scores. These are mostly launch-window numbers; treat as ties-ish.
- Within Anthropic's own lineup, independent reviewers converge on: Opus 5
  matches or beats Fable 5 on most *coding* tasks at half the price; Fable 5
  retains the edge only on the longest-horizon, hardest autonomous work.

**Community texture (persistent across generations, from HN/Reddit threads):**
the split has been stable for several model generations —

- Codex/GPT models: better at *large mechanical changes across big
  codebases*, faster, leaner on tokens, but "miss the forest for the trees."
- Claude models: more mistakes on rote breadth work but better *taste*,
  architecture judgment, idiomatic code, and catching hidden design problems
  (e.g. reviewing a PR for design flaws, spotting a technically-correct page
  that breaks on mobile). One hands-on Opus 5 test: best refactoring judgment
  of the field, but 3.4× GPT-5.6 Sol's output tokens at default settings.
- The most common practitioner recommendation is literally "use both":
  Codex for speed/cost-sensitive mechanical work, Claude for judgment-heavy
  and architectural work.

**Mid tier:** Sonnet 5 is the consensus independent default ("default to
Sonnet 5, reserve Fable/Opus for problems where the quality gap pays for
itself"). It reaches previously-Opus-tier coding quality at $3/$15.
GPT-5.3-Codex is its natural OpenAI counterpart for coding delegation:
cheaper ($1.75/$14), very token-efficient, purpose-built for software tasks.

**Budget tier:** Artificial Analysis (independent) puts GPT-5.4 mini at
Intelligence Index 30–40 vs Haiku 4.5 at 24, and GPT-5.4 nano at 30 —
i.e. OpenAI's small models currently score higher *and* run ~1.8× faster
(≈165 vs ≈90 tok/s), at similar or lower blended price. Haiku's remaining
edge is time-to-first-token (consistently <600ms, among the best of any
mainstream API). One caveat from the same source: GPT-5.4 mini at `xhigh`
reasoning is extremely verbose (220M tokens on the AA eval run vs a 63M
median), which erodes its cost advantage if run at high effort.

## Speed

- **Throughput (small tier):** GPT-5.4 mini/nano ≈165 tok/s; Haiku 4.5
  ≈88–95 tok/s. Haiku wins TTFT.
- **Coding specialist:** GPT-5.3-Codex is ~25% faster than prior Codex models
  (vendor claim, but consistent with third-party "Codex feels snappier"
  sentiment).
- **Frontier tier:** all frontier models are slow in wall-clock terms because
  they think; Fable 5 in particular is documented to run *many minutes per
  request* on hard tasks. For delegation, latency at this tier is dominated
  by effort/reasoning settings, not raw tok/s. Claude's `effort: low/medium`
  and OpenAI's reasoning-effort settings are the real speed knobs.
- Claude fast mode (Opus 5/4.8): up to 2.5× output speed at 2× price —
  relevant when a delegated task is Opus-hard but latency-sensitive.

## Cost-to-accomplish-a-task (not sticker price)

This is the most contested area, and the handoff is right to distrust
per-token price. Findings:

- **Direction is consistent: Codex/GPT models use fewer tokens per task than
  Claude models.** Every independent test agrees on the sign. The *magnitude*
  is wildly disputed:
  - High end: a Figma-to-code task, Codex/GPT-5.3 1.5M tokens vs Claude
    Code/Opus 4.6 6.2M (~4×); one comparison claims ~3× cost advantage per
    task vs GPT-5.5 and ~7× vs GPT-5.3-Codex.
  - Low end: Composio's controlled same-prompt test (Opus 4.7 vs GPT-5.5)
    found only a 1.4× token gap and 23% cost gap.
  - Aggregate: Artificial Analysis's own index run cost ~$4,686 (110M tokens)
    on Opus 4.8 vs ~$3,357 (75M) on GPT-5.5 — Claude ~40% more expensive to
    win the index by one point.
  - Counter-example exists: one multi-file feature test had Claude Code
    finish in 33K tokens with zero errors vs 188K for a GPT-5 agent setup —
    harness matters as much as model.
- **The gap is narrowing on Anthropic's side**: Opus 4.8 cut output tokens
  ~35% vs 4.7 on knowledge tasks; Opus 5 continues the trend *at low/medium
  effort*, but at default settings still bills several times GPT-5.6's output
  tokens on identical tasks. Effort tuning is the difference between the two
  outcomes.
- **Verbosity cuts both ways at the small tier**: GPT-5.4 mini at xhigh is a
  token firehose; Haiku is terse. Sticker-price rankings invert depending on
  reasoning settings.
- **Quality offsets tokens on hard work**: multiple sources note Claude's
  higher first-attempt success on complex tasks can mean fewer paid
  iterations — the "cheaper per completed task despite pricier per token"
  argument holds for Fable 5/Opus 5 on genuinely hard, long-horizon work, and
  demonstrably does *not* hold for routine work (this is also the widely
  reported reason a Microsoft division capped Claude Code use at ~$2k/eng/mo).
- **Long-context economics differ structurally**: GPT-5.6 jumps to a higher
  rate card above 272K input tokens; Claude bills the full 1M window at flat
  rates. For delegated tasks with huge context (big repo dumps, long logs),
  Claude's flat pricing can flip the usual cost ordering.
- Honest gap: I found no rigorous, large-N, third-party study of tokens-per-
  completed-task across both vendors' *current* models (Opus 5 and GPT-5.6
  are too new). The 1.4×–4× token-efficiency range above is the best
  available signal; anything more precise would be false precision.

## Recommendation: how to choose, and how to organize the reference doc

**Proposed organization** — two parts, not one blended score:

1. **A facts table** (per model: ID, price in/out, context window, speed
   class, date-stamped), because facts rot fast — both vendors shipped
   multiple generations within 2026, and OpenAI is retiring models inside
   Codex this month. Date-stamp the table and expect to regenerate it.
2. **Three task-oriented axes**, scored coarsely (e.g. ◐/●/○ or 1–5), rather
   than one capability number or a long axis list:
   - **Judgment / architecture / long-horizon autonomy** — hard reasoning,
     design review, multi-hour agentic runs. Frontier Claude leads here per
     independent consensus (Fable 5 > Opus 5 ≥ GPT-5.6, with Fable justified
     only at the extreme).
   - **Mechanical coding throughput** — large-but-routine changes, wide
     refactors, boilerplate, test scaffolding. Codex/GPT leads on
     token-efficiency and speed (GPT-5.3-Codex is the standout
     value pick; Sonnet 5 is the Claude-side counterpart).
   - **Quick cheap subtasks** — classification, extraction, summarizing tool
     output, formatting. GPT-5.4 nano/mini and Haiku 4.5; independent data
     currently favors the GPT small models on intelligence-per-dollar-per-
     second, Haiku on first-token latency and terseness.

   I considered more axes (research/web tasks, vision, orchestration) and
   recommend against: current evidence doesn't cleanly separate the vendors
   on them, and they'd mostly duplicate the judgment axis.

3. **A short "cost reality" sidebar** stating explicitly: (a) expect
   Codex/GPT to use ~1.5–4× fewer tokens for the same task, so compare
   projected task cost, not $/MTok; (b) on Claude, effort level is a bigger
   cost lever than model choice within a tier; (c) quality offsets tokens
   only on hard tasks; (d) >272K-token context flips economics toward Claude.

**Decision shorthand for the delegate skill** (my suggested default mapping):

| Delegated task looks like… | First choice | Alternate |
|---|---|---|
| Days-long autonomous run, hardest problems, compounding-error risk | Claude Fable 5 | Claude Opus 5 |
| Complex feature work, refactor with design judgment, PR review for design flaws | Claude Opus 5 | GPT-5.6 |
| Routine-to-moderate coding, wide mechanical changes, cost-sensitive coding | GPT-5.3-Codex | Claude Sonnet 5 |
| General mid-tier task, good default when unsure | Claude Sonnet 5 | GPT-5.4 |
| Huge-context task (>272K tokens of input) | Claude (flat 1M pricing) | GPT-5.6 (mind the breakpoint) |
| Classification / extraction / cheap subagent chores | GPT-5.4 nano or mini (medium effort, not xhigh) | Claude Haiku 4.5 (best TTFT) |

Caveats worth carrying into the final doc: Opus 5 vs GPT-5.6 is close enough
that this table encodes a *style* difference (judgment vs throughput) more
than a capability ranking; and every row here should be revisited when either
vendor ships — which, on 2026 cadence, is roughly every 6–10 weeks.

## Sources

Vendor-adjacent / lineup & pricing:
- [Codex rate card — OpenAI Help Center](https://help.openai.com/en/articles/20001106-codex-rate-card)
- [OpenAI API pricing tracker — ModelPricing.ai](https://modelpricing.ai/models/openai)
- [GPT-5.3-Codex — OpenRouter](https://openrouter.ai/openai/gpt-5.3-codex)
- [GPT-5.3-Codex pricing — pricepertoken](https://pricepertoken.com/pricing-page/model/openai-gpt-5.3-codex)
- [Claude Haiku 4.5 — OpenRouter](https://openrouter.ai/anthropic/claude-haiku-4.5)

Independent benchmarks / measurements:
- [Claude Haiku 4.5 — Artificial Analysis](https://artificialanalysis.ai/models/claude-4-5-haiku)
- [GPT-5.4 mini — Artificial Analysis](https://artificialanalysis.ai/models/gpt-5-4-mini)
- [GPT-5.4 nano vs GPT-5 mini — Artificial Analysis](https://artificialanalysis.ai/models/comparisons/gpt-5-4-nano-medium-vs-gpt-5-mini-medium)
- [Anthropic provider performance — Artificial Analysis](https://artificialanalysis.ai/providers/anthropic)
- [LLM API latency benchmarks 2026 — kunalganglani.com](https://www.kunalganglani.com/blog/llm-api-latency-benchmarks-2026)
- [Claude Fable 5 benchmarks & developer notes — kunalganglani.com](https://www.kunalganglani.com/blog/claude-fable-5-benchmark-developer)

Cost-per-task / token efficiency:
- [AI coding costs 2026, token math — morphllm.com](https://www.morphllm.com/ai-coding-costs)
- [Claude Code vs Codex: 23% higher cost per task — tech-insider.org](https://tech-insider.org/claude-code-vs-codex-2026/)
- [Claude Code vs Codex efficiency claims examined — spectrumailab.com](https://spectrumailab.com/blog/claude-code-vs-openai-codex-comparison-2026)
- [Codex vs Claude Code token efficiency — MindStudio](https://www.mindstudio.ai/blog/codex-vs-claude-code-context-window-token-efficiency)
- [Claude Code vs Codex benchmarks & verdict — aivy.com.au](https://aivy.com.au/resources/claude-code-vs-codex/)
- [Claude Code vs Codex — firecrawl.dev](https://www.firecrawl.dev/blog/claude-code-vs-codex)

Community sentiment / reviews:
- [HN: "GPT-5.5 is the better programmer but Opus 4.8 remains the better system architect"](https://news.ycombinator.com/item?id=48336351)
- [Claude Opus 5 vs GPT-5.6 — kie.ai](https://kie.ai/blog/claude-opus-5-vs-gpt)
- [Claude Opus 5 vs GPT-5.6 Sol/Terra/Luna tested — aireiter.com](https://aireiter.com/blog/claude-opus-5-vs-gpt-5-6)
- [Is Claude Fable 5 worth it? Breakeven analysis — shadow.inc](https://www.shadow.inc/resources/claude-fable-5-pricing-breakeven-analysis)
- [Claude Fable 5 review — atlascloud.ai](https://www.atlascloud.ai/blog/guides/claude-fable-5-review)
- [Codex vs Claude Code, July 2026 — morphllm.com](https://www.morphllm.com/comparisons/codex-vs-claude-code)
- [LLM coding benchmark comparison 2026 — SmartScope](https://smartscope.blog/en/generative-ai/chatgpt/llm-coding-benchmark-comparison-2026/)
