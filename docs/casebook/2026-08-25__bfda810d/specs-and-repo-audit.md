# Specs and repository audit

Audit date: 2026-09-08. This is a documentation and source-text audit. It does
not claim runtime behavior for Claude Code, Codex, or any other client.

## Part 1: what the specifications say

### Agent Skills

The [Agent Skills specification](https://agentskills.io/specification) requires
a directory containing `SKILL.md`, with YAML frontmatter followed by Markdown.
The complete frontmatter table defines these fields:

| Field | Required by the spec | Status and meaning |
| --- | --- | --- |
| `name` | Yes | 1 to 64 characters, lowercase letters, numbers, and hyphens, matching the parent directory. |
| `description` | Yes | Non-empty, up to 1024 characters, describing what the skill does and when to use it. |
| `license` | No | License name or bundled license reference. |
| `compatibility` | No | Environment requirements such as intended product, packages, or network access. The spec's example explicitly says `Designed for Claude Code (or similar products)`. |
| `metadata` | No | Arbitrary string-to-string metadata for properties not defined by the spec. This is the explicit extension point. |
| `allowed-tools` | No | Experimental, space-separated pre-approved tools. Support may vary by implementation. |

The specification says, verbatim, “Clients can use this to store additional
properties not defined by the Agent Skills spec” for `metadata`, and labels
`allowed-tools` “Experimental.” It does not define `argument-hint` or
`disable-model-invocation`. Those are therefore non-standard fields in this
repository. `compatibility` is standard, although a value naming a vendor is
vendor-specific content rather than a new field.

The [implementation guide](https://agentskills.io/client-implementation/adding-skills-support)
describes the intended loading model: clients load `name` and `description` at
startup, then load the body “when the skill is activated.” It says the exact
activation syntax is up to the client and that the harness may perform lookup
and injection “without the model needing to take an activation action itself.”
The [overview](https://agentskills.io/home) also says activation occurs when a
task matches a skill description. Thus the ecosystem documents model-mediated
relevance and client-mediated activation, but the format has no standard
frontmatter switch for “the model may invoke this on its own.” In particular,
the spec does not define the repository's `disable-model-invocation` behavior.

The specification does not define `agents.md`, `AGENTS.md`, project instruction
discovery, global scope, or vendor adapters. Its required instruction artifact
is `SKILL.md`, and its optional directories are `scripts/`, `references/`, and
`assets/`. The implementation guide says clients choose where to scan. It gives
project and user scope as common implementation choices, not a normative path.

The [Client Showcase](https://agentskills.io/clients) is the specification
site's support claim. It is a showcase of products, not a conformance test or a
support-level matrix. The page currently exposes no product rows in its
server-rendered text, so this audit records the claim at that level rather than
inventing a complete list or treating presence as conformance. The official
overview says Agent Skills are supported by “a large number of AI tools and
agentic clients,” and identifies the format as originally developed by
Anthropic and adopted by other products. The showcase navigation and the
repository's client data identify products including Claude, OpenAI Codex,
Claude Code, Cursor, GitHub Copilot, VS Code, Gemini CLI, Goose, OpenCode,
Amp, and Piebald. The page supplies links and descriptions, not levels such as
native, partial, or certified.

### `.agents` protocol draft

The [`.agents` protocol](https://dotagentsprotocol.com/) is explicitly a
“DRAFT” dated 2026-02-24. It defines a vendor-neutral directory convention,
not the Agent Skills file format. Its layout uses `~/.agents/` as global scope
and `<project>/.agents/` as workspace scope, with workspace overrides winning.
It names `agents.md` as the instruction file and calls it “AGENTS.md
compatible.” The examples use lowercase `agents.md`, lowercase
`skills/*/skill.md`, and simple frontmatter.

For its own file types, the draft gives examples rather than a single universal
frontmatter schema:

| `.agents` artifact | Fields shown in the draft's example |
| --- | --- |
| `agents.md` | `kind` |
| `skills/*/skill.md` | `id`, `name`, `description`, `enabled` |
| `agents/*/agent.md` | `id`, `name`, `description`, `role`, `enabled`, `connection-type` |
| `tasks/*/task.md` | `kind`, `id`, `name`, `intervalMinutes`, `enabled`, `runOnStartup`, `profileId` |
| `memories/*.md` | `id`, `title`, `content`, `importance`, `tags` |

The draft says its frontmatter is simple `key: value` text and “Not full YAML.”
It does not mark fields as required or optional in a formal schema. It also
does not identify any field as a vendor extension. Its `enabled` examples are
protocol-level artifact settings, not a model-invocability control.

The draft does not define a model-invocation permission or a semantic
equivalent of `disable-model-invocation`. It describes enabled skills and
tasks, plus `runOnStartup` for tasks, but does not say whether a model can
choose a skill autonomously, whether a human must invoke it, or what syntax a
client must expose. It mentions compatibility metadata for bundles in the Hub,
but does not specify runtime adapters.

Its ecosystem table maps existing standards to the directory: MCP is credited
to Anthropic and the Linux Foundation, AGENTS.md to OpenAI and the Linux
Foundation, Skills to Anthropic, and ACP to Zed Industries. Sub-Agents, Tasks,
and Memories are attributed to the `.agents` protocol itself. This is a mapping
of standards and ownership, not a list of clients claiming implementation.
The draft calls the directory “Vendor-neutral” and says it works with any AI
tool, editor, or agent framework, but provides no vendor-by-vendor support
levels and no adapter contract.

### Conflicts and practical conclusions

The two documents overlap in intent but are not interchangeable:

1. Agent Skills requires `SKILL.md`, YAML frontmatter, and at least `name` and
   `description`. The `.agents` draft illustrates `skill.md`, adds `id` and
   `enabled`, and says its frontmatter is not full YAML. A repository should
   preserve `SKILL.md` for Agent Skills compatibility and treat the draft's
   lowercase example as a separate convention or a case-sensitive portability
   risk.
2. Agent Skills leaves skill discovery paths to each client. The `.agents`
   draft prescribes global and workspace `.agents/` layers. The draft therefore
   adds a layout convention that is not part of the Agent Skills format.
3. The `.agents` draft's lowercase `agents.md` example is not the same spelling
   as the widely used `AGENTS.md` filename, even though it calls the content
   compatible. Neither document defines case-folding or a complete filename
   search algorithm.
4. Neither document standardizes `/skill-name`, `argument-hint`, or
   `disable-model-invocation`. A README must describe those as client behavior
   or an adapter convention, not as vendor-neutral spec features.

## Part 2: repository audit

The repository was searched with `rg -n -i
'claude|codex|\\.claude|\\.codex|CLAUDE\\.md|AGENTS\\.md|disable-model-invocation|/skill-'`.
There are no other matching tracked files beyond the rows below and the
casebook files themselves. The classifications use “Claude-specific” for
Claude Code naming or syntax, “Codex-specific” for Codex naming or syntax, and
“vendor-neutral” where the text describes a general convention.

| File and line or section | Assumption or statement | Vendor | Proposed disposition |
| --- | --- | --- | --- |
| `README.md:3-5` | Calls the collection vendor-agnostic and says skills follow both Agent Skills and the `.agents` protocol. | Vendor-neutral | Keep, but clarify that Agent Skills does not prescribe `.agents/skills/` and that the `.agents` site is a draft. |
| `README.md:20-36` | Installer copies to `~/.agents/skills`, and `--dest` supports project `.agents/skills`. | Vendor-neutral `.agents` layout | Reword as this project's default install convention, not a path required by Agent Skills. |
| `README.md:38-59` | Says Claude is the odd one out, only scans `.claude/`, and needs the bridge. | Claude-specific, overstated | Reword. The specs do not establish “most tools” or Claude's runtime behavior. Say the script is a Claude Code adapter and document native, partial, and unverified support separately. |
| `README.md:41-59` | Documents `.claude/skills` and `.claude/CLAUDE.md` symlinks. | Claude-specific | Keep in a Claude adapter section, with the claim explicitly marked repository behavior and tested/documented evidence, not protocol behavior. |
| `README.md:61-68` | Presents `disable-model-invocation` as the standard way to restrict autonomous invocation. | Claude-specific, inaccurate as a spec claim | Move to a vendor adapter section or label it Claude Code metadata. Explain that neither cited spec defines it. |
| `fix-claude.sh:2-15,21-31,52-75` | Scaffolds `.agents`, then exposes it via `.claude/skills` and `.claude/CLAUDE.md`, and leaves existing paths untouched. | Claude-specific adapter | Keep as an adapter. Its comments and help should say it bridges this repository's layout to Claude Code, not that `.agents` is universally recognized. |
| `fix-claude.sh:69-70` | Creates lowercase `.agents/agents.md` with an `AGENTS.md` heading. | `.agents` draft plus filename ambiguity | Reword documentation around the draft's lowercase filename and the separate `AGENTS.md` convention. Do not infer case-insensitive discovery. |
| `install.sh:1-2,15-29,71-73` | Installs skills into `.agents/skills`, defaulting to `$HOME/.agents/skills`. | Vendor-neutral repository convention | Keep, but describe as the repository's portable default. Agent Skills itself leaves scan locations to clients. |
| `skills/casebook/SKILL.md:1-8` | Uses `name`, `description`, `compatibility`, `argument-hint`, and `disable-model-invocation`. | Standard fields plus Claude-specific fields | Keep `name`, `description`, `compatibility`. Move or namespace the latter two as client metadata if cross-client portability is required. |
| `skills/delegate/SKILL.md:1-15,31` | Uses standard fields and names Claude/Codex as delegated CLI examples. | Vendor-neutral skill with vendor-aware content | Keep. The examples are content-level compatibility notes, not non-standard frontmatter. |
| `skills/iac/SKILL.md:1-7` | Uses only standard `name`, `description`, and `compatibility`. | Vendor-neutral | Keep. |
| `skills/lead/SKILL.md:1-7` | Uses `argument-hint` and `disable-model-invocation`. | Claude-specific fields in otherwise portable skill | Move or namespace those controls in a vendor adapter, or document them as ignored by clients that do not implement them. |
| `skills/report-skill-feedback/SKILL.md:1-7` | Uses `argument-hint` and `disable-model-invocation`. | Claude-specific fields in otherwise portable skill | Same as `lead`: retain only with an explicit client-specific compatibility note, or move the controls to an adapter. |
| `skills/casebook/README.md:12-13,27-33,40-43,55-63,74` | Uses `/casebook` command syntax and tells readers to use a harness equivalent. | Vendor-neutral documentation of a possible syntax, but syntax itself is client-specific | Reword examples as illustrative client syntax. Do not imply either cited spec defines slash commands. |
| `skills/delegate/README.md:3-6,14-25,63-97` | Describes agents, model invocation, harness-native subagents, and CLI delegation generally. | Vendor-neutral, vendor-aware content | Keep. Add a note that “model-invocable” is repository doctrine, not an Agent Skills or `.agents` frontmatter field. |
| `skills/delegate/README.md:93-97` | Says bundled Claude/Codex entries were derived from observed versions. | Claude and Codex | Keep with version maintenance. It is operational documentation, not a spec claim. |
| `skills/lead/README.md:19-21` | Uses `/lead` and `/casebook /lead`. | Vendor-neutral documentation of client syntax | Reword as examples for harnesses that support slash commands. |
| `skills/report-skill-feedback/README.md:35-42` | Uses `/report-skill-feedback <skill>`. | Vendor-neutral documentation of client syntax | Reword as illustrative syntax and state that the specs do not define slash invocation. |
| `skills/delegate/tools.md:7-61` | Documents Claude and Codex CLI flags, headless invocation, and versions. | Claude-specific and Codex-specific | Keep in the intentionally vendor-aware file. The orientation note is stale: it says Claude 2.1.220 and Codex 0.147.0, while the handoff records Claude 2.1.258 and Codex CLI 0.153.4. Re-check all flags before relying on them. |
| `skills/delegate/models.md:23-47` | Lists Claude and Codex model IDs, ratings, and behavioral notes. | Claude-specific and Codex-specific | Keep vendor-aware, but revalidate model IDs and claims independently. The file has no installed CLI version pin. Only its “August 2026” update date is recorded. |
| `skills/delegate/skill-feedback-reporting.md:10,24-25,48` | Refers to Claude's Agent tool and records Claude/Codex versions. | Claude and Codex | Keep as vendor-aware reporting guidance. Mark the native Agent tool reference as an example, not a cross-vendor API. |
| `skills/iac/iac:32` | Mentions Codex workspace-write behavior and sandboxed agents. | Codex-specific aside | Keep only if backed by the probe case. Otherwise generalize to “sandboxed/headless agents” and move Codex-specific behavior to an adapter note. |
| `skills/casebook/casebook.py:48` | Creates lowercase `agents.md`. | `.agents` draft convention | Keep if intentionally targeting the draft. Document that this is not proof of `AGENTS.md` discovery by any client. |

### Scope and evidence limits

The repository has no tracked `AGENTS.md`, `CLAUDE.md`, or `.claude/` and
`.codex/` directories in this worktree. The audit therefore finds references to
those names, not additional instruction artifacts. The handoff explicitly
prohibited running either CLI, so this report does not upgrade any statement to
“observed runtime behavior.”

The immediate high-value documentation changes are to stop presenting
`disable-model-invocation` as a portable spec feature, stop treating
`.agents/skills` as mandated by Agent Skills, and refresh the stale CLI version
note in `skills/delegate/tools.md` in a later implementation task.
