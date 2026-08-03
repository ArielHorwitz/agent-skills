# Delegate — available agents

Checked 2026-08-03. Model access still depends on the authenticated account;
if a CLI rejects a listed model, choose another available row rather than
silently substituting an unlisted model.

## Tools

### claude

Non-interactive invocation, prompt over stdin, JSON result on stdout:

    claude -p --model <model> --output-format json --permission-mode bypassPermissions

The final answer is in the JSON `result` field. This syntax was verified
against locally installed Claude Code 2.1.220 (`claude --help`) on 2026-08-03.

### codex

Non-interactive invocation, prompt over stdin, final answer written to a file:

    codex exec --model <model> -s danger-full-access -o <output-file> -

The final `-` explicitly makes stdin the prompt. `-s` selects Codex's sandbox
policy (`read-only`, `workspace-write`, or `danger-full-access`); the full-access
setting here preserves the current headless policy, where no unattended approval
can block the run. This syntax was verified against locally installed Codex CLI
0.146.0 (`codex exec --help`) on 2026-08-03. OpenAI's non-interactive-mode
reference is https://learn.chatgpt.com/docs/non-interactive-mode.

Google is intentionally not listed as an available tool. Google ended Gemini
CLI service for individual free, Pro, and Ultra accounts on 2026-06-18 in favor
of Antigravity CLI (`agy`); Gemini CLI remains supported only for enterprise,
Google Cloud, and paid API-key use. The replacement is not installed here, and
its selectable model display names are account-specific (`agy models`), so a
locally usable command and truthful local model roster could not be verified. See
Google's transition notice:
https://developers.googleblog.com/en/an-important-update-transitioning-gemini-cli-to-antigravity-cli/.

## Models

Prefer balancing cost, speed, and intelligence when choosing between multiple
appropriate models. Capability is an editorial 1–5 task-routing aid, not a
benchmark score. Reasoning effort and the CLI harness can materially change
quality, latency, and usage, so close ratings should be treated as peers.
Anthropic dollar figures below are API list prices; Claude Code subscription
quota and usage-credit economics vary by plan.

| tool | model | capability | notes |
| --- | --- | ---: | --- |
| claude | claude-fable-5 | 5 | Deep factual knowledge and long-running agents; slowest and most expensive Claude row ($10/$50 per million input/output tokens). Prefer when its extra depth justifies the cost. |
| claude | claude-opus-5 | 5 | Complex agentic coding, deep reasoning, and long-horizon work; usually the best capability/cost Claude starting point at $5/$25 per million tokens. |
| claude | claude-sonnet-5 | 4 | Fast, strong general-purpose coding and tool use; Anthropic's best speed/intelligence balance. Introductory $2/$10 pricing ends 2026-08-31, then $3/$15. |
| claude | claude-haiku-4-5 | 2 | Fastest Claude row for high-volume, well-scoped extraction, classification, copy, and simple subagent tasks; $1/$5 per million tokens. |
| codex | gpt-5.6-sol | 5 | Flagship for ambiguous or high-value coding, computer use, research, cybersecurity, review, and polished deliverables. |
| codex | gpt-5.6-terra | 4 | Everyday workhorse for strong reasoning and tool use at lower cost than Sol; the default choice when Sol's extra depth is unnecessary. |
| codex | gpt-5.6-luna | 3 | Fastest and lowest-cost GPT-5.6 row for clear, repeatable extraction, classification, transformation, summaries, and batch work. |
| codex | gpt-5.3-codex-spark | 3 | Near-instant text-only coding iteration; research preview limited to ChatGPT Pro, so do not select unless the account exposes it. |

Anthropic model IDs, relative latency, and API pricing are from the current
official model overview:
https://platform.claude.com/docs/en/about-claude/models/overview. OpenAI's
current Codex roster and use-case guidance are at
https://learn.chatgpt.com/docs/models. Third-party evaluation broadly supports
rating Opus 5 and Sol as peers rather than asserting a universal winner: Opus 5
leads Artificial Analysis's overall and agentic knowledge-work indexes, while
Sol remains competitive or ahead on some terminal, presentation, and scientific
reasoning measures:
https://artificialanalysis.ai/articles/opus-5 and
https://artificialanalysis.ai/articles/claude-opus-5-leader-agentic-knowledge-work.
Early community comparisons also disagree sharply by workload and harness, so
the table deliberately avoids encoding a stronger preference between the two.
