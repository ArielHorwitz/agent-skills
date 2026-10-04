#!/bin/sh
set -eu

root=$(CDPATH='' cd -P -- "$(dirname "$0")/.." && pwd)
bridge=$root/bridge.sh
sandbox=$(mktemp -d)
trap 'rm -rf "$sandbox"' EXIT HUP INT TERM

fail() { printf 'FAIL: %s\n' "$1" >&2; exit 1; }
contains() { printf '%s\n' "$1" | grep -F "$2" >/dev/null || fail "missing output: $2"; }
run_bridge() {
    output_file=$sandbox/output
    if "$@" >"$output_file" 2>&1; then result=0; else result=$?; fi
    output=$(cat "$output_file")
}

project=$sandbox/fresh
mkdir "$project"
run_bridge "$bridge" all "$project"
[ "$result" -eq 0 ] || fail 'fresh all returned nonzero'
[ "$(cat "$project/.agents/agents.md")" = '# AGENTS.md' ] || fail 'wrong stub content'
[ "$(readlink "$project/.claude/skills")" = '../.agents/skills' ] || fail 'wrong Claude skills link'
[ "$(readlink "$project/.claude/CLAUDE.md")" = '../.agents/agents.md' ] || fail 'wrong Claude instructions link'
[ "$(readlink "$project/AGENTS.md")" = '.agents/agents.md' ] || fail 'wrong Codex instructions link'
[ -e "$project/.claude/skills" ] || fail 'Claude skills link does not resolve'
[ -e "$project/.claude/CLAUDE.md" ] || fail 'Claude instructions link does not resolve'
[ -e "$project/AGENTS.md" ] || fail 'Codex instructions link does not resolve'
contains "$output" "created $project/.agents"
contains "$output" "linked $project/AGENTS.md -> .agents/agents.md"
[ "$(printf '%s\n' "$output" | grep -c '^linked ')" -eq 3 ] || fail 'fresh all did not report three links'

ls -lR "$project" >"$sandbox/before"
run_bridge "$bridge" all "$project"
[ "$result" -eq 0 ] || fail 'repeat run returned nonzero'
ls -lR "$project" >"$sandbox/after"
cmp "$sandbox/before" "$sandbox/after" >/dev/null || fail 'repeat run changed the tree'
[ "$(printf '%s\n' "$output" | grep -c '^ok ')" -eq 3 ] || fail 'repeat run did not report three links as ok'

collision=$sandbox/regular
mkdir "$collision"
printf 'keep\n' >"$collision/AGENTS.md"
run_bridge "$bridge" codex "$collision"
[ "$result" -eq 1 ] || fail 'regular AGENTS.md did not fail'
contains "$output" "exists $collision/AGENTS.md (regular file)"
[ "$(cat "$collision/AGENTS.md")" = keep ] || fail 'regular AGENTS.md changed'

collision=$sandbox/directory
mkdir -p "$collision/.claude/skills"
run_bridge "$bridge" claude "$collision"
[ "$result" -eq 1 ] || fail 'skills directory did not fail'
contains "$output" "exists $collision/.claude/skills (directory)"

collision=$sandbox/foreign
mkdir -p "$collision/.claude"
mkdir "$collision/.claude/elsewhere"
ln -s elsewhere "$collision/.claude/CLAUDE.md"
run_bridge "$bridge" claude "$collision"
[ "$result" -eq 1 ] || fail 'foreign symlink did not fail'
contains "$output" "exists $collision/.claude/CLAUDE.md (symlink -> elsewhere)"
[ "$(readlink "$collision/.claude/CLAUDE.md")" = elsewhere ] || fail 'foreign symlink changed'

collision=$sandbox/all-continues
mkdir -p "$collision/.claude"
printf 'keep\n' >"$collision/.claude/CLAUDE.md"
run_bridge "$bridge" all "$collision"
[ "$result" -eq 1 ] || fail 'all collision did not fail'
contains "$output" "exists $collision/.claude/CLAUDE.md (regular file)"
[ -e "$collision/.claude/skills" ] || fail 'all collision prevented Claude skills link'
[ -e "$collision/AGENTS.md" ] || fail 'all collision prevented Codex link'

collision=$sandbox/dangling
mkdir "$collision"
ln -s missing "$collision/AGENTS.md"
run_bridge "$bridge" codex "$collision"
[ "$result" -eq 1 ] || fail 'dangling AGENTS.md did not fail'
contains "$output" "exists $collision/AGENTS.md (dangling symlink -> missing)"

collision=$sandbox/dangling-canonical
mkdir -p "$collision/.agents"
ln -s missing "$collision/.agents/agents.md"
run_bridge "$bridge" all "$collision"
[ "$result" -eq 1 ] || fail 'dangling canonical agents.md did not fail'
contains "$output" "exists $collision/.agents/agents.md (dangling symlink -> missing)"
[ ! -L "$collision/.claude/CLAUDE.md" ] || fail 'dangling canonical target was bridged for Claude'
[ ! -L "$collision/AGENTS.md" ] || fail 'dangling canonical target was bridged for Codex'

collision=$sandbox/directory-canonical
mkdir -p "$collision/.agents/agents.md"
run_bridge "$bridge" all "$collision"
[ "$result" -eq 1 ] || fail 'directory canonical agents.md did not fail'
contains "$output" "exists $collision/.agents/agents.md (directory)"
[ ! -L "$collision/.claude/CLAUDE.md" ] || fail 'directory canonical target was bridged for Claude'
[ ! -L "$collision/AGENTS.md" ] || fail 'directory canonical target was bridged for Codex'

collision=$sandbox/scaffold-collision
mkdir "$collision"
printf 'keep\n' >"$collision/.agents"
run_bridge "$bridge" all "$collision"
[ "$result" -eq 1 ] || fail 'occupied .agents did not fail'
contains "$output" "exists $collision/.agents (regular file)"
contains "$output" "warning: skipped $collision/.claude/skills"
contains "$output" "warning: skipped $collision/.claude/CLAUDE.md"
contains "$output" "warning: skipped $collision/AGENTS.md"
[ ! -L "$collision/AGENTS.md" ] || fail 'occupied .agents produced Codex link'

collision=$sandbox/skills-scaffold-collision
mkdir -p "$collision/.agents"
printf 'keep\n' >"$collision/.agents/skills"
run_bridge "$bridge" all "$collision"
[ "$result" -eq 1 ] || fail 'occupied .agents/skills did not fail'
contains "$output" "exists $collision/.agents/skills (regular file)"
contains "$output" "warning: skipped $collision/.claude/skills"
[ -e "$collision/.claude/CLAUDE.md" ] || fail 'skills collision prevented Claude instructions link'
[ -e "$collision/AGENTS.md" ] || fail 'skills collision prevented Codex link'
[ ! -L "$collision/.claude/skills" ] || fail 'occupied .agents/skills produced Claude skills link'

override=$sandbox/override
mkdir "$override"
printf 'override\n' >"$override/AGENTS.override.md"
run_bridge "$bridge" codex "$override"
[ "$result" -eq 0 ] || fail 'override warning changed exit status'
contains "$output" "warning: $override/AGENTS.override.md exists; Codex will ignore AGENTS.md there"
[ -L "$override/AGENTS.md" ] || fail 'override prevented link creation'

project=$sandbox/claude-symlink
claude_directory=$sandbox/claude-sibling
mkdir "$project" "$claude_directory"
ln -s "$claude_directory" "$project/.claude"
run_bridge "$bridge" claude "$project"
[ "$result" -eq 0 ] || fail 'symlinked Claude directory returned nonzero'
[ "$(readlink "$claude_directory/skills")" = "$project/.agents/skills" ] || fail 'symlinked Claude skills target is not absolute'
[ "$(readlink "$claude_directory/CLAUDE.md")" = "$project/.agents/agents.md" ] || fail 'symlinked Claude instructions target is not absolute'
[ -e "$project/.claude/skills" ] || fail 'symlinked Claude skills link does not resolve'
[ -e "$project/.claude/CLAUDE.md" ] || fail 'symlinked Claude instructions link does not resolve'

home=$sandbox/home-default
mkdir "$home"
run_bridge env HOME="$home" "$bridge" codex "$home"
[ "$result" -eq 0 ] || fail 'default home case returned nonzero'
[ ! -e "$home/AGENTS.md" ] && [ ! -L "$home/AGENTS.md" ] || fail 'home AGENTS.md was created'
[ "$(readlink "$home/.codex/AGENTS.md")" = '../.agents/agents.md' ] || fail 'wrong default home link'

home=$sandbox/home-override
mkdir -p "$home/.codex"
printf 'override\n' >"$home/.codex/AGENTS.override.md"
run_bridge env HOME="$home" "$bridge" codex "$home"
[ "$result" -eq 0 ] || fail 'home override warning changed exit status'
contains "$output" "warning: $home/.codex/AGENTS.override.md exists; Codex will ignore AGENTS.md there"

home=$sandbox/home-occupied
mkdir "$home"
printf 'keep\n' >"$home/.codex"
run_bridge env HOME="$home" "$bridge" codex "$home"
[ "$result" -eq 1 ] || fail 'occupied Codex home did not fail'
contains "$output" "exists $home/.codex (regular file)"
contains "$output" "warning: skipped $home/.codex/AGENTS.md"
[ "$(cat "$home/.codex")" = 'keep' ] || fail 'occupied Codex home changed'

home=$sandbox/home-custom
codex_home=$sandbox/custom-codex
mkdir "$home"
run_bridge env HOME="$home" CODEX_HOME="$codex_home" "$bridge" codex "$home"
[ "$result" -eq 0 ] || fail 'custom Codex home case returned nonzero'
[ "$(readlink "$codex_home/AGENTS.md")" = "$home/.agents/agents.md" ] || fail 'custom home target is not absolute'

home=$sandbox/home-absolute
mkdir -p "$home/.codex" "$home/.agents"
printf 'distinct existing guidance\n' >"$home/.agents/agents.md"
ln -s "$home/.agents/agents.md" "$home/.codex/AGENTS.md"
run_bridge env HOME="$home" "$bridge" codex "$home"
[ "$result" -eq 0 ] || fail 'equivalent absolute link returned nonzero'
contains "$output" "ok $home/.codex/AGENTS.md -> $home/.agents/agents.md"
[ "$(cat "$home/.agents/agents.md")" = 'distinct existing guidance' ] || fail 'existing agents.md changed'

project="$sandbox/project with spaces"
mkdir "$project"
run_bridge "$bridge" all "$project"
[ "$result" -eq 0 ] || fail 'path with spaces returned nonzero'
[ -e "$project/.claude/skills" ] || fail 'path with spaces has unresolved Claude skills link'
[ -e "$project/.claude/CLAUDE.md" ] || fail 'path with spaces has unresolved Claude instructions link'
[ -e "$project/AGENTS.md" ] || fail 'path with spaces has unresolved Codex link'

only=$sandbox/claude-only
mkdir "$only"
run_bridge "$bridge" claude "$only"
[ "$result" -eq 0 ] || fail 'Claude-only returned nonzero'
[ ! -e "$only/AGENTS.md" ] || fail 'Claude-only created AGENTS.md'
only=$sandbox/codex-only
mkdir "$only"
run_bridge "$bridge" codex "$only"
[ "$result" -eq 0 ] || fail 'Codex-only returned nonzero'
[ ! -e "$only/.claude" ] || fail 'Codex-only created .claude'

run_bridge "$bridge" other "$sandbox"
[ "$result" -ne 0 ] || fail 'unknown vendor succeeded'
contains "$output" 'unknown vendor: other'
run_bridge "$bridge" all "$sandbox/missing"
[ "$result" -ne 0 ] || fail 'missing directory succeeded'
contains "$output" "not a directory: $sandbox/missing"

printf 'PASS: bridge.sh vendor bridge tests\n'
