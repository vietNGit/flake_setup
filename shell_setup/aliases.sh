#!/bin/sh

# Bash aliases =================================================================
alias show_bash="cat ~/.bashrc"
alias re_source="source ~/.bashrc" # Deprecated, use reload_current_shell_session instead

# ==============================================================================

# Nixos channels aliases =======================================================

alias mod_nix="sudo nano /etc/nixos/configuration.nix"
alias nix_reload="sudo nixos-rebuild switch"
alias nix_upgrade="sudo nixos-rebuild switch --upgrade"
alias nix_full_update="echo 'Update channel and upgrade packages' && sudo nix-channel --update && sudo nixos-rebuild switch --upgrade"

# ==============================================================================

# Nixos flakes aliases =========================================================

alias flake_update="nix flake update" # Deprecated, use update_flake_lock instead
# TODO: Add config name, see rebuild_darwin for example
alias rebuild_nixos="sudo nixos-rebuild switch --flake $FLAKE_PROJECT_ROOT/flakes"

# ==============================================================================

# General aliases ==============================================================

alias ff="fastfetch"
alias ffa="fastfetch -c all"
alias dtb="distrobox"
alias reload_current_shell_session="exec $SHELL"
alias update_flake_lock="nix flake update --flake $FLAKE_PROJECT_ROOT/flakes"

command -v bat >/dev/null 2>&1 && alias cat=bat
command -v nvim >/dev/null 2>&1 && alias vim=nvim
command -v nvim >/dev/null 2>&1 && alias vi=nvim

# ==============================================================================

# Nix Darwin specific aliases ==================================================

alias home_manager_switch="nix run home-manager switch --flake $FLAKE_PROJECT_ROOT/flakes#macbookPro14"
alias darwin_flake_update="nix flake update --flake $FLAKE_PROJECT_ROOT/flakes" # Deprecated, use update_flake_lock instead
alias rebuild_darwin="sudo darwin-rebuild switch --flake $FLAKE_PROJECT_ROOT/flakes#macbookPro14"

# ==============================================================================
