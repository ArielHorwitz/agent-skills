# Overview

## Goal

`skills/delegate/models.md` and `tools.md` were last refreshed in August 2026
(models: Opus 5 / Fable 5 / Sonnet 5 / GPT-5.6; tools observed at claude 2.1.258,
codex 0.153.4). Since then new, stronger and more efficient models shipped from
both Anthropic (Opus 5.5, Sonnet 5.5, Fable 5.1 at least) and OpenAI, and both
CLIs moved (claude 2.1.286, codex 0.159.3 at case open).

Rather than a one-off update, build a **repo-local maintainer skill** that makes
the refresh reproducible, then use it, then review it against practice:

1. Design the skill.
2. Run it in this session (lead session) to produce the actual refresh.
3. Review the skill after real use and fold in lessons learned.

User direction: cost is no object; this is high-leverage (every future delegate
spawn reads these files), so put in lots of effort.

## Decisions so far

- **Location:** `.agents/skills/` (vendor-neutral), bridged to `.claude/skills`
  and `AGENTS.md` via `bridge.sh all` (committed `4c435e3`). Repo-local so it is
  not shipped by `install.sh`, which installs only `skills/`.
- Prior art: the delegate design case (df73dba7) did the original two-wave,
  eleven-pass multi-model research; the permission-posture case (cf504f22)
  established "guidance over enumeration" for tools.md and a claim-verification
  pattern. The skill generalizes both.

See [skill-design-brief.md](skill-design-brief.md) for the design.

## Where things stand

1. **Skill designed** (`.agents/skills/refresh-delegate-catalog/`): drafted by an
   Opus 5.5 author from `skill-design-brief.md`, reviewed by GPT-5.6 Sol and Fable
   5.1, then cut per `user-decisions.md` (no fidelity, no availability notes, no
   calibration; ratings come from research only).
2. **Skill run** in this lead session. Trail in `run-log.md`. Outcome, approved
   by the user: `models.md` re-rated to seven models (Opus 5.5, Sonnet 5.5,
   Fable 5.1, Haiku 4.5, GPT-6 Astra, GPT-6.1 Sol, GPT-6 Luna) on depth,
   execution, cost-to-task; `tools.md` refreshed for claude 2.1.286 and codex
   0.159.3 (`tools-probes.md`). Key artifacts: `drift-report.md`,
   `research-*.md`, `synthesis-*.md`, `rating-reconciliation.md` (incl. the
   user's correction of flattened cost bands), `verification-summary.md`.
3. **Skill reviewed after use**: `lessons-from-first-run.md` (18 lessons,
   lesson 1 corrected after review) folded in by the author, then a fresh
   two-vendor review (`review-skill-post-run-*.md`) caught a wrong diagnosis
   (the stray codex report was the lead's shell bug, not codex) and unchecked
   post-verification wording; both fixed in the skill and the shipped file.

## Status

Closed. Next refresh: invoke `refresh-delegate-catalog`; it finds this case by
the `delegate-catalog-refresh` keyword and starts from its filled-in briefs and
`help/` snapshots.
