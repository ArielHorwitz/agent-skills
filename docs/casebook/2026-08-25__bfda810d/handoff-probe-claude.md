# Handoff: Claude Code compatibility probe

Read `handoff-common-lab-rules.md` in this directory first and follow it.

## Goal

Produce `claude-compatibility-report.md` in the case directory: a precise,
evidence-backed matrix of how **Claude Code** (CLI 2.1.258, plus what the
docs say about the desktop app, IDE extensions, and web) handles each of the
following, relative to the vendor-neutral `.agents` layout this repo targets
(`~/.agents/agents.md`, `<project>/.agents/agents.md`, `~/.agents/skills/`,
`<project>/.agents/skills/`).

The repo's README currently claims Claude Code reads only `.claude/` and
needs a symlink bridge (`fix-claude.sh` at the repo root, read it). Verify
whether that is still true for the installed version.

## Questions to answer

### A. Instruction discovery
1. Global: does Claude read `~/.claude/CLAUDE.md` only, or also
   `~/.agents/agents.md` or `~/AGENTS.md`? Test with a faked HOME.
2. Project: which filenames does it walk (`CLAUDE.md`, `.claude/CLAUDE.md`,
   `CLAUDE.local.md`, `AGENTS.md`, `.agents/agents.md`)? Does it read a
   root `AGENTS.md`? Is there any setting that adds instruction files?
3. Symlink handling: a symlinked `CLAUDE.md` pointing into `.agents/`, a
   dangling symlink, a symlink to a directory.
4. Precedence and merging when several of these exist.

### B. Skill discovery
1. Which directories does Claude scan: `~/.claude/skills`,
   `<project>/.claude/skills`, `~/.agents/skills`, `<project>/.agents/skills`,
   plugin skills? Does it follow a symlinked skills directory (the current
   bridge relies on this)?
2. Precedence when the same skill name exists in two locations.
3. Any setting that adds skill directories.

### C. Skill metadata
1. Which `SKILL.md` frontmatter fields Claude reads and their semantics:
   `name`, `description`, `argument-hint`, `disable-model-invocation`,
   `user-invocable` or similar, `allowed-tools`, `model`, `compatibility`,
   `metadata`, and anything else documented. Which fields are ignored.
2. Does Claude read or choke on a Codex-style `agents/openai.yaml` file
   inside a skill directory, or any other extra files?
3. Confirm `disable-model-invocation: true` behavior and test it: build a
   lab skill with and without it, ask a probe run which skills it may
   invoke on its own.

### D. Surfaces
Which of the above differ between CLI, desktop app, IDE extension, and
web, per the docs. Mark anything you cannot test as documented-only.

## Method

Docs first (code.claude.com/docs and docs.anthropic.com for Claude Code:
memory/CLAUDE.md, skills, settings, plugins), `claude --help`, then lab
experiments under `/tmp/vendor-compat-lab/claude-probe/`. Build small
throwaway project directories with `git init`, the relevant files and
symlinks, and run a cheap probe as described in the common rules. Note that
`claude -p` may need `--setting-sources` or similar to control which
settings load. Check `claude --help` for flags that affect discovery.

## Report shape

1. A summary matrix: rows are the artifacts above, columns are
   "native `.agents` support", "documented Claude location", "observed
   behavior", "bridge needed?".
2. Per-question findings with evidence.
3. A short "implications for a bridge" section: whether `fix-claude.sh`
   is still needed, still correct, and what it misses (for example, a
   root `AGENTS.md` if Claude reads that natively).
4. Anything surprising or that contradicts the README or `fix-claude.sh`.
5. Open questions you could not settle, each with what would settle it.
