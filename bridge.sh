#!/bin/sh
# Scaffold a vendor-neutral .agents/ directory and bridge vendor instruction
# and skill paths to it. Claude receives instruction and skill links. Codex
# receives only an instruction link because it reads .agents/skills natively.
# Existing paths are never removed or replaced.

set -eu

usage() {
    cat <<'EOF'
Scaffold .agents/ and bridge it to Claude, Codex, or both.

Usage:
    bridge.sh [options] <claude|codex|all> [directory]

Options:
    -h, --help   Show this help and exit

directory defaults to the current directory. Existing paths are left untouched.
EOF
}

fail() { printf 'error: %s\n' "$1" >&2; exit 1; }

status=0

create_directory() {
    directory_path=$1
    if [ ! -d "$directory_path" ]; then
        if [ -e "$directory_path" ] || [ -L "$directory_path" ]; then
            report_occupied "$directory_path"
            status=1
            return 1
        fi
        mkdir -p "$directory_path"
        printf 'created %s\n' "$directory_path"
    fi
}

resolved_link_target() {
    link_path=$1
    link_target=$2
    case "$link_target" in
        /*) target_path=$link_target ;;
        *) target_path=$(dirname "$link_path")/$link_target ;;
    esac
    target_directory=$(dirname "$target_path")
    target_name=$(basename "$target_path")
    [ -d "$target_directory" ] || return 1
    printf '%s/%s\n' "$(CDPATH='' cd -P -- "$target_directory" && pwd)" "$target_name"
}

report_occupied() {
    occupied_path=$1
    if [ -L "$occupied_path" ]; then
        occupied_target=$(readlink "$occupied_path")
        if [ -e "$occupied_path" ]; then
            printf 'exists %s (symlink -> %s)\n' "$occupied_path" "$occupied_target"
        else
            printf 'exists %s (dangling symlink -> %s)\n' "$occupied_path" "$occupied_target"
        fi
    elif [ -d "$occupied_path" ]; then
        printf 'exists %s (directory)\n' "$occupied_path"
    else
        printf 'exists %s (regular file)\n' "$occupied_path"
    fi
}

ensure_link() {
    link_path=$1
    intended_target=$2
    if [ -L "$link_path" ]; then
        existing_target=$(readlink "$link_path")
        if [ "$existing_target" = "$intended_target" ]; then
            printf 'ok %s -> %s\n' "$link_path" "$intended_target"
            return
        fi
        existing_resolved=$(resolved_link_target "$link_path" "$existing_target" || true)
        intended_resolved=$(resolved_link_target "$link_path" "$intended_target" || true)
        if [ -n "$existing_resolved" ] && [ "$existing_resolved" = "$intended_resolved" ]; then
            printf 'ok %s -> %s\n' "$link_path" "$existing_target"
            return
        fi
        report_occupied "$link_path"
        status=1
    elif [ -e "$link_path" ]; then
        report_occupied "$link_path"
        status=1
    else
        ln -s "$intended_target" "$link_path"
        printf 'linked %s -> %s\n' "$link_path" "$intended_target"
        if [ ! -e "$link_path" ]; then
            printf 'warning: %s does not resolve\n' "$link_path"
            status=1
        fi
    fi
}

skip_link() {
    printf 'warning: skipped %s because %s is unavailable\n' "$1" "$2"
    status=1
}

vendor=
directory=.
while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help) usage; exit 0 ;;
        --) shift; break ;;
        -*) fail "unknown option: $1" ;;
        *) break ;;
    esac
done

[ $# -gt 0 ] || { usage >&2; exit 1; }
vendor=$1
shift
case "$vendor" in
    claude|codex|all) ;;
    *) usage >&2; fail "unknown vendor: $vendor" ;;
esac
[ $# -le 1 ] || { usage >&2; fail "too many arguments"; }
[ $# -eq 0 ] || directory=$1
[ -d "$directory" ] || fail "not a directory: $directory"

project=$(CDPATH='' cd -P -- "$directory" && pwd)
agents_directory=$project/.agents
agents_directory_usable=1
skills_directory_usable=1
agents_file_usable=1
create_directory "$agents_directory" || agents_directory_usable=0
if [ "$agents_directory_usable" -eq 1 ]; then
    create_directory "$agents_directory/skills" || skills_directory_usable=0
    if [ ! -e "$agents_directory/agents.md" ] && [ ! -L "$agents_directory/agents.md" ]; then
        printf '# AGENTS.md\n' > "$agents_directory/agents.md"
        printf 'created %s\n' "$agents_directory/agents.md"
    elif [ ! -f "$agents_directory/agents.md" ]; then
        report_occupied "$agents_directory/agents.md"
        status=1
        agents_file_usable=0
    fi
else
    skills_directory_usable=0
    agents_file_usable=0
fi

bridge_claude() {
    claude_directory=$project/.claude
    if ! create_directory "$claude_directory"; then
        skip_link "$claude_directory/skills" "$claude_directory"
        skip_link "$claude_directory/CLAUDE.md" "$claude_directory"
        return
    fi
    resolved_claude_directory=$(CDPATH='' cd -P -- "$claude_directory" && pwd)
    if [ "$resolved_claude_directory" = "$project/.claude" ]; then
        claude_skills_target=../.agents/skills
        claude_agents_target=../.agents/agents.md
    else
        claude_skills_target=$project/.agents/skills
        claude_agents_target=$project/.agents/agents.md
    fi
    if [ "$skills_directory_usable" -eq 1 ]; then
        ensure_link "$claude_directory/skills" "$claude_skills_target"
    else
        skip_link "$claude_directory/skills" "$agents_directory/skills"
    fi
    if [ "$agents_file_usable" -eq 1 ]; then
        ensure_link "$claude_directory/CLAUDE.md" "$claude_agents_target"
    else
        skip_link "$claude_directory/CLAUDE.md" "$agents_directory/agents.md"
    fi
}

bridge_codex() {
    home_directory=$(CDPATH='' cd -P -- "$HOME" && pwd)
    if [ "$project" = "$home_directory" ]; then
        codex_directory=${CODEX_HOME:-$HOME/.codex}
        if ! create_directory "$codex_directory"; then
            skip_link "$codex_directory/AGENTS.md" "$codex_directory"
            return
        fi
        resolved_codex_directory=$(CDPATH='' cd -P -- "$codex_directory" && pwd)
        if [ "$resolved_codex_directory" = "$home_directory/.codex" ]; then
            codex_target=../.agents/agents.md
        else
            codex_target=$home_directory/.agents/agents.md
        fi
        if [ "$agents_file_usable" -eq 1 ]; then
            ensure_link "$codex_directory/AGENTS.md" "$codex_target"
        else
            skip_link "$codex_directory/AGENTS.md" "$agents_directory/agents.md"
        fi
        [ ! -e "$codex_directory/AGENTS.override.md" ] && [ ! -L "$codex_directory/AGENTS.override.md" ] || \
            printf 'warning: %s exists; Codex will ignore AGENTS.md there\n' "$codex_directory/AGENTS.override.md"
    else
        if [ "$agents_file_usable" -eq 1 ]; then
            ensure_link "$project/AGENTS.md" .agents/agents.md
        else
            skip_link "$project/AGENTS.md" "$agents_directory/agents.md"
        fi
        [ ! -e "$project/AGENTS.override.md" ] && [ ! -L "$project/AGENTS.override.md" ] || \
            printf 'warning: %s exists; Codex will ignore AGENTS.md there\n' "$project/AGENTS.override.md"
    fi
}

case "$vendor" in
    claude) bridge_claude ;;
    codex) bridge_codex ;;
    all) bridge_claude; bridge_codex ;;
esac

if [ "$status" -eq 0 ]; then
    printf 'Done. %s\n' "$agents_directory"
fi
exit "$status"
