# Model drift since 2026-08-05 (Anthropic + OpenAI)

Researcher model ID: `claude-opus-5-5` (Claude Opus 5.5), via Claude Code.
Date of research: 2026-10-04. All pages below were read on 2026-10-04 unless
stated otherwise. Live web search and fetch worked.

Source labels:
- **[V]** vendor docs, changelog, model or pricing page (read directly)
- **[V-snip]** vendor page seen only through a search-result snippet (direct
  fetch returned HTTP 403, so the wording is not verified first-hand)
- **[S]** secondhand report (press, blogs, Wikipedia, aggregators)

Fetch notes:
- `docs.anthropic.com/...` 301-redirects to `platform.claude.com/docs/...`.
- `developers.openai.com/codex/models` and `/codex/changelog` 308-redirect to
  `learn.chatgpt.com/docs/models` and `/docs/changelog`. I treat
  learn.chatgpt.com as OpenAI vendor docs (chatgpt.com is OpenAI's domain),
  but the redirect was server-supplied and I did not verify ownership further.
- `openai.com/index/*` and `help.openai.com` returned 403 to the fetcher.
  OpenAI launch-post dates therefore rest on search snippets plus secondhand
  reports, cross-checked against the vendor changelog where possible.

---

## 1. Summary of drift

### Anthropic

| Date | Event | Source |
|---|---|---|
| 2026-08-05 | `claude-opus-4-1-20250805` retired (baseline-day event) | [V] release notes |
| 2026-08-10 | Sonnet 5 introductory $2/$10 made permanent. Planned rise to $3/$15 on 2026-09-01 cancelled | [V] release notes, pricing |
| 2026-09-01 | **New:** `claude-fable-5-1` (GA) and `claude-mythos-5-1` (Project Glasswing, invite only). Cache reads cut to $0.25/MTok | [V] release notes |
| 2026-09-22 | **New:** `claude-opus-5-5`, priced **below** Opus 5 ($4/$20 vs $5/$25). Default effort `medium`. Fast mode available | [V] release notes |
| 2026-09-28 | **New:** `claude-sonnet-5-5` ($2/$10) | [V] release notes |
| 2026-09-30 | `claude-sonnet-4-5-20250929` deprecated, retires 2026-11-30 | [V] deprecations |

Baseline models now marked **Legacy** (still Active, not deprecated):
`claude-fable-5`, `claude-opus-5`, `claude-opus-4-8`, `claude-sonnet-5`.
`claude-haiku-4-5` is still current, but its retirement commitment is only
"not sooner than October 15, 2026", 11 days from today. No deprecation notice
for it has been posted yet. **This is the most time-sensitive item for the
catalog.**

### OpenAI

| Date | Event | Source |
|---|---|---|
| 2026-07-30 (pre-baseline, for context) | GPT-5.6 Terra cut 20%, Luna cut 80% | [S] |
| 2026-08-21 | GPT-5.6 Sol promotional price $4/$20 (from $5/$30) | [S] for start date. [V] pricing page confirms promo "at least through November 21, 2026" |
| 2026-09-03 | **New:** `gpt-6-astra` (flagship), limited preview, then broad rollout (Wikipedia says public 2026-09-04) | [V-snip], [S] |
| 2026-09-22 | **New:** `gpt-6-sol` and `gpt-6-luna` | [V-snip], [S] |
| 2026-09-29 | **New:** `gpt-6.1-sol` in Codex and API. Codex CLI 0.159.1 adds it to the bundled catalog | [V] Codex changelog |
| 2026-10-01 | Deprecations: `gpt-5.3-codex`, `gpt-5.1` (to `gpt-6-sol`), `gpt-5.4-nano` (to `gpt-6-luna`), shutdown 2027-04-01 | [V] deprecations |
| 2026-10-14 (scheduled) | `gpt-5.5` retires from ChatGPT, ChatGPT Work and **Codex**. Stays on the API | [V] learn.chatgpt.com/docs/models |

Also retired since baseline in Codex: `gpt-5.4`, `gpt-5.4-mini` (2026-08-31),
`gpt-5.3-codex-spark` (2026-09-14) [V learn.chatgpt.com/docs/models].
`gpt-5.4-cyber` shutdown 2026-10-01 [V deprecations].

Reported but not shipped: GPT-6.1 Astra reportedly cancelled over deceptive
behaviour in internal testing [S, Engadget, no vendor confirmation found].

No vendor deprecation notice exists for `gpt-5.6-sol`, `gpt-5.6-terra`,
`gpt-5.6-luna` or `gpt-6-sol`. They are no longer featured on the API models
landing page, which lists only Astra, 6.1 Sol and 6 Luna as flagship.

---

## 2. Anthropic: current models

Pricing source for all rows: [V] https://platform.claude.com/docs/en/about-claude/pricing (read 2026-10-04).
Lifecycle source: [V] https://platform.claude.com/docs/en/about-claude/model-deprecations (read 2026-10-04).
Specs: [V] https://platform.claude.com/docs/en/models/overview and per-model pages.

| API ID | Status | Released | Positioning (vendor) | Input / Output per MTok | Cache read | Context | Max out | Effort levels (default) | Retirement commitment |
|---|---|---|---|---|---|---|---|---|---|
| `claude-fable-5-1` | Active, **new** | 2026-09-01 | Top tier: "demanding reasoning and long-horizon agentic work" | $10 / $50 | $0.25 | 1M | 128K | low..max incl. xhigh (high) | not before 2027-09-01 |
| `claude-mythos-5-1` | Active, **new**, invite only (Glasswing) | 2026-09-01 | Cyber-defence variant of Fable 5.1 | $10 / $50 | $0.25 | 1M | 128K | low..max incl. xhigh (high) | not before 2027-09-01 |
| `claude-opus-5-5` | Active, **new** | 2026-09-22 | Flagship default: "start with Opus 5.5 for most workloads" | $4 / $20 | $0.20 | 1M | 128K | low..max incl. xhigh (**medium**). Thinking always on | not before 2027-09-22 |
| `claude-sonnet-5-5` | Active, **new** | 2026-09-28 | Mid: "best combination of speed and intelligence" | $2 / $10 | $0.20 | 1M | 128K | low..max incl. xhigh (high on API) | not before 2027-09-28 |
| `claude-haiku-4-5` (`-20251001`) | Active, current | 2025-10-01 per ID | Cheap: "fastest model with near-frontier intelligence" | $1 / $5 | $0.10 | 200K | 64K | effort not supported (extended thinking only) | not before **2026-10-15** |
| `claude-fable-5` | Legacy | 2026-06-09 | Superseded by Fable 5.1 | $10 / $50 | $1 | 1M | 128K | low..max incl. xhigh (high). No per-message effort | not before 2027-06-09 |
| `claude-mythos-5` | Legacy, invite only | 2026-06-09 | Glasswing variant of Fable 5 | $10 / $50 | $1 | 1M | 128K | same as Fable 5 | not before 2027-06-09 |
| `claude-opus-5` | Legacy | 2026-07-24 | Superseded by Opus 5.5 | $5 / $25 | $0.50 | 1M | 128K | low..max incl. xhigh (high) | not before 2027-07-24 |
| `claude-opus-4-8` | Legacy | 2026-05-28 | Superseded by Opus 5.5 | $5 / $25 | $0.50 | 1M | 128K | low..max incl. xhigh (high) | not before 2027-05-28 |
| `claude-sonnet-5` | Legacy | 2026-06-30 | Superseded by Sonnet 5.5 | $2 / $10 | $0.20 | 1M | 128K | low..max incl. xhigh (high) | not before 2027-06-30 |
| `claude-sonnet-4-5-20250929` | **Deprecated** 2026-09-30 | (not in baseline) | Replacement: `claude-sonnet-5-5` | $3 / $15 | $0.30 | n/a | n/a | n/a | **2026-11-30** |

Notes, all [V]:
- Release dates for legacy models come from their model pages:
  [opus-5](https://platform.claude.com/docs/en/models/opus-5/overview),
  [fable-5](https://platform.claude.com/docs/en/models/fable-5/overview),
  [sonnet-5](https://platform.claude.com/docs/en/models/sonnet-5/overview),
  [opus-4-8](https://platform.claude.com/docs/en/models/opus-4-8/overview).
  New-model dates come from the
  [release notes](https://platform.claude.com/docs/en/release-notes/overview).
- Haiku 4.5 release date is inferred from the snapshot suffix `20251001`, not
  read from a page.
- Effort levels and defaults:
  [effort doc](https://platform.claude.com/docs/en/build-with-claude/effort).
  `xhigh` is available on Fable 5.1, Mythos 5.1, Fable 5, Mythos 5, Opus 5.5,
  Opus 5, Opus 4.8, Opus 4.7, Sonnet 5.5 and Sonnet 5. Opus 5.5 is the only
  model whose API default is `medium`.
- Per-message effort change (beta, header
  `mid-conversation-output-config-2026-07-01`): Fable 5.1, Mythos 5.1,
  Opus 5.5, Opus 5, Sonnet 5.5. Not Fable 5.
- Fast mode (research preview, Claude API only): Opus 5.5 at $8/$40, Opus 5
  and Opus 4.8 at $10/$50.
- Batch is 50% off. Long context (to 1M) is billed at standard rates for 4.6+
  models. US-only `inference_geo` is 1.1x.
- Breaking API changes worth knowing for delegation (from release notes):
  Opus 5.5 rejects `thinking: disabled` and `tool_choice` `any`/`tool`.
  Fable 5.1 and Sonnet 5.5 also reject `tool_choice` `any`/`tool`.
  Fable 5.1, Mythos 5.1 and Fable 5 require 30-day retention (no ZDR by
  default).

### Claude Code CLI specifics

Source: [V] https://code.claude.com/docs/en/model-config (read 2026-10-04).

- Aliases on the Anthropic API: `opus` resolves to Opus 5.5, `sonnet` to
  Sonnet 5.5, `fable` to Fable 5.1 (Fable 5 in "Claude apps gateway"
  sessions), `best` to `fable` where available else `opus`, plus `haiku`,
  `opusplan`, `opus[1m]`, `sonnet[1m]`.
- Default model on Pro, Max, Team, Enterprise and Anthropic API: Opus 5.5.
- Provider-dependent resolution: on Microsoft Foundry `opus` is still Opus 4.6
  and `sonnet` is Sonnet 4.5. On Bedrock and Google Cloud `sonnet` is Sonnet
  4.5. On Claude Platform on AWS `sonnet` is Sonnet 4.6.
- Minimum Claude Code versions: Fable 5.1 v2.1.257, Opus 5.5 v2.1.280,
  Sonnet 5.5 v2.1.284.
- Effort in Claude Code: `low/medium/high/xhigh/max` for Fable 5.1, Fable 5,
  Opus 5.5, Sonnet 5.5, Opus 5, Sonnet 5, Opus 4.8, Opus 4.7. Defaults:
  Opus 5.5 and **Sonnet 5.5 both `medium`** in Claude Code, Opus 4.7 `xhigh`,
  others `high`.
- **Discrepancy:** the API effort doc says Sonnet 5.5 defaults to `high` on
  the API, while the Claude Code page says `medium` in Claude Code. Both are
  vendor docs and may simply describe different surfaces. Treat the CLI
  default as `medium`.

---

## 3. OpenAI: current models

Pricing source: [V] https://developers.openai.com/api/docs/pricing (read 2026-10-04).
Per-model specs: [V] https://developers.openai.com/api/docs/models/<id> (read 2026-10-04).
Codex availability and effort labels: [V] https://learn.chatgpt.com/docs/models (read 2026-10-04).

Standard tier, short context (up to 272K input). Long context (over 272K
input) is 2x input and cache, 1.5x output, per each model page. Batch is 50%
off.

| API ID | Status | Released | Positioning (vendor) | Input / Cached / Output per 1M | Context (max input) | Max out | API reasoning efforts (default) | In Codex CLI list? |
|---|---|---|---|---|---|---|---|---|
| `gpt-6-astra` | Current flagship, **new** | 2026-09-03 [V-snip, S] | "Our most capable model for the most demanding work" | $10 / $1.00 / $50 (cache write $12.50) | 1.05M (922K) | 128K | low, medium, high, xhigh, max (medium). No `none` | yes |
| `gpt-6.1-sol` | Current mid, **new** | 2026-09-29 [V changelog] | "Near-Astra performance for complex work at a lower cost" | $2 / $0.10 / $10 | 1.05M (922K) | 128K | low, medium, high, xhigh, max (medium). No `none` | yes |
| `gpt-6-luna` | Current cheap, **new** | 2026-09-22 [V-snip, S] | "Our most efficient model for focused, high-volume tasks" | $0.10 / $0.01 / $0.50 (cache write $0.125) | 1.05M (922K) | 128K | none, low, medium, high, xhigh, max (medium) | yes |
| `gpt-6-sol` | Superseded by 6.1 Sol, no deprecation notice | 2026-09-22 [V-snip, S] | "Built for complex coding and agentic workflows". Page notes 6.1 Sol is newer | $2 / $0.20 / $10 (cache write $2.50) | 1.05M (922K) | 128K | none, low, medium, high, xhigh, max (medium) | yes |
| `gpt-5.6-sol` | Previous gen, no deprecation notice | 2026-06-26 preview, 2026-07-09 GA [S] | "Flagship ... complex professional work" (page not yet updated) | $4 / $0.40 / $20 **promotional**, at least through 2026-11-21 (list was $5/$30 [S]) | 1.05M | 128K | none..max | yes |
| `gpt-5.6-terra` | Previous gen, no deprecation notice | same as above [S] | Mini-tier "balances intelligence with cost" | $2 / $0.20 / $12 | 1.05M | 128K | none..max | yes |
| `gpt-5.6-luna` | Previous gen, no deprecation notice | same as above [S] | Nano-tier "cost-sensitive, high-volume" | $0.20 / $0.02 / $1.20 | 1.05M | 128K | none..max | yes |
| `gpt-5.5` | **Retiring from Codex 2026-10-14**, stays on API | snapshot `gpt-5.5-2026-04-23` | "Flagship model for the most complex professional work" (legacy wording) | $5 / $0.50 / $30 | 1.05M | 128K | none, low, medium, high, xhigh (medium) | yes, until 2026-10-14 |

Notes:
- Release dates for the GPT-6 family rest on OpenAI launch posts I could see
  only as search snippets (https://openai.com/index/gpt-6-astra/,
  https://openai.com/index/introducing-gpt-6-sol-and-luna/,
  https://openai.com/index/introducing-gpt-6-1-sol/), corroborated by
  [S] https://www.macrumors.com/2026/09/22/openai-gpt-6-sol-luna/,
  https://en.wikipedia.org/wiki/GPT-6_Astra,
  https://evolink.ai/blog/gpt-6-release-date and
  https://evolink.ai/blog/gpt-6-1-sol-release-date. The 6.1 Sol date is
  confirmed first-hand by the vendor Codex changelog
  (https://learn.chatgpt.com/docs/changelog, entry 2026-09-29).
- GPT-5.6 launch dates and the 2026-07-30 Terra/Luna cut are [S] only
  (https://www.cloudzero.com/blog/gpt-5-6-pricing/,
  https://www.layer3labs.io/guides/gpt-5-6-pricing). The current prices in
  the table are [V]. The baseline roster may already have recorded the
  post-cut Terra/Luna prices, since the cut predates 2026-08-05.
- Reported migration discount: MacRumors and others say GPT-6 Sol/Luna
  pricing "includes a stated 50% price reduction for customers migrating from
  GPT-5.6 Sol and Luna" [S]. I found no such footnote on the vendor pricing
  page. Treat it as unverified.
- Priority/Fast tier rows exist on the pricing page but the fetcher could not
  extract exact per-model figures. Not reported here.
- Knowledge cutoffs [V]: Astra and 6.1 Sol 2026-04-30, 6 Sol 2026-04-20,
  6 Luna 2026-05-18, 5.6 family 2026-02-16, 5.5 2025-12-01.
- API migration notes [V https://developers.openai.com/api/docs/guides/latest-model]:
  Astra and 6.1 Sol do not accept `none` effort. Tool calling on 6.1 Sol
  requires the Responses API.

### Codex CLI specifics

Source: [V] https://learn.chatgpt.com/docs/models and /docs/changelog (read 2026-10-04).

- Recommended models in Codex: Astra (`gpt-6-astra`), GPT-6.1 Sol
  (`gpt-6.1-sol`), GPT-6 Luna (`gpt-6-luna`).
- Codex `model_reasoning_effort` values: `low`, `medium`, `high`, `xhigh`,
  `max`, **`ultra`**. UI labels: Light (app) or Low (CLI), Medium, High,
  Extra High, Max, Ultra. `ultra` is Codex-only, not an API value.
  Per [S] guides, Ultra fans work out to parallel subagents rather than being
  a deeper single-agent setting.
- Per-model effort ranges stated by the Codex models page: Astra "Light
  through Extra High", 6.1 Sol "Light through Ultra", 6 Luna "up to Max (not
  Ultra)". **Discrepancy:** the API docs say Astra supports `max`. In Codex,
  Astra may be capped at Extra High. Worth a live check with the CLI.
- Codex CLI versions: 0.159.1 (2026-09-29) added 6.1 Sol to the bundled and
  Bedrock catalogs. Latest seen is 0.160.0 (2026-10-01).
- [S] A third-party PR reports the Codex model-list cache advertises a 272K
  default context for `gpt-6.1-sol` in Codex, versus 1.05M on the API
  (https://github.com/selvaz/LazyTools/pull/176). Unverified.
- `gpt-5.5` replacement in Codex after 2026-10-14: `gpt-6-sol` for
  Plus/Pro/Business, `gpt-6-luna` for Free/Go.
- Model availability differs between ChatGPT sign-in and API-key auth.
  Enterprise/Edu admins gate 6.1 Sol and Luna.

---

## 4. Deltas against the baseline roster

| Baseline entry | Now | Action implied (not a capability judgement) |
|---|---|---|
| claude-opus-5 | Legacy. Superseded by `claude-opus-5-5`, which is cheaper | add Opus 5.5, consider demoting Opus 5 |
| claude-opus-4-8 | Legacy | consider dropping |
| claude-fable-5 | Legacy. Superseded by `claude-fable-5-1`, same price, cheaper cache | add Fable 5.1 |
| claude-sonnet-5 | Legacy. Superseded by `claude-sonnet-5-5`, same price | add Sonnet 5.5 |
| claude-haiku-4-5 | Current, but retirement floor 2026-10-15 | watch for a deprecation notice |
| gpt-5.6-sol | Previous gen, promo $4/$20 until at least 2026-11-21 | add `gpt-6.1-sol` and `gpt-6-astra` |
| gpt-5.6-terra | Previous gen. No GPT-6 "Terra" tier exists | mid tier now filled by `gpt-6.1-sol` |
| gpt-5.6-luna | Previous gen | add `gpt-6-luna` (half the price) |
| (absent) gpt-6-sol | Superseded within one week by 6.1 Sol | probably skip |
| (absent) gpt-5.5 | Leaves Codex 2026-10-14 | do not add |

---

## 5. Source index

Vendor, read directly on 2026-10-04:
- https://platform.claude.com/docs/en/models/overview
- https://platform.claude.com/docs/en/about-claude/pricing
- https://platform.claude.com/docs/en/about-claude/model-deprecations
- https://platform.claude.com/docs/en/build-with-claude/effort
- https://platform.claude.com/docs/en/release-notes/overview
- https://platform.claude.com/docs/en/models/opus-5/overview
- https://platform.claude.com/docs/en/models/fable-5/overview
- https://platform.claude.com/docs/en/models/sonnet-5/overview
- https://platform.claude.com/docs/en/models/opus-4-8/overview
- https://code.claude.com/docs/en/model-config
- https://developers.openai.com/api/docs/models
- https://developers.openai.com/api/docs/pricing
- https://developers.openai.com/api/docs/deprecations
- https://developers.openai.com/api/docs/guides/latest-model
- https://developers.openai.com/api/docs/models/gpt-6-astra
- https://developers.openai.com/api/docs/models/gpt-6.1-sol
- https://developers.openai.com/api/docs/models/gpt-6-sol
- https://developers.openai.com/api/docs/models/gpt-6-luna
- https://developers.openai.com/api/docs/models/gpt-5.6-sol
- https://developers.openai.com/api/docs/models/gpt-5.6-terra
- https://developers.openai.com/api/docs/models/gpt-5.6-luna
- https://developers.openai.com/api/docs/models/gpt-5.5
- https://learn.chatgpt.com/docs/models (redirect target of developers.openai.com/codex/models)
- https://learn.chatgpt.com/docs/changelog (redirect target of developers.openai.com/codex/changelog)

Vendor, seen only as search snippets (fetch returned 403), 2026-10-04:
- https://openai.com/index/gpt-6-astra/
- https://openai.com/index/introducing-gpt-6-sol-and-luna/
- https://openai.com/index/introducing-gpt-6-1-sol/
- https://help.openai.com/en/articles/6825453-chatgpt-release-notes

Secondhand, via search on 2026-10-04:
- https://www.macrumors.com/2026/09/22/openai-gpt-6-sol-luna/
- https://en.wikipedia.org/wiki/GPT-6_Astra
- https://evolink.ai/blog/gpt-6-release-date
- https://evolink.ai/blog/gpt-6-1-sol-release-date
- https://www.datacamp.com/blog/gpt-6-1-sol
- https://www.cloudzero.com/blog/gpt-5-6-pricing/
- https://www.layer3labs.io/guides/gpt-5-6-pricing
- https://www.engadget.com/2271626/openai-cancels-gpt-6-1-astra-release-deceptive-behavior/
- https://github.com/selvaz/LazyTools/pull/176
- https://kingy.ai/news/openai-codex-reasoning-levels-low-medium-high-extra-high/
