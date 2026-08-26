# Agent skills

A collection of vendor-agnostic [agent skills](https://agentskills.io) focused
on coordination and orchestration. Skills install into a `.agents/skills/`
directory, following the [.agents protocol](https://dotagentsprotocol.com/).

## Skills

| Skill | What it does |
| --- | --- |
| [`casebook`](skills/casebook/) | Work within a project's *casebook* — a directory of "cases", each a bounded unit of work (investigation, design, feature) with its own metadata and files. |
| [`iac`](skills/iac/) | Inter-agent communication — a filesystem channel for agents working in parallel to coordinate over shared files. |
| [`delegate`](skills/delegate/) | Spawn another agent — a different CLI tool, model, or a fresh headless session — to carry out a task, using a user-maintained doc of what's available and how to invoke it. |
| [`lead`](skills/lead/) | Take the lead on a goal — hold the high-level objective and steer, delegating significant work to other agents instead of doing it in this session. |
| [`report-skill-feedback`](skills/report-skill-feedback/) | Send a skill's author a feedback report on how their skill actually behaved in real use — for skills that ship a `skill-feedback-reporting.md` (reporting instructions) saying what they want. |

Each skill is rooted at its `SKILL.md`; a companion `README.md` provides a
human-facing explanation.

## Install

Clone the repo and run the installer:

```sh
git clone https://github.com/ArielHorwitz/agent-skills
cd agent-skills
./install.sh              # all skills, into ~/.agents/skills/
./install.sh casebook     # just one
./install.sh --list       # see what's available
./install.sh --check      # report what would happen, change nothing
```

The installer is opinionated: it lays things out the way the
[.agents protocol](https://dotagentsprotocol.com/) describes, creating
`~/.agents/skills/` for skills and an `~/.agents/agents.md` stub for your
instructions. Use `--dir DIR` to set up somewhere else — `--dir .` treats the
current directory as a project rather than your home directory. An
already-installed skill is left alone unless you pass `--upgrade` (alias
`--force`), which removes the existing skill directory and reinstalls it fresh —
so `git pull` then `./install.sh --upgrade` is the update path. Full flags:
`install.sh --help`.

None of that is required to use the skills. If you'd rather not adopt the
protocol, skip the installer and copy them wherever your tool already reads
from:

```sh
cp -R skills/casebook ~/.claude/skills/
```

## Vendor setup

Tools disagree about where they look, and each one is missing something
different. `--vendor` bridges the gaps, pointing the locations a tool expects at
the `.agents/` directory you already have:

```sh
./install.sh --vendor claude          # bridge your home directory (global)
./install.sh --dir . --vendor all     # bridge the current project, every vendor
```

| | Skills | Instructions |
| --- | --- | --- |
| [Claude Code](https://claude.com/claude-code) | `.claude/skills` → `.agents/skills` | `.claude/CLAUDE.md` → `.agents/agents.md` |
| [Codex](https://learn.chatgpt.com/docs/agent-configuration/agents-md) | reads `.agents/skills` directly | global: `~/.codex/AGENTS.md` → `.agents/agents.md`<br>project: `AGENTS.md` → `.agents/agents.md` |

Two documented limits are worth knowing. Codex cloud tasks can't see local
files, so a project bridge reaches them only if both `AGENTS.md` and
`.agents/agents.md` are committed. And Claude's Cowork sessions on desktop skip
a `~/.claude/CLAUDE.md` that is itself a symlink, so the global instructions
bridge is invisible to that one surface — skills and every other Claude surface
are unaffected.

Every link is reported, including the ones already in place, so re-running is
safe and never silent. Anything real sitting where a link belongs is left
untouched and reported as a conflict; pass `--adopt` to move that content into
`.agents/` and link it afterwards. When both sides hold real content the
installer aborts and leaves the merge to you.

## Model invocation

A skill can trigger on its own when its `description` matches what an agent
is doing, or be restricted to only run when explicitly invoked, via
`disable-model-invocation: true` in `SKILL.md`'s frontmatter. Each skill in
this collection picks whichever default fits it; edit that line directly (add
it to disable auto-triggering, remove it to allow) if you want different
behavior — reinstalling/upgrading a skill will overwrite the change.
