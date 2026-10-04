# Handoff: Codex compatibility probe

Read `handoff-common-lab-rules.md` in this directory first and follow it.

## Goal

Produce `codex-compatibility-report.md` in the case directory: a precise,
evidence-backed matrix of how **Codex** (CLI 0.153.4, plus whatever the docs
say about the IDE extension, desktop app, and cloud) handles each of the
following, relative to the vendor-neutral `.agents` layout this repo targets
(`~/.agents/agents.md`, `<project>/.agents/agents.md`, `~/.agents/skills/`,
`<project>/.agents/skills/`).

## Questions to answer

### A. Instruction discovery
1. Global: which files does Codex read? (`$CODEX_HOME/AGENTS.md` is documented.)
   Does it read `~/.agents/agents.md` natively? Test with a faked CODEX_HOME.
2. Project: which filenames and directories does it walk? Does it ever look
   at `<project>/.agents/agents.md`? Can config (`project_doc_fallback_filenames`
   or similar) make it do so with a nested path? Test what actually works.
3. Precedence and merging: what happens when both a symlinked root
   `AGENTS.md` and `AGENTS.override.md` exist, or when global and project both
   exist. Are symlinks followed? Size limits (`project_doc_max_bytes`)?
4. What happens when `AGENTS.md` is a dangling symlink or a directory.

### B. Skill discovery
1. Which directories does Codex scan for skills: `~/.agents/skills`,
   `~/.codex/skills`, `<project>/.agents/skills`, others? Nested projects?
   Does it follow symlinked skill directories?
2. Precedence when the same skill name exists in two locations.
3. Does it honor the `.agents` protocol (https://dotagentsprotocol.com/) as
   a whole, partially, or only coincidentally?

### C. Skill metadata
1. Which `SKILL.md` frontmatter fields does Codex read (name, description,
   argument-hint, compatibility, disable-model-invocation, allowed-tools,
   anything else)? Which does it ignore?
2. Codex is believed to use a separate per-skill file for invocation policy
   (something like `agents/openai.yaml` with an implicit-invocation flag).
   Confirm the exact path, schema, and semantics from docs and, if possible,
   the open-source codex repo (github.com/openai/codex). Test whether it
   changes behavior: create a lab skill with and without the file and ask a
   probe run whether it would auto-use the skill.
3. Does Codex read Claude's `disable-model-invocation: true` at all?

### D. Surfaces
Which of the above differ between CLI, IDE extension, desktop app, cloud,
and the ChatGPT-hosted harness, per the docs. Mark anything you cannot test
as documented-only.

## Method

Docs first (learn.chatgpt.com / developers.openai.com Codex docs, the codex
GitHub repo including source for the discovery code and `codex --help`,
`codex exec --help`), then lab experiments under
`/tmp/vendor-compat-lab/codex-probe/`. Build small throwaway project
directories with `git init`, the relevant files and symlinks, and run a
cheap probe as described in the common rules.

## Report shape

1. A summary matrix: rows are the artifacts above, columns are
   "native `.agents` support", "documented Codex location", "observed
   behavior", "bridge needed?".
2. Per-question findings with evidence.
3. A short "implications for a bridge" section: what symlinks or config
   would make Codex read the `.agents` layout, and what collisions the
   bridge must handle.
4. Anything surprising or that contradicts the case `overview.md`.
5. Open questions you could not settle, each with what would settle it.
