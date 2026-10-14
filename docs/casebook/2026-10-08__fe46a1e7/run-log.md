# Run log (incremental refresh, Haiku 5.5)

## Phase 1: setup and go/no-go

- Baseline: models.md `0e21e2c`, tools.md `146fb4a`, both 2026-10-04. Previous
  case 5f21657f.
- Installed claude 2.1.286, codex 0.159.3 (same as baseline). Published:
  claude 2.1.293 (2.1.294 tagged 2026-10-08), codex 0.161.0. Not upgraded.
- Smoke (scratch dir, "Reply with OK", 2026-10-08): claude-haiku-5-5 OK
  ($0.021, 200K context, 32K max output reported), but CLI 2.1.286 logs
  `[claude-code:unrecognized_model]` and `costBasis: unknown`: the CLI predates
  the model. claude-opus-5-5 OK, gpt-6.1-sol OK. Go.
- codex models cache (fetched 2026-10-08) identical to the 2026-10-04 snapshot.
- Axes unchanged: depth, execution, cost-to-task.
- Scaled plan (user direction): drift x2 and Haiku 5.5 research x3 in
  parallel; synthesis x2; verification x2; no tools probes.

## Phase 2+3: drift and research (parallel, effort high, case dir as cwd)

- Drift: claude-opus-5-5 (5e3ff752-4712-473e-975a-9e3d43ad03c1, $2.10),
  gpt-6.1-sol (01a11b08-349a-7272-bf6e-de503958a81d). Merged into
  `drift-report.md`. Only new model: claude-haiku-5-5. Not surprising, no
  user check.
- Research on Haiku 5.5: claude-opus-5-5 (e35e406d-0eac-404a-9d26-57064240da88,
  $2.99), gpt-6-astra (01a11b08-3494-7592-a6d5-32c0d3b5ce28), gpt-6.1-sol
  (01a11b08-34ac-7ed3-ad4e-62bfc610a7fe). All done in ~7 minutes, no usage
  limits, no stray files, no commit attempts.
- Running drift in parallel with research was safe here because the new model
  was known up front; had drift found another model, it would have needed a
  follow-up research round.

## Phase 4: synthesis

- First attempt failed on both. claude-opus-5-5 (dcba702b-2b70-441c-85e6-0a4860c4969b,
  $0.76): headless claude with cwd = case dir could not read the previous case
  or `skills/delegate/models.md` (outside cwd, permission denied), and wrote a
  blocker instead of a blind draft. **Lesson:** a claude delegate reading inputs
  outside its cwd needs `--add-dir`; the first run never hit this because its
  inputs all lived in the case dir. gpt-6-astra (01a11b0f-297f-7921-a351-9540494bef1e)
  hit the ChatGPT usage limit mid-synthesis (resets 16:00) after 107K tokens.
- Opus resumed with `--add-dir <worktree>`.
- Opus resume: done ($1.81, no denials). Haiku 5.5 2/2/lowest; Haiku 4.5 to Not listed.
- User reset codex usage manually; Astra synthesis started early.
- Astra synthesis (01a11b21-fdbc-7b03-a638-08f7ec9c6928) done after manual
  usage reset. Ratings identical to Opus. Merged into `models-draft.md`, see
  `rating-reconciliation.md`.

## Phase 5: verification

Scoped to claims new or changed since the 2026-10-04 verified file (user
direction: no full re-run). Three verifiers, effort high, blind, each in its
own scratch dir outside the repo: claude-sonnet-5-5, gpt-6.1-sol, gpt-6-astra
(two OpenAI, since most claims concern an Anthropic model).
scratch /tmp/verify.XkpL
- All three verifiers done, no usage limits. Decisions in `verification-summary.md`.

## Phase 6: tools

Skipped: installed CLIs unchanged since baseline. Flagged for the gate: claude
2.1.293+ is required for Haiku 5.5 per docs (2.1.286 runs it with a 200K
window and unknown cost basis).

## Phase 7: user gate

- User approved, deferring both judgment calls to the lead (2026-10-14).
  Kept Haiku 5.5 at `lowest`: both synthesizers chose it independently,
  verifiers called it defensible, and the row states it costs more than Luna.
- Days passed at the gate, so the lead rechecked on 2026-10-14: codex model
  cache unchanged, Anthropic release notes and OpenAI API changelog show no
  new model, repricing, or roster deprecation since 2026-10-08. Only GPT-6.1
  Sol Ultrafast (a service tier, 2026-10-08), which the catalog doesn't track.
  Footer kept at 2026-10-08, the research date.
- CLI upgrade (claude 2.1.293+ for Haiku 5.5) left to the user.

## Retrospective

- The light run took about an hour of delegate time plus a usage-limit wait,
  against hours for the full run. Spend: Claude delegates about $12; codex on
  subscription.
- Folded into the skill: claude `--add-dir` for inputs outside cwd; matching
  the usage-limit error line, not the phrase; smoke test reading for a CLI
  older than the model; an "Incremental runs" section.
- Not folded: the bundled briefs stay generic; this case's
  `research-brief.md` and `synthesis-brief.md` are the incremental variants a
  later light run can start from.
