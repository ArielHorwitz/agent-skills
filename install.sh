#!/bin/sh
# Install agent skills from this repo into a .agents/skills directory.
#
# Run from a clone of the repo:
#     ./install.sh [options] [skill ...]
#
# With no skill names, every skill in the repo is installed. A skill that is
# already installed is left alone unless --force (--upgrade) is given, which
# removes the existing skill directory and installs it fresh.

set -eu

usage() {
    cat <<'EOF'
Install agent skills into a .agents/skills directory.

Usage:
    install.sh [options] [skill ...]

Options:
    -d, --dest DIR    Install into DIR (default: ~/.agents/skills)
    -f, --force       Replace skills that are already installed
        --upgrade     Alias for --force
    -l, --list        List the skills available in this repo and exit
    -h, --help        Show this help and exit

With no skill names, all skills are installed. Installing over an already
installed skill needs --force; the existing skill directory is removed first so
no stale files survive.
EOF
}

fail() { printf 'error: %s\n' "$1" >&2; exit 1; }

# --- parse arguments --------------------------------------------------------

DEST=""
LIST_ONLY=0
FORCE=0
SKILLS=""

while [ $# -gt 0 ]; do
    case "$1" in
        -d|--dest)          DEST="${2:-}"; [ -n "$DEST" ] || fail "--dest needs a value"; shift 2 ;;
        -f|--force|--upgrade) FORCE=1; shift ;;
        -l|--list)          LIST_ONLY=1; shift ;;
        -h|--help)          usage; exit 0 ;;
        --)                 shift; while [ $# -gt 0 ]; do SKILLS="$SKILLS $1"; shift; done ;;
        -*)                 fail "unknown option: $1" ;;
        *)                  SKILLS="$SKILLS $1"; shift ;;
    esac
done

# --- locate the skills in this checkout -------------------------------------

here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRC="$here/skills"
[ -d "$SRC" ] || fail "no skills/ directory next to install.sh (run from a clone of the repo)"

available=$(find "$SRC" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort)
[ -n "$available" ] || fail "no skills found in $SRC"

if [ "$LIST_ONLY" -eq 1 ]; then
    printf 'Available skills:\n'
    printf '  %s\n' $available
    exit 0
fi

# --- resolve destination and selection --------------------------------------

if [ -z "$DEST" ]; then
    DEST="$HOME/.agents/skills"
fi

# shellcheck disable=SC2086
set -- $SKILLS
if [ $# -eq 0 ]; then
    # shellcheck disable=SC2086
    set -- $available
fi

for name in "$@"; do
    found=0
    for candidate in $available; do
        [ "$candidate" = "$name" ] && found=1 && break
    done
    [ "$found" -eq 1 ] || fail "unknown skill: $name (try --list)"
done

# --- install ----------------------------------------------------------------

mkdir -p "$DEST"

# Refuse to touch already-installed skills unless --force was given.
if [ "$FORCE" -eq 0 ]; then
    existing=""
    for name in "$@"; do
        [ -e "$DEST/$name" ] && existing="$existing $name"
    done
    if [ -n "$existing" ]; then
        printf 'warning: already installed at %s:%s\n' "$DEST" "$existing" >&2
        fail "refusing to overwrite; re-run with --force (or --upgrade) to replace"
    fi
fi

for name in "$@"; do
    src="$SRC/$name"
    target="$DEST/$name"
    staging="$DEST/.$name.tmp.$$"
    rm -rf "$staging"
    cp -R "$src" "$staging"
    rm -rf "$target"          # remove the old skill wholesale, so nothing stale survives
    mv "$staging" "$target"
    printf 'installed %s -> %s\n' "$name" "$target"
done

printf 'Done. %s\n' "$DEST"
