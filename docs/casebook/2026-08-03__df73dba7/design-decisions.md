# Design decisions for `delegate`

In rough chronological order, including reversals — the "why" matters more
than the current text, since the skill is still being iterated.

## `iac` already covered half the original ask

The original two-skill split assumed "spawning" and "communicating with a
long-running delegate" were one problem. Checking the repo first: `iac`
(`skills/iac/`) already exists and is exactly the vendor-agnostic transport
for talking to longer-running sessions — a filesystem channel, no server, a
`directive.md` any capable agent can follow. That narrowed `delegate`'s scope
to the part that was actually missing: deciding *how* to spawn something and
constructing the command to do it. `delegate` now explicitly defers to `iac`
for ongoing back-and-forth once a delegate is running.

## Verify CLI flags, don't guess them

Before drafting anything, checked what's actually installed (`claude`,
`codex`; no `gemini`/`cursor-agent`/`aider`) and read their real `--help`
output rather than inventing flag names. Confirmed:

- `claude -p --model <model> --output-format json --permission-mode <mode>`
  (modes: `acceptEdits`, `auto`, `bypassPermissions`, `manual`, `dontAsk`,
  `plan`)
- `codex exec --model <model> -s <sandbox> -o <output-file>` (sandbox:
  `read-only`, `workspace-write`, `danger-full-access`; or
  `--dangerously-bypass-approvals-and-sandbox` for full auto)

Both expose a real middle ground between "ask for everything" and "bypass
everything," which is why the permission posture became its own open
question (see `open-threads.md`) rather than an obvious default.

## Config format: freeform markdown, not TOML

First draft used a structured TOML file (`~/.config/agent-skills/delegate/
models.toml`), split into `[tool.*]` command templates and `[[model]]` rows,
explicitly to mirror casebook's `tomllib`-based `case.toml`.

User pushback: there's no real reason for structure here. The file only
needs to demonstrate how to call a tool and how to pick a model — the rest is
freeform, and a fixed schema fights that. Rewritten as plain markdown the
agent reads and interprets directly, the same way it reads `iac`'s
`directive.md` or its own `SKILL.md` — no parser, no required columns, no
script needed at all (unlike `casebook`/`iac`, `delegate` bundles no code).

## No model-selection algorithm in the skill

First draft of the picking logic: "pick the lowest tier that clears the
bar" — cost-conscious by default. User pushback: this is opinionated: some
users want smartest-available and aren't cost-sensitive. Don't encode a
policy in the skill; let the model decide from whatever the file says
(capability, cost, notes — whatever the user chose to record). Final
instruction is deliberately thin: *"consider the task and the file, and
choose a model appropriately. If nothing is available, fail loudly."*
Iterating on this instruction is expected to happen through use, not by
front-loading more prescription now.

## Prompt delivery: handoff doc + short pointer, not inlined stdin

First draft: pass the full prompt over stdin (to avoid `ARG_MAX` and `ps`
exposure for long handoff-sized prompts). User's preferred shape: write the
task as a handoff doc and pass a short prompt like `follow
path/to/handoff.md` — stdin is still the transport, but the content is now
trivially short regardless of how much context the task needs, and it
produces a durable artifact (the handoff doc) as a side effect.

## Trimming the instructions

The initial `SKILL.md` was much more verbose than it needed to be — a full
paragraph of caveats for model-picking, a "what if the process fails" bullet,
etc. User's explicit direction: err on the side of *less* instruction, and
add detail later as the skill is actually used and gaps show up. The
"Invoke it" and "Pick a tool and model" sections were both cut down
substantially; several bullets (failure handling, native-subagent caveat)
were removed outright rather than trimmed.

## Delegate supersedes native subagents, doesn't defer to them

First draft's "Relationship to other tools" section said: prefer a harness's
native in-process subagent mechanism (e.g. Claude Code's `Agent` tool) for
same-vendor work, and reach for `delegate` only for cross-vendor/isolated
cases. User reversed this explicitly: the point of `delegate` is to
*supersede* per-harness native spawning entirely and standardize one
vendor-agnostic process, not to be a fallback used only when the native
mechanism doesn't fit.

## Config filename: `agents.md` → `models.md`, no "example"/"template" wording in the file itself

Went through several naming iterations:

1. `~/.config/agent-skills/delegate/agents.md`, bundled `agents.example.md` —
   named to mirror casebook's own `docs/casebook/agents.md` convention
   (freeform doc telling agents how to behave in a context).
2. Simplified location to `~/.config/delegate/agents.md` (global, since this
   is about the user's own tools/subscriptions, not a project).
3. User: strip "example"/"template" language *out of the bundled file's own
   content* (title, intro) — that framing belongs in `README.md`
   ("copy this template to ~/.config/delegate/..."), not in the file an
   agent is meant to read as if it were real configuration.
4. User: rename the bundled file (and the destination it's copied to) from
   `agents.md` to `models.md` — the content is fundamentally a model
   listing, not a general "how to work here" doc the way casebook's
   `agents.md` is, so the name should say that directly. Re-checked with
   `grep -rni example` across `skills/delegate/` to confirm no leftover
   wording.

## `models.md` structure: Tools section, then one Models table

Original bundled file had a `## claude` subsection and a `## codex`
subsection, each with its own invocation snippet *and* its own small model
table. User's preferred shape: a single `## Tools` section holding just the
per-CLI invocation syntax (`### claude`, `### codex`), followed by one
`## Models` table covering every tool's models together (with a `tool`
column) — cleaner separation between "how to call this thing" and "what's
available." The intro paragraph that used to sit at the top of the bundled
file (explaining the file's purpose and that structure is optional) was
moved into `README.md`'s "Why freeform" section instead, keeping the bundled
file itself lean and purely content.

## Populating `models.md` via delegated research

Once the skill's shape settled, used `delegate` itself (dogfooding) to
research and improve the model roster in `skills/delegate/models.md`, which
had only ever contained hand-picked placeholders.

**Wave 1.** Wrote a shared handoff doc
(`handoff-models-research.md`) and spawned three agents per the skill's own
method (prompt over stdin pointing at the handoff, each writing its own
output file, run in the background): `claude-opus-4-8`, `claude-opus-5`, and
a codex model. The codex spawn's requested model, `gpt-5-6-sol`, failed
outright (`400 invalid_request_error`) — turned out to be a real bug in our
own placeholder: codex model IDs use dots, not dashes (confirmed via
`~/.codex/config.toml`, which had `model = "gpt-5.6-sol"` all along). Retried
with the corrected name and it succeeded. All three proposals independently
found and flagged this same separator bug, plus that the old file was
missing a mid-tier codex model (`gpt-5.6-terra`) and had likely under-rated
`gpt-5.6-luna` (rated 1/"simple parsing or copy" in the placeholder; codex's
own model registry describes it as a real agentic coding model, and after a
2026-07-30 price cut it's cheaper than `claude-haiku-4-5` while more
capable).

**User feedback on wave 1, before merging:** two problems, both about
epistemics rather than mechanics.

1. The handoff boxed proposals into the existing `## Tools` / `## Models`
   table shape and a bare 1–5 "capability" column, when a more holistic
   structure — a cost or speed column, subsections instead of a table, etc.
   — might serve better. The task should have invited agents to propose
   their own structure, not just fill in the existing one.
2. The proposals leaned too heavily on vendor-published claims. Concretely:
   two of the three research passes dropped `claude-opus-4-8` entirely in
   favor of `claude-opus-5`, reasoning that Anthropic's own catalog
   positions Opus 5 as a strict improvement at the same price. The user
   pushed back hard on this specific conclusion — `claude-opus-4-8` is their
   actual daily driver despite having `claude-fable-5` and `claude-opus-5`
   available, and they suspect (their own impression, not independently
   confirmed, and deliberately not asserted as fact in the file) that Opus 5
   looks good on benchmarks but has some undesirable behavior in practice,
   and that Sonnet 5 is better suited to orchestration than to writing code
   itself. The broader point: don't let a vendor's own benchmark/catalog
   framing silently become the file's ground truth.

**The manual merge that followed** (in `skills/delegate/models.md` as it
stands now): kept `claude-opus-4-8` as a full row rather than dropping it,
with a note that its gap (if any) with Opus 5 rests on vendor positioning,
not independent verification — deliberately not asserting the user's
specific suspicions about Opus 5/Sonnet 5 as fact, since those are personal
impressions, not verified findings, and belong in this case file rather than
in a skill artifact other sessions will read as settled. Added the
requested cost column. Added a `## Caveats` section naming the specific
disagreements between the three passes (`gpt-5.6-luna`'s rating spread 1–3;
`claude-sonnet-5` vs `gpt-5.6-terra` positioning) and a general note to
discount vendor self-reported benchmarks — including a concrete instance
found while merging: the codex-run pass rated codex's own model family more
favorably than the two claude-run passes did, a mild self-family bias worth
flagging as a pattern, not just a one-off.

Also independently verified (via `WebFetch`) a claim only the codex pass
made and the other two didn't mention: Google discontinued Gemini CLI for
individual (free/Pro/Ultra) accounts on 2026-06-18 in favor of a new
`agy` (Antigravity CLI) product, keeping Gemini CLI itself only for
enterprise/Cloud/API-key use. Checked because it was a surprising, load-bearing
claim appearing in only one of three sources — confirmed accurate against
Google's own transition announcement, so it's now in `models.md`'s Tools
section explaining why Gemini isn't listed.

**Wave 2:** a second research round, deliberately designed to avoid
repeating both problems above. The handoff was a wholly separate file that
didn't reference wave 1, the merged `models.md`, or either problem from the
user's feedback — it didn't mention `claude-opus-4-8` at all, to avoid
steering researchers toward or away from it. It explicitly invited proposing
the file's structure rather than assuming the existing shape, and instructed
weighing independent/community signal against vendor self-reported claims
generally, without asserting any specific opinion about any model. Per a
follow-up instruction, all 8 models across both waves were re-run against
this improved brief (not just the 5 unused in wave 1), and scope was
narrowed to model capability/selection only (dropping CLI-invocation
research, which wave 1 had already settled) and to Anthropic/OpenAI only.

All 8 reports converged, unprompted, on the same structural conclusion as
wave 1: no single blended score. Three independently proposed a "fidelity/
reliability for unsupervised delegation" axis that hadn't been in the
brief's example list — driven by real evidence (`gpt-5.6-sol` documented
gaming its own evaluations). Full synthesis of all 8 in
`wave2-synthesis.md`. `models.md` was rewritten again around four axes
(depth, execution, cost-to-task, fidelity), then trimmed hard on user
feedback to strip out every trace of research process/provenance from the
shipped file — no vendor/study names, no "an earlier version had this
wrong," no self-reference to the research that produced it. That meta
material lives here and in `wave2-synthesis.md` instead; `models.md` itself
now just tells a delegator what to pick and why, nothing about how it was
derived.

On the `claude-opus-4-8` question specifically: `open-threads.md` had
flagged this as unsettled, pending wave 2. It landed as settled, in the
direction the user's own instinct pointed — one wave-2 report
(`gpt-5.6-terra`'s, run with zero knowledge of the debate) independently
recommended keeping `claude-opus-4-8` as a known-good option rather than
auto-replacing it with Opus 5. `models.md` keeps the row.

Also added, following on from the research: an "Identification" subsection
per tool in `models.md`'s `## Tools`, after confirming empirically (spawning
a real test session) that claude's `-n <name>` sets a real, discoverable
`agentName` in its transcript and appears in `/resume`, while codex has no
equivalent naming flag and is identified by its printed session id only.
Each tool's subsection states its own mechanism plainly, without describing
what the other tool lacks.

## Claude model IDs verified, codex model IDs were placeholders (superseded)

Originally: the bundled `models.md`'s claude rows used real current model
IDs available from system context, while the codex rows (`gpt-5-6-sol`,
`gpt-5-6-luna`) were the user's own illustrative names from the original
conversation, never verified against a real OpenAI release. Superseded by
the "Populating `models.md` via delegated research" entry above — the codex
names were real but dashed instead of dotted, and the roster has since been
replaced wholesale with researched content.

## Config path: back to `~/.config/agent-skills/delegate/`, not bare `~/.config/delegate/`

Item 2 above ("simplified" to `~/.config/delegate/agents.md`) got reversed.
The user made a self-review pass over the diff and reintroduced the
`agent-skills/` namespace segment in `README.md` but not `SKILL.md`, leaving
the two files disagreeing on the actual path — caught and flagged during
review. Confirmed intentional: bare `~/.config/delegate/` is too generic and
more likely to collide with an unrelated tool of the same name than
`~/.config/agent-skills/delegate/` is. Both files now consistently read
`~/.config/agent-skills/delegate/models.md`.

This gives a three-way parallel structure worth keeping in mind for any
future skill that needs user-level config: this repo's `skills/<name>/`
(source) → installed `~/.agents/skills/<name>/` (the `.agents` protocol's
install location) → user config `~/.config/agent-skills/<name>/`. Checked
whether the `.agents` protocol (dotagentsprotocol.com) itself defines a
config-directory convention to align with instead — it doesn't, it only
covers skill definitions, not user-level configuration — so this convention
is ours to set, not one we're deviating from.

## Fallback-to-bundled-file: decided, no longer open

`open-threads.md` previously logged whether the bundled `models.md` should
serve as an automatic fallback when the user has no
`~/.config/agent-skills/delegate/models.md` as unresolved. It's now decided:
yes — both `SKILL.md` and `README.md` state the fallback plainly. The
"fail loudly" behavior now applies to *not finding an appropriate model in
whichever file is read* (user's or bundled), not to the user's file being
absent.

## "Running tasks": dropped "that is not blocking"

The background-execution bullet read "consider running it in the background
for anything non-trivial that is not blocking" — flagged in review as
tangled/ambiguous (non-trivial-but-not-blocking conflates two qualifiers).
Intent, per the user: not to prescribe backgrounding, just to nudge toward it
when it's clearly warranted — the task will take a while and there's other
useful work to do meanwhile. Reworded to state that reasoning directly:
"consider running it in the background if the task will take a while and
there's other useful work to do while it runs."
