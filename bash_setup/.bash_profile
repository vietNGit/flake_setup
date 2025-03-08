#!/bin/sh

source ~/flake_setup/bash_setup/vars.sh
source ~/flake_setup/bash_setup/aliases.sh

eval "$(direnv hook bash)"
eval "$(oh-my-posh init bash --config ~/flake_setup/omp/personal.omp.yaml)"

# PS1='${_RESET}${_BOLD}${_CYAN}\D{%d-%m-%y} ${_RED} \u@\H:\w ${_RESET}\n${_BOLD}${_GREEN}\$${_RESET} '

modified_files() {
  git status --porcelain | sed s/^...//
}

get_modified_shell_scripts() {
  modified_files | grep -e bash -e sh
}

get_modified_flakes() {
  modified_files | grep .nix
}

get_modified_lock() {
  modified_files | grep .lock
}

bash_modified_prtcl() {
  printf "\n"
    printf "=================================================================\n"
    printf "Checking if shell scripts modified \n"
    printf "=================================================================\n"
    printf "\n"
  if [[ `get_modified_shell_scripts` ]]
  then
    printf "\n"
    printf "=================================================================\n"
    printf "Shell script updated, perform git commit \n"
    printf "=================================================================\n"
    printf "\n"

    get_modified_shell_scripts | xargs git add
    git commit -a -m "Update shell script $DATE"
    git push origin HEAD
  fi
}

flake_modified_prtcl() {
  printf "\n"
  printf "=================================================================\n"
  printf "Checking if flakes and lock added or updated \n"
  printf "=================================================================\n"
  printf "\n"

  need_update = false

  if [[ `get_modified_flakes` ]]
  then
    printf "\n"
    printf "=================================================================\n"
    printf "Flakes updated \n"
    printf "=================================================================\n"
    printf "\n"

    get_modified_shell_scripts | xargs git add
    git commit -a -m "Flakes updated or modified $DATE"
    git push origin HEAD

    $need_update = true
  fi

  if [[ `get_modified_lock` ]]
  then
    printf "\n"
    printf "=================================================================\n"
    printf "Lock updated \n"
    printf "=================================================================\n"
    printf "\n"

    get_modified_lock | xargs git add
    git commit -a -m "Lock updated $DATE"
    git push origin HEAD

    $need_update = true
  fi

  if [[ `$need_update` ]]
  then
    printf "\n"
    printf "=================================================================\n"
    printf "Rebuild system \n"
    printf "=================================================================\n"
    printf "\n"

    flake_rebuild .
  fi
}

flake_system_update() {
  cd ~/flake_setup/flakes

  printf "This script require sudo priviledge \n"
  sudo echo "Sudo priviledge granted"

  flake_update

  bash_modified_prtcl
  flake_modified_prtcl
}
