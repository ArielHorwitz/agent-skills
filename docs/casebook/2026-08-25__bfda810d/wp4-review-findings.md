# WP4 review findings (claude-opus-5, read-only)

# WP4 review: vendor compatibility branch

`sh -n bridge.sh` clean. `sh tests/bridge-test.sh` passes. Findings ranked.

## 1. `bridge.sh:122-127` — a symlinked `.claude` produces dangling links outside the project, silently

`bridge_claude` always uses targets relative to `$project` (`../.agents/skills`), but writes them into `$project/.claude` *without resolving it*. A dotfiles user with `~/.claude -> ~/dotfiles/claude` gets:

```
linked /tmp/brt/c6/.claude/skills -> ../.agents/skills
Done.        (exit 0, and both links are dangling in /tmp/brt/outside)
```

Reproduced above: two broken symlinks created in a directory outside the one the user named, reported as success. Claude then reads nothing and the user has no signal. `bridge_codex` already solves exactly this for `$CODEX_HOME` (`bridge.sh:134-139`: resolve, fall back to an absolute target when it isn't the expected path). **Fix:** mirror that in `bridge_claude` — resolve `$claude_directory` and use `$project/.agents/...` when it is not `$project/.claude`. Cheap belt-and-braces alternative: after `ln -s`, `[ -e "$link_path" ] || { printf 'warning: %s does not resolve\n'; status=1; }` in `ensure_link`, which catches every future variant of this.

## 2. `bridge.sh:117-120` — a dangling `.agents/agents.md` is bridged silently

The `-L` guard correctly refuses to clobber it, but nothing reports it, so the run exits 0 with `Done.` after linking `CLAUDE.md` and `AGENTS.md` at a target that does not exist (reproduced). Contrast `.agents/skills`, where the same condition correctly hits `fail`. **Fix:** if `agents.md` is present but `! -e`, call `report_occupied` and set `status=1`.

## 3. `README.md:71-74` overstates the failure contract

"It reports each skipped path and exits with status 1 **after checking everything**." True for vendor links (verified: `all` with a `.claude/CLAUDE.md` collision still bridges Codex), false for scaffold collisions — an occupied `.agents` or `.agents/skills` calls `fail` and aborts before any vendor path is examined. **Fix:** either route scaffold collisions through `report_occupied`/`status=1` like the rest, or say "a scaffolding collision aborts immediately".

## 4. `README.md:106` contradicts `install.sh:95-103`

"Reinstalling or upgrading the skill overwrites local changes." A plain reinstall does not overwrite — it aborts with `refusing to overwrite; re-run with --force`. Only `--upgrade`/`--force` overwrites, and the Install section 12 lines earlier says so. **Fix:** "Upgrading the skill (`install.sh --upgrade`) overwrites local changes."

## 5. `README.md:53` drops a caveat the source report insists on

The matrix says project/global skills are `Bridged: .claude/skills` flatly. `claude-compatibility-report.md:161-162` and open item 3 state the *top-level directory* symlink is observed but not the form current docs guarantee (they promise symlinked skill *entries*). The plan's own matrix carries "observed, not documented". **Fix:** add a Known gaps bullet: the whole-directory `.claude/skills` symlink works in CLI 2.1.258 but is not a documented guarantee. Everything else in §Vendor compatibility checks out against both reports, including all three known gaps.

## 6. Test gaps that matter — `tests/bridge-test.sh`

- No assertion that a created link **resolves**. This is the only gap that hides a live bug (finding 1). Add `[ -e "$project/.claude/skills" ]`, plus a case where `.claude` is a symlink to a sibling directory.
- No test that `all` keeps going past a collision, which is the specific claim in `README.md:71-74`.
- `AGENTS.override.md` is only tested in the project branch (line 66-72), never in the `$CODEX_HOME` branch, which is a separate code path (`bridge.sh:141`).
- Line 90 writes the stub content `# AGENTS.md` into an existing `agents.md`, so the test cannot detect a clobber. Use distinct content and assert it survives.
- No path-with-spaces case (I verified manually that it works, so this is regression insurance only).

## 7. Codex sidecars — no findings

`skills/lead/agents/openai.yaml` and `skills/report-skill-feedback/agents/openai.yaml` match `codex-compatibility-report.md:160-189` exactly: right path, right key, right value, and `policy` alone is valid since the other blocks are optional.

## 8. Public-copy style

- `skills/delegate/tools.md:61` keeps a prose semicolon on a line this branch edited: "codex 0.153.4; confirm current behavior". Also `tools.md:28-29` retains two more inside a bullet the branch otherwise de-semicoloned.
- `skills/lead/README.md:19` "into the role, for example, `/lead ship the auth refactor`" — the comma sandwich reads worse than the em-dash it replaced. Drop the second comma.
- The three vendor-syntax notes (`casebook:12`, `lead:24`, `report-skill-feedback:40`) are near-identical boilerplate; three verbatim repetitions of "and other harnesses have their own invocation syntax" is the most machine-written thing in the diff. Vary or shorten two of them.
- `skills/report-skill-feedback/README.md:20` "**Hard traces of the actual use**, including verbatim invocations" — the bold fragment plus comma reads spliced. "**Hard traces of the actual use**: verbatim invocations, ..." keeps the list intact.
- No em-dashes remain in any changed Markdown. The remaining semicolons in `skills/iac/README.md` are inside code comments, which is fine.

## Minor, no action needed

A relative `CODEX_HOME` creates the directory relative to the caller's cwd rather than `$HOME` (verified), but Codex resolves it the same way, so the script is consistent with the tool. `create_directory` reuses the global name `directory`, shadowing the parsed argument variable — harmless today because `project` is computed first, fragile if the order ever changes.
