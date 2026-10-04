# Landscape synthesis and proposed plan

Synthesized 2026-09-08 from `claude-compatibility-report.md`,
`codex-compatibility-report.md`, and `specs-and-repo-audit.md`. Versions:
Claude Code 2.1.258, Codex CLI 0.153.4.

## Compatibility matrix

| Concern | Claude Code | Codex |
| --- | --- | --- |
| Global instructions | Reads only `~/.claude/CLAUDE.md`. Symlink to `~/.agents/agents.md` works. Desktop Cowork skips a symlink whose target is outside the session directory. | Reads only `$CODEX_HOME/AGENTS.md` (override file wins). Symlink to `~/.agents/agents.md` works. |
| Project instructions | Reads `CLAUDE.md`, `.claude/CLAUDE.md`, `CLAUDE.local.md`. Ignores `AGENTS.md` and `.agents/agents.md`. Symlink works. | Reads `AGENTS.md` per directory from repo root to cwd. Ignores `.agents/agents.md` by default. Two bridges work: a root `AGENTS.md` symlink, or user config `project_doc_fallback_filenames = [".agents/agents.md"]`. |
| Global skills | Reads only `~/.claude/skills`. Whole-directory symlink works (observed, not documented). | Reads `~/.agents/skills` natively. |
| Project skills | Reads only `.claude/skills`. Whole-directory symlink works. | Reads `.agents/skills` natively at every directory up to the repo root. Bridging would create duplicates. |
| Explicit-only invocation | `disable-model-invocation: true` in frontmatter. Hides the skill from the model, keeps `/name`. | `agents/openai.yaml` sidecar with `policy.allow_implicit_invocation: false`. Ignores Claude's frontmatter field. |
| Unknown metadata | Tolerated. | Tolerated. Parses only `name`, `description`, `metadata.short-description`. |
| Name collisions | Personal beats project. | All copies shown side by side. |
| Remote surfaces | Web sees only committed project config. | Cloud parity for `.agents/skills` and the sidecar is unverified. |

Neither the Agent Skills spec nor the `.agents` draft defines model
invocability. Our `disable-model-invocation` and `argument-hint` fields are
Claude extensions. The `.agents` draft is dated February 2026 and still marked
draft.

## What is wrong today

1. `README.md` says Claude is the only tool needing a bridge. Codex needs
   one for instructions too.
2. `README.md` presents `disable-model-invocation` as the portable control.
   Codex ignores it, so `lead` and `report-skill-feedback` are implicitly
   invocable under Codex.
3. There is no Codex bridge script. The user hand-made the global symlink.
4. `fix-claude.sh` silently skips anything that already exists, so a
   half-bridged setup gives no signal.
5. `skills/delegate/tools.md` pins stale CLI versions.
6. Skill READMEs use `/skill` syntax without noting it is Claude's spelling
   (Codex uses `$skill`).

## Proposed plan

### WP1: one bridge script for both vendors

Replace `fix-claude.sh` with `bridge.sh <claude|codex|all> [directory]`,
same POSIX style and same no-clobber rule, but every skipped path is
reported with what is already there. Behavior per vendor:

- `claude`: as today (`.claude/skills` and `.claude/CLAUDE.md` symlinks).
- `codex`: `AGENTS.md -> .agents/agents.md` in the directory. When the
  directory is `$HOME`, also `${CODEX_HOME:-$HOME/.codex}/AGENTS.md ->
  ~/.agents/agents.md`. Warn if `AGENTS.override.md` exists. No skill
  symlinks, since Codex reads `.agents/skills` natively.
- Both scaffold `.agents/skills/` and a stub `.agents/agents.md` if missing.

The root `AGENTS.md` symlink is preferred over the Codex config fallback
because it is zero-config, survives a fresh clone, and serves every other
`AGENTS.md` reader for free. The config fallback is documented as an
alternative for people who refuse a root file.

A shell test exercises the collision cases (existing file, directory,
foreign symlink, dangling symlink, override present, re-run idempotency).

### WP2: Codex invocation sidecars

Add `agents/openai.yaml` with `policy.allow_implicit_invocation: false` to
`lead` and `report-skill-feedback`, next to their existing frontmatter flag.
Committed files, no generator. `install.sh` already copies whole directories.

### WP3: documentation

- README: replace the Claude section with a vendor compatibility section and
  the matrix above, honest about native versus bridged versus unverified.
  Rewrite the model invocation section to name both mechanisms and say
  neither spec defines one.
- Skill READMEs: note `/name` is Claude's syntax and `$name` is Codex's.
- `skills/delegate/tools.md`: refresh the observed-versions line.
- Case: update `overview.md`, close the open questions that are now settled.

### WP4: review

Fresh read-only reviewer over the whole diff before closing.

## Delegation

| Work | Delegate | Why |
| --- | --- | --- |
| WP1 script and test | codex gpt-5.6-sol | Strong terminal execution, medium cost. Lead reviews and runs the test. |
| WP2 sidecars | lead directly | Two tiny files, cheaper than a handoff. |
| WP3 docs | codex gpt-5.6-sol, after WP1 interface is fixed | Public copy, medium cost. Lead reviews for style. |
| WP4 review | claude-opus-5, read-only | Independent vendor and model from the authors. |

WP1 and WP3 can run in parallel because the script interface is fixed above.

## Out of scope, noted

- Upstream report to Codex: not needed. The config fallback already covers
  the gap and Codex docs already adopt `.agents/skills`.
- Automated runtime probes as repo tests: rejected for now. They cost model
  calls per run. The reproduction commands live in the probe reports.
- Remote surfaces (Claude web and Cowork, Codex cloud): documented as
  unverified, not tested.

## Side finding for the delegate skill

The first Codex probe, run by claude-sonnet-5 headless, spawned a native
background subagent to do the whole task and then exited, so the subagent
died with the session and nothing was produced. Cost about $1.40. Worth a
fidelity note in `models.md` and a standing line in handoffs.
