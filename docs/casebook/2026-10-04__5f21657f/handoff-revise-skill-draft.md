# Handoff: revise the skill draft from review

Two independent reviews: `review-skill-draft-gpt-5-6-sol.md` and
`review-skill-draft-fable-5-1.md` (this case dir). Read both. Lead's rulings:

## Accept (implement)

- **Two synthesizers, one per vendor**, same inputs, independent ratings; the
  lead reconciles from a disagreement table. Verifiers may still not verdict
  ratings, but the reconciliation is where rating bias gets controlled.
- **Reconcile by evidence quality, not vote count** (source independence,
  recency, authority). Research brief asks researchers to flag when several
  claims rest on one source.
- **Exact baseline:** record the refresh date and the case/commit, not a month.
  The new shipped footer should carry an exact date.
- **Axes are "the current file's axes"**, not hardcoded four. Phase 1/2 puts the
  axis set to the user if anything about it is unsettled (it is, this run: the
  fidelity column, see your own report). Keep honesty/substitution/outage as a
  research question regardless of whether it is a column.
- **Calibration:** pin and record an effort level per CLI; no web in calibration
  spawns; run in a scratch copy outside the repo; record "refused because tests
  contradict" as a distinct outcome; compute cost from tokens x researched price
  list; say plainly what calibration can and cannot move. Add one larger
  multi-file task only if it stays deterministic to check and cheap to
  maintain, otherwise state the limitation. Add a small self-test for
  `check.py` (known-good, unfixed, test-editing, gamed) and run it.
- **Posture per role:** researchers spawned with the case dir as working dir;
  verifiers from a scratch copy of the draft; tool probes in disposable repos
  with canary paths, real config and an isolated config contrasted.
- **Phase 1 go/no-go:** confirm the lead's shell has network and can run each
  CLI. Observed this run: the lead's shell has network, but a nested `claude -p`
  delegate's Bash could not resolve DNS. So the lead runs smoke tests,
  calibration, and tool probes itself (phase 7 defaults to the lead).
- **Record requested vs reported model per spawn**; self-report is weak signal.
- **Phase 8:** after approval, offer the user the reinstall
  (`install.sh --force delegate`) so live spawns pick up the change, and remind
  about a user override at `~/.config/agent-skills/delegate/models.md`.
- **Ambiguities:** fix all of Fable's list (define "strong model", verifier
  agreement rule, "every vendor in tools.md" consistently, how to extract tokens
  and final message per CLI is worked out in phase 2 and recorded, first run may
  live in an existing case, web search vs fetch wording, background long spawns).

## Pending user decisions (keep the skill neutral)

Fidelity column, and whether calibration stays at all. Make removal of the
calibration dir a clean cut (nothing else breaks if it goes).

## Do

Revise, run the check.py self-test, commit (amend is not needed; a new commit
is fine). Append a "Revision" section to `author-report-skill-draft.md` listing
what changed and anything you rejected and why. No em-dashes.
