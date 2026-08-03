# Proposal: revised `skills/delegate/models.md` — by Opus 5

Structure follows the existing file (`## Tools` per-CLI, then one `## Models`
table with tool / model / capability / notes). Two small additions inside that
shape, noted here so the diff isn't surprising:

- Per-tool **reasoning-effort flag**, alongside the invocation line. The file's
  own guidance is "balance cost and intelligence"; effort is the other half of
  that lever and costs nothing to document.
- **Price in the `notes` column.** Same four columns, but a delegating agent
  can't balance cost against intelligence without knowing the cost. Prices go
  stale, so each is dated.

Everything below the `---` is the proposed file verbatim.

**Provenance.** CLI flags verified by running `claude --help` and
`codex exec --help` on this machine (claude 2.1.220, codex-cli 0.146.0).
Codex model slugs, descriptions, and context windows read from
`~/.codex/models_cache.json` (server-fetched `2026-08-03T06:24Z`) — that is
the CLI's own model registry, so it is authoritative for what `--model` will
accept. Claude model IDs and prices from the bundled `claude-api` skill's
model table (cached 2026-06-24), cross-checked against `claude --help`.
Pricing and comparative claims for OpenAI models from live web search on
2026-08-03; sources cited inline. Capability ratings are my judgment calls,
with the reasoning shown.

**Correction to the current file worth flagging:** the codex slugs are
`gpt-5.6-sol` / `gpt-5.6-luna` — dotted, not `gpt-5-6-sol`. The names were
real, the separator was wrong, so those rows would have failed at invocation.
The file was also missing `gpt-5.6-terra` and rated Luna a 1 ("simple parsing
or copy") when the CLI registry describes it as a full agentic coding model.

---

# Delegate — available agents

## Tools

### claude

Non-interactive invocation, prompt over stdin:

    claude -p --model <model> --output-format json --permission-mode bypassPermissions

`--permission-mode bypassPermissions` is used so a headless call never blocks
on an approval prompt no one is present to answer.

Add `--effort <low|medium|high|xhigh|max>` to trade cost against depth. Default
is `high`. Use `xhigh` for hard coding and agentic work, `low` for scoped,
mechanical tasks. `--model` also takes aliases (`opus`, `sonnet`, `haiku`,
`fable`), but prefer the full IDs below so a delegated run is pinned to a
known model.

### codex

Non-interactive invocation, prompt over stdin, result written to a file:

    codex exec --model <model> -s danger-full-access -o <output-file>

`-s` is codex's sandbox/approval policy (`read-only`, `workspace-write`,
`danger-full-access`) — `danger-full-access` is used here so a headless
call never blocks on an approval prompt no one is present to answer.

Add `-c model_reasoning_effort="<low|medium|high|xhigh|max>"` to trade cost
against depth. Defaults differ per model: `low` for `gpt-5.6-sol`, `medium`
for the others. `gpt-5.6-sol` also accepts `ultra`, which spawns parallel
subagents — very expensive, reserve it for problems that have already
defeated a `max` run.

## Models

Prefer balancing cost and intelligence when choosing between multiple appropriate models.

Prices are USD per million tokens, input/output, as of 2026-08-03.

| tool | model | capability | notes |
| --- | --- | --- | --- |
| claude | claude-fable-5 | 5 | hardest reasoning and long-horizon autonomy; $10/$50 — only when opus-5 isn't enough |
| claude | claude-opus-5 | 5 | complex code, orchestration, repo-scale changes; $5/$25 |
| codex | gpt-5.6-sol | 5 | frontier agentic coding; long-horizon work; $5/$30 — best cross-vendor second opinion |
| claude | claude-sonnet-5 | 4 | near-opus coding at workhorse cost; $2/$10 (intro, $3/$15 from 2026-09-01) |
| codex | gpt-5.6-terra | 3 | everyday coding and review; $2/$12 |
| codex | gpt-5.6-luna | 2 | cheap bulk agentic work, mechanical edits; $0.20/$1.20 |
| claude | claude-haiku-4-5 | 1 | fast, simple parsing or copy; $1/$5 |

Rules of thumb:

- **Default to `claude-sonnet-5`.** It covers most delegated work; escalate
  only when a task actually needs frontier capability.
- **Escalate on task shape, not difficulty vibes.** Repo-scale reasoning and
  multi-file changes favor `claude-opus-5` (per Anthropic's SWE-bench Pro
  figures, 79.2% vs 64.6% for `gpt-5.6-sol`); very long single-run autonomous
  tasks favor `gpt-5.6-sol` (per OpenAI's long-horizon coding figures, 72.7%
  vs 68.8%). Both vendors' numbers are self-reported on their own harnesses
  and are not directly comparable, so treat this as a weak prior, not a fact.
- **Delegate across vendors for review.** The strongest reason to reach for
  codex from claude (or vice versa) is an independent second opinion —
  a model doesn't inherit the blind spots of the one that wrote the code.
- **Fan out on `gpt-5.6-luna`.** At $0.20/$1.20 it is the cheapest model here
  by a wide margin and still a real agentic coding model, so it is the right
  choice for wide, parallel, mechanical work. `claude-haiku-4-5` is for
  non-agentic one-shots: parsing, classification, short copy.
- **Effort beats model choice for cost control.** Dropping a tier loses
  capability permanently; dropping effort one notch often costs very little.
  Try `--effort medium` / `model_reasoning_effort="medium"` before downgrading.

All models above take ≥272K context (codex 272K; claude 1M except haiku's
200K), so context size is rarely the deciding factor.

Deliberately not listed: `claude-opus-4-8` and `gpt-5.5` (previous-generation
flagships, no advantage over their successors at equal or higher price), and
`gpt-5.4` / `gpt-5.4-mini` (marked for deprecation in codex's own registry, in
favor of `gpt-5.6-terra` / `gpt-5.6-luna`).

---

## Notes on this proposal (not part of the proposed file)

### On the capability ratings

The scale is coarse on purpose — the brief asked not to overengineer it. What
each rung means here:

- **5** — frontier. Reach for these when the task could plausibly fail on
  anything less.
- **4** — near-frontier workhorse. The default.
- **3** — competent everyday coding.
- **2** — cheap but genuinely agentic; fine for well-specified mechanical work.
- **1** — non-agentic; one-shot text tasks.

Two ratings are worth defending explicitly:

- **`claude-sonnet-5` at 4 vs `gpt-5.6-terra` at 3.** Anthropic positions
  Sonnet 5 as reaching "previously Opus-tier quality on many tasks" and gives
  it the full `xhigh`/`max` effort ladder and a 1M window; codex's own
  registry describes Terra as the "balanced agentic coding model for everyday
  work," the middle of three tiers. Similar price, different position in their
  respective lineups. This is the rating I hold with least confidence.
- **`gpt-5.6-luna` at 2, up from 1 in the current file.** The current rating
  ("simple parsing or copy") appears to have been a guess. Codex's registry
  calls it a "fast and affordable agentic coding model," gives it 272K context
  and the full `low`–`max` reasoning ladder, and names it the successor to
  `gpt-5.4-mini`. It is also, after the July 30 price cut, cheaper than
  `claude-haiku-4-5` while being substantially more capable — which inverts
  the ordering the current file implies.

### On Gemini CLI

I researched it and am **not** including it. `gemini` is not installed on this
machine (`which gemini` → not found), and this file is read by an agent about
to spawn a subprocess — listing a binary that isn't on PATH turns a model
choice into a runtime failure. The skill's `compatibility` field already says
the CLIs must be installed, and `models.md` is user-overridable at
`~/.config/agent-skills/delegate/models.md`, so anyone who has it can add it.

For whoever does, the syntax is:

    gemini -p <prompt> -m <model> --output-format json --yolo

`-p`/`--prompt` triggers headless mode, `--yolo` auto-approves tool calls (the
analogue of `bypassPermissions` / `danger-full-access`). I have **not** run
this — it is from Google's headless-mode docs, not verified locally, and I
could not confirm the current Gemini model IDs to the standard I held the
other two rows to. Verify before use.

### Caveats

- **Anthropic prices are from a cached table (2026-06-24), not live.** They
  match what live search reports for Opus 5 ($5/$25), which is a partial
  cross-check. The Sonnet 5 introductory rate expiring 2026-08-31 is the most
  time-sensitive number in the file.
- **Codex pricing moved once already, fast.** Terra and Luna were cut 20% and
  80% on 2026-07-30, three weeks after the 2026-07-09 GA. This table is
  post-cut, but a lot of secondary sources still quote launch prices, and
  another move would not be surprising.
- **Benchmark numbers are vendor-reported.** Both cited figures come from the
  vendors' own announcements and harnesses. I included them because the brief
  asked for cited reasoning on capability judgments, but the file's own text
  flags them as a weak prior rather than presenting them as settled.
- **Community sentiment was thin.** Searches for developer opinion on the
  5.6 tiers returned mostly SEO aggregators and a naming collision with the
  Terra/LUNA cryptocurrency. The one substantive read (Sol well-received for
  one-shot builds; Luna commercially the interesting tier) was a single
  consultancy blog, so I did not put any sentiment claim into the file itself.

### Sources

- [Advancing the price-performance frontier with GPT-5.6 — OpenAI](https://openai.com/index/advancing-the-price-performance-frontier-with-gpt-5-6/)
- [OpenAI cuts prices for two of its GPT-5.6 AI models — CNBC](https://www.cnbc.com/2026/07/30/open-ai-price-cut-gpt.html)
- [AI price wars: OpenAI cuts GPT-5.6 Luna prices by 80% — VentureBeat](https://venturebeat.com/technology/ai-price-wars-openai-cuts-gpt-5-6-luna-prices-by-80-as-model-competition-shifts-toward-cost)
- [Claude Opus 5 vs GPT-5.6 Sol: Benchmarks & Pricing — DataCamp](https://www.datacamp.com/blog/claude-opus-5-vs-gpt-5-6-sol)
- [Claude Opus 5 vs GPT-5.6 Sol Ultra: Evidence, Not Hype — Kingy AI](https://kingy.ai/blog/opus-5-vs-gpt-5-6-sol-ultra/)
- [Headless Mode — Gemini CLI docs](https://google-gemini.github.io/gemini-cli/docs/cli/headless.html)
- [GPT-5.6 Sol, Terra & Luna: Reddit's First-Week Verdict — Idea to MVP](https://ideatomvp.ai/en/blog/gpt-5-6-sol-terra-luna-reddit-verdict)
