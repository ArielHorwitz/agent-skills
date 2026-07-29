# IAC — inter-agent communication

A dead-simple communication channel for AI agents (or anything else) working in
parallel, built entirely on ordinary files. Named after IPC, but for agents.

A **channel** is a directory. A **message** is a write-once file. **Presence**
is one JSON file per participant under `who/`. Agents read by listing and reading
files, and stay in sync by polling with `iac wait`. There is no server, no
daemon, and no routing — just a filesystem and a directive telling agents how to
use it.

IAC is only a *transport*. It makes no promise of persistence and keeps no
record of its own — treat channels as throwaway. If a conversation matters
beyond the moment, copy it somewhere durable yourself. Where and how you archive
is your business, not IAC's.

## Design

The single-file `iac` script is thin sugar; the real payload is
`directive.md`, which is written into every channel and tells any reasonably
capable agent how to participate. This keeps IAC agnostic to model, harness, and
tool — anything that can read files and run a command can join.

When you create a channel, the script **copies itself into it**, so onboarding a
new agent needs nothing more than the channel's path:

```
~/.iac/<channel>/iac wait 0
```

## Install

`iac` is a single self-contained script. Run it in place as `./iac`, or put it
on your PATH so the examples below work verbatim:

```sh
./iac install            # copy this script to ~/.local/bin/iac
```

Pass `--dest <path>` to install elsewhere. If the destination directory isn't on
your PATH, the command prints the line to add it. Channels always carry their own
copy, so onboarding an agent never depends on this — it is purely a convenience
for driving `iac` by hand.

## Usage

```sh
iac new [name]                          # create a channel under ~/.iac (self-copies in)
iac join [handle] [--status ...] [--from ...] [--for ...]   # announce (errors if handle taken; -f to take over)
iac update [--status ...] [--from ...] [--for ...]          # update your own entry (overlays given fields)
iac send "<title>" [message] [--to <recipient|group>] [--sender ...]
iac who                                 # show announced presence
iac ls                                  # list messages
iac wait [cursor] [--timeout N]         # block until the channel changes
iac install [--dest ...]                # copy this script onto your PATH
```

### Staying in sync

`iac wait` blocks until a message or presence entry is added or modified (a new
file in `messages/`, or an updated `who/` entry), then prints each changed path
followed by `cursor: <n>`. Pass that `<n>` as the cursor on your next call and
you only ever see what's new — each poll compares against the same cursor rather
than the wall clock, so nothing slips through between polls. Call it with no
cursor (or `0`) to catch up on everything, `--timeout` for a heartbeat, and
`--timeout 0` to check once without blocking.

The cursor is a filesystem mtime, so this assumes the sub-second timestamps of a
modern local filesystem; on coarse-grained media (FAT, old HFS+) or if the
system clock steps backward, a message that shares or predates the cursor's
timestamp can be missed. For a throwaway local channel that's a non-issue.

It reports additions and modifications, not deletions.

Commands other than `new` operate on the channel the script lives in, or on one
named with `--channel <name-or-path>`. Set `IAC_ROOT` to relocate the channel
root (default `~/.iac`).

### Environment (convenience for interactive use)

Every command is fully self-describing, but a human participating or driving
`iac` by hand repeats the same channel and handle constantly. Two environment
variables cut that out:

- `IAC_CHANNEL` — the channel (name under `IAC_ROOT`, or a path) to operate on
  when `--channel` is absent and you aren't running a channel-local copy.
- `IAC_HANDLE` — your handle. Used as the default `sender` for `send` and the
  default `handle` for `join`/`update`. If neither an argument nor `IAC_HANDLE`
  is present, those commands fail rather than send an unattributed message.

Channel resolution order is `--channel` > channel-local copy > `IAC_CHANNEL`.

A child process can't set variables in your shell, so `new` and `join` take
`--export`: they print `export …` lines on stdout (messages go to stderr) for
you to `eval`. `join --export` emits the resolved channel *and* handle, so one
step wires up both:

```sh
eval "$(iac new standup --export)"                       # sets IAC_CHANNEL
eval "$(iac join human-supervisor --export)"             # reads it, adds IAC_HANDLE
# ...or join an existing channel in a single step:
eval "$(iac join human-supervisor --channel standup --export)"

iac send all "hop on when you can"                       # sender + channel now implicit
```

These are a human convenience only; agents keep passing everything explicitly
and are unaffected.
