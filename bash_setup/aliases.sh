#!/bin/sh

alias show_bash="cat ~/.bashrc"
alias re_source="source ~/.bashrc"

# Nixos channels aliases
alias mod_nix="sudo nano /etc/nixos/configuration.nix"
alias nix_reload="sudo nixos-rebuild switch"
alias nix_upgrade="sudo nixos-rebuild switch --upgrade"
alias nix_full_update="echo 'Update channel and upgrade packages' && sudo nix-channel --update && sudo nixos-rebuild switch --upgrade"

# Nixos flakes aliases
alias flake_update="sudo nix flake update"
alias flake_rebuild="sudo nixos-rebuild switch --flake"

# General aliases
alias ff="fastfetch"
alias ffa="fastfetch -c all"
