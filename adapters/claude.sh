# Claude Code — https://claude.com/claude-code
#
# Reads only from .claude/, so both skills and instructions need bridging, at
# both scopes. The layout is the same either way: .claude/ sits beside .agents/,
# so every link is one level up.
#
# Sourced by install.sh, which provides link/native/adopt.

adapter_claude() {
    # $1 = base directory, $2 = global|project
    link "$1/.claude/skills" "../.agents/skills"
    link "$1/.claude/CLAUDE.md" "../.agents/agents.md"
}
