# Codex compatibility with the `.agents` protocol

## Problem

This repository treats `.agents/` as the canonical, vendor-neutral home for
agent configuration. Codex currently provides only partial interoperability
with that layout:

- The active Codex harness discovers skills in
  `/home/wiw/.agents/skills/`.
- It does not automatically discover the global instructions in
  `/home/wiw/.agents/agents.md`.
- Codex's documented global instruction location is
  `$CODEX_HOME/AGENTS.md`, normally `~/.codex/AGENTS.md`.
- Codex's documented project discovery walks from the project root to the
  working directory and checks instruction filenames in those directories. It
  does not document discovery of `<project>/.agents/agents.md`.

The result is split support by artifact type: skills work from `.agents`, but
instructions require a Codex-specific location. This contradicts the current
repository documentation's implication that Claude is the sole tool requiring
a compatibility bridge.

## Relevant contracts

- The draft [`.agents` protocol](https://dotagentsprotocol.com/) defines
  `~/.agents/agents.md` as global guidance and
  `<project>/.agents/agents.md` as workspace guidance.
- [Codex's official `AGENTS.md` documentation](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
  defines `$CODEX_HOME/AGENTS.md` for global guidance and direct hierarchical
  discovery of `AGENTS.md`, `AGENTS.override.md`, or configured fallback
  filenames for project guidance.

These are related but distinct contracts. Codex can comply with its own
`AGENTS.md` discovery rules without implementing the `.agents` directory
protocol.

## Initial compatibility direction

Keep `.agents/agents.md` canonical and expose it through vendor-facing
adapters, avoiding copied instruction files that can drift. The simplest Codex
bridge appears to be:

- Global: `~/.codex/AGENTS.md -> ~/.agents/agents.md`
- Project: `<project>/AGENTS.md -> <project>/.agents/agents.md`

This resembles the existing Claude bridge in `fix-claude.sh`, but it should not
be accepted as the design until collision handling, installation scope, and
Codex lifecycle behavior have been examined.

## Open questions

1. Should Codex receive a focused `fix-codex.sh`, or should vendor adapters be
   consolidated into a more general setup command?
2. How should the adapter behave when a real `AGENTS.md`, an override, or a
   pre-existing symlink already occupies the Codex-visible location?
3. Should global and project setup be separate operations, as they are for the
   current Claude bridge?
4. Can Codex configuration provide a reliable nested-path fallback, or are
   root-level symlinks the only documented approach?
5. Which Codex surfaces share this behavior: CLI, IDE extension, desktop,
   cloud, and the ChatGPT-hosted harness?
6. How should the README describe native, partial, and adapter-mediated
   compatibility without overstating support for the draft protocol?

## Intended outcomes

- Establish the exact Codex compatibility matrix for `.agents` instructions
  and skills.
- Choose an idempotent bridge that preserves existing user files.
- Add focused verification for global and project instruction discovery.
- Correct the installation and compatibility documentation.
- Decide whether the remaining gap should also be reported upstream to Codex.

## Decisions

The framing shifted first: no vendor reads `.agents/` completely, and the gaps
differ *by artifact type*, so "Claude is the odd one out" was wrong rather than
merely incomplete. Codex reads skills from `.agents/skills` natively but not
instructions; Claude reads neither. That is a compatibility matrix, and the
README now prints it as one.

The repository's identity did not change with it. It stays a skills collection
that happens to ship an opinionated installer — adopting the protocol is what
the installer *does*, not a precondition for using the skills. Anyone who wants
neither the layout nor the symlinks can `cp -R skills/<name>` into whatever
directory their tool reads, which needs no code and is now documented.

Resolving the open questions above:

1. **One installer, not a `fix-codex.sh`.** `install.sh` absorbed the scaffolding
   that `fix-claude.sh` was doing on the side, and `fix-claude.sh` is deleted.
   Vendors are selected with `--vendor claude,codex` (or `all`).
2. **Adapters are vendor-keyed plugins.** Each `adapters/<name>.sh` declares an
   `adapter_<name>` function; `install.sh` sources them all and dispatches by
   name, so the link, adopt, and reporting helpers exist in exactly one file.
   Convention-keying was considered and dropped: two vendors that both want
   `<project>/AGENTS.md` are declaring the *same* link, so they agree by
   construction and there is nothing to deduplicate.
3. **One `--dir`, scope derived.** `--dir` names where `.agents/` goes (default
   `~`); global when it is the home directory, project otherwise. This replaced
   `--dest`, which pointed at the skills subdirectory and read as the wrong
   level of the layout.
4. **Conflicts are reported, never silently skipped.** Every link reports one of
   `linked` / `up-to-date` / `native` / `adopted` / `CONFLICT`, and a run with
   conflicts exits non-zero. `--check` renders the same report without touching
   anything, which is both the dry run and the verification tool.
5. **`--adopt` is opt-in and refuses to merge.** It moves real content out of a
   vendor location into `.agents/` and links it back. Adoption runs *before*
   skills are installed, so an existing `.claude/skills` moves into an empty
   `.agents/skills` rather than colliding with freshly-installed content. When
   both sides hold real content it aborts loudly and leaves the merge to a human;
   directories are never merged automatically.

## Verified against vendor documentation

Checked 2026-08-26; every adapter decision above survived, and the compatibility
matrix is now grounded rather than assumed.

**Question 4 — no nested-path fallback.** `project_doc_fallback_filenames` takes
bare filenames checked in each walked directory, not relative paths: the
documented example is `["TEAM_GUIDE.md", ".agents.md"]`, and Codex "checks each
directory in this order: `AGENTS.override.md`, `AGENTS.md`, `TEAM_GUIDE.md`,
`.agents.md`". A root-level symlink is the only documented route to
`.agents/agents.md`. Note also that `AGENTS.override.md` takes precedence at
every scope, so a user with one will not see the bridged file.

**Question 5 — surfaces.** The CLI, desktop app, and IDE extension share
`~/.codex/config.toml` and project `AGENTS.md` alike. Cloud is the exception:
cloud tasks have no access to local files and read what is committed to the
repository. The project bridge therefore reaches cloud only when *both* the
`AGENTS.md` symlink and `.agents/agents.md` are committed.

**Claude project instructions — both locations work.** Project instructions load
from "`./CLAUDE.md` or `./.claude/CLAUDE.md`", so the adapter's existing link
needs no second root-level link.

**Codex project skills — discovered, and symlinks are followed.** Codex scans
`.agents/skills` in every directory from the working directory up to the
repository root, plus `$HOME/.agents/skills` (user) and `/etc/codex/skills`
(admin), and "supports symlinked skill folders and follows the symlink target".
Project-scope skill installation is useful, and `native` is the correct report at
both scopes.

**One bridge limitation, on Claude's side.** Cowork sessions on desktop skip a
`~/.claude/CLAUDE.md` that is itself a symlink or hard link. The global
instructions bridge is invisible to that surface; the skills link and every
other Claude surface are unaffected.

## Still open

- Reporting the instruction-discovery gap upstream to Codex is still undecided.
  The gap is now precisely stateable: Codex reads `.agents/skills` but not
  `.agents/agents.md`, and its fallback mechanism cannot express a nested path.

## Follow-up: implicit invocation under Codex

The observation that `disable-model-invocation` is not respected by Codex is not
a bug — Codex does not implement that field. It reads a vendor file *inside* the
skill, `<skill>/agents/openai.yaml`, whose `policy.allow_implicit_invocation:
false` means "Codex won't implicitly invoke the skill based on user prompt;
explicit `$skill` invocation still works" — the same intent, a different
mechanism.

Three skills here declare `disable-model-invocation: true` and so trigger
implicitly under Codex today: `casebook`, `lead`, and `report-skill-feedback`.
Closing that gap means shipping an `agents/openai.yaml` beside each SKILL.md,
which is skill content rather than installer work; it belongs in its own case.
