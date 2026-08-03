# Wave-two model research: Claude and Codex/GPT

Research date: 2026-08-03. This is research input for the eventual `models.md`, not a claim that every listed API model is selectable in every installed CLI or subscription. The final reference should list only models the user's actual Claude/Codex installations and plans expose.

## Bottom line

There is no defensible current cross-vendor winner. The newest public families—Claude 5 (June/July) and GPT-5.6 (July)—have too little independent, same-harness evidence to rank them reliably. Vendor and partner evaluations indicate both are frontier-capable, but should not be treated as neutral comparisons.

For a practical delegate configuration, make **GPT-5.6 Terra** and **Claude Sonnet 5** the normal choices; escalate to **GPT-5.6 Sol** or **Claude Opus 5** when the likely rework cost exceeds an extra agent run; use **Claude Fable 5** only for truly long-horizon, quality-first work; and use **GPT-5.6 Luna** or **Claude Haiku 4.5** for well-specified, bounded mechanical work. Treat **Claude Mythos 5** as unavailable unless the account is in its restricted program.

This is a routing starting hypothesis, not an automatic policy. Before routing recurring important work, run a small representative evaluation using the same handoff and harness.

## Current public models worth considering

Anthropic's current-model overview lists Fable 5, Opus 5, Sonnet 5, and Haiku 4.5; it identifies Fable as its most capable widely released model and Haiku as the fast tier. [Anthropic current overview](https://platform.claude.com/docs/en/about-claude/models/overview?cc61befa_page=2) also confirms that Mythos 5 is restricted to approved Project Glasswing customers. OpenAI's [current model catalogue](https://developers.openai.com/api/docs/models) makes GPT-5.6 Sol, Terra, and Luna its current frontier family.

| Model | Suitable default use | Published list rate (input/output per MTok) | Evidence and confidence |
| --- | --- | ---: | --- |
| **Claude Fable 5** | Exceptional, days-long autonomous investigation or implementation, when failed first pass is very expensive | $10 / $50 | Anthropic's most capable generally available model; 1M context / 128k output. Public only since June: no credible independent, same-harness comparison with GPT-5.6 found. Highest-potential, **low independent-confidence**. |
| **Claude Opus 5** | Hard refactors, difficult review/debugging, technical planning, agent coordination, complex documents | $5 / $25 | Current advanced Claude tier, released July 24; 1M context / 128k output, adaptive thinking. Sensible Claude quality-first default below Fable, but comparative independent signal is **very weak**. |
| **Claude Sonnet 5** | Most substantial ordinary coding, research, analysis, and writing | $2 / $10 introductory through 2026-08-31; then $3 / $15 | Anthropic's balanced tier and a reasonable first Claude choice. New tokenizer can make equivalent text roughly 1.0–1.35x as many tokens, so its nominal price is an important cost uncertainty. **Low independent-confidence** on exact rank. |
| **Claude Haiku 4.5** | Short transformations, extraction, classification, first-pass review, subtask fan-out | $1 / $5 | Anthropic's fast tier. One independent but narrow code-review study found it ahead of Sonnet 4.6 on that dataset; that does not establish superiority for general coding/reasoning. **Moderate confidence** for cheap/fast bounded work. |
| **GPT-5.6 Sol** | Hardest multi-step coding/reasoning/research, or final synthesis after cheaper parallel work | $5 / $30 | OpenAI's flagship, 1.05M context / 128k output. Release is only weeks old; alleged token-efficiency/quality gains are vendor or partner evidence, not an independently established ranking. **Low independent-confidence**. |
| **GPT-5.6 Terra** | Default Codex/GPT delegate for non-trivial implementation, debugging, research, analysis, and synthesis | $2.50 / $15 | OpenAI's balanced tier, positioned near GPT-5.5 performance. The price/likely capability make it the best initial throughput default, but no independent study validates the exact Sol/Terra/Fable/Opus trade-off. **Low independent-confidence**. |
| **GPT-5.6 Luna** | High-volume tightly scoped edits, extraction, classification, test generation, or triage | $1 / $6 | OpenAI's cost/latency tier, also with large context. Do not use it as a blind Terra substitute on under-specified or risky tasks; no independent basis quantifies the quality drop. **Low independent-confidence** beyond its economy role. |

Primary availability/specification sources: [Fable/Mythos launch documentation](https://platform.claude.com/docs/en/about-claude/models/introducing-claude-fable-5-and-claude-mythos-5), [Sonnet 5 documentation](https://platform.claude.com/docs/en/about-claude/models/whats-new-sonnet-5), [Opus 5 documentation](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5), and [GPT-5.6 release/pricing](https://openai.com/index/gpt-5-6/).

Older public models such as Claude Opus 4.8/Sonnet 4.6 and GPT-5.5/GPT-5.4/GPT-5.3-Codex are real, but normally omit them from a fresh-selection table: their vendors now direct new work to the current generation. Keep a pinned older model only when reproducibility or a local regression evaluation justifies it. GPT-5.3-Codex-Spark is a restricted research-preview latency experiment, not a stable general delegation default. [Spark announcement](https://openai.com/index/introducing-gpt-5-3-codex-spark/)

## What independent evidence does—and does not—show

The best useful independent evidence is methodological rather than a current-model leaderboard verdict:

- The independent FeatureBench paper tested end-to-end feature development, not merely issue repair. A then-state-of-the-art Claude Opus 4.5 agent which resolved 74.4% on SWE-bench solved only 11.0% of FeatureBench tasks. This is strong evidence against treating one coding benchmark as a proxy for real-project success. [FeatureBench](https://arxiv.org/abs/2602.10975)

- The official SWE-bench maintainers reported an equal-agent/prompt comparison in which Opus 4.5 narrowly led their board, but also that it used materially more steps than GPT-5.1 models. They explicitly noted that a step limit changes which model is cost-efficient. This is historical evidence that capability and cost-to-done are not proportional to token sticker price—not a ranking of current models. [Maintainer report and reproducible harness links](https://www.reddit.com/r/Anthropic/comments/1p5we05/opus_45_reclaims_1_on_official_swebench/)

- A recent independent code-review evaluation found the cheaper Haiku 4.5 ahead of Sonnet 4.6 on its 150-sample review set. It is narrow, but supports testing cheap models for repetitive reviewers rather than assuming the bigger model always wins. [Comparative code-review study](https://arxiv.org/abs/2606.15689)

- Community head-to-head accounts disagree on speed and quality and usually confound model, agent harness, prompting, subscription limits, and task. Use them to create test cases, not to assign universal scores. The same caution applies to vendor customer-evaluation quotes and cross-vendor charts.

I found no dependable public measurement answering “is Opus 5 faster than Terra on comparable agent work?” or “is Fable 5 cheaper to complete the same feature than Sol?” Do not invent one. Raw output speed is also insufficient: end-to-end time includes reasoning, tool calls, tests, retries, queueing, and human correction.

## Capability, speed, and real cost must be measured together

Per-token price is only an input to cost. Compare each representative task with the same harness, prompt, and tool budget, recording:

| Measure | Why it belongs in the comparison |
| --- | --- |
| Task completion / acceptance rate | Captures whether the delegate actually completed the requested outcome. |
| Human rework and review findings | A cheap run needing a senior engineer to repair it is not cheap. |
| End-to-end elapsed time | Includes reasoning, terminal/browser work, tests, retries, and queueing. |
| Input, cached-input, output, and reasoning-token usage | Lets cost be calculated rather than inferred from list price. |
| Tool calls / agent steps and failure modes | Explains cost and detects stuck, over-exploring, or silently incomplete agents. |

Compute **cost per accepted task**: metered model cost plus a defensible estimate of necessary human rework. Repeat enough to capture variance and split simple/well-specified work from ambiguous/long-horizon work.

Caching and effort settings matter enough to invalidate naive price tables. OpenAI offers a 90% cached-input discount for GPT-5.6 (with cache writes priced higher), while Anthropic provides prompt caching too. OpenAI supports reasoning settings from none through max; Anthropic treats effort as a principal Opus quality/latency/token control. These vendor facts make the experimental design point clear: compare a small effort sweep before declaring a model uneconomic. [OpenAI GPT-5.6 guidance](https://developers.openai.com/api/docs/guides/latest-model) and [Anthropic model-choice guidance](https://platform.claude.com/docs/en/about-claude/models/choosing-a-model)

## Suggested shape of the eventual reference

Use a compact operational table, not one blended capability score. For each installed model include:

1. model identifier and access caveat;
2. a short **use when** and **avoid when**;
3. a cost band based on local accepted-task data (initially `unknown`, not invented);
4. a latency band based on local wall-clock data; and
5. date verified, actual CLI/tool version, and account plan.

Then give a simple selection order:

1. Narrow, verifiable, high-volume task: start with Luna or Haiku.
2. Substantial normal engineering/research task: start with Terra or Sonnet.
3. Difficult, ambiguous, security-sensitive, or deeply iterative task: use Sol or Opus.
4. Long-running, high-consequence task where failed work costs more than model spend: consider Fable, subject to availability and its safety-routing behavior.
5. For recurring task classes, replace these heuristics with local acceptance, rework, elapsed-time, and spend data.

The final document should state explicitly that model choice is only one part of the system. Task handoff quality, permissions, tools, repository context, and agent harness can move results enough to reverse an apparent model ranking.

