# Model drift research

Researcher model: `gpt-6.1-sol`. Read date for every linked source and every price: **2026-10-04**. Live web search succeeded. Research performed independently, without subagents.

## Findings

The baseline needs four new OpenAI entries and three new general-purpose Claude entries. None of the eight baseline IDs has a documented retirement announcement in the sources reviewed. GPT-5.5 has a separate Codex retirement date despite remaining available through the API. Vendor positioning below is attribution, not an independent capability assessment.

All citations below are first-party vendor documentation. Search also returned news and Reddit results, but no secondhand report is used as evidence. API specifications describe model limits, not necessarily the usable conversation size or selectable efforts in a particular CLI, plan, or gateway.

## OpenAI changes since August 5

- August 5, boundary event: long-context Fast mode became available for the three GPT-5.6 models.
- August 13: GPT-5.6 Sol Ultrafast announced in limited preview.
- August 21: GPT-5.6 Sol promotional input/output prices fell to $4/$20 per million tokens, guaranteed at least through November 21.
- September 3: GPT-6 Astra released.
- September 22: GPT-6 Sol and GPT-6 Luna released.
- September 25: image-encoding correction for GPT-6 Sol and Luna, without new IDs.
- September 29: GPT-6.1 Sol released and Astra Ultrafast became available through Responses.

Source for these dated events: [OpenAI API changelog](https://developers.openai.com/api/docs/changelog), read 2026-10-04. Sol 6.1 is a distinct model ID, not evidence that Sol 6 was renamed or retired.

### Current roster

Prices are USD per **one million tokens**, Standard processing, at most 272K input tokens. Divide by 1,000,000 for dollars per token. Price columns are input, cached input, cache write, output. `E5` means `low`, `medium`, `high`, `xhigh`, `max`. `E6` adds `none`. Each model link supports that row's positioning, context, reasoning settings, and model pricing, read 2026-10-04.

| Exact API and CLI ID | API release date | Vendor positioning | Context tokens | API reasoning | Price I / cached I / write / O |
| --- | --- | --- | --- | --- | --- |
| [`gpt-6.1-sol`](https://developers.openai.com/api/docs/models/gpt-6.1-sol) | 2026-09-29 | Near-Astra work at lower cost | 1,050,000 | E5, medium default | 2 / 0.10 / 2.50 / 10 |
| [`gpt-6-astra`](https://developers.openai.com/api/docs/models/gpt-6-astra) | 2026-09-03 | Most capable, demanding work | 1,050,000 | E5 | 10 / 1 / 12.50 / 50 |
| [`gpt-6-sol`](https://developers.openai.com/api/docs/models/gpt-6-sol) | 2026-09-22 | Complex coding and agentic work | 1,050,000 | E6, medium default | 2 / 0.20 / 2.50 / 10 |
| [`gpt-6-luna`](https://developers.openai.com/api/docs/models/gpt-6-luna) | 2026-09-22 | Efficient, focused high-volume work | 1,050,000 | E6, medium default | 0.10 / 0.01 / 0.125 / 0.50 |
| [`gpt-5.6-sol`](https://developers.openai.com/api/docs/models/gpt-5.6-sol) | 2026-07-09 | GPT-5.6 flagship | 1,050,000 | E6, medium default | 4 / 0.40 / 5 / 20 |
| [`gpt-5.6-terra`](https://developers.openai.com/api/docs/models/gpt-5.6-terra) | 2026-07-09 | Balance of intelligence and cost, former mini tier | 1,050,000 | E6, medium default | 2 / 0.20 / 2.50 / 12 |
| [`gpt-5.6-luna`](https://developers.openai.com/api/docs/models/gpt-5.6-luna) | 2026-07-09 | Cost-sensitive work, former nano tier | 1,050,000 | E6, medium default | 0.20 / 0.02 / 0.25 / 1.20 |
| [`gpt-5.5`](https://developers.openai.com/api/docs/models/gpt-5.5) | 2026-04-24, API | Previous flagship, professional work | 1,050,000 | none, low, medium default, high, xhigh | 5 / 0.50 / write not established here / 30 |

Release dates refer to API availability, from the [API changelog](https://developers.openai.com/api/docs/changelog), read 2026-10-04. Earlier ChatGPT or Codex availability can differ. All rows have 128,000 maximum output tokens according to their linked model pages.

GPT-6 pricing for prompts above 272K input tokens doubles input/cache rates and multiplies output rates by 1.5 for the full request. Batch and Flex cost half of Standard, Fast costs twice Standard. Astra Ultrafast costs six times Standard: short-context 60 / 6 / 75 / 300, long-context 120 / 12 / 150 / 450. Regional and FedRAMP processing adds 10% where applicable. [OpenAI pricing](https://developers.openai.com/api/docs/pricing), read 2026-10-04. The older GPT-5.6 and GPT-5.5 model pages likewise document the >272K input/output uplift. GPT-5.6 cache writes cost 1.25 times input.

### Availability and deprecations

The [Codex model documentation](https://learn.chatgpt.com/docs/models), read 2026-10-04, confirms the three GPT-5.6 models remain available during rollout. It documents `codex -m MODEL_ID` selection, GPT-6.1 Sol, Astra, and Luna. Account, client, and administrator settings affect access. Ultra uses subagents and is a CLI orchestration option, not an additional API `reasoning.effort` enum. GPT-6.1 Sol can expose Ultra, Luna supports up to Max only.

That same source states:

- GPT-5.4 and GPT-5.4-mini retired from Codex with ChatGPT sign-in on August 31, 2026.
- GPT-5.5 retires from ChatGPT, Work, and Codex on October 14, 2026, while remaining available through the API.

The [API deprecations page](https://developers.openai.com/api/docs/deprecations), read 2026-10-04, announces on October 1 that `gpt-5.3-codex`, `gpt-5.1`, and `gpt-5.4-nano` retire April 1, 2027. It records `gpt-5.4-cyber` deprecated September 11 and removed October 1. `gpt-5.2-chat-latest` and `gpt-5.3-chat-latest` shut down August 10 following earlier notices. No GPT-6, GPT-5.6, or GPT-5.5 API retirement notice was found there. Absence of a notice is not a vendor guarantee of indefinite availability.

## Anthropic changes since August 5

- August 5, boundary event: Opus 4.1 retired, following its June notice.
- August 10: Sonnet 5's $2/$10 introductory price became permanent. The planned September increase was cancelled.
- September 1: Fable 5.1 and restricted Mythos 5.1 released, with cache reads reduced to $0.25/MTok.
- September 22: Opus 5.5 released at $4/$20, below Opus 5's $5/$25. This is a new model, not a repricing of Opus 5.
- September 28: Sonnet 5.5 released.
- September 30: Sonnet 4.5 deprecated, retirement November 30.

Sources: [Claude release notes](https://platform.claude.com/docs/en/release-notes/overview), [Opus 5.5 model page](https://platform.claude.com/docs/en/models/opus-5-5/overview), and [deprecations](https://platform.claude.com/docs/en/about-claude/model-deprecations), all read 2026-10-04. No baseline model rename or baseline retirement was found.

### Current general-purpose roster

All prices below are USD/MTok, read 2026-10-04, ordered input / output / 5-minute cache write / 1-hour cache write / cache read. Each linked model page supports its row. All non-Haiku entries support `low`, `medium`, `high`, `xhigh`, `max`, per [Anthropic effort documentation](https://platform.claude.com/docs/en/build-with-claude/effort), read 2026-10-04. Default effort is high except Opus 5.5, which defaults to medium. Haiku has extended thinking but no effort parameter.

| Exact API and CLI ID | Release date | Vendor role | Context / max output | Pricing | Status and earliest retirement |
| --- | --- | --- | --- | --- | --- |
| [`claude-fable-5-1`](https://platform.claude.com/docs/en/models/fable-5-1/overview) | 2026-09-01 | Demanding reasoning, long-horizon work | 1M / 128K | 10 / 50 / 12.50 / 20 / 0.25 | Active, not before 2027-09-01 |
| [`claude-opus-5-5`](https://platform.claude.com/docs/en/models/opus-5-5/overview) | 2026-09-22 | Default recommendation, agentic coding and knowledge work | 1M / 128K | 4 / 20 / 5 / 8 / 0.20 | Active, not before 2027-09-22 |
| [`claude-sonnet-5-5`](https://platform.claude.com/docs/en/models/sonnet-5-5/overview) | 2026-09-28 | Balance of speed and intelligence | 1M / 128K | 2 / 10 / 2.50 / 4 / 0.20 | Active, not before 2027-09-28 |
| [`claude-fable-5`](https://platform.claude.com/docs/en/models/fable-5/overview) | 2026-06-09 | Prior Fable premium tier | 1M / 128K | 10 / 50 / 12.50 / 20 / 1 | Active legacy, not before 2027-06-09 |
| [`claude-opus-5`](https://platform.claude.com/docs/en/models/opus-5/overview) | 2026-07-24 | Prior Opus premium tier | 1M / 128K | 5 / 25 / 6.25 / 10 / 0.50 | Active legacy, not before 2027-07-24 |
| [`claude-opus-4-8`](https://platform.claude.com/docs/en/models/opus-4-8/overview) | 2026-05-28 | Earlier Opus premium tier | 1M / 128K | 5 / 25 / 6.25 / 10 / 0.50 | Active legacy, not before 2027-05-28 |
| [`claude-sonnet-5`](https://platform.claude.com/docs/en/models/sonnet-5/overview) | 2026-06-30 | Prior Sonnet balanced tier | 1M / 128K | 2 / 10 / 2.50 / 4 / 0.20 | Active legacy, not before 2027-06-30 |
| [`claude-haiku-4-5-20251001`](https://platform.claude.com/docs/en/models/haiku-4-5/overview), alias `claude-haiku-4-5` | 2025-10-15 | Fast, economical tier | 200K / 64K | 1 / 5 / 1.25 / 2 / 0.10 | Active, not before 2026-10-15 |

Opus 5.5's default recommendation is from the [models overview](https://platform.claude.com/docs/en/models/overview), read 2026-10-04. Legacy means a newer version is recommended, not that the model is deprecated. Retirement commitments are independently listed on the [status page](https://platform.claude.com/docs/en/about-claude/model-deprecations), read 2026-10-04.

Fable 5/5.1 and Opus 5.5 have always-on adaptive thinking. Opus 5, Opus 4.8, Sonnet 5, and Sonnet 5.5 use adaptive thinking. Sonnet 5.5 supports `between_tools` at high effort or below to remove up-front thinking, rather than `disabled`. These are model-specific controls, supported by the linked model pages.

[Claude pricing](https://platform.claude.com/docs/en/about-claude/pricing), read 2026-10-04, documents a 50% Batch discount on input/output. Fast mode is a research preview: Opus 5.5 costs $8/$40, Opus 5 and Opus 4.8 cost $10/$50 per MTok. These are separate speed-tier prices, not replacements for the Standard rates.

### CLI distinctions and restricted models

[Claude Code model configuration](https://code.claude.com/docs/en/model-config), read 2026-10-04, permits full API model names with `claude --model MODEL_ID`. Opus 5.5 requires Claude Code 2.1.280+, Sonnet 5.5 requires 2.1.284+. The `fable` alias normally resolves to Fable 5.1 but resolves to Fable 5 through the Claude apps gateway. Pin exact IDs rather than assuming aliases are stable. Sonnet 5/5.5 always use 1M context on the Anthropic API. Other families can have plan-specific context selection. API effort support should not be treated as proof that every CLI surface offers the same controls.

Mythos 5.1 (`claude-mythos-5-1`) was released September 1 for Project Glasswing participants, at $10/$50, 1M context, 128K output, always-on adaptive thinking, cache read $0.25. The effort page supports all five levels. Its lifecycle is Active, not before September 1, 2027. [Release notes](https://platform.claude.com/docs/en/release-notes/overview), [effort](https://platform.claude.com/docs/en/build-with-claude/effort), [status](https://platform.claude.com/docs/en/about-claude/model-deprecations), read 2026-10-04. Ordinary `claude` CLI access was not established, so this is a restricted release rather than a general delegation option.

Claude Code supports all five effort levels for every non-Haiku Claude row above. Its Sonnet 5.5 default is **medium**, unlike the API's high default. Ultracode is workflow orchestration, not a sixth model effort level. [Claude Code configuration](https://code.claude.com/docs/en/model-config), read 2026-10-04.

Similarly, the OpenAI changelog records August 7 access-tier changes for `gpt-5.6-cyber`, `gpt-daybreak-red-latest`, and `gpt-daybreak-blue-latest`, requiring separate approval/provisioning. Their general Codex CLI availability was not established. They should not silently enter the ordinary model roster. [API changelog](https://developers.openai.com/api/docs/changelog), read 2026-10-04.

## Limits of this inventory

The eight supplied Codex IDs are handoff observations, not independently executed local model-selection tests. Official sources establish model identity and specifications but cannot prove this account can invoke each one. This report covers all baseline entries and newly identified general-purpose releases. Restricted cyber/research models are recorded separately, without claiming ordinary CLI access. No capability rankings or benchmarks were evaluated.
