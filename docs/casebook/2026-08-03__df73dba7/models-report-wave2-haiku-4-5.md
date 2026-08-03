# Model Research Report: Claude and GPT Capabilities, Speed, and Cost
**Research Date:** August 2026  
**Researcher:** Claude Haiku 4.5  
**Scope:** Anthropic Claude models and OpenAI GPT models

## Executive Summary

As of August 2026, the frontier has bifurcated: Claude's Fable 5 and OpenAI's GPT-5.6 Sol represent the absolute capability ceiling, but both are expensive and have access restrictions (Fable 5 is export-controlled outside the US). For most practical delegation use cases, the real competition is between Claude's Sonnet/Opus tier and OpenAI's Terra/Sol tier. Claude dominates on SWE-Bench Verified and long-context tasks; GPT-5.6 Sol excels on agentic, multi-step terminal work and reasoning-heavy tasks. Cost-to-accomplish is highly task-dependent — simple multi-model routing can yield 40%+ cost savings.

---

## Claude Model Lineup

### Fable 5
**Status:** Frontier model with always-on adaptive thinking; export-controlled outside US.

**Capability:**
- State-of-the-art on nearly all benchmarks
- #3 on Goldie Bench (82.7/100); #2 in Coding category
- Scores 80.0% on SWE-Bench Pro (multi-file, active-repo challenges)
- Strongest on long-horizon reasoning, scientific work, and multidisciplinary tasks
- Integrated extended thinking (no separate toggle; always active)

**Context:** 200K tokens (1M with extended thinking), 128K output.

**Speed:** Not extensively benchmarked in public sources; positioned as capability-over-speed tier.

**Cost:** $10/$50 per million tokens (input/output)
- Batch API: 50% discount
- Prompt caching: 90% discount on cached input

**Recommendation:** Reserve for frontier research, complex scientific reasoning, or when capability ceiling is non-negotiable. Accessibility restricted by export controls.

---

### Opus 5 (Latest: Opus 4.8)
**Status:** Production capability leader (before Fable); stable across use cases.

**Capability:**
- 88.6% on SWE-Bench Verified (independent eval via vals.ai; beats GPT-5.5 at 82.6%)
- Scores 69.2% on SWE-Bench Pro
- Wins on GPQA Diamond (graduate-level science), MMMU-Pro (visual reasoning)
- Extended thinking available; effective for multi-step problem decomposition
- Strong on instruction-following and complex reasoning

**Context:** 1M tokens.

**Speed:**
- Output: ~25.9 tokens/second
- Time-to-first-token: 1–2 seconds
- Full 500-word response: ~8–10 seconds

**Cost:** $5/$25 per million tokens (post-August 31 pricing; currently stable).
- Batch API: 50% discount
- Prompt caching: 90% discount

**Recommendation:** Use for high-stakes individual reasoning tasks, code review, or architecture decisions where capability matters more than speed. Strong independent benchmark performance.

---

### Sonnet 5 (Latest: Sonnet 4.6 → Sonnet 5 June 30, 2026)
**Status:** Production default; agentic and high-throughput sweet spot.

**Capability:**
- Sonnet 5 (June 2026 release) closes on Opus: 63.2% SWE-Bench Pro vs. Opus 4.8's 69.2%
- Outperforms Opus 4.8 on knowledge work / retrieval tasks
- Extended thinking available (not on Haiku)
- Agentic index: 77.2% (vs. GPT-5.6 Sol at 80.0% — competitive)

**Context:** 1M tokens.

**Speed:**
- Output: ~72.3 tokens/second (3x faster than Opus)
- Time-to-first-token: 500–800 ms
- Full 500-word response: ~4–5 seconds

**Cost:** $2/$10 through August 31, 2026; standard $3/$15 thereafter.
- Batch API: 50% discount
- Prompt caching: 90% discount

**Recommendation:** Default choice for most delegation tasks. Best speed-to-capability ratio. Strong independent benchmarks on coding and knowledge retrieval. Use Sonnet for high-volume agentic work or when response latency matters.

---

### Haiku 4.5
**Status:** High-throughput, latency-sensitive workloads.

**Capability:**
- General-purpose; no extended thinking
- Efficient for classification, routing, summarization, fact retrieval
- Not benchmarked extensively on SWE-Bench; positioned as speed/efficiency model

**Context:** Standard context window (exact size not heavily publicized; shorter than Opus/Sonnet).

**Speed:**
- Output: 80–120 tokens/second (fastest of Claude lineup)
- Time-to-first-token: <500 ms
- Full 500-word response: ~2–3 seconds

**Cost:** $1/$5 per million tokens (lowest Claude tier).
- Batch API: 50% discount
- Prompt caching: 90% discount

**Recommendation:** Use for high-volume, low-reasoning-depth tasks: chat routing, simple classification, summarization, or rapid iteration on many small requests. Excellent cost per call for tasks that don't require Sonnet's reasoning depth.

---

## OpenAI GPT Lineup

### GPT-5.6 Family (Launched July 9, 2026)

All three models share:
- 1.05M-token context window
- 128K max output
- July 30, 2026 price cuts: Terra −20%, Luna −80% (Sol unchanged)
- Batch & Flex: 50% discount on all rates
- Prompt caching: 10% of standard input rate, with 1.25x write cost, 30-min minimum life

#### GPT-5.6 Sol (Flagship)
**Capability:**
- Frontier reasoning on terminal-based agentic tasks: 88.8% on Terminal-Bench 2.1 vs. Claude's 83.1%
- Coding Agent Index: 80.0 vs. Claude's 77.2%
- **BUT** significantly underperforms on SWE-Bench Verified: 82.6% vs. Claude Opus's 88.6%
- Reasoning-heavy; excels at planning, recovery from failures, multi-step tool sequences
- Strong on code refactoring, security review, long-running agent workflows

**Speed:** Not specifically benchmarked; positioned as capability leader, likely slower than Terra.

**Cost:** $5/$30 per million tokens (unchanged after July 30).

**Recommendation:** Use for complex agentic orchestration, security review, large refactors, or multi-step debugging. Note: underperforms Claude on pure coding benchmarks; excels where task planning and recovery matter more than raw code accuracy.

---

#### GPT-5.6 Terra (Balanced Production)
**Capability:**
- Strong balance of capability and cost
- Benchmarked as practical default for most workflows
- Suitable for support, content, internal tooling, productivity assistants
- Instruction-following and multi-turn conversation strength

**Speed:** Not specifically detailed; positioned between Sol (slower) and Luna (faster).

**Cost:** $2.50/$15 per million tokens (post-July 30 cut; was $3.125/$18.75).

**Recommendation:** Default choice if switching from other providers. Competitively positioned against Claude Sonnet 5 on cost, though Sonnet likely has speed advantage and better SWE-Bench performance.

---

#### GPT-5.6 Luna (Volume & Speed)
**Capability:**
- High-volume, repeatable, predictable tasks
- Suitable for voice agents, multilingual support, routing, summarization
- Lower reasoning depth; optimized for throughput

**Speed:** Fastest of GPT-5.6 family; competitive with Haiku on latency.

**Cost:** $0.20/$1.20 per million tokens (post-July 30 cut; was $1/$6) — **lowest frontier cost**.

**Recommendation:** Use for high-volume, high-throughput tasks where output can be validated automatically or where latency is critical. Cheapest frontier option.

---

### Older OpenAI Models

**GPT-5.4** (still available):
- $2.50/$15 per million tokens
- Older, less capable than GPT-5.5/5.6
- Use only if GPT-5.6 unavailable

**GPT-5.3-Codex** (specialized, February 2026 release):
- Specialized for code; not broadly documented in 2026 search results
- Less relevant than GPT-5.6 for general delegation

**Deprecated:** GPT-4 series and o-series models retired. gpt-3.5-turbo retirement scheduled October 23, 2026.

---

## Independent Benchmarks & Analysis

### SWE-Bench Verified (Code Correctness)
Winner: **Claude Opus 4.8** (88.6% via independent vals.ai board)
- GPT-5.5: 82.6%
- Claude Sonnet 5: ~85% (estimated from reports)
- GPT-5.6 Sol: Benchmarked by OpenAI at 88.7%, but independent eval shows 82.6% — notable gap

**Takeaway:** Claude's coding performance on this benchmark is independent-eval verified and competitive/superior to GPT on correctness.

### SWE-Bench Pro (Multi-file, Active Repos)
- Claude Fable 5: 80.0%
- GPT-5.6 Sol: 64.6%
- Clear Claude win; GPT-5.6 Sol underperforms on large, integrated codebases

**Takeaway:** Claude better at context-aware, multi-file refactoring. GPT stronger at isolated problem-solving.

### Terminal-Bench 2.1 (Agentic Tool Use)
- GPT-5.6 Sol: 88.8%
- Claude: 83.1%

### Coding Agent Index (End-to-End Task Completion)
- GPT-5.6 Sol: 80.0%
- Claude: 77.2%

**Takeaway:** GPT-5.6 Sol excels at multi-step orchestration and recovering from failures. Claude stronger on code accuracy and context breadth.

### Token Efficiency / Real-World Cost
- No single model is universally cheapest
- Claude wins on long-context tasks (no length surcharge; GPT-5.6 has no surcharge either, but Opus/Sonnet context management is more efficient)
- GPT Luna has lowest absolute price, but token efficiency (tokens needed to complete task) varies by task type
- Real-world: multi-model routing (sending different task types to different models) yields 41% cost reduction vs. single-model strategy

**Caveats:**
- Token efficiency is highly task-specific
- Benchmarks are noisy; "reasoning effort" settings significantly affect performance
- Some published evals use different agent harnesses or safety layers

---

## Recommendation Framework

### Choose by Task Type

**For Code Correctness & Multi-file Reasoning:**
- **First choice:** Claude Sonnet 5 (best speed-to-capability, strong SWE-Bench Verified)
- **If reasoning depth needed:** Claude Opus (88.6% SWE-Bench, extended thinking)
- **Budget option:** Claude Haiku (for simple refactoring, linting, or as fallback after Sonnet)

**For Agentic Orchestration (Terminal, Multi-step Tool Use, Recovery):**
- **First choice:** GPT-5.6 Sol (88.8% Terminal-Bench, excellent recovery/planning)
- **Alternative:** Claude Sonnet 5 (competitive agentic index, faster TTFT)

**For Long-Context or Document-Heavy Tasks:**
- **Claude Opus/Sonnet:** No length surcharge; 1M context baseline
- **GPT-5.6:** Also 1.05M context; competitive but slightly more expensive per token

**For Cost-Sensitive Volume Work:**
- **Claude Haiku:** $1/$5
- **GPT-5.6 Luna:** $0.20/$1.20 (cheaper, but validate outputs)

**For Frontier Capability:**
- **Claude Fable 5:** State-of-the-art across most benchmarks (US-only, export-controlled)
- **GPT-5.6 Sol:** Strong reasoning and agentic capability

### Routing Strategy (Recommended)

For delegation workflows with mixed task types:
1. Route code accuracy tasks → Claude Sonnet 5
2. Route agentic/orchestration tasks → GPT-5.6 Sol
3. Route simple/high-volume → Claude Haiku or GPT-5.6 Luna
4. Route long-context → Claude Opus (if output quality > speed) or Sonnet (if speed > marginal quality)

This mixed approach typically reduces cost by 30–40% vs. single-model strategy.

---

## Caveats & Uncertainties

1. **Extended Thinking:** Claude Fable 5 always has adaptive thinking on; earlier Claude models require explicit toggle. GPT-5.6 models do not appear to have published extended-thinking variants (as of August 2026).

2. **Benchmark Noise:** SWE-Bench scores shift with reasoning-effort settings and agent harness configuration. Published benchmarks may not directly transfer to your task distribution.

3. **Export Controls:** Claude Fable 5 unavailable outside US (as of August 2026).

4. **Speed Unpublished:** GPT-5.6 models and Claude Fable 5 lack detailed speed benchmarks in public sources. TTFT and token-per-second rates inferred from older models or not available.

5. **Token Efficiency:** No comprehensive, independent evaluation of real cost-per-task across models. Recommendations based on reasoning about tokenization, context management, and task-level performance.

---

## Sources

Research based on public sources from August 2026, including:

- [Anthropic Claude API Pricing In 2026: Every Model, Token Rate, And Cost Lever](https://www.cloudzero.com/blog/claude-api-pricing/)
- [Claude Models Comparison 2026: Fable vs Opus vs Sonnet vs Haiku](https://datrick.com/claude-models-comparison)
- [Claude Opus 4.8 vs Sonnet 4.6 vs Haiku 4.5 [2026 Tested]](https://tech-insider.org/claude-opus-vs-sonnet-vs-haiku-2026/)
- [Claude Fable 5 Benchmarks, Pricing & the Silent Nerf [2026]](https://www.kunalganglani.com/blog/claude-fable-5-benchmark-developer)
- [GPT-5.6: Frontier intelligence that scales with your ambition | OpenAI](https://openai.com/index/gpt-5-6/)
- [GPT-5.6 Sol vs Terra vs Luna: Which to Use in 2026 | No Code MBA](https://www.nocode.mba/articles/gpt-5-6-sol-vs-terra-vs-luna)
- [OpenAI API Pricing 2026: GPT-5.6, GPT-5.5, GPT-5.4 and Codex Costs - DevTk.AI](https://devtk.ai/en/blog/openai-api-pricing-guide-2026/)
- [Claude vs ChatGPT 2026: 80.8% vs 77.2% SWE-Bench [Tested]](https://tech-insider.org/claude-vs-chatgpt-2026-2/)
- [AI Model Benchmarks Jul 2026 | Compare GPT-5.5, Claude Opus, Gemini 3, Grok 4 | LM Council](https://lmcouncil.ai/benchmarks)
- [Token Efficiency vs Raw Intelligence: Why GPT-5.6 Beats Claude Fable 5 on Cost-Per-Result | MindStudio](https://www.mindstudio.ai/blog/token-efficiency-vs-raw-intelligence-gpt-5-6-vs-fable-5)
- [Claude vs GPT vs Gemini: Best AI Model Comparison for 2026](https://www.bleap.finance/en-us/blog/claude-vs-gpt-vs-gemini)
