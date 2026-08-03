# Delegate — available agents

<!--
Proposal notes (remove before merging into skills/delegate/models.md).

Structure: kept the original shape exactly — `## Tools` (one subsection per CLI)
then a single `## Models` table (tool, model, capability, notes), capability 1–5.

Sourcing / how each claim was verified (proposal by claude-opus-4-8):
- CLI invocation flags: verified locally against the actually-installed binaries
  `claude 2.1.220` and `codex-cli 0.146.0` via `--help`. Every flag below appears
  in that output. Re-verify when the CLIs update.
- Anthropic models, IDs, and pricing: from the bundled `claude-api` skill
  (Anthropic's own model catalog; pricing snapshot cached 2026-06-24). Treated as
  authoritative for Anthropic — not re-derived from the open web.
- OpenAI / codex models: verified via live WebSearch (Aug 2026), corroborated by
  the local `~/.codex/config.toml` (which is set to `model = "gpt-5.6-sol"`).
  Sources: OpenAI GPT-5.6 announcement (openai.com/index/gpt-5-6/), the Codex
  models docs (developers.openai.com/codex/models), and OpenAI's Sol/Terra/Luna
  preview notes.

Two concrete corrections to the current file, both verified:
1. codex model IDs use DOTS, not dashes: `gpt-5.6-sol`, not `gpt-5-6-sol`. The
   dashed forms in the current file do not exist and will error.
2. The codex lineup is a three-tier family (Sol / Terra / Luna). The current file
   omits the mid-tier `gpt-5.6-terra` — added below.
Also: `claude-opus-5` now exists as a same-price step-change over `claude-opus-4-8`
(per the Anthropic catalog), so it is added as the primary Opus recommendation.

Not included: Google's Gemini CLI. `gemini` is not installed in this environment
(`command not found`), so I did not invent an invocation for it. If it is added
later, give it its own `### gemini` subsection here.

Pricing figures are dated (Anthropic snapshot 2026-06-24; OpenAI figures reflect
the 2026-07-30 Luna/Terra price cuts) and may drift — they inform the capability
column but should not be quoted as live.
-->

## Tools

### claude

Non-interactive invocation, prompt over stdin:

    claude -p --model <model> --output-format json --permission-mode bypassPermissions

`-p`/`--print` is the non-interactive (print-and-exit) mode; `--output-format`,
`--permission-mode`, and `--model` only take effect alongside it.
`--permission-mode bypassPermissions` is used so a headless call never blocks on a
tool-permission prompt no one is present to answer (`bypassPermissions` is one of
`acceptEdits`/`auto`/`bypassPermissions`/`manual`/`dontAsk`/`plan`). `--output-format
json` returns a single structured result; use `text` if you only want the reply
body. (Verified against `claude 2.1.220 --help`.)

### codex

Non-interactive invocation, prompt over stdin, final message written to a file:

    codex exec --model <model> -s danger-full-access -o <output-file>

`codex exec` is codex's non-interactive mode. `-s`/`--sandbox` is the
sandbox/approval policy (`read-only`, `workspace-write`, `danger-full-access`) —
`danger-full-access` is used here so a headless call never blocks needing an
escalation no one is present to approve. `-o`/`--output-last-message <FILE>` writes
the agent's final message to a file (the current file's `-o` flag). The prompt is
read from stdin when not passed as an argument. (Verified against `codex-cli
0.146.0 codex exec --help`.)

> Note: codex model IDs contain dots — `gpt-5.6-sol`, not `gpt-5-6-sol`. The
> dashed variants used in the previous version of this file do not resolve.

## Models

Prefer balancing cost and intelligence when choosing between multiple appropriate
models. Capability is a coarse 1–5 (5 highest), judged across both vendors — it
blends raw intelligence with cost-efficiency, so a cheaper-but-strong model and an
expensive-but-frontier model can land on the same number for different reasons.

| tool | model | capability | notes |
| --- | --- | --- | --- |
| claude | claude-opus-5 | 5 | Default for hard code and orchestration. Frontier reasoning/agentic at $5/$25 per Mtok, 1M context — a step-change over Opus 4.8 at the same price (per Anthropic catalog). |
| claude | claude-fable-5 | 5 | Highest ceiling — the most demanding reasoning and long-horizon agentic orchestration. Premium: $10/$50 per Mtok (~2× Opus). Reach for it only when Opus 5 isn't enough. |
| claude | claude-opus-4-8 | 4 | Previous-gen Opus; still very strong. Same $5/$25 as Opus 5 — prefer Opus 5 unless you need to pin this exact version. |
| claude | claude-sonnet-5 | 3 | General-purpose default. Near-Opus on coding/agentic at $3/$15 ($2/$10 introductory through 2026-08-31), 1M context. |
| claude | claude-haiku-4-5 | 1 | Fast, cheap; simple parsing or copy. $1/$5, 200K context. |
| codex | gpt-5.6-sol | 4 | OpenAI's deep-reasoning flagship — "best coding model yet" per OpenAI; frontier-class code and high-level review, mid-to-high complexity code. ~$5/$30 per Mtok. |
| codex | gpt-5.6-terra | 3 | Balanced everyday workhorse — the general-purpose codex tier. ~$2.50/$15 per Mtok. |
| codex | gpt-5.6-luna | 1 | Fastest and cheapest in the GPT-5.6 family; simple parsing or copy. ~$1/$6 per Mtok. |

Rough cross-vendor guidance for a delegating agent:

- **Hardest code / multi-step orchestration** → `claude-opus-5` first; `claude-fable-5`
  only if it genuinely needs the top ceiling and the ~2× cost is justified.
- **High-level review, second-opinion, or a strong non-Anthropic take** →
  `gpt-5.6-sol` (frontier-class on coding; useful as a cross-vendor check).
- **General-purpose default** → `claude-sonnet-5` or `gpt-5.6-terra` — comparable
  tier; pick by which vendor/behaviour you want.
- **Fast, simple parsing or copy** → `claude-haiku-4-5` or `gpt-5.6-luna`.
