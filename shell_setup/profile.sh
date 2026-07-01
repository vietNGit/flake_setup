#!/bin/sh

# Only exception for global declarable vars
export FLAKE_PROJECT_ROOT="$HOME/GitProjs/GitHub/vietNGit/flake_setup";

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

[[ -f "$SCRIPT_DIR/vars.sh" ]] && source "$SCRIPT_DIR/vars.sh"
[[ -f "$SCRIPT_DIR/aliases.sh" ]] && source "$SCRIPT_DIR/aliases.sh"
