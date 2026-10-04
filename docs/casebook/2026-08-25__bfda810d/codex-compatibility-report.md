# Codex compatibility with the `.agents` layout

Tested 2026-09-08 with `codex-cli 0.153.4` on Linux. CLI findings are observed unless marked otherwise. Desktop, IDE, cloud, and ChatGPT findings are documentation-only or harness observations because those surfaces were not independently available in the lab.

## Summary matrix

| Artifact or behavior | Native `.agents` support | Documented Codex location | Observed behavior | Bridge needed? |
|---|---|---|---|---|
| Global instructions | No | `$CODEX_HOME/AGENTS.override.md`, otherwise `$CODEX_HOME/AGENTS.md` | Fake `$CODEX_HOME/AGENTS.md` loaded. Fake `$HOME/.agents/agents.md` did not load. | Yes |
| Project instructions | Configurable, not default | `AGENTS.override.md`, `AGENTS.md`, then configured fallback names in every directory from repo root to CWD | `<project>/.agents/agents.md` was ignored by default. `project_doc_fallback_filenames = [".agents/agents.md"]` loaded it. | Config or symlink |
| User skills | Yes | `$HOME/.agents/skills`, plus deprecated `$CODEX_HOME/skills` | Both loaded. `$HOME/.codex/skills` was ignored when `$CODEX_HOME` pointed elsewhere. | No |
| Project skills | Yes | `.agents/skills` in every directory from repo root to CWD | Root and nested `.agents/skills` loaded. A project `.codex/skills` also loaded as a config-layer compatibility location. | No |
| Symlinked instruction file | Codex behavior, not protocol-specific | Not stated explicitly | A valid root `AGENTS.md` symlink was followed. A dangling symlink was skipped. | Safe bridge option |
| Symlinked skill directory | Yes | Explicitly documented | Loaded from a symlinked child directory. | No |
| Duplicate skill names | Yes, without precedence collapse | Docs say both can appear | Repo, user, and legacy Codex-home copies with the same `name` all appeared, each with its own path and description. | Collision policy needed |
| `SKILL.md` core metadata | Yes | `name`, `description`, optional `metadata.short-description` | Those fields were parsed. Unknown fields did not reject the skill. | No |
| Claude invocation metadata | No | None | A skill with `disable-model-invocation: true` still appeared for implicit use. `allowed-tools`, `argument-hint`, and `compatibility` were not represented in Codex's parsed metadata. | Translate policy if needed |
| Codex invocation metadata | Codex-specific sidecar | `<skill>/agents/openai.yaml` | `policy.allow_implicit_invocation: false` removed the skill from ambient model context, while explicit `$skill` invocation still loaded and followed it. | Generate sidecar |

## A. Instruction discovery

### Global scope

[Official OpenAI documentation](https://learn.chatgpt.com/docs/agent-configuration/agents-md) says Codex reads only the first non-empty global candidate, preferring `$CODEX_HOME/AGENTS.override.md` over `$CODEX_HOME/AGENTS.md`. It does not name `$HOME/.agents/agents.md`.

The lab isolated both concepts by setting `HOME` and `CODEX_HOME` to different temporary directories:

```text
HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/home
CODEX_HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/codex-home
codex exec --model gpt-5.6-luna --skip-git-repo-check --ephemeral --json \
  -C /tmp/vendor-compat-lab/codex-probe/runtime2/project/nested/deeper \
  'List verbatim every instructions file marker and every skill name, description, and path you were given. Do nothing else.'
```

Relevant output:

```text
GLOBAL_CODEX_HOME_MARKER
PROJECT_OVERRIDE_MARKER
NESTED_AGENTS_MARKER
```

`GLOBAL_DOT_AGENTS_MARKER` was absent. This confirms that changing `CODEX_HOME` controls global instruction discovery, and that `~/.agents/agents.md` is not a native global instruction source in CLI 0.153.4.

### Project scope and fallback paths

By default, Codex checked each directory from Git root through CWD for `AGENTS.override.md`, then `AGENTS.md`. A root override suppressed the root `AGENTS.md` symlink, while a nested `AGENTS.md` was also loaded:

```text
PROJECT_OVERRIDE_MARKER
NESTED_AGENTS_MARKER
```

After removing both root candidates, this command tested a fallback containing a path separator:

```text
codex exec ... -C /tmp/vendor-compat-lab/codex-probe/runtime2/project/nested/deeper \
  -c 'project_doc_fallback_filenames=[".agents/agents.md"]' \
  'List verbatim every instructions marker you were given. Do nothing else.'
```

Relevant output:

```text
GLOBAL_CODEX_HOME_MARKER
PROJECT_DOT_AGENTS_MARKER
NESTED_AGENTS_MARKER
```

This is the most useful result for a bridge. Despite the setting's documented name of “filenames,” 0.153.4 accepts the nested relative path `.agents/agents.md`. The implementation appends each configured candidate to every searched directory using a path join. See [`candidate_filenames` and `agents_md_paths`](https://github.com/openai/codex/blob/rust-v0.153.4/codex-rs/core/src/agents_md.rs).

The setting is user configuration. A project `.codex/config.toml` cannot reliably bootstrap discovery of its own instructions unless the project is already trusted, because project configuration is trust-gated.

### Precedence, symlinks, and size

Observed precedence matched the docs:

1. Global instructions loaded first.
2. One project file loaded per directory.
3. `AGENTS.override.md` won over `AGENTS.md` in the same directory.
4. Deeper project files appeared later.

A valid `AGENTS.md -> .agents/agents.md` symlink was followed when no same-directory override existed. When an override existed, the symlink target was not loaded because only the winning candidate is included.

`project_doc_max_bytes=10` with a project file containing `1234567890_END_MARKER` produced:

```text
GLOBAL_CODEX_HOME_MARKER
--- project-doc ---
1234567890
```

The byte limit therefore applies to the combined project-document budget and truncates a file at the remaining byte count. Global instructions are outside that project budget. The documented default is 32 KiB.

### Invalid candidates

A dangling root `AGENTS.md` symlink was treated as missing and the run continued with only global instructions. A directory named `AGENTS.md` was also skipped and the run continued. Neither condition caused a startup error in the CLI probe. Source inspection agrees: only metadata classified as a file is selected, and a not-found error is ignored.

## B. Skill discovery

[Official OpenAI skill documentation](https://learn.chatgpt.com/docs/build-skills) documents these roots:

| Scope | Root |
|---|---|
| Repository | `.agents/skills` at every directory from repository root to CWD |
| User | `$HOME/.agents/skills` |
| Admin | `/etc/codex/skills` |
| System | Skills bundled with Codex |

CLI 0.153.4 additionally loaded the deprecated `$CODEX_HOME/skills` root and a `.codex/skills` directory belonging to the project config layer. The latter was observed even without a project config file. These compatibility roots are visible in [`host_roots.rs`](https://github.com/openai/codex/blob/rust-v0.153.4/codex-rs/ext/skills/src/host_roots.rs).

The baseline probe returned all of the following custom entries:

```text
duplicate-skill | REPO duplicate description | .../project/.agents/skills/repo-duplicate/SKILL.md
linked-skill | SYMLINK skill description | .../project/.agents/skills/linked-skill/SKILL.md
nested-skill | NESTED skill description | .../project/nested/.agents/skills/nested-skill/SKILL.md
duplicate-skill | CODEX_HOME legacy duplicate description | .../codex-home/skills/legacy-duplicate/SKILL.md
duplicate-skill | USER duplicate description | .../home/.agents/skills/user-duplicate/SKILL.md
project-codex-skill | PROJECT dot codex description | .../project/.codex/skills/project-codex-skill/SKILL.md
```

`$HOME/.codex/skills/ignored-codex-home-skill` did not appear. This distinguishes the deprecated `$CODEX_HOME/skills` root from a hard-coded `~/.codex/skills` root.

There is no winner when names collide. Codex exposes every copy with its source path. The bridge must avoid creating a second copy or symlink of a skill already visible through `.agents`, since that creates duplicate selectors rather than precedence.

Codex explicitly documents following symlinked skill folders. The probe confirmed a symlinked child below `.agents/skills` was discovered. The target itself was elsewhere in the repository.

Codex therefore honors the `.agents` draft only partially. It natively implements the skill locations targeted by this repository, but not the draft's global or project instruction locations by default. Codex documentation describes its skills as implementing the separate [open agent skills standard](https://agentskills.io), not the `.agents` protocol as a whole.

## C. Skill metadata

### `SKILL.md` frontmatter

The 0.153.4 parser deserializes only:

```text
name
description
metadata.short-description
```

`description` is required. An absent or blank `name` falls back to the skill directory name. Unknown YAML keys are accepted and ignored. See the exact [`SkillFrontmatter` parser](https://github.com/openai/codex/blob/rust-v0.153.4/codex-rs/skills/src/parser.rs).

The lab put all of these extra fields on a visible user skill:

```yaml
argument-hint: ignored-argument-hint
compatibility: ignored-compatibility
disable-model-invocation: true
allowed-tools: ignored-tool
metadata:
  short-description: short-user
  custom-key: ignored-custom
```

The skill still appeared in ambient context. Source inspection shows no fields for `argument-hint`, `compatibility`, `disable-model-invocation`, or `allowed-tools`. Codex does not enforce Claude's `disable-model-invocation: true`, and it does not use `allowed-tools` to constrain tools. The bundled plugin validator mentions these keys for cross-vendor package validation, but that is separate from runtime parsing.

### `agents/openai.yaml`

The exact sidecar is:

```text
<skill>/agents/openai.yaml
```

The documented schema includes:

```yaml
interface:
  display_name: "User-facing name"
  short_description: "User-facing description"
  icon_small: "./assets/small.svg"
  icon_large: "./assets/large.png"
  brand_color: "#3B82F6"
  default_prompt: "Prompt text"
policy:
  allow_implicit_invocation: false
dependencies:
  tools:
    - type: "mcp"
      value: "server-name"
      description: "Dependency description"
      transport: "streamable_http"
      url: "https://example.invalid/mcp"
```

`policy.allow_implicit_invocation` defaults to `true`. When false, the skill is withheld from ambient model context but remains explicitly invocable.

Observed behavior matched exactly. A skill whose description said to trigger for “orchard code” did not appear in the baseline catalog and was not used for `Give me the orchard code.` Explicitly asking `Use $noimplicit-skill and give me the orchard code.` produced `NOIMPLICIT_USED`, the exact instruction in the skill body.

This is stronger evidence than merely asking the model whether it would use the skill. It demonstrates both sides of the policy in separate fresh runs.

## D. Surfaces

| Surface | Instruction discovery | Standalone local skills | Evidence level |
|---|---|---|---|
| CLI | Full behavior described above | Yes | Observed and documented |
| IDE extension | Codex docs present `AGENTS.md` as general Codex configuration. Exact path parity is not stated on the IDE page. | Explicitly supported, including `$skill` and `/skills` | Documented-only |
| Codex in ChatGPT desktop app | The general Codex customization docs point to the same `AGENTS.md` model, but exact local discovery parity is not stated. | Explicitly supported and has a Skills browser | Documented-only |
| Codex cloud | Repository `AGENTS.md` is documented for cloud workflows and code review. Local `$CODEX_HOME` and `$HOME` roots do not exist in the cloud environment in the same sense. | The standalone-skill availability statement omits cloud. Repository skill discovery was not explicitly established. | Documented-only and partly unsettled |
| ChatGPT-hosted harness in this session | The harness supplied project `AGENTS.md` instructions to this agent. That does not prove CLI-native discovery because the host assembles the prompt. | The harness exposed `/home/wiw/.agents/skills` entries. This is consistent with Codex behavior but still host-mediated. | Observed harness behavior only |

The [Build skills page](https://learn.chatgpt.com/docs/build-skills) explicitly says standalone skills are available in the ChatGPT desktop app, Codex CLI, and IDE extension. It separately says plugin-bundled skills are available in Chat and Work on web, desktop, and mobile. It does not include Codex cloud in the standalone local-skill claim.

## Implications for a bridge

Two viable project bridges exist:

1. Preferred where user configuration is acceptable: add `project_doc_fallback_filenames = [".agents/agents.md"]` to `$CODEX_HOME/config.toml`. This preserves the canonical file and avoids occupying `<project>/AGENTS.md`. It applies at every searched directory, so nested `<directory>/.agents/agents.md` files also work. Existing `AGENTS.override.md` or `AGENTS.md` still wins in that directory.
2. Zero-config repository bridge: create `<project>/AGENTS.md -> .agents/agents.md`. Codex follows it. The bridge must refuse to overwrite any existing file, directory, symlink to another target, or dangling symlink. An existing `AGENTS.override.md` means the symlink will be ignored in that directory and should be reported as a collision.

Global instructions still require `$CODEX_HOME/AGENTS.md -> $HOME/.agents/agents.md`, or an equivalent real file. `project_doc_fallback_filenames` does not affect global discovery. The global bridge must preserve an existing `$CODEX_HOME/AGENTS.md`, `$CODEX_HOME/AGENTS.override.md`, directory, or non-matching symlink.

No skill bridge should be created for `.agents/skills`. Codex already discovers those directories natively. Bridging them into `$CODEX_HOME/skills` would produce duplicate skill names and paths.

For invocation policy, a cross-vendor generator should map a neutral “explicit only” concept to Codex's `agents/openai.yaml` with `policy.allow_implicit_invocation: false`. Copying Claude's `disable-model-invocation` field alone has no Codex effect.

## Corrections and surprises relative to the overview

The overview's statement that Codex does not automatically discover `.agents/agents.md` remains correct for default configuration. Its open question about nested-path fallback is now settled for CLI 0.153.4: `.agents/agents.md` works as a fallback entry.

Additional surprises were:

- Project `.codex/skills` is still discovered as a compatibility root even though current user-facing docs emphasize `.agents/skills`.
- Duplicate skill names coexist rather than shadowing one another.
- `disable-model-invocation: true` is ignored by the runtime parser.
- A dangling instruction symlink and an `AGENTS.md` directory are skipped without aborting the run.

## Open questions

- Exact instruction and repository-skill parity in the IDE extension and desktop app needs a surface-level probe or an explicit OpenAI statement that those clients use identical discovery code.
- Codex cloud's support for repository `.agents/skills`, nested skill roots, symlinked skill directories, and `agents/openai.yaml` needs a cloud task in a purpose-built repository.
- The ChatGPT-hosted harness may add its own discovery and policy layers. A controlled harness with an isolated home and repository would distinguish host injection from Codex core behavior.
- Admin `/etc/codex/skills` and system-bundled precedence were not mutated or exhaustively tested because the lab rules forbid system changes. Source and docs establish the roots, but not every collision combination.
- Symlink targets outside the readable sandbox were not tested. A valid symlink is still subject to the active filesystem permission profile.

## Reproduction notes

All throwaway fixtures lived under `/tmp/vendor-compat-lab/codex-probe/runtime2/`. Authentication used only this symlink, as required by the lab rules:

```text
/tmp/vendor-compat-lab/codex-probe/runtime2/codex-home/auth.json
  -> /home/wiw/.codex/auth.json
```

The OpenAI Codex source was checked out at the exact installed tag `rust-v0.153.4`, commit `3d2ee51ca2d5db578f328aa75e20aa22c0197c9a`, under `/tmp/vendor-compat-lab/codex-probe/codex-src/`. No files under `/home/wiw` were modified.

The remaining exact probe commands were:

```bash
HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/home \
CODEX_HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/codex-home \
codex exec --model gpt-5.6-luna --skip-git-repo-check --ephemeral --json \
  -C /tmp/vendor-compat-lab/codex-probe/runtime2/project/nested/deeper \
  -c 'project_doc_fallback_filenames=[".agents/agents.md"]' \
  'List verbatim every instructions marker you were given. Do nothing else.'

HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/home \
CODEX_HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/codex-home \
codex exec --model gpt-5.6-luna --skip-git-repo-check --ephemeral --json \
  -C /tmp/vendor-compat-lab/codex-probe/runtime2/project \
  'List verbatim every instructions marker you were given. Do nothing else.'

HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/home \
CODEX_HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/codex-home \
codex exec --model gpt-5.6-luna --skip-git-repo-check --ephemeral --json \
  -C /tmp/vendor-compat-lab/codex-probe/runtime2/project \
  -c project_doc_max_bytes=10 \
  'Quote all project instruction text you received. Do nothing else.'

HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/home \
CODEX_HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/codex-home \
codex exec --model gpt-5.6-luna --skip-git-repo-check --ephemeral --json \
  -C /tmp/vendor-compat-lab/codex-probe/runtime2/project \
  'Give me the orchard code.'

HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/home \
CODEX_HOME=/tmp/vendor-compat-lab/codex-probe/runtime2/codex-home \
codex exec --model gpt-5.6-luna --skip-git-repo-check --ephemeral --json \
  -C /tmp/vendor-compat-lab/codex-probe/runtime2/project \
  'Use $noimplicit-skill and give me the orchard code.'
```

The dangling-symlink and directory probes used the same second command after replacing the root candidate first with `AGENTS.md -> missing-target`, then with an actual directory named `AGENTS.md`. The former returned only `GLOBAL_CODEX_HOME_MARKER`. The latter returned no file marker and did not report a startup failure.
