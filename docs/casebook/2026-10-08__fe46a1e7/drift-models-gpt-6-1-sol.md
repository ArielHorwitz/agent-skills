Researcher model ID: `gpt-6.1-sol`

Research date: **2026-10-08**. Comparison window: after the 2026-10-04 baseline through the sources available on 2026-10-08. Live web search succeeded. Research was performed independently, without subagents. All sources below are vendor documentation, announcements, or vendor-maintained changelogs. No secondhand reports support the findings. Positioning describes the vendor's product tier, without assessing capability.

**Confirmed delta:** Anthropic released `claude-haiku-5-5` and halved `claude-sonnet-5-5` cache-read pricing on **2026-10-07**. Haiku 5.5 requires Claude Code **2.1.293 or later** according to its CLI documentation. [Anthropic release notes](https://platform.claude.com/docs/en/release-notes/overview), entries dated 2026-10-07, read 2026-10-08. [Claude Code model configuration](https://code.claude.com/docs/en/model-config), read 2026-10-08.

For OpenAI, I found **no new general-purpose GPT/Codex model, model rename, token-price change, or baseline-model deprecation/retirement announcement** in the comparison window. There is a CLI change: **Codex 0.161.0**, released **2026-10-07**, makes GPT-6.1 Sol the bundled and Amazon Bedrock catalog default. This changes model selection, not its release date or price. These are findings from the reviewed records, not proof against an undocumented change. [OpenAI API changelog](https://developers.openai.com/api/docs/changelog), [API pricing](https://developers.openai.com/api/docs/pricing), [API deprecations](https://developers.openai.com/api/docs/deprecations), and [ChatGPT/Codex changelog](https://learn.chatgpt.com/docs/changelog), all read 2026-10-08.

**Anthropic: new and repriced models**

The specifications in each column come from that model's linked vendor page, read **2026-10-08**. Effort details are expanded below.

| Field | New: Claude Haiku 5.5 | Repriced baseline model: Claude Sonnet 5.5 |
| --- | --- | --- |
| Exact first-party API / CLI model ID | `claude-haiku-5-5` | `claude-sonnet-5-5` |
| Model release date | 2026-10-07 | 2026-09-28, before baseline |
| Change date | 2026-10-07 launch | 2026-10-07 cache-read price reduction |
| Vendor positioning | Cheap small-model tier for high-volume, latency-sensitive classification, extraction, routing, and subagent tasks | Middle tier combining speed and intelligence |
| Context window | 1,000,000 tokens | 1,000,000 tokens |
| Max ordinary API output | 128,000 tokens | 128,000 tokens |
| Thinking | Adaptive, on by default | Adaptive, on by default |
| Effort levels | `low`, `medium`, `high`, `xhigh`, `max` | `low`, `medium`, `high`, `xhigh`, `max` |
| API default effort | `medium` | `high` |
| Claude Code default effort | `medium` | `medium` |
| Lifecycle status | Active, not deprecated | Active, not deprecated |
| Earliest stated retirement | Not sooner than 2027-10-07 | Not sooner than 2027-09-28 |
| Model source | [Haiku overview, read 2026-10-08](https://platform.claude.com/docs/en/models/haiku-5-5/overview) | [Sonnet overview, read 2026-10-08](https://platform.claude.com/docs/en/models/sonnet-5-5/overview) |

Sources for the change date and effort rows: [release notes](https://platform.claude.com/docs/en/release-notes/overview), entry 2026-10-07, [API effort documentation](https://platform.claude.com/docs/en/build-with-claude/effort), and [Claude Code configuration](https://code.claude.com/docs/en/model-config), all read 2026-10-08. The tier labels are a shorthand for the vendor positioning, not a benchmark comparison.

All prices below are **USD per 1,000,000 tokens**, read **2026-10-08**. Divide by 1,000,000 for dollars per token. These are standard first-party API token rates.

| Model / prompt length | Uncached input | Output | Cache read | Cache write, 5 minutes | Cache write, 1 hour |
| --- | ---: | ---: | ---: | ---: | ---: |
| Haiku 5.5, prompt up to and including 100,000 tokens | $0.10 | $0.50 | $0.01 | $0.125 | $0.20 |
| Haiku 5.5, prompt over 100,000 tokens | $0.50 | $2.50 | $0.05 | $0.625 | $1.00 |
| Sonnet 5.5, full context window | $2.00 | $10.00 | **$0.10, previously $0.20** | $2.50 | $4.00 |

Sources for all table prices: [Haiku model pricing](https://platform.claude.com/docs/en/models/haiku-5-5/overview), [Sonnet model pricing](https://platform.claude.com/docs/en/models/sonnet-5-5/overview), and [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing), read 2026-10-08. The Sonnet reduction is explicitly dated **2026-10-07**, with cache writes and every other price unchanged. Haiku's threshold changes both input and output rates. [Release notes](https://platform.claude.com/docs/en/release-notes/overview), entry 2026-10-07, read 2026-10-08.

Both models have a **50% Batch API input/output discount**. Both also advertise a **300,000-token max output in Message Batches beta**, using `output-300k-2026-03-24`. That exception is separate from their ordinary 128,000-token output limit and is not a Claude Code output setting. [Haiku overview](https://platform.claude.com/docs/en/models/haiku-5-5/overview) and [Sonnet overview](https://platform.claude.com/docs/en/models/sonnet-5-5/overview), read 2026-10-08.

Haiku's API permits `thinking: {type: "disabled"}` at `low`, `medium`, or `high`, but rejects it at `xhigh` or `max`. Manual `budget_tokens` thinking is unsupported. Sonnet's lowest API thinking setting is `between_tools`, permitted at `high` and below. **Claude Code exposes neither model's API thinking-off option:** its documentation says thinking cannot be turned off for Haiku 5.5 or Sonnet 5.5. [API effort](https://platform.claude.com/docs/en/build-with-claude/effort), [release notes](https://platform.claude.com/docs/en/release-notes/overview), and [CLI configuration](https://code.claude.com/docs/en/model-config), read 2026-10-08.

Select Haiku explicitly with `claude --model claude-haiku-5-5`. The current first-party `haiku` alias resolves to Haiku 5.5, while the documented AWS, Bedrock, Google Cloud, and Foundry aliases still resolve to Haiku 4.5. The first-party CLI uses Haiku 5.5's native 1M context without a `[1m]` suffix. [Claude Code configuration](https://code.claude.com/docs/en/model-config), read 2026-10-08. The vendor changelog records its addition in **2.1.293**, but does not date that version heading. [Claude Code changelog](https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md), read 2026-10-08.

**Anthropic baseline audit:** only Sonnet 5.5 has an announced repricing in this window. No additional release, rename, repricing, deprecation, or retirement was found for `claude-opus-5-5`, `claude-fable-5-1`, `claude-haiku-4-5`, `claude-opus-5`, `claude-opus-4-8`, `claude-fable-5`, or `claude-sonnet-5` in the reviewed release and pricing records. [Release notes](https://platform.claude.com/docs/en/release-notes/overview) and [pricing](https://platform.claude.com/docs/en/about-claude/pricing), read 2026-10-08.

All eight Anthropic baseline models remain **Active** in the lifecycle table. Haiku 4.5 is listed by its pinned ID `claude-haiku-4-5-20251001`, with retirement **not sooner than 2026-10-15**. That is an earliest commitment boundary, not an announced October 15 shutdown. The latest listed deprecation is Sonnet 4.5, announced **2026-09-30**, outside this window and outside the baseline roster. Haiku 5.5's launch has not deprecated Haiku 4.5. [Anthropic model deprecations](https://platform.claude.com/docs/en/about-claude/model-deprecations), read 2026-10-08.

**OpenAI: CLI default change and adjacent API update**

GPT-6.1 Sol became the Codex default on **2026-10-07**, but its API release was **2026-09-29**. GPT-6 Luna was released **2026-09-22** and gained the beta **Decisions API** endpoint on **2026-10-06**. The latter is an endpoint addition to an existing model, not a new CLI model or token-price reduction. [ChatGPT/Codex changelog](https://learn.chatgpt.com/docs/changelog), entries 2026-10-07, and [API changelog](https://developers.openai.com/api/docs/changelog), entries 2026-09-29, 2026-09-22, and 2026-10-06, read 2026-10-08.

| Field | GPT-6.1 Sol | GPT-6 Luna |
| --- | --- | --- |
| Exact API / CLI ID | `gpt-6.1-sol` | `gpt-6-luna` |
| Vendor positioning | Workhorse for complex coding and professional work at lower cost than Astra | Cheap tier for focused, high-volume work |
| Context window | 1,050,000 tokens | 1,050,000 tokens |
| Max output | 128,000 tokens | 128,000 tokens |
| API reasoning efforts | `low`, `medium`, `high`, `xhigh`, `max` | `none`, `low`, `medium`, `high`, `xhigh`, `max` |
| API default effort | `medium` | `medium` |
| API deprecation | No notice found | No notice found |
| Model source | [Sol model page, read 2026-10-08](https://developers.openai.com/api/docs/models/gpt-6.1-sol) | [Luna model page, read 2026-10-08](https://developers.openai.com/api/docs/models/gpt-6-luna) |

Deprecation source for both rows: [OpenAI API deprecations](https://developers.openai.com/api/docs/deprecations), read 2026-10-08. Sol rejects `none` and `minimal`. Codex additionally offers **Ultra** for supported models as a multi-agent mode, beyond the ordinary API effort list. Luna supports up to Max, **not Ultra**. Codex 0.161.0 adds Ultra and multi-agent V2 on compatible Bedrock models. [Sol model page](https://developers.openai.com/api/docs/models/gpt-6.1-sol), [Codex models](https://learn.chatgpt.com/docs/models), and [Codex changelog](https://learn.chatgpt.com/docs/changelog), read 2026-10-08.

Standard prices, **USD per 1,000,000 tokens**, read **2026-10-08**:

| Model / input length | Uncached input | Cached input | Cache write | Output |
| --- | ---: | ---: | ---: | ---: |
| GPT-6.1 Sol, up to 272K | $2.00 | $0.10 | $2.50 | $10.00 |
| GPT-6.1 Sol, over 272K | $4.00 | $0.20 | $5.00 | $15.00 |
| GPT-6 Luna, up to 272K | $0.10 | $0.01 | $0.125 | $0.50 |
| GPT-6 Luna, over 272K | $0.20 | $0.02 | $0.25 | $0.75 |

Sources for all prices: [OpenAI pricing](https://developers.openai.com/api/docs/pricing), [Sol model page](https://developers.openai.com/api/docs/models/gpt-6.1-sol), and [Luna model page](https://developers.openai.com/api/docs/models/gpt-6-luna), read 2026-10-08. The long-input multipliers apply to the **full request**. Batch and Flex cost 50% of Standard, and Fast costs twice Standard. These API rates are distinct from ChatGPT subscription usage credits. [Sol model page](https://developers.openai.com/api/docs/models/gpt-6.1-sol), [Luna model page](https://developers.openai.com/api/docs/models/gpt-6-luna), and [Work/Codex pricing](https://learn.chatgpt.com/docs/pricing), read 2026-10-08.

**OpenAI baseline audit:** no new token repricing, rename, deprecation, or retirement was found for any of `gpt-6-astra`, `gpt-6.1-sol`, `gpt-6-luna`, `gpt-6-sol`, `gpt-5.6-sol`, `gpt-5.6-terra`, or `gpt-5.6-luna` in the reviewed dated records. GPT-5.6 Sol's current promotional pricing remains guaranteed at least through **2026-11-21**. That reduction was announced **2026-08-21**, before the baseline. [API changelog](https://developers.openai.com/api/docs/changelog), [API pricing](https://developers.openai.com/api/docs/pricing), and [API deprecations](https://developers.openai.com/api/docs/deprecations), read 2026-10-08.

**Previously announced retirement relevant to the supplied local list:** `gpt-5.5` retires from Codex with ChatGPT sign-in on **2026-10-14**, across all plans. The announcement was **2026-09-14**, so it is not new drift. The OpenAI API is unaffected. Its appearance in the supplied October 8 CLI list is compatible with a future retirement. [ChatGPT/Codex changelog](https://learn.chatgpt.com/docs/changelog), entry 2026-09-14, and [Codex model documentation](https://learn.chatgpt.com/docs/models), read 2026-10-08. The local-list observation itself is supplied by the [research brief](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/drift-brief.md), dated/read 2026-10-08, not independently tested here.

Two additional OpenAI items do not add a general-purpose CLI model: the API changelog updates `chat-latest` on **2026-10-07**, and GPT-Rosalind research billing begins **2026-10-05** under restricted research access. Neither appears in the supplied CLI roster. Codex 0.161.0 also changes **Daybreak access routing** to explicit opt-in and adds a per-turn Cyber program override, without announcing a new model ID. [API changelog](https://developers.openai.com/api/docs/changelog), [API pricing](https://developers.openai.com/api/docs/pricing), [Codex changelog](https://learn.chatgpt.com/docs/changelog), and [supplied brief](/mnt/black/prog/agent-skills/.worktrees/refresh-catalog-haiku-5-5/docs/casebook/2026-10-08__fe46a1e7/drift-brief.md), all read 2026-10-08.

**Evidence limits:** absence findings concern published changes in the specified window. Current pages establish today's settings and prices but do not, alone, prove they were identical on October 4. Dated changelogs establish the identified changes. No inference requests or CLI upgrades were performed, so account-specific access and behavior of older installed clients were not tested.
