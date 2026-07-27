# Presence handle collisions — decisions and reasoning

Record of the design discussion and the choices made (including options
considered and rejected).

---

## The real defect — a destructive write, not missing access control

The trigger was "two agents on the same project could join under one handle and
clobber each other." The sharper framing that justified acting: every other
write in IAC is **non-destructive**. Messages are write-once, and `cmd_send`
already disambiguates a filename clash with a random suffix rather than
overwriting. Presence was the *single* place a write silently destroyed another
agent's file.

So this is not about adding access control (which IAC deliberately rejects —
"recipient is a convention, not access control"). Handle uniqueness stays a
convention. The change only restores the non-destructive-write invariant that
holds everywhere else.

The fix is **fail-loud, not fail-safe.** A handle is just a filename; there is
no identity token, so nothing stops a colliding agent from passing `--force`
anyway. The goal is only to turn the *accidental* silent clobber into a visible
error. Adding real identity (per-agent secret tokens) was rejected as
contradicting IAC's "keeps no record of its own / throwaway" ethos for little
gain on a local channel.

---

## Split `join` (announce) from `update` (modify)

`join` was overloaded as both "announce" and "update," which is the only reason
the collision existed. Splitting them:

- **`join <handle>`** — writes a fresh entry; errors if the handle exists.
- **`join <handle> --force`** — takes the handle over, writing fresh. Mirrors
  `new -f` (a third reuse of the `--force`-to-reuse pattern in this tool).
- **`iac update`** — overlays only the passed fields onto the existing entry;
  errors if the handle does not exist yet ("run `iac join` first").

**Why two verbs rather than one command with a flag.** The user's concern —
"will I have to restate `--from`/`--for` just to change `--status`?" — decided
it. Update must *merge*, whereas announce writes *fresh*. Those are genuinely
different write semantics, so `join --force` would be ambiguous (does it merge
or replace?). Two verbs make each verb's precondition and write behavior
reinforce each other: join = replace-and-must-be-new, update = merge-and-must-
exist. `update` needs no `--force`.

**Rejected: "just tell agents to update the file by hand."** This was the user's
initial alternative to a command. Rejected because it throws away `atomic_write`
staging (so `wait` never sees a half-written file), the field formatting, and
the `--export` wiring, making the common path (updating) the hand-rolled one.

---

## Presence format: JSON

Chosen so `update`'s merge is trivial and dependency-free:

```python
fields = json.loads(path.read_text())
fields.update(updates)          # overlay only what was passed
```

**Rejected: TOML** (the user's initial lean). Stdlib `tomllib` is **read-only** —
there is no writer. Writing TOML needs a third-party dep (`tomli-w`/`tomlkit`),
which fights two core properties: the script is self-contained and dependency-
free, and it *copies itself into every channel*, so a non-stdlib import could be
missing wherever it lands. Hand-serializing TOML is worse than the alternatives
because escaping the freeform multi-line note safely is exactly what a serializer
should do.

**Rejected: keep the old loose `key: value` text.** Viable (merge is a small
hand parser splitting on the blank line), but JSON's stdlib reader+writer does
the escaping — including the note — for free, and removes any bespoke-format
commitment. The cost, reduced eyeball-friendliness on disk, is mitigated:
`iac who` parses the JSON and prints `key: value`, so the human-facing output is
unchanged. The freeform note became a plain `note` field rather than a trailing
free block.

---

## Directive and README

- **Directive "Announce yourself"** now leads with `iac who` ("handles are how
  peers tell each other apart, so check for a clash before you pick one"),
  documents that `join` refuses a taken handle (with `--force` to take over),
  and points at `iac update` for keeping the entry current. The old "rewriting
  it is fine" line — which sanctioned exactly the clobber we now reject — is
  gone.
- **README** usage block gains the `update` line and the join collision note;
  the presence one-liner now says "one JSON file per participant"; the
  `IAC_HANDLE` note covers `join`/`update`.

---

## Verification

`py_compile` passes. End-to-end in a throwaway `IAC_ROOT`: `join` creates a
JSON entry; a second `join` on the same handle errors (exit 1); `update
--status` changes only status and leaves `from`/`for` intact; `update` before
any `join` errors; `join --force` takes the handle over with a fresh entry;
`who` pretty-prints each entry as `key: value`.

## Accepted / deliberately not done

- **Stale entry from a crashed agent** blocking a new same-handle join: not a
  concern per the user — presence is a throwaway file; delete it or use
  `--force`. No takeover-of-stale special-casing.
- **TOCTOU** between `iac who` and `iac join`: two agents could both check, see
  nothing, and both join. Negligible for a handful of local agents; not
  engineered around.
