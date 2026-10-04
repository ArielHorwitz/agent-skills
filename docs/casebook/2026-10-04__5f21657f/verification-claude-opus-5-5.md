# Verification report: models-draft.md

Verifier model ID: `claude-opus-5-5`
Date checked: 2026-10-04

Web search worked. Page fetches worked for every page I tried, though WebFetch hands back a model's summary of each page rather than the raw text. One case where that matters: the Artificial Analysis comparison page came back with latency columns labelled "ms", which can only mean seconds given the values. I read them as seconds.

**Source concentration warning.** Most of the cost-per-task, token-count, speed and effort-range verdicts rest on one independent source, Artificial Analysis (AA). Its pages are measured continuously, so the numbers move. Where I could, I cross-checked against Vals.ai, Endor Labs and vendor docs. The IDs, prices, defaults and lifecycle verdicts rest on vendor docs (Anthropic, OpenAI), which is the right authority for those.

## Summary table

Line numbers refer to `models-draft.md`.

| # | Claim (line) | Verdict | Source |
|---|---|---|---|
| 1 | `claude-opus-5-5` is a current model ID (24) | HOLDS | Anthropic models overview, platform.claude.com/docs/en/about-claude/models/overview (vendor, live 2026-10-04) |
| 2 | `claude-sonnet-5-5` is a current model ID (25) | HOLDS | same (vendor) |
| 3 | `claude-fable-5-1` is a current model ID (26) | HOLDS | same (vendor) |
| 4 | `claude-haiku-4-5` is a current model ID (27) | HOLDS, but see details: retirement window opens 2026-10-15 | same, plus platform.claude.com/docs/en/about-claude/model-deprecations (vendor) |
| 5 | `gpt-6-astra`, `gpt-6.1-sol`, `gpt-6-luna` are current model IDs (28-30) | HOLDS | developers.openai.com/api/docs/pricing (vendor); Codex CLI 0.159.1 ships gpt-6.1-sol as default, codexusage.dev/gpt-6-1-sol (independent) |
| 6 | Sticker prices: Fable 5.1 $10/$50, Opus 5.5 $4/$20, Sonnet 5.5 $2/$10, Haiku 4.5 $1/$5 (49-51) | HOLDS | platform.claude.com/docs/en/about-claude/pricing (vendor) |
| 7 | Sticker prices: Astra $10/$50, 6.1 Sol $2/$10, 6 Luna $0.10/$0.50 (49-51) | HOLDS | developers.openai.com/api/docs/pricing (vendor); eesel.ai, yottalabs.ai (independent, Sept 2026) |
| 8 | Opus 5.5 and Sonnet 5.5 start at `medium` in Claude Code, Fable 5.1 at `high` (24, 43-44) | HOLDS | code.claude.com/docs/en/model-config (vendor) |
| 9 | Codex models default to `medium` (28, 44) | HOLDS | developers.openai.com/api/docs/guides/reasoning (vendor) |
| 10 | Opus 5.5 is strongest on software and agentic knowledge work (24) | HOLDS | AA Opus 5.5 article, #1 on Intelligence Index (independent, 2026-09-22); Vals.ai Terminal-Bench 4.0 #1 (independent, 2026-10-01). Dissent: Endor Labs coding test (independent) |
| 11 | Opus 5.5 `max` roughly doubles cost for a point or two (24) | HOLDS | AA: xhigh 56 at $3.46, max 58 at $5.98 (1.7x) (independent) |
| 12 | Opus 5.5 `max` can run for hours (24) | UNSUPPORTED | Found only reports of 2-5 minutes of silent thinking per turn (GitHub lidge-jun/opencodex #5824) |
| 13 | Opus 5.5 `max` can spend the whole output window thinking and return nothing (24) | HOLDS | Anthropic effort and extended-thinking docs (vendor): thinking counts against max_tokens and can't be disabled on Opus 5.5. Several GitHub issues confirm in practice (independent) |
| 14 | Opus 5.5 takes two to three times Astra's wall clock (24, 52-53) | FAILS | AA Opus 5.5 vs Astra comparison (independent) |
| 15 | Sonnet 5.5: Opus-class quality on most work (25) | FAILS at matched effort (vendor-only support) | AA Sonnet 5.5 pages (independent, 2026-09-28); vendor GDPval 1844 vs 1846 supports it |
| 16 | Sonnet 5.5: best terminal-loop scores of any model (25) | HOLDS, contested | AA Terminal-Bench 4.0: Sonnet 63.6% first (independent); Anthropic 70.6% (vendor). Vals.ai has Opus 5.5 first at 65.15% vs 64.14% (independent) |
| 17 | Sonnet 5.5: token appetite puts cost-to-task at Opus level (25) | FAILS at `medium` through `xhigh`, holds at `max` | AA (independent); Anthropic Terminal-Bench cost chart via Digital Applied (vendor) |
| 18 | Sonnet 5.5 costs more per task than Opus 5.5 at `max` (25, 47-48) | HOLDS | AA: $7.60 vs $5.98 per task (independent) |
| 19 | Fable 5.1 positioned as the escalation above Opus 5.5 for demanding reasoning and long-horizon work (26) | HOLDS | Anthropic models overview (vendor) |
| 20 | Fable 5.1 doesn't measurably beat Opus 5.5 on hard problems (26) | HOLDS, one dissent | AA: tie at default, Opus 58 vs Fable 53 at max (independent). Dissent: Endor Labs coding, Fable 87.2% vs Opus 68.7% passing (independent) |
| 21 | Fable 5.1 is the slowest model (26) | UNSUPPORTED across vendors, HOLDS within Claude | Anthropic labels it "Slower" (vendor). AA throughput: Fable ~56 t/s, Astra 52-61, 6.1 Sol 45-53 (independent) |
| 22 | Fable 5.1 is among the most expensive per task (26) | HOLDS | AA: $7.63 at max, highest measured (independent) |
| 23 | Fable 5.1 edge: knowledge recall (26) | FAILS | AA-Omniscience: Opus 5.5 46, Fable 5.1 43 (independent) |
| 24 | Fable 5.1 edge: competitive coding (26) | UNSUPPORTED | No Codeforces or competitive-programming numbers found for either model |
| 25 | Fable 5.1 uses fewer tokens per coding task than Opus 5.5 (26) | FAILS (contested) | Endor Labs: Opus 5.5 uses about a third of Fable's output tokens per coding task (independent). AA at `max` only: Fable 78k vs Opus 119k (independent) |
| 26 | Haiku 4.5 weaker than GPT-6 Luna, which costs less (27) | HOLDS | AA: Luna (max) 38 vs Haiku 4.5 18 on Intelligence Index (independent); prices from vendor docs |
| 27 | Astra strongest on novel math and science (28) | HOLDS, mostly vendor | FrontierMath Tier 4 97.6% (OpenAI-reported, Anthropic published no score); Terminal-Bench-Science 64.6% vs 58.7% (vendor figures via Vellum, CodingFleet) |
| 28 | Astra is the fastest frontier model (28) | FAILS | AA: Astra 52-61 t/s, "slower than average". Opus 5.5 72-92, Sonnet 5.5 93-139 (independent) |
| 29 | Astra frugal with tokens (28) | HOLDS | AA: 27k output tokens per task at max vs Opus 5.5 119k (independent) |
| 30 | Astra top sticker price (28) | HOLDS | Shared with Fable 5.1 at $10/$50 (vendor pricing pages) |
| 31 | Astra trails the Claude 5.5 pair on terminal-heavy loops (28) | HOLDS | AA and Vals.ai Terminal-Bench 4.0 (independent). Caveat: official tbench.ai board has Astra first, Anthropic entries not yet confirmed |
| 32 | Astra can overthink small tasks (28) | UNSUPPORTED | Nothing found |
| 33 | 6.1 Sol best cost-to-quality of any model (29) | HOLDS | AA, "best-value model" on Coding Agent Index (independent, 2026-09-29) |
| 34 | 6.1 Sol near-Astra depth (29) | HOLDS | AA: 1 point below Astra on Intelligence Index (independent) |
| 35 | 6.1 Sol top-tier agentic coding (29) | HOLDS | AA Coding Agent Index, xhigh 1 point above Astra (independent) |
| 36 | 6.1 Sol costs a fifth to a tenth of frontier models per task (29) | HOLDS | AA: max $0.72 vs Astra $3.26 (22%) and Opus 5.5 $5.98 (12%). xhigh $0.39 (independent) |
| 37 | 6.1 Sol is fast (29) | FAILS | AA: 45-53 t/s, "notably slow" (independent) |
| 38 | 6.1 Sol `xhigh` beats its own `max` on agentic coding (29, 40-41) | HOLDS | AA Coding Agent Index, xhigh 3 points above max (independent) |
| 39 | ...at two-thirds the cost (40-41) | UNSUPPORTED | Closest figure: AA Intelligence Index, xhigh $0.39 vs max $0.72 = 54% (independent) |
| 40 | 6.1 Sol trails Opus/Sonnet 5.5 on terminal-heavy loops (29) | HOLDS | Vals.ai TB 4.0: 55.05% vs 65.15% and 64.14% (independent) |
| 41 | Luna weak at terminal loops (30) | HOLDS | AA Terminal-Bench 4.0: 13% (independent) |
| 42 | Effort moves cost-to-task 5x to 18x within a model (19, 39) | FAILS (minor) | AA low to max: Astra 4.0x, 6.1 Sol 5.5x, Opus 5.5 10.9x, Sonnet 5.5 18.5x (independent) |
| 43 | Claude 5.5 models emit four to seven times Astra's output tokens per task (46) | HOLDS only at `max` | AA at max: Opus 119k, Sonnet 193k, Astra 27k (4.4x, 7.1x) (independent) |
| 44 | Astra costs less per task than Opus 5.5 or Sonnet 5.5 at `max` (47-48) | HOLDS | AA: $3.26 vs $5.98 and $7.60 (independent) |
| 45 | Claude flagships take two to three times as long as Astra or 6.1 Sol (52-53) | FAILS | See #14. No wall-clock data for 6.1 Sol vs Claude found |
| 46 | Codex models bill the whole request at 2x input and 1.5x output above 272K input (54-55) | HOLDS | OpenAI pricing page (vendor). 6.1 Sol long rate $4/$15 (eesel.ai, independent) |
| 47 | Claude bills flat across its 1M window (55) | HOLDS, minor gap | Anthropic pricing, "Long context pricing" (vendor). Haiku 4.5 has a 200K window, not 1M |
| 48 | Opus 5, Opus 4.8, Fable 5, Sonnet 5 still callable (57-58) | HOLDS | Anthropic deprecations page: all Active (vendor) |
| 49 | GPT-6 Sol, GPT-5.6 Sol/Terra/Luna still callable (57-58) | HOLDS | OpenAI pricing page lists them, deprecations page has no notice for them (vendor) |
| 50 | Each unlisted model is beaten on quality and cost-to-task by a listed model from the same vendor (58-59) | FAILS for GPT-5.6 Luna | AA: GPT-6 Luna Coding Agent Index 41, 2 points below GPT-5.6 Luna (independent) |

## Details for everything not HOLDS, plus HOLDS with caveats

### #4 Haiku 4.5: holds today, retirement window opens in 11 days
The deprecations page lists `claude-haiku-4-5-20251001` as Active, "Not sooner than October 15, 2026". No deprecation notice has gone out, and Anthropic promises at least 60 days' notice, so it won't actually be retired on Oct 15. But Anthropic has said twice (in the Opus 5.5 and Sonnet 5.5 launches) that "Claude Haiku 5.5 ... will join the Claude 5.5 family in the coming weeks". This row is likely to go stale soon. Also, `claude-haiku-4-5` is an alias. The pinned ID is `claude-haiku-4-5-20251001`, which matters if the delegate tool wants pinned IDs. Sources: platform.claude.com/docs/en/about-claude/model-deprecations (vendor). Haiku 5.5 status: orcarouter.ai/blog/claude-haiku-5-5-leak and dhseadev.online, 2026-09-25 (independent, quoting Anthropic).

### #12 "can run for hours"
I found nothing showing hour-long single runs at `max`. The longest I found was "routinely thinks for 2-5 minutes before the first text or tool call" at ~220k context (GitHub lidge-jun/opencodex issue #5824, independent). A long agentic session at `max` could plausibly last hours, but no source says so. Suggest dropping "for hours" or replacing it with "minutes of silent thinking per turn".

### #14 and #45 Wall clock, two to three times Astra
AA's per-response end-to-end times (independent, measured per 500 output tokens plus thinking, not per task):

| effort | Opus 5.5 | Astra | ratio |
|---|---|---|---|
| low | 11.5s | 11.9s | 1.0x |
| medium | 31.2s | 14.5s | 2.2x |
| high | 41.4s | 67.7s | 0.6x (Opus faster) |
| xhigh | 159.7s | 146.0s | 1.1x |
| max | 721.5s | 293.6s | 2.5x |

At `high`, which the draft calls Opus's sweet spot, Opus is faster than Astra. Hands-on tests go both ways. MindStudio: Astra 32 min vs Opus 40 min on a website build, Opus 31 min vs Astra 39 min on video editing (mindstudio.ai/blog/opus-5-5-vs-gpt-6-astra, independent). I found no wall-clock data for 6.1 Sol vs the Claude models, and AA rates 6.1 Sol "notably slow" on throughput. Correction: drop the blanket 2-3x. If anything stays, something like "at `max`, Opus 5.5 can take about 2.5x Astra's time per response". The advice "when time matters, go codex" is not supported as a general rule.

### #15 Sonnet 5.5, "Opus-class quality on most work"
Only vendor numbers support this. Anthropic's GDPval-AA is 1844 vs 1846 (the-decoder.com, 2026-09-28, which notes "independent testing still needs to confirm"). AA's Intelligence Index at matched effort (independent):

| effort | Sonnet 5.5 | Opus 5.5 |
|---|---|---|
| low | 36 | 42 |
| medium | 41 | 51 |
| high | 47 | 54 |
| xhigh | 52 | 56 |
| max | 56 | 58 |

Sonnet only gets close to Opus at `max`. AA says Sonnet 5.5 "sits off the Intelligence vs. Cost per Task Pareto Frontier" at every effort level (artificialanalysis.ai/articles/claude-sonnet-5-5). Correction: say it nears Opus quality only at `xhigh` or `max`, and is clearly below Opus at the `medium`/`high` levels the row recommends for routine work.

### #16 "Best terminal-loop scores of any model"
AA (63.6%, first) and Anthropic's own figure (70.6%) support it. Vals.ai, running the same harness for every model, puts Opus 5.5 first at 65.15% and Sonnet 5.5 second at 64.14% (vals.ai/benchmarks/terminal-bench-4, 2026-10-01, independent). Safer wording: "tied for the best terminal-loop scores with Opus 5.5".

### #17 Sonnet 5.5, cost-to-task "at Opus level"
At matched effort, Sonnet 5.5 is much cheaper per task than Opus 5.5 at every level except `max`:

- AA cost per task (independent): medium $0.59 vs $1.34, high $1.12 vs $1.82, max $7.60 vs $5.98.
- Anthropic's Terminal-Bench 4.0 chart (vendor, via digitalapplied.com and tokencost.app): high $1.94 vs $3.88, xhigh $5.30 vs $7.35.

The draft's conclusion still holds on a quality-adjusted basis. Sonnet hits Opus's xhigh score (56) only at `max`, where it costs $7.60 vs Opus's $3.46 for the same score. So "not the budget Claude" stands. The stated reason (token appetite makes per-task cost equal to Opus) is wrong except at `max`, and token use at low/medium is similar to Opus (AA: 23M vs 20M tokens at low). Correction: "cheaper per task than Opus at the same effort, but needs higher effort to match Opus's quality, which makes it no cheaper for equal results. At `max` it costs more than Opus outright."

### #20 Fable 5.1 doesn't beat Opus 5.5 on hard problems
AA and Anthropic support this. One independent dissent: Endor Labs' secure-coding benchmark puts Fable 5.1 ahead, 87.2% vs 68.7% passing and 37.4% vs 33.5% secure, after removing 51 Opus 5.5 answers it flagged as recalled from training data (endorlabs.com/learn/opus-5-5-6x-cheaper-and-2x-faster-than-fable-5-1..., independent). Also, AA at `low` effort has Fable ahead, 47 vs 42. I'd keep the claim but it's not unanimous.

### #21 Fable 5.1 "the slowest model"
Within Claude, Anthropic labels Fable "Slower" and Opus "Moderate" (vendor). Endor Labs measured 9.5 min per task for Fable vs 4.0 for Opus 5.5 (independent). Across vendors, AA throughput puts Fable (~56 t/s) level with or ahead of Astra (52-61) and 6.1 Sol (45-53). No source compares Fable's per-task wall clock with the codex models. Correction: "the slowest Claude model".

### #23 Fable 5.1 edge in knowledge recall
AA-Omniscience, AA's knowledge benchmark: Opus 5.5 46 (first), Fable 5.1 43, Astra 43 (independent, via search summary of AA). This contradicts the claim. Remove it.

### #24 Fable 5.1 edge in competitive coding
No Codeforces, LiveCodeBench or similar figures found for either model. Anthropic's launch table has none. Remove it, or source it.

### #25 Fable 5.1 uses fewer tokens per coding task than Opus 5.5
- Contradicted: Endor Labs (agentic coding): Opus 5.5 used about a third of Fable 5.1's output tokens per task, with ~17 tool calls vs 42 (independent).
- Supported only at `max`: AA Intelligence Index (not coding-specific) has Fable 78k vs Opus 119k output tokens per task (independent).
- At default efforts (Opus medium, Fable high), Opus 5.5 uses fewer (emergent.sh, independent).
- The widely cited "58% fewer tokens" Snorkel result compares Fable 5.1 to Opus 5, not Opus 5.5 (snorkel.ai/blog/fable-5-1-vs-opus-5-coding-benchmark, independent).

Correction: remove, or narrow to "fewer tokens than Opus 5.5 at `max`".

### #27 Astra strongest on novel math and science
The direction holds, but the evidence is vendor-reported. FrontierMath Tier 4 97.6% comes from OpenAI, and Anthropic published no FrontierMath or GPQA score for Opus 5.5. Terminal-Bench-Science 64.6% vs 58.7% also comes from vendor tables (via vellum.ai, codingfleet.com). Opus 5.5 leads on Humanity's Last Exam with tools, 67.7% vs 57.2% (vendor figures). No independent math/science head-to-head found.

### #28 Astra "fastest frontier model"
AA (independent): Astra produces 52-61 t/s depending on effort, "slower than average" for its tier. Opus 5.5 does 71-92 t/s and Sonnet 5.5 93-139 t/s. The only sense in which Astra is "fast" is that it emits fewer tokens, so at `max` (and at `medium`) a response finishes sooner than Opus's (see #14). OpenAI's new Ultrafast tier (up to 300 t/s at 6x price, Astra only so far) is a separate paid option (venturebeat.com, 2026-09-29, independent). Correction: "concise, so often quicker to finish than Opus at matched effort despite slow token throughput".

### #32 Astra overthinks small tasks
Nothing found either way. Note that AA has Astra at `medium` finishing a response in 14.5s, close to `low` (11.9s), which doesn't suggest overthinking at the default.

### #37 6.1 Sol "fast"
AA (independent): 45.4-53.4 t/s across efforts, "notably slow, however fairly concise". The tier median is about 75 t/s. It is slower than GPT-6 Sol (~78 t/s). Ultrafast for 6.1 Sol is "coming soon" (venturebeat.com). Correction: drop "and fast". "Concise" is supported.

### #39 6.1 Sol `xhigh` at "two-thirds the cost" of `max`
I found no per-effort cost for AA's Coding Agent Index. The nearest figure is AA's Intelligence Index: xhigh $0.39 vs max $0.72 per task, about 54%, or roughly half (artificialanalysis.ai/models/gpt-6-1-sol-xhigh, independent). Correction: "about half the cost", or drop the ratio.

### #42 Effort moves cost-to-task 5x to 18x
AA cost per Intelligence Index task, low to max (independent):

| model | low | max | span |
|---|---|---|---|
| GPT-6 Astra | $0.82 | $3.26 | 4.0x |
| GPT-6.1 Sol | $0.13 | $0.72 | 5.5x |
| Claude Opus 5.5 | $0.55 | $5.98 | 10.9x |
| Claude Sonnet 5.5 | $0.41 | $7.60 | 18.5x |

The upper bound holds. Astra falls below the lower bound. Correction: "4x to 18x". Minor.

### #43 Four to seven times Astra's output tokens
The ratio holds only at `max` (AA: 119k and 193k vs 27k). The draft states it without an effort qualifier. At lower efforts the gap is smaller: at `medium` Opus 5.5 costs less per task than Astra ($1.34 vs $1.54) despite a 2.5x lower token price, which implies about a 2x token ratio, not 4x. Correction: add "at `max`".

### #47 Claude bills flat across its 1M window
True for the 4.6-and-later models. Haiku 4.5 has a 200K context window, so "its 1M window" doesn't apply to it. Minor.

### #50 Every unlisted model beaten on both axes by a listed same-vendor model
- Holds for Opus 5 (same AA cost at max, lower score), Sonnet 5 (Sonnet 5.5 at low, 36, beats Sonnet 5 at xhigh, 34) and GPT-6 Sol (6.1 Sol is 31% cheaper per task at max and higher scoring).
- Fails for GPT-5.6 Luna: AA reports GPT-6 Luna scoring 41 on the Coding Agent Index, 2 points below GPT-5.6 Luna, with regressions on SWE-Atlas-QnA and DeepSWE, at ~60% lower cost (artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier, independent). On cost it's beaten, on coding quality it isn't.
- GPT-5.6 Terra and Fable 5: I did not find a direct head-to-head. Plausible but unverified.
- The list also omits other still-callable models: Opus 4.7, 4.6, 4.5, Sonnet 4.6, Sonnet 4.5 (deprecated, retiring 2026-11-30) and the Glasswing-only Mythos models. Not wrong, since the list doesn't claim to be complete, but "the still-callable previous generation" could be read as exhaustive.

## Ratings that the evidence makes look wrong

- **Opus 5.5 cost-to-task "high" vs Astra "medium-high".** AA cost per task at matched effort: low $0.55 vs $0.82, medium $1.34 vs $1.54, high $1.82 vs $1.73. Opus is at or below Astra's cost at every level up to `high`, the draft's recommended range for Opus. Opus is pricier only at xhigh ($3.46 vs $2.31) and max ($5.98 vs $3.26). Rating Opus a notch costlier than Astra holds only if Opus is run at xhigh/max. The two should probably share a rating, or the notes should say the gap appears only at high effort.
- **Sonnet 5.5 depth 4, execution 5, "Opus-class".** Depth 4 is fair, but at the `medium`/`high` efforts the row recommends, AA puts Sonnet 7-10 points under Opus, closer to 6.1 Sol at low/medium. Execution 5 is supported by Terminal-Bench.
- **Sonnet 5.5 cost-to-task "high".** Defensible as a quality-adjusted rating, but it contradicts the row's own reasoning (see #17). If the rating stays, the explanation needs fixing.
- **6.1 Sol and Astra speed language** (not a numeric rating, but used for routing). The "go codex when time matters" advice rests on #14, #28, #37 and #45, all of which fail or lack support.

## Research-process, honesty and outage notes in the draft

None found. The draft names no sources or studies, has no "this used to say X" text, and has no notes on honesty, evaluation gaming, outages or silent substitution. Line 18 ("Ratings are coarse and relative, not benchmark scores") and line 61 (the last-updated date) are about the content, not the research process, so I'd keep them.

Related point: if the authors consider adding the Endor Labs training-data-recall finding about Opus 5.5 (#20), it would count as an evaluation-gaming note and shouldn't be shipped.

## What I could not do

- I couldn't read OpenAI's or Anthropic's pages verbatim, only through WebFetch summaries. The vendor facts (IDs, prices, defaults, lifecycle) were consistent across vendor pages and several independent restatements, so I'm confident in them.
- I found no per-task wall-clock comparison between 6.1 Sol and any Claude model.
- I found no per-effort cost breakdown for AA's Coding Agent Index (affects #39).
- I found no competitive-coding figures for Fable 5.1 or Opus 5.5 (#24).
