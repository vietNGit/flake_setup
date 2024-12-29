#!/bin/sh

source ~/flake_setup/bash_setup/vars.sh
source ~/flake_setup/bash_setup/aliases.sh

eval "$(direnv hook bash)"
export DATE=$(date)

PS1='${_RESET}${_BOLD}${_CYAN}\D{%d-%m-%y} ${_RED} \u@\H:\w ${_RESET}\n${_BOLD}${_GREEN}\$${_RESET} '

flake_system_update() {
  cd ~/flake_setup/flakes
  flake_update
  if [[ `git status --porcelain | grep lock` ]]
  then
    printf "\n"
    printf "=================================================================\n"
    printf "Lock updated, perform git commit and flake system rebuild \n"
    printf "=================================================================\n"
    printf "\n"
    git add .
    git commit -a -m "Update lock $DATE"
    git push origin HEAD
    flake_rebuild .
  elif [[ `git status --porcelain | grep -e bash -e sh` ]]
  then
    printf "\n"
    printf "=================================================================\n"
    printf "Shell script updated, perform git commit \n"
    printf "=================================================================\n"
    printf "\n"
    git add .
    git commit -a -m "Update shell script"
    git push origin HEAD
  else
    printf "\n"
    printf "=================================================================\n"
    printf "No changes \n"
    printf "=================================================================\n"
    printf "\n"
  fi
}
