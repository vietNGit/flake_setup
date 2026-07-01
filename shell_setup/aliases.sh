#!/bin/sh

# Bash aliases =================================================================
alias show_bash="cat ~/.bashrc"
alias re_source="source ~/.bashrc"

# ==============================================================================

# Nixos channels aliases =======================================================

alias mod_nix="sudo nano /etc/nixos/configuration.nix"
alias nix_reload="sudo nixos-rebuild switch"
alias nix_upgrade="sudo nixos-rebuild switch --upgrade"
alias nix_full_update="echo 'Update channel and upgrade packages' && sudo nix-channel --update && sudo nixos-rebuild switch --upgrade"

# ==============================================================================

# Nixos flakes aliases =========================================================

alias flake_update="nix flake update"
alias flake_rebuild="sudo nixos-rebuild switch --flake"

# ==============================================================================

# General aliases ==============================================================

alias ff="fastfetch"
alias ffa="fastfetch -c all"
alias dtb="distrobox"
command -v bat >/dev/null 2>&1 && alias cat=bat
alias reload_current_shell_session="exec $SHELL"
command -v nvim >/dev/null 2>&1 && alias vim=nvim
command -v nvim >/dev/null 2>&1 && alias vi=nvim

# ==============================================================================

# Nix Darwin specific aliases ==================================================

alias home_manager_switch="nix run home-manager switch --flake $FLAKE_INGRESS_PATH#macbookPro14"
alias darwin_flake_update="nix flake update --flake $FLAKE_INGRESS_PATH" # TODO: Rebuild this to use the flake path from the config file instead of hardcoding it
alias rebuild_darwin="sudo darwin-rebuild switch --flake $FLAKE_INGRESS_PATH#macbookPro14"

# ==============================================================================
