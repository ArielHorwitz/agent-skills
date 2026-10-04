# Handoff: revise the skill from the post-run reviews

Read `review-skill-post-run-claude-opus-5-5.md` and
`review-skill-post-run-gpt-6-astra.md` (this case dir), and the corrected
lesson 1 plus new lesson 18 in `lessons-from-first-run.md`.

Lead's rulings: **accept all seven Opus findings** and Astra's 1 (comparisons
keep workload, effort, and measurement scope) and 3 (drop the dollar anecdote,
keep duration and usage-limit warning). Astra's 2 is moot once Opus finding 1 is
fixed (scratch dirs only for verifiers; probes in disposable git repos as
before). On Opus 1: the trust-entry note should say codex adds an entry per git
repo it runs in with `workspace-write` (each probe dir was its own repo).

Do: revise `.agents/skills/refresh-delegate-catalog/`, keep it lean (Opus
finding 6's cuts). Commit with `git commit --fixup=<sha of "feat: add repo-local
refresh-delegate-catalog skill">` (find it with git log; don't rebase). Append a
short "Post-run review revision" section to `author-report-skill-draft.md` and
commit it as `git commit --fixup=<sha of "docs(casebook): add delegate catalog
refresh case">`. No em-dashes.
