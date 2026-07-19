# Follow-up audit — 2026-07-19

Fresh review of the current `iac` script and README. The user approved the
two path/input-handling fixes documented below; they are implemented in the
working tree but not committed.

## Findings

### Accepted risk — concurrent same-field sends can overwrite a message

`cmd_send` builds a name only to second precision and checks `path.exists()`
before calling `atomic_write()` ([`iac`](../../../iac), lines 251–262). The
write is committed with `os.replace()` (lines 126–134), which replaces an
already-existing target. Two simultaneous senders with the same normalized
sender, recipient, and title can both observe that the base filename does not
exist, then the second `replace` overwrites the first.

This technically violates the documented write-once invariant and can silently
discard a message. In practice it requires the same agent (or two agents using
the same handle) to use the same recipient and title within the same second. A
stress run of 80 same-field concurrent sends retained 80 files.

Decision: accepted as implausible for the intended workflow; no change planned.

### Medium — documented first-run command is unavailable from a fresh clone

The repository's `iac` file has mode `0644`, so `./iac --help` fails with
`Permission denied`. The README's primary usage and setup examples invoke
`iac new`, `iac join`, etc. ([`README.md`](../../../README.md), lines 31–39
and 61–65), but the repository provides neither an executable script nor an
installation/PATH setup instruction. `python3 iac --help` does work.

Suggested direction: either make the script executable and document a clear
installation/PATH path, or consistently use `python3 /path/to/iac` in the
first-run instructions.

### Low — invalid poll interval fails at runtime rather than argument parsing (fixed)

`--interval` accepted any float. With no pending changes, a negative value
reached `time.sleep()` and raised `ValueError`; zero caused a busy loop. It now
uses an argparse validator that rejects zero, negative, and non-finite values
with a clear error.

### Low — channel “names” can escape the configured root (fixed)

`channel_from_name()` treats any value containing `/` as a path and resolves
it. Thus `iac new ../somewhere` created outside `IAC_ROOT`, despite the CLI
help and README describing a name as a channel under that root. `new` now
normalizes its optional name with `slug()` and joins it directly below
`IAC_ROOT`; explicit paths remain available when selecting an existing channel
with `--channel`.

## Checks performed

- `python3 -m py_compile iac` passed.
- `python3 iac --help` passed.
- `./iac --help` failed because the file is non-executable.
- A disposable channel received 80 concurrently launched same-field sends;
  80 message files resulted. This provides a smoke test only; static analysis
  establishes the overwrite race.
