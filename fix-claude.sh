#!/bin/sh
# Scaffold a vendor-neutral .agents/ directory in a project (or your home dir)
# and bridge it to .claude/ with symlinks, so an agent that only looks in
# .claude (e.g. Claude Code) still reads the standard .agents/ layout.
#
#     fix-claude.sh [options] [directory]
#
# In DIRECTORY (default: the current directory) this ensures:
#     .agents/skills/          skills directory
#     .agents/agents.md        stub instructions file (created if missing)
#     .claude/skills   -> ../.agents/skills     (symlink)
#     .claude/CLAUDE.md -> ../.agents/agents.md (symlink)
#
# Anything that already exists (a symlink, or a real file) is left as-is, so
# this is safe to re-run and won't disturb an existing setup.

set -eu

usage() {
    cat <<'EOF'
Scaffold .agents/ and bridge it to .claude/ with symlinks.

Usage:
    fix-claude.sh [options] [directory]

Options:
    -h, --help   Show this help and exit

directory defaults to the current directory. Anything that already exists is
left untouched.
EOF
}

fail() { printf 'error: %s\n' "$1" >&2; exit 1; }

# --- parse arguments --------------------------------------------------------

DIR="."

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help) usage; exit 0 ;;
        --)        shift; [ $# -gt 0 ] && DIR="$1"; break ;;
        -*)        fail "unknown option: $1" ;;
        *)         DIR="$1"; shift ;;
    esac
done

[ -d "$DIR" ] || fail "not a directory: $DIR"
project=$(CDPATH= cd -- "$DIR" && pwd)

agents_dir="$project/.agents"
claude_dir="$project/.claude"

# Link $1 (the link path) to $2 (a target relative to the link's directory).
# Anything already at the link path (a symlink or a real file) is left as-is.
link_relative() {
    link=$1
    target=$2
    if [ -e "$link" ] || [ -L "$link" ]; then
        return 0
    fi
    ln -s "$target" "$link"
    printf 'linked %s -> %s\n' "$link" "$target"
}

mkdir -p "$agents_dir/skills" "$claude_dir"

if [ ! -e "$agents_dir/agents.md" ]; then
    printf '# AGENTS.md\n' > "$agents_dir/agents.md"
    printf 'created %s\n' "$agents_dir/agents.md"
fi

link_relative "$claude_dir/skills" "../.agents/skills"
link_relative "$claude_dir/CLAUDE.md" "../.agents/agents.md"

printf 'Done. %s\n' "$agents_dir"
