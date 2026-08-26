# Codex — https://learn.chatgpt.com/docs/agent-configuration/agents-md
#
# Finds skills in .agents/skills directly, so only instructions need bridging.
# The two scopes take different shapes: globally Codex reads $CODEX_HOME/AGENTS.md
# (normally ~/.codex/AGENTS.md), while for a project it walks from the project
# root down to the working directory looking for AGENTS.md by filename — which
# puts the project link at the repo root rather than inside a vendor directory.
#
# That root AGENTS.md is the shared convention, not a Codex invention; other
# tools that read AGENTS.md get bridged by the same link. Adapters that declare
# it too are declaring the same link, so they agree by construction.
#
# Sourced by install.sh, which provides link/native/adopt.

adapter_codex() {
    # $1 = base directory, $2 = global|project
    native skills "$1/.agents/skills"
    case "$2" in
        global)  link "$1/.codex/AGENTS.md" "../.agents/agents.md" ;;
        project) link "$1/AGENTS.md" ".agents/agents.md" ;;
    esac
}
