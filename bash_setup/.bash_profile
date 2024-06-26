#!/bin/sh

source ~/flake_setup/bash_setup/vars.sh
source ~/flake_setup/bash_setup/aliases.sh

eval "$(direnv hook bash)"

PS1='$_BOLD${_CYAN}\D{%d-%m-%y} ${_RED} \u@\H:\w $_RESET\n$_BOLD$_GREEN\$ '
# PS1='\[\e[1m\][\D{%d-%m-%Y}][\u@\H:\w]$(show_virtual_env)$(get_current_branch)\n\$\[\e[0m\] '
# PS1='$(show_virtual_env)'$PS1

# New line after every command ran, except first prompt
# PROMPT_COMMAND="export PROMPT_COMMAND=echo"
# alias clear="unset PROMPT_COMMAND; clear; PROMPT_COMMAND='export PROMPT_COMMAND=echo'"