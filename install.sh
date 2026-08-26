#!/bin/sh
# Install agent skills into a .agents/ directory, and bridge that directory to
# the locations vendor tools actually look in.
#
# Run from a clone of the repo:
#     ./install.sh [options] [skill ...]
#
# This installer is opinionated: it lays things out the way the .agents
# protocol (https://dotagentsprotocol.com/) describes, under DIR/.agents/, and
# points vendor-specific locations at that directory with symlinks. If you'd
# rather not adopt that layout, skip the installer entirely and copy skills
# wherever your tool reads them from:
#
#     cp -R skills/casebook ~/.claude/skills/

set -eu

usage() {
    cat <<'EOF'
Install agent skills into a .agents/ directory and bridge it to vendor tools.

Usage:
    install.sh [options] [skill ...]

Options:
    -d, --dir DIR       Set up DIR/.agents (default: ~)
    -v, --vendor NAME   Bridge a vendor tool to DIR/.agents (repeatable,
                        comma-separated, or "all")
        --no-skills     Skip skills; only set up .agents/ and any vendors
    -f, --force         Replace skills that are already installed
        --upgrade       Alias for --force
        --adopt         Move a real file or directory sitting where a vendor
                        link belongs into .agents/, then link it
        --check         Report what would happen; change nothing
    -l, --list          List the available skills and vendors, then exit
    -h, --help          Show this help and exit

With no skill names, every skill is installed. A skill that is already
installed is left alone unless --force is given, which removes the existing
skill directory and installs it fresh.

DIR sets the scope: when it is your home directory vendors are bridged
globally, otherwise DIR is treated as a project.
EOF
}

fail() { printf 'error: %s\n' "$1" >&2; exit 1; }

# --- parse arguments --------------------------------------------------------

DIR=""
VENDORS=""
SKILLS=""
WANT_SKILLS=1
FORCE=0
ADOPT=0
CHECK=0
LIST_ONLY=0

while [ $# -gt 0 ]; do
    case "$1" in
        -d|--dir)             DIR="${2:-}"; [ -n "$DIR" ] || fail "--dir needs a value"; shift 2 ;;
        -v|--vendor)          [ -n "${2:-}" ] || fail "--vendor needs a value"
                              VENDORS="$VENDORS $(printf '%s' "$2" | tr ',' ' ')"; shift 2 ;;
        --no-skills)          WANT_SKILLS=0; shift ;;
        -f|--force|--upgrade) FORCE=1; shift ;;
        --adopt)              ADOPT=1; shift ;;
        --check)              CHECK=1; shift ;;
        -l|--list)            LIST_ONLY=1; shift ;;
        -h|--help)            usage; exit 0 ;;
        --)                   shift; while [ $# -gt 0 ]; do SKILLS="$SKILLS $1"; shift; done ;;
        -*)                   fail "unknown option: $1" ;;
        *)                    SKILLS="$SKILLS $1"; shift ;;
    esac
done

# --- locate this checkout ---------------------------------------------------

here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRC="$here/skills"
ADAPTERS="$here/adapters"

[ -d "$SRC" ] || fail "no skills/ directory next to install.sh (run from a clone of the repo)"

available=$(find "$SRC" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort)
[ -n "$available" ] || fail "no skills found in $SRC"

# Every adapters/<name>.sh declares an adapter_<name> function; sourcing them
# all makes those functions available to dispatch by name.
vendors_available=""
if [ -d "$ADAPTERS" ]; then
    vendors_available=$(find "$ADAPTERS" -maxdepth 1 -name '*.sh' -exec basename {} .sh \; | sort)
    for adapter in $vendors_available; do
        . "$ADAPTERS/$adapter.sh"
    done
fi

if [ "$LIST_ONLY" -eq 1 ]; then
    printf 'Available skills:\n'
    printf '  %s\n' $available
    printf 'Available vendors:\n'
    if [ -n "$vendors_available" ]; then printf '  %s\n' $vendors_available; else printf '  (none)\n'; fi
    exit 0
fi

# --- resolve the destination and the selections -----------------------------

[ -n "$DIR" ] || DIR="$HOME"
[ -d "$DIR" ] || fail "not a directory: $DIR"
BASE=$(CDPATH= cd -- "$DIR" && pwd)
HOME_ABS=$(CDPATH= cd -- "$HOME" && pwd)

if [ "$BASE" = "$HOME_ABS" ]; then SCOPE=global; else SCOPE=project; fi

AGENTS_DIR="$BASE/.agents"
SKILLS_DIR="$AGENTS_DIR/skills"
STUB='# AGENTS.md'

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
selected_skills=$*

for name in $VENDORS; do
    [ "$name" = all ] && continue
    found=0
    for candidate in $vendors_available; do
        [ "$candidate" = "$name" ] && found=1 && break
    done
    [ "$found" -eq 1 ] || fail "unknown vendor: $name (try --list)"
done
for name in $VENDORS; do
    if [ "$name" = all ]; then VENDORS="$vendors_available"; break; fi
done

# --- reporting --------------------------------------------------------------

CONFLICTS=0

report() { printf '  %-12s %s\n' "$1" "$2"; }

conflict() {
    report CONFLICT "$1"
    CONFLICTS=$((CONFLICTS + 1))
}

# --- helpers available to adapters ------------------------------------------

# normalize PATH — collapse "dir/../" so paths built from a link and its
# relative target read cleanly in reports.
normalize() {
    printf '%s' "$1" | sed -e 's|/\./|/|g' -e ':a' -e 's|/[^/][^/]*/\.\./|/|' -e ta
}

# is_clear PATH — true when nothing worth keeping lives at PATH: it is absent,
# an empty directory, an empty file, or the instructions stub we write.
is_clear() {
    [ -e "$1" ] || return 0
    if [ -d "$1" ]; then
        [ -z "$(ls -A "$1" 2>/dev/null)" ] && return 0
        return 1
    fi
    [ -s "$1" ] || return 0
    [ "$(cat "$1")" = "$STUB" ] && return 0
    return 1
}

# adopt EXISTING DEST — move real content out of a vendor location and into
# .agents/ so a symlink can take its place. Aborts loudly when real content
# lives on both sides; merging is a decision for a human, not this script.
adopt() {
    adopt_src=$1
    adopt_dst=$2
    if ! is_clear "$adopt_dst"; then
        fail "refusing to adopt $adopt_src: $adopt_dst already has content — merge the two by hand, then re-run"
    fi
    if [ "$CHECK" -eq 1 ]; then
        report "would adopt" "$adopt_src -> $adopt_dst"
        return 0
    fi
    mkdir -p "$(dirname "$adopt_dst")"
    if [ -d "$adopt_dst" ]; then
        rmdir "$adopt_dst"          # is_clear guarantees it is empty
    elif [ -e "$adopt_dst" ]; then
        rm -f "$adopt_dst"
    fi
    mv "$adopt_src" "$adopt_dst"
    report adopted "$adopt_src -> $adopt_dst"
}

# link LINK TARGET — point LINK at TARGET, where TARGET is relative to the
# directory holding LINK. Anything already there is left alone and reported,
# so re-running is safe and never silent.
link() {
    link_path=$1
    link_target=$2
    link_dir=$(dirname "$link_path")

    if [ -L "$link_path" ]; then
        link_current=$(readlink "$link_path")
        if [ "$link_current" = "$link_target" ]; then
            report up-to-date "$link_path -> $link_target"
        else
            conflict "$link_path is a symlink to $link_current, not $link_target"
        fi
        return 0
    fi

    if [ -e "$link_path" ]; then
        if [ "$ADOPT" -eq 1 ]; then
            adopt "$link_path" "$(normalize "$link_dir/$link_target")"
        else
            if [ -d "$link_path" ]; then link_kind=directory; else link_kind=file; fi
            conflict "$link_path is a real $link_kind; re-run with --adopt to move it into .agents/"
            return 0
        fi
    fi

    if [ "$CHECK" -eq 1 ]; then
        report "would link" "$link_path -> $link_target"
        return 0
    fi
    mkdir -p "$link_dir"
    ln -s "$link_target" "$link_path"
    report linked "$link_path -> $link_target"
}

# native LABEL PATH — nothing to bridge; the vendor reads PATH directly. Only
# reports, so --check shows a complete picture instead of going quiet.
native() { report native "$2 ($1, read directly)"; }

# --- set up .agents/ --------------------------------------------------------

printf '%s (%s):\n' "$AGENTS_DIR" "$SCOPE"
if [ "$CHECK" -eq 1 ]; then
    [ -d "$SKILLS_DIR" ] || report "would create" "$SKILLS_DIR/"
    [ -e "$AGENTS_DIR/agents.md" ] || report "would create" "$AGENTS_DIR/agents.md"
else
    [ -d "$SKILLS_DIR" ] || report created "$SKILLS_DIR/"
    mkdir -p "$SKILLS_DIR"
    if [ ! -e "$AGENTS_DIR/agents.md" ]; then
        printf '%s\n' "$STUB" > "$AGENTS_DIR/agents.md"
        report created "$AGENTS_DIR/agents.md"
    fi
fi

# --- bridge vendors ---------------------------------------------------------

# Before installing skills, so that --adopt sees an empty .agents/skills and can
# move an existing vendor skills directory into it. Installing first would leave
# real content on both sides, which adopt refuses to merge.
for name in $VENDORS; do
    printf 'vendor %s:\n' "$name"
    "adapter_$name" "$BASE" "$SCOPE"
done

# --- install skills ---------------------------------------------------------

if [ "$WANT_SKILLS" -eq 1 ]; then
    printf 'skills:\n'
    for name in $selected_skills; do
        target="$SKILLS_DIR/$name"
        if [ -e "$target" ] && [ "$FORCE" -eq 0 ]; then
            report skipped "$name (already installed; --upgrade to replace)"
            continue
        fi
        if [ "$CHECK" -eq 1 ]; then
            report "would install" "$name"
            continue
        fi
        staging="$SKILLS_DIR/.$name.tmp.$$"
        rm -rf "$staging"
        cp -R "$SRC/$name" "$staging"
        rm -rf "$target"          # remove the old skill wholesale, so nothing stale survives
        mv "$staging" "$target"
        report installed "$name"
    done
fi

# --- summary ----------------------------------------------------------------

if [ "$CONFLICTS" -gt 0 ]; then
    printf '\n%s conflict(s): existing files were left untouched.\n' "$CONFLICTS" >&2
    exit 1
fi
if [ "$CHECK" -eq 1 ]; then
    printf '\nNothing changed (--check).\n'
else
    printf '\nDone. %s\n' "$AGENTS_DIR"
fi
