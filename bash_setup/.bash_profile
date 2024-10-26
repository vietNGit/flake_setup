#!/bin/sh

source ~/flake_setup/bash_setup/vars.sh
source ~/flake_setup/bash_setup/aliases.sh

eval "$(direnv hook bash)"

PS1='${_RESET}${_BOLD}${_CYAN}\D{%d-%m-%y} ${_RED} \u@\H:\w ${_RESET}\n${_BOLD}${_GREEN}\$${_RESET} '

flake_system_update() {
  cd ~/flake_setup/flakes
  flake_update .
  if [[ `git status --porcelain` ]]; then
    echo "Changes confirmed, perform git commit and flake system rebuild"
    git add .
    git commit -a -m "Update lock"
    git push origin HEAD
    flake_rebuild .
  else
    echo "No changes"
  fi
}
