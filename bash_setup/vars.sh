#!/bin/sh

_BOLD=$(tput bold)
_BLACK=$(tput setaf 0)
_RED=$(tput setaf 1)
_GREEN=$(tput setaf 2)
_YELLOW=$(tput setaf 11)
_BLUE=$(tput setaf 4)
_MAGENTA=$(tput setaf 5)
_CYAN=$(tput setaf 6)
_WHITE=$(tput setaf 7)
_GREY=$(tput setaf 253)

_BG_BLACK=$(tput setab 0)
_BG_RED=$(tput setab 1)
_BG_GREEN=$(tput setab 2)
_BG_YELLOW=$(tput setab 3)
_BG_BLUE=$(tput setab 4)
_BG_MAGENTA=$(tput setab 5)
_BG_CYAN=$(tput setab 6)
_BG_WHITE=$(tput setab 7)

_RESET=$(tput sgr0)

_CHOSEN_BG=$(tput setab 241)

export config_file="/etc/nixos/configuration.nix";
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
