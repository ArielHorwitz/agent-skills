# Common rules for the vendor-compatibility probes

You are one of several delegates probing how agent CLIs (Claude Code, Codex)
discover instructions, skills, and skill metadata, so this repository can
document and bridge vendor compatibility accurately. You are headless: nobody
will answer questions. Do what you can, and state plainly what you could not.

## Where things are

- Repo worktree (your working directory, write your report here):
  `/mnt/black/prog/agent-skills/.worktrees/vendor-compatibility`
- Case directory (put your report in it):
  `docs/casebook/2026-08-25__bfda810d/` (read `overview.md` first)
- Scratch lab for experiments (writable, throwaway): `/tmp/vendor-compat-lab/`
  Create your own subdirectory named after your task.
- Installed tool versions on this machine: claude 2.1.258, codex-cli 0.153.4.

## Hard rules

1. Never create, modify, or delete anything under `/home/wiw` other than
   inside `/tmp/vendor-compat-lab`. That includes `~/.codex`, `~/.claude`,
   `~/.agents`, and `~/.config`. Reading them is fine.
2. For "global" (home-level) experiments, fake the home instead:
   - Codex: run with `CODEX_HOME=/tmp/vendor-compat-lab/<you>/codex-home`,
     and symlink `auth.json` there from `/home/wiw/.codex/auth.json`
     (symlink, do not copy). Create a minimal `config.toml` if needed.
   - Claude: run with `HOME=/tmp/vendor-compat-lab/<you>/home`, and symlink
     `.claude/.credentials.json` there from
     `/home/wiw/.claude/.credentials.json` (symlink, do not copy).
   If a faked home cannot authenticate, record the attempt and mark that
   experiment "untested", do not work around it by touching the real home.
3. Nested probe runs must be cheap and short. Use the cheapest model
   (`codex exec --model gpt-5.6-luna`, `claude -p --model claude-haiku-4-5`),
   a tiny prompt, and non-interactive flags (`codex exec ... --skip-git-repo-check`,
   `claude -p ...`). A good probe prompt is: "List verbatim every instructions
   file and every skill you were given, with their paths. Do nothing else."
4. Evidence over assertion. For each finding, record the exact command,
   the relevant output (trimmed), and whether it was observed or only read in
   docs. Distinguish "documented", "observed", "documented but not observed",
   and "untested". Quote doc URLs.
5. If your own sandbox blocks a step (network, path, denial), record exactly
   what was denied and move on. Do not try to escalate around it.
6. Do not edit anything in the repo except your own report file(s) in the
   case directory. Do not commit.
7. Public-copy style in the report: no em-dashes, no semicolons, plain
   prose, tables where a matrix is the natural shape.
8. Do the work yourself, in this session, directly. Do not spawn subagents,
   background agents, or delegate any part of the task. A headless session
   ends when you stop, and anything you handed off dies with it.
