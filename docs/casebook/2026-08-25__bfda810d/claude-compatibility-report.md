# Claude Code compatibility with the `.agents` layout

Tested 2026-09-08 with Claude Code CLI 2.1.258 and `claude-haiku-4-5`.
Desktop, IDE, Cowork, and web findings are documented-only unless stated
otherwise. Runtime probes used a fake home and throwaway Git repositories under
`/tmp/vendor-compat-lab/claude-probe/`.

## Summary

Claude Code still has no native discovery of `~/.agents/agents.md`,
`<project>/.agents/agents.md`, or skills in either `.agents/skills/` location.
Its native local locations are `~/.claude/CLAUDE.md`, project `CLAUDE.md` or
`.claude/CLAUDE.md`, `CLAUDE.local.md`, and `.claude/skills/`.

The existing `fix-claude.sh` bridge is still needed and its two symlinks work in
the tested CLI. It does not address web availability of home configuration or
the stricter symlink rules in Desktop Cowork sessions.

| Artifact | Native `.agents` support | Documented Claude location | Observed behavior | Bridge needed? |
| --- | --- | --- | --- | --- |
| Global instructions | No | `~/.claude/CLAUDE.md` | Read only the Claude location. Ignored `~/.agents/agents.md` and `~/AGENTS.md` | Yes |
| Project instructions | No | `CLAUDE.md`, `.claude/CLAUDE.md`, `CLAUDE.local.md` | Read all three. Ignored `AGENTS.md` and `.agents/agents.md` | Yes |
| Global skills | No | `~/.claude/skills/<name>/SKILL.md` | Read `.claude`, ignored `.agents` | Yes |
| Project skills | No | `.claude/skills/<name>/SKILL.md` | Read `.claude`, ignored `.agents` | Yes |
| Plugin skills | Not applicable | `<plugin>/skills/<name>/SKILL.md` | Documented as namespaced and separately discovered | No `.agents` bridge applies |
| Symlinked instruction file | No direct support | A `CLAUDE.md` symlink is documented | File symlink into `.agents` loaded | Yes, bridge works |
| Symlinked skills directory | No direct support | Skill entries may be symlinked | Whole `.claude/skills` symlink into `.agents/skills` loaded | Yes, bridge works |

## A. Instruction discovery

### Global discovery

**Observed.** A fake home contained these markers:

```text
~/.claude/CLAUDE.md       GLOBAL_CLAUDE_MARKER
~/.agents/agents.md       GLOBAL_DOTAGENTS_MARKER
~/AGENTS.md               GLOBAL_HOME_AGENTS_MARKER
```

Probe command, with the prompt shortened here only for readability:

```sh
HOME=/tmp/vendor-compat-lab/claude-probe/home \
  claude -p --model claude-haiku-4-5 \
  --setting-sources user,project,local --tools '' \
  --no-session-persistence --max-budget-usd 0.03 \
  'Return every ALL_CAPS marker string present in instructions...'
```

The result included `GLOBAL_CLAUDE_MARKER`. It did not include either
`GLOBAL_DOTAGENTS_MARKER` or `GLOBAL_HOME_AGENTS_MARKER`.

**Documented.** The memory documentation names `~/.claude/CLAUDE.md` as the
user instruction file and explicitly says Claude Code reads `CLAUDE.md`, not
`AGENTS.md`:
<https://code.claude.com/docs/en/memory>

### Project discovery

**Observed.** One project contained markers in all requested candidates. The
same probe returned:

```text
ROOT_CLAUDE_MARKER
DOTCLAUDE_CLAUDE_MARKER
LOCAL_CLAUDE_MARKER
```

It did not return `ROOT_AGENTS_MARKER` or `PROJECT_DOTAGENTS_MARKER`.
Therefore CLI 2.1.258 reads project `CLAUDE.md`, `.claude/CLAUDE.md`, and
`CLAUDE.local.md`, but not root `AGENTS.md` or `.agents/agents.md`.

**Documented.** Claude walks from the filesystem root down to the launch
directory. It concatenates every `CLAUDE.md` and `CLAUDE.local.md` instead of
overriding. Nested files below the launch directory load on demand when Claude
reads files there. The docs also cover `.claude/CLAUDE.md` as a project
location: <https://code.claude.com/docs/en/memory>

There is no user or project setting for arbitrary instruction filenames.
`claudeMd` works only in managed or policy settings. Setting it in user,
project, or local settings has no effect. `claudeMdExcludes` can exclude found
memory files. For additional working directories, `--add-dir` plus
`CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` loads their `CLAUDE.md`,
`.claude/CLAUDE.md`, rules, and eligible `CLAUDE.local.md` files. These are
additional roots, not custom filenames.

### Symlink handling

**Observed.** This bridge loaded `BRIDGED_INSTRUCTION_MARKER`:

```text
.claude/CLAUDE.md -> ../.agents/agents.md
```

This matches the documented recommendation that `CLAUDE.md` may be a symlink
to `AGENTS.md`.

A dangling project `CLAUDE.md -> missing.md` did not crash the CLI. The probe
completed with `OK`. A `CLAUDE.md` symlink to a directory was not traversed and
returned no marker from a file inside that directory. This is accepted as
non-fatal, not interpreted as an instruction directory.

Desktop Cowork has a documented exception. It skips a user-scope
`~/.claude/CLAUDE.md` that is a symlink or hard link when its target is outside
the session working directory. The home-level bridge created by
`fix-claude.sh` therefore does not supply global instructions to Cowork:
<https://code.claude.com/docs/en/memory>

### Ordering and conflicts

**Documented.** Instructions merge by concatenation. Across directories they
are ordered from the filesystem root toward the launch directory. Within a
directory, `CLAUDE.local.md` follows `CLAUDE.md`.

**Observed.** The combined probe presented markers in this order:

```text
GLOBAL_CLAUDE_MARKER
ROOT_CLAUDE_MARKER
DOTCLAUDE_CLAUDE_MARKER
LOCAL_CLAUDE_MARKER
```

This confirms broad-to-specific merging for the tested layout and shows the
root file before `.claude/CLAUDE.md`, then the local file. Conflicting prose is
not mechanically resolved. The docs warn that Claude may choose arbitrarily
between contradictory rules.

## B. Skill discovery

### Locations

**Observed.** With the `Skill` tool enabled, Claude listed these custom skills:

```text
user-skill       USER_SKILL_DESCRIPTION_MARKER
project-skill    PROJECT_SKILL_DESCRIPTION_MARKER
metadata-probe   METADATA_DESCRIPTION_MARKER
```

It did not list skills present only in these paths:

```text
~/.agents/skills/global-dotagents-skill/SKILL.md
<project>/.agents/skills/dotagents-skill/SKILL.md
```

The native paths observed were `~/.claude/skills/` and
`<project>/.claude/skills/`.

**Observed.** The bridge below exposed `bridged-skill` with description
`BRIDGED_SKILL_MARKER`:

```text
.claude/skills -> ../.agents/skills
```

This confirms the whole-directory symlink used by `fix-claude.sh` works in CLI
2.1.258. The current docs explicitly guarantee that an individual skill entry
may be a symlink to a directory. They do not explicitly promise that the
top-level `skills` directory itself may be a symlink, so the latter remains an
observed compatibility behavior:
<https://code.claude.com/docs/en/skills>

**Documented.** Claude also scans project `.claude/skills/` directories from
the launch directory through its parents to the repository root. Nested skill
directories load on demand. `.claude/skills/` under a CLI `--add-dir` also
loads. The similarly named `permissions.additionalDirectories` setting grants
file access only and does not load skills. There is no documented setting that
adds an arbitrary skill directory. The Agent SDK equivalents of `--add-dir`
do add roots.

**Documented-only.** Enterprise skills, claude.ai-synced skills, and plugin
skills are additional sources. Plugin skills live at
`<plugin>/skills/<name>/SKILL.md` and use a `plugin-name:skill-name` namespace:
<https://code.claude.com/docs/en/plugins-reference>

### Same-name precedence

**Observed.** A `collision` skill existed in both the fake user's
`~/.claude/skills/` and project `.claude/skills/`. Claude reported
`USER_COLLISION_MARKER`, not `PROJECT_COLLISION_MARKER`.

**Documented.** Precedence is enterprise over personal over project. Any of
those overrides a same-name bundled skill. Plugin skills cannot collide
because they are namespaced. A skill overrides a legacy command with the same
name. Nested duplicates remain available under directory-qualified names.

## C. Skill metadata

The complete documented frontmatter for CLI 2.1.258 is below. All fields are
optional and only `description` is recommended.

| Field | Documented semantics | Evidence status |
| --- | --- | --- |
| `name` | Display and invocation name, with directory fallback | Documented, name observed |
| `description` | Model-facing discovery text, with first body paragraph fallback | Documented and observed |
| `when_to_use` | Appended model-facing trigger guidance | Documented-only |
| `argument-hint` | Autocomplete hint | Documented-only |
| `arguments` | Names positional arguments for `$name` substitution | Documented-only |
| `disable-model-invocation` | Removes model discovery and blocks automatic or scheduled invocation | Documented and observed |
| `user-invocable` | Hides and blocks direct `/name` use when false, while retaining model use | Documented, model visibility observed |
| `allowed-tools` | Per-turn pre-approved tool grant | Documented-only |
| `disallowed-tools` | Per-turn removal from available tools | Documented-only |
| `model` | Per-turn model override, or fork model with `context: fork` | Documented-only |
| `effort` | Per-turn effort override | Documented-only |
| `context` | `fork` runs the skill in a subagent | Documented-only |
| `agent` | Selects the subagent used with `context: fork` | Documented-only |
| `background` | Controls whether a forked skill waits for its result | Documented-only |
| `hooks` | Registers session hooks when invoked | Documented-only |
| `paths` | Limits automatic activation to matching file globs | Documented-only |

Source: <https://code.claude.com/docs/en/skills>

The handoff specifically asked about two foreign fields:

| Field | Result |
| --- | --- |
| `compatibility` | Undocumented by Claude. Accepted without error in the probe. No Claude behavior was demonstrated, so treat it as ignored metadata |
| `metadata` | Undocumented by Claude. Accepted without error, including a nested mapping. No Claude behavior was demonstrated, so treat it as ignored metadata |

An additional unknown scalar field was also accepted without error. The docs
state that frontmatter is read only when the opening `---` is the first line.

### Codex sidecar and extra files

**Observed.** The valid skill `metadata-probe` also contained:

```text
agents/openai.yaml
```

with a unique `CODEX_SIDECAR_MARKER`. Claude loaded the skill and exposed its
`SKILL.md` description without error. It did not expose the sidecar marker.
Claude supports arbitrary referenced supporting files, so an extra file does
not itself cause a failure. Nothing documents special handling for
`agents/openai.yaml`. Treat the Codex sidecar as inert unless the skill body
explicitly tells Claude to read it.

### `disable-model-invocation`

**Observed.** `manual-only` had a unique description and body plus:

```yaml
disable-model-invocation: true
```

When asked to list every available custom skill without invoking one, Claude
omitted `manual-only` while listing ordinary project and user skills. Direct
invocation succeeded:

```sh
claude -p ... '/manual-only Reply with the body marker only.'
```

Output:

```text
MANUAL_ONLY_BODY_MARKER
```

This confirms the field removes the description from model context and still
allows explicit user invocation, matching the docs. In the same probe,
`user-invocable: false` did not remove `metadata-probe` from model-visible
skills, also matching the documented split between menu visibility and model
availability.

## D. Surfaces

| Surface | Instructions and skills | Evidence |
| --- | --- | --- |
| CLI | Behavior described and tested above | Observed plus documented |
| VS Code and JetBrains | Local surfaces use the same engine and share local configuration, project memory, and skills | Documented-only |
| Desktop Code tab, local and SSH sessions | Same underlying engine as CLI and shares `CLAUDE.md`, settings, project memory, and skills | Documented-only |
| Desktop Cowork | Uses account-synced skills. Local user skill files do not transfer. User instruction symlinks outside the working directory are skipped | Documented-only |
| Claude Code on the web | Fresh clone receives committed project `CLAUDE.md`, `.claude/skills/`, rules, commands, agents, and repo-declared plugins. It does not receive local `~/.claude/CLAUDE.md`, user skills, or user-only plugins | Documented-only |

The docs describe CLI, VS Code, JetBrains, Desktop, and claude.ai as surfaces
of the same engine. Local surfaces share filesystem configuration. Their
session histories remain separate. Web and Cowork differ because they run in
fresh remote environments and use repository or account-synced configuration:
<https://code.claude.com/docs/en/platforms>,
<https://code.claude.com/docs/en/claude-code-on-the-web>,
<https://code.claude.com/docs/en/skills>

## Implications for `fix-claude.sh`

`fix-claude.sh` is still needed for the repository's canonical `.agents`
layout. Its local project and home bridges are correct for the tested CLI:

```text
.claude/CLAUDE.md -> ../.agents/agents.md
.claude/skills -> ../.agents/skills
```

The README claim that Claude "only looks under `.claude/`" is directionally
correct about `.agents`, but technically too narrow. Claude also reads root
`CLAUDE.md`, `CLAUDE.local.md`, managed instructions, rules, added directories
under explicit controls, plugins, and synced skills. It does not read root
`AGENTS.md` natively.

The bridge misses or cannot solve these cases:

1. Web sessions do not inherit the home bridge. Project symlinks must be
   committed and preserved in the clone, or the repository must contain native
   Claude-facing configuration.
2. Desktop Cowork skips the home instruction symlink because it resolves
   outside the session working directory. Account-synced skills solve skills,
   not `.agents` global instructions.
3. The top-level skills-directory symlink works now but is not the exact
   symlink form guaranteed by current docs, which guarantee symlinked skill
   entries. A future bridge could link individual skill directories for the
   narrowest documented contract, at the cost of more collision handling.
4. Existing files are silently left untouched. This is safe, but it can leave
   the bridge incomplete without telling the user which artifacts remain
   unbridged.

## Surprises and contradictions

1. Claude now explicitly documents `AGENTS.md` interoperability through a
   `CLAUDE.md` import or symlink, but still does not discover `AGENTS.md`
   directly.
2. Claude calls its skills compatible with the Agent Skills open standard,
   yet its documented filesystem discovery remains `.claude/skills`, not the
   draft `.agents` paths targeted by this repository.
3. Personal skills override project skills. This is the opposite of the common
   expectation that project configuration is more specific and therefore wins.
4. `disable-model-invocation: true` removes the skill description from model
   context entirely. It does more than merely ask the model not to invoke it.
5. The CLI accepted unknown and Codex-specific metadata without choking.

## Open questions

1. The whole `.claude/skills` directory symlink is observed but not explicitly
   guaranteed in current docs. A regression test across future Claude versions
   would settle its stability.
2. Desktop Code tab and IDE extensions were not installed in this headless
   environment. Running the same marker fixture in each UI would verify the
   documented same-engine behavior.
3. A real web or Cowork session was not launched. Committing the fixture to a
   disposable repository and inspecting `/context` and `/skills` there would
   verify how internal project symlinks survive cloud cloning.
4. The precise ordering between root `CLAUDE.md` and `.claude/CLAUDE.md` is
   observed in one CLI release but not stated explicitly in the docs. A client
   test or an explicit Anthropic contract would make it reliable.
