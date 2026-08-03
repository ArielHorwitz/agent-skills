# Agent skills

A collection of [agent skills](https://agentskills.io) — portable,
self-contained capabilities an AI coding agent can discover and use.

Skills install into a vendor-neutral `.agents/skills/` directory, following the
[.agents protocol](https://dotagentsprotocol.com/).

## Skills

| Skill | What it does |
| --- | --- |
| [`iac`](skills/iac/) | Inter-agent communication — a filesystem channel for agents working in parallel to coordinate over shared files. |
| [`casebook`](skills/casebook/) | Work within a project's *casebook* — a directory of "cases", each a bounded unit of work (investigation, design, feature) with its own metadata and files. |
| [`delegate`](skills/delegate/) | Spawn another agent — a different CLI tool, model, or a fresh headless session — to carry out a task, using a user-maintained doc of what's available and how to invoke it. |
| [`lead`](skills/lead/) | Take the lead on a goal — hold the high-level objective and steer, delegating significant work to other agents instead of doing it in this session. |

Each skill's directory has its own `SKILL.md` (and, where useful, a `README.md`)
with the full details.

## Model invocation

A skill can trigger on its own when its `description` matches what an agent
is doing, or be restricted to only run when explicitly invoked, via
`disable-model-invocation: true` in `SKILL.md`'s frontmatter. Each skill in
this collection picks whichever default fits it; edit that line directly (add
it to disable auto-triggering, remove it to allow) if you want different
behavior — reinstalling/upgrading a skill will overwrite the change.

## Install

Clone the repo and run the installer. It copies skills into `~/.agents/skills/`:

```sh
git clone https://github.com/ArielHorwitz/iac
cd iac
./install.sh              # all skills
./install.sh casebook     # just one
./install.sh --list       # see what's available
```

Use `--dest DIR` to install elsewhere (e.g. a project's `.agents/skills`).
An already-installed skill is left alone unless you pass `--upgrade` (alias
`--force`), which removes the existing skill directory and reinstalls it fresh —
so `git pull` then `./install.sh --upgrade` is the update path. Full flags:
`install.sh --help`.

> **Using Claude?** Claude doesn't read `.agents/` — see [Claude](#claude) for
> the one extra step it needs.

## Claude

Most tools that read the [.agents protocol](https://dotagentsprotocol.com/) find
skills in `.agents/skills/` directly. [Claude Code](https://claude.com/claude-code)
is the odd one out: it only looks under `.claude/`, so it needs a symlink pointing
`.claude/` at the `.agents/` you already installed into.

`fix-claude.sh` sets that up. Run it once per directory you want Claude to see —
your home directory for globally-installed skills, or a project:

```sh
./fix-claude.sh ~    # bridge your home directory (global skills)
./fix-claude.sh      # bridge the current project
```

It symlinks `.claude/skills -> ../.agents/skills` (and `.claude/CLAUDE.md ->
../.agents/agents.md`), creating `.agents/` if needed. Anything that already
exists — a symlink, or a real `CLAUDE.md` — is left untouched, so it's safe to
re-run and won't disturb an existing setup.
