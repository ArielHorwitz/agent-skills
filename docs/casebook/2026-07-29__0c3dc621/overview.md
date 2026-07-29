# Restructure repo into a public multi-skill collection

## Why this case exists

The repo began as a single-skill repo for `iac` (inter-agent communication). It
now holds a second skill, `casebook`, and the intent has shifted: this is to
become a **public, shared collection of agent skills**. This case covers
restructuring and organizing the repo for that new purpose.

## Starting state (before this case)

Tracked layout:

```
.gitignore            # __pycache__/
iac/
  SKILL.md
  README.md
  iac                 # the executable script (no extension)
casebook/
  SKILL.md
  casebook.py
docs/
  casebook/           # the casebook itself (cases live here)
```

Observations:
- Two skills (`iac`, `casebook`) each live in a top-level directory holding a
  `SKILL.md` plus their implementation.
- No top-level README — nothing orients a visitor to the repo as a whole.
- No install story for end users (how a skill lands in `~/.claude/skills/`).
  `iac` has its own `iac install` for the script onto PATH, which is a different
  concern from installing the *skill*.
- `docs/casebook/` is repo-internal working history, not a shipped skill.

## Decisions & implementation (2026-07-29)

1. **Directory structure — skills under `skills/`.** Each skill is one directory
   (`skills/iac/`, `skills/casebook/`), mapping 1:1 to `~/.claude/skills/<name>/`.
   Top level is kept for repo meta (README, installer, `docs/`). Done via
   `git mv`.
2. **Top-level `README.md`** — entry point + skills index table, install
   instructions, per-skill prerequisites, and a layout map. Each skill keeps its
   own `SKILL.md`/`README.md`; the top-level README does not re-explain them.
3. **Installer `install.sh`** — POSIX `sh`, **copies** skills (not symlinks,
   consistent with `iac` having dropped `--symlink`). Installs all skills or a
   named subset into `~/.agents/skills`; `--dest` to override, `--list` to
   enumerate. Kept distinct from `iac install` (which puts the `iac` *executable*
   on PATH — a separate concern).
   - Originally sketched with a `curl | sh` download path (tarball via codeload);
     the user then decided to **assume a local clone**, so the installer is
     clone-only (resolves `skills/` next to itself). Simpler, no network code.
   - **Existing skills are not clobbered silently.** If a target skill dir already
     exists the installer warns and exits (before writing anything, so no partial
     install); `--force`/`--upgrade` removes the existing skill dir wholesale and
     reinstalls fresh, so stale files from a previous version can't survive. This
     replaced the earlier always-overwrite behavior.
4. **Vendor-neutral location.** Skills install into `.agents/skills`, not
   `.claude/skills`. The Claude-specific `CLAUDE_CONFIG_DIR` env var was dropped;
   default dest is `~/.agents/skills`, `--dest` overrides. `.claude` survives in
   the docs only where we describe the bridge (below), since removing it would
   delete the explanation of how Claude finds the skills.
5. **`fix-claude.sh`** (renamed from `agents-init.sh`, reflecting the
   Claude-as-outlier framing) — brought over from the user's personal `.dmd`
   tooling and rewritten dependency-free (dropped `spongecrab`/`printcolor`/`exit_error`;
   plain POSIX `sh`). Scaffolds `.agents/` (`agents.md` + `skills/`) in a target
   directory and bridges it to `.claude/` with relative symlinks
   (`.claude/skills -> ../.agents/skills`, `.claude/CLAUDE.md ->
   ../.agents/agents.md`). Anything already present — a symlink or a real file —
   is left untouched, so it is safe to re-run and won't disturb an existing setup
   (an earlier `--skills-only` flag was dropped in favor of this skip-existing
   behavior). Kept decoupled from `install.sh`: install writes to `.agents`, this
   handles the bridge.
6. **README framing.** The README no longer explains what a skill is — it links
   the [Agent Skills spec](https://agentskills.io) and the
   [.agents protocol](https://dotagentsprotocol.com/) instead. Claude is treated
   as a misbehaving outlier: the main install flow is vendor-neutral, and a
   dedicated **Claude** section at the bottom (linked from Install) covers the
   `.claude` → `.agents` bridge for Claude users only.
7. **No LICENSE** — per the user's explicit call, out of scope for now.
8. **Branding kept as "agent skills."** Considered rebranding to "agent toolkit"
   (prompted by `fix-claude` being useful beyond the bundled skills), and an
   `.agents`-protocol-centric framing. Rejected both: "toolkit" is generic and
   overloaded and the non-skill surface is currently just one small script — too
   thin a basis to trade away the precise, discoverable "agent skills" term.
9. **Unpushed git history reorganized** into four logical commits (iac doc tweak
   / add casebook / restructure / case record), squashing the iteration and
   per-step case-doc churn. Verified byte-identical tree to the pre-rewrite ref
   (`backup/pre-organize`). Not yet pushed.

## Follow-ups (not done here)

- **Repo rename.** The GitHub repo / remote is still `ArielHorwitz/iac`, now a
  misnomer for a multi-skill collection. A new name was never chosen. Renaming is
  a GitHub-side action the user must take; when done, update the clone URL in
  `README.md`. The installer has no hardcoded repo reference (clone-only), so it
  is unaffected.
- **Push.** The four commits are unpushed; `backup/pre-organize` still exists as
  a safety ref to delete once satisfied.

## Status

Implementation complete on `master`. Restructure, README, installer
(`install.sh`), and the `.agents` bridge (`fix-claude.sh`) are in place and
tested (install → list / all / subset / unknown-rejection / refuse-existing /
--force stale-file removal; fix-claude → fresh bridge / skip real CLAUDE.md /
leave existing symlink / idempotent re-run). All in-scope decisions are settled.
The only open thread is the repo rename, which is blocked on a user decision and
a GitHub action — not code work.
