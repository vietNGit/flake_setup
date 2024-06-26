#!/bin/sh

alias re_source="source ~/.bashrc"
alias mod_nix="sudo nano /etc/nixos/configuration.nix"
alias nix_reload="sudo nixos-rebuild switch"
alias nix_upgrade="sudo nixos-rebuild switch --upgrade"
alias nix_full_update="echo 'Update channel and upgrade packages' && sudo nix-channel --update && sudo nixos-rebuild switch --upgrade"
alias show_bash="cat ~/.bashrc"
