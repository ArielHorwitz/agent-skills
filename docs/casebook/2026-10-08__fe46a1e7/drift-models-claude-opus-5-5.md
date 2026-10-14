# Model drift since 2026-10-04 (researcher: claude-opus-5-5)

Researcher model ID: `claude-opus-5-5` (Anthropic, Claude Code harness).
Live web search: working. All pages read 2026-10-08.

Source labels: **[vendor]** = Anthropic or OpenAI docs, changelog, model page,
pricing page, or official announcement. **[secondhand]** = press, blogs,
trackers, aggregators. Vendor pages were read through a fetch tool that
summarizes page content, so long tables were sometimes condensed. Where that
matters it is noted.

## Summary

- **Anthropic: one new model, one price cut.** Claude Haiku 5.5
  (`claude-haiku-5-5`) launched 2026-10-07. On the same day, Claude Sonnet 5.5
  cache reads dropped from $0.20 to $0.10 per MTok. No baseline model was
  deprecated, retired or renamed. One thing to watch: `claude-haiku-4-5` has a
  "not sooner than" retirement date of 2026-10-15, one week away. It is still
  listed as Active with no deprecation notice.
- **OpenAI: no new API or Codex model, no repricing, no deprecations hitting
  the baseline roster.** The only model change after the baseline is a pair of
  ChatGPT-only October 2026 snapshots of GPT-6 Sol and GPT-6 Luna. OpenAI says
  Codex and the API keep the earlier versions. GPT-6.1 Sol Ultrafast was
  announced 2026-09-29 and has still not shipped.

## Anthropic

### New: Claude Haiku 5.5

| Field | Value | Source |
|---|---|---|
| API / CLI model ID | `claude-haiku-5-5` (dateless, pinned snapshot, alias is the same string). Bedrock: `anthropic.claude-haiku-5-5`. Google Cloud, Foundry, Claude Platform on AWS: `claude-haiku-5-5` | [vendor] [1], [3] |
| Release date | 2026-10-07 | [vendor] [1], [2], [4] |
| Positioning | Cheap/fast tier. "For high-volume, latency-sensitive tasks such as classification, extraction, and routing". Announcement calls it "the cheapest, fastest, and most capable small model" and pitches it for subagent work under Opus 5.5 and Sonnet 5.5 | [vendor] [1], [2] |
| Pricing, prompts up to 100k tokens | $0.10 input, $0.50 output, $0.125 5m cache write, $0.20 1h cache write, $0.01 cache read (per MTok) | [vendor] [1], [5] |
| Pricing, prompts over 100k tokens | $0.50 input, $2.50 output, $0.625 5m cache write, $1 1h cache write, $0.05 cache read (per MTok) | [vendor] [1], [5] |
| Batch | 50% off: $0.05/$0.25 (up to 100k), $0.25/$1.25 (over 100k) | [vendor] [5] |
| Long-context note | Haiku 5.5 is the only 4.6-or-later model that is *not* flat-priced across the 1M window | [vendor] [5] |
| Context window | 1M tokens. In Claude Code, 1M on every plan with no `[1m]` suffix | [vendor] [1], [3], [7] |
| Max output | 128K sync; 300K on the Batch API with beta header `output-300k-2026-03-24` | [vendor] [1] |
| Effort levels | `low`, `medium`, `high`, `xhigh`, `max`. Default `medium` on the API and in Claude Code. `thinking: {"type":"disabled"}` is allowed only at `high` or below (400 at `xhigh`/`max`). Per-message effort (beta) supported on the Claude API and Google Cloud | [vendor] [6], [7] |
| Thinking | Adaptive, on by default. Manual `budget_tokens` returns 400 | [vendor] [1], [4] |
| Tokenizer | Newer tokenizer (same as 4.7 and later). About 30% more tokens for the same text than Haiku 4.5 [vendor] [1]. The announcement says "slightly more tokens" [vendor] [2]. Simon Willison measured about 1.25x on one long prompt [secondhand] [9] | as noted |
| Fast mode | Not supported. Fast mode is Opus 5.5 / Opus 5 / Opus 4.8 only | [vendor] [5] |
| Knowledge cutoff | Reliable: Jun 2026. Training data: Jun 2026 | [vendor] [1] |
| Deprecation status | Active (latest). Retirement not sooner than 2027-10-07 | [vendor] [1], [8] |
| Platforms | Claude API, Bedrock, Google Cloud, Microsoft Foundry, Claude Platform on AWS | [vendor] [1], [4] |
| Claude CLI | Added in Claude Code 2.1.293 (2026-10-07). It is now what the `haiku` alias resolves to on the Anthropic API. On Bedrock, Google Cloud, Foundry and Claude Platform on AWS, `haiku` still resolves to Haiku 4.5 | [vendor] [7], [10] |

### Repriced: Claude Sonnet 5.5 (baseline model)

- Cache reads (hits and refreshes) went from **$0.20 to $0.10 per MTok**
  (0.1x to 0.05x of base input), effective 2026-10-07. "Cache writes and all
  other prices are unchanged." [vendor] [4], [5], [2]
- Current Sonnet 5.5 prices: $2 input, $2.50 5m write, $4 1h write, $0.10
  cache read, $10 output. Batch $1/$5. [vendor] [5]
- Anthropic's announcement claims this makes Sonnet 5.5 "about 20% cheaper on
  most agentic work". That is a vendor claim, not checked here. [vendor] [2]

### Baseline models with no change found

Each of these was checked against the models overview [3], pricing [5] and
deprecations [8] pages on 2026-10-08. None has a post-baseline release note [4].

| Model | Status (deprecations page) | Current base price (in/out per MTok) |
|---|---|---|
| `claude-opus-5-5` | Active, not sooner than 2027-09-22 | $4 / $20 (cache read $0.20; fast mode $8/$40) |
| `claude-sonnet-5-5` | Active, not sooner than 2027-09-28 | $2 / $10 (cache read repriced, see above) |
| `claude-fable-5-1` | Active, not sooner than 2027-09-01 | $10 / $50 (cache read $0.25) |
| `claude-haiku-4-5` (`claude-haiku-4-5-20251001`) | Active, **not sooner than 2026-10-15** | $1 / $5 |
| `claude-opus-5` | Active, not sooner than 2027-07-24 | $5 / $25 |
| `claude-opus-4-8` | Active, not sooner than 2027-05-28 | $5 / $25 |
| `claude-fable-5` | Active, not sooner than 2027-06-09 | $10 / $50 |
| `claude-sonnet-5` | Active, not sooner than 2027-06-30 | $2 / $10 |

Notes:

- **Haiku 4.5 retirement floor is 2026-10-15.** Anthropic promises at least 60
  days' notice before retiring a publicly released model [8]. No notice has
  been posted, so the earliest real retirement is about 60 days after a notice.
  Even so, Haiku 5.5 now replaces it as the cheap tier, and a deprecation
  notice looks likely soon. This is my inference, not a vendor statement.
- The models overview now lists Haiku 4.5 under "Legacy models (still
  available)", next to Fable 5, Opus 5, Opus 4.8 and Sonnet 5 [vendor] [3].
- Sonnet 5's $2/$10 price is now marked standard. The previously scheduled
  increase to $3/$15 will not happen [vendor] [5]. I could not tell from the
  page whether this note was added before or after 2026-10-04.

### Other Anthropic items (context only, not roster changes)

- `claude-sonnet-4-5-20250929` was deprecated 2026-09-30 and retires
  2026-11-30, with `claude-sonnet-5-5` as the replacement. This was announced
  before the baseline, and the model is not in the roster. [vendor] [4], [8]
- `claude-mythos-5-1` and `claude-mythos-5` are listed as limited-availability
  models (Cyber Verification Program), priced the same as Fable 5.1 and Fable 5.
  I found no sign they are new since the baseline. [vendor] [5], [8]
- Possible discrepancy to check: the Claude Code model-config page (as
  summarized by my fetch tool) says Sonnet 5.5's default effort in Claude Code
  is `medium`. The API effort page says `high` is Sonnet 5.5's default "on the
  Claude API". These may simply be different surface defaults. [vendor] [6], [7]

## OpenAI

### Nothing new or repriced in the API or Codex since 2026-10-04

- The API changelog has no new model, snapshot, price change or deprecation
  dated 2026-10-04 to 2026-10-08. The entries in that window are: the
  Decisions API beta using the existing `gpt-6-luna` (2026-10-06), a
  restructuring of usage tiers into Build/Launch/Grow (2026-10-06), and a
  `chat-latest` snapshot refresh (2026-10-07). [vendor] [11]
- Some search summaries described the 2026-10-06 entry as a "new model,
  gpt-6-luna". That is wrong. It is a new API that runs on the existing model.
  [secondhand misreading, corrected against vendor] [11]
- Codex changelog: Codex CLI 0.161.0 (2026-10-07) makes `gpt-6.1-sol` the
  default in the bundled and Amazon Bedrock catalogs. It already became the
  bundled default in 0.159.1 on 2026-09-29, so this changes no models. The
  same entry mentions "Ultra reasoning" on compatible Bedrock models without
  defining it. [vendor] [12]

### Changed, ChatGPT only: GPT-6 Sol and GPT-6 Luna (October 2026) snapshots

- Published 2026-10-07. New ChatGPT snapshots "GPT-6 Sol (October 2026)" and
  "GPT-6 Luna (October 2026)" replace GPT-5.6 Sol and GPT-5.6 Luna in ChatGPT on
  all plans. [vendor] [13]
- OpenAI says explicitly: "Users accessing GPT-6 Sol and GPT-6 Luna in Codex,
  and via ChatGPT Work, are still using previously released versions." No new
  API model ID was published. [vendor] [13]
- This probably relates to the 2026-10-07 `chat-latest` refresh ("most recent
  model accessible to ChatGPT Plus, Pro, Business, and Enterprise"). That
  connection is my inference. [vendor] [11]
- It does not affect `codex` CLI model IDs.

### Announced, still not shipped: GPT-6.1 Sol Ultrafast

- Announced 2026-09-29 at DevDay (before the baseline) as "coming soon". As of
  2026-10-08, the vendor pricing page has Ultrafast rows only for
  `gpt-6-astra` ($60 / $6 cached / $300, long context $120 / $12 / $450). It
  has no `gpt-6.1-sol` Ultrafast row. [vendor] [14]
- The `gpt-6.1-sol` model page lists Standard, Fast (2x) and Batch/Flex (0.5x)
  only. [vendor] [15]
- Secondhand reports agree it is not yet callable or priced. [secondhand] [16]
- Ultrafast has no separate model ID. It is selected with
  `service_tier: "ultrafast"` on the base model. [secondhand] [17]

### Baseline OpenAI models: current state, all unchanged

Prices are standard tier, per 1M tokens (input / cached input / output), for
prompts of 272K input tokens or less. Long context costs 2x input and 1.5x
output. Read 2026-10-08 from [14] and the model pages.

| Model | Positioning (vendor) | Price | Context / max out | Reasoning levels | Status |
|---|---|---|---|---|---|
| `gpt-6-astra` | Flagship, "most capable" | $10 / $1 / $50; Fast $20/$2/$100; Ultrafast $60/$6/$300 | 1.05M / 128K | low to max | Current [vendor] [18], [19] |
| `gpt-6.1-sol` | Mid, "near-Astra ... at a lower cost" | $2 / $0.10 / $10 (cache write $2.50); Fast $4/$0.20/$20 | 1.05M (922K max input) / 128K | low, medium (default), high, xhigh, max; no none/minimal | Current [vendor] [15], [18] |
| `gpt-6-luna` | Cheap, "most efficient ... high-volume" | $0.10 / $0.01 / $0.50; Fast $0.20/$0.02/$1 | 1.05M (922K max input) / 128K | none to max | Current [vendor] [18], [20] |
| `gpt-6-sol` | Superseded ("see GPT-6.1 Sol") | $2 / $0.20 / $10 | 1.05M / 128K | not restated on page | Still listed, not deprecated [vendor] [21], [22] |
| `gpt-5.6-sol` | Older | $4 / $0.40 / $20 (promotional, "at least through November 21, 2026") | not checked | not checked | Not deprecated [vendor] [14], [22] |
| `gpt-5.6-terra` | Older | $2 / $0.20 / $12 | not checked | not checked | Not deprecated [vendor] [14], [22] |
| `gpt-5.6-luna` | Older | $0.20 / $0.02 / $1.20 | not checked | not checked | Not deprecated [vendor] [14], [22] |
| `gpt-5.5` | Older (in codex CLI list, not in baseline roster) | $5 / $0.50 / $30 | not checked | not checked | Not deprecated [vendor] [14], [22] |

- I did not have the baseline catalog's own price figures to diff against. The
  "unchanged" verdict rests on three things: no post-baseline pricing or
  changelog entries [11], the pricing page notes [14], and the Codex changelog
  [12].
- The GPT-5.6 Sol promo ($5/$30 cut to $4/$20, from about 2026-08-21) has no
  announced extension or end. The "at least through 2026-11-21" wording is
  unchanged. [vendor] [14]; [secondhand] [23]

### OpenAI deprecations (none hit the baseline roster)

- 2026-10-01 (before the baseline): `gpt-5.3-codex` and `gpt-5.1` (replacement
  `gpt-6-sol`) and `gpt-5.4-nano` (replacement `gpt-6-luna`) shut down
  2027-04-01. TTS models shut down 2027-01-06. [vendor] [22]
- Nothing dated after 2026-10-04 on the deprecations page. [vendor] [22]

### Other OpenAI items (out of scope or unverified)

- Forum thread "Introducing GPT-Live-1 in the API", shown as 2026-10-06. This
  is a realtime/voice model, not usable through the `codex` CLI. Forum dates
  may be last-activity dates, so the release date is unverified.
  [vendor forum] [24]
- DevDay 2026 was 2026-09-29 (before the baseline): GPT-6.1 Sol, Astra
  Ultrafast, Pro 500 plan. The vendor recap page returned 403, so the date
  comes from secondhand sources. [secondhand] [17]

## Sources (all read 2026-10-08)

1. Anthropic, Claude Haiku 5.5 model page: https://platform.claude.com/docs/en/models/haiku-5-5/overview [vendor]
2. Anthropic, "Introducing Claude Haiku 5.5" (dated 2026-10-07): https://www.anthropic.com/claude-haiku-5-5 [vendor]
3. Anthropic, Models overview: https://platform.claude.com/docs/en/about-claude/models/overview [vendor]
4. Anthropic, Platform release notes: https://platform.claude.com/docs/en/release-notes/overview [vendor]
5. Anthropic, Pricing: https://platform.claude.com/docs/en/about-claude/pricing [vendor]
6. Anthropic, Effort: https://platform.claude.com/docs/en/build-with-claude/effort [vendor]
7. Anthropic, Claude Code model configuration: https://code.claude.com/docs/en/model-config [vendor]
8. Anthropic, Model deprecations: https://platform.claude.com/docs/en/about-claude/model-deprecations [vendor]
9. Simon Willison, "Claude Haiku 5.5" (2026-10-07): https://simonwillison.net/2026/Oct/7/claude-haiku-5-5/ [secondhand, via search snippet]
10. Anthropic, Claude Code changelog (2.1.293, 2026-10-07): https://code.claude.com/docs/en/changelog [vendor]
11. OpenAI, API changelog: https://developers.openai.com/api/docs/changelog [vendor]
12. OpenAI, Codex changelog (redirects from developers.openai.com/codex/changelog): https://learn.chatgpt.com/docs/changelog [vendor]
13. OpenAI Deployment Safety Hub, "GPT-6 Sol and GPT-6 Luna: October 2026 update" (2026-10-07): https://deploymentsafety.openai.com/gpt-6-october [vendor]
14. OpenAI, API pricing: https://developers.openai.com/api/docs/pricing [vendor]
15. OpenAI, GPT-6.1 Sol model page: https://developers.openai.com/api/docs/models/gpt-6.1-sol [vendor]
16. aifreeapi.com, "OpenAI Ultrafast vs Sol": https://www.aifreeapi.com/en/posts/openai-ultrafast-vs-sol and VentureBeat: https://venturebeat.com/technology/openais-gpt-6-1-sol-offers-astra-like-performance-at-1-5th-price-a-new-ultrafast-tier-clocks-at-300-tokens-per-second [secondhand, via search snippets]
17. bazaarlink.ai DevDay recap: https://bazaarlink.ai/en/blog/openai-devday-2026-recap-gpt-6-1-sol-ultrafast-en and qcode.cc: https://qcode.cc/en/openai-devday-2026 [secondhand, via search snippets]
18. OpenAI, Models overview: https://developers.openai.com/api/docs/models [vendor]
19. OpenAI, GPT-6 Astra model page: https://developers.openai.com/api/docs/models/gpt-6-astra [vendor]
20. OpenAI, GPT-6 Luna model page: https://developers.openai.com/api/docs/models/gpt-6-luna [vendor]
21. OpenAI, GPT-6 Sol model page: https://developers.openai.com/api/docs/models/gpt-6-sol [vendor]
22. OpenAI, Deprecations: https://developers.openai.com/api/docs/deprecations [vendor]
23. OpenAI Developer Community, GPT-5.6 Sol 20% price reduction: https://community.openai.com/t/20-price-reduction-for-gpt-5-6-sol-api-codex-credits-and-chatgpt-work/1391726 [vendor forum, via search snippet]
24. OpenAI Developer Community, Announcements: https://community.openai.com/c/announcements/6 [vendor forum]

Pages that failed: openai.com/index/devday-2026-recap (403),
openai.com/news/product-releases (403), help.openai.com ChatGPT release notes
(403), developers.openai.com/api/docs/guides/ultrafast (404).
