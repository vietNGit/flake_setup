#!/bin/sh

source ~/flake_setup/bash_setup/vars.sh
source ~/flake_setup/bash_setup/aliases.sh

eval "$(direnv hook bash)"
eval "$(oh-my-posh init bash --config ~/flake_setup/omp/personal.omp.yaml)"

# PS1='${_RESET}${_BOLD}${_CYAN}\D{%d-%m-%y} ${_RED} \u@\H:\w ${_RESET}\n${_BOLD}${_GREEN}\$${_RESET} '

focus_print() {
  printf "\n"
  printf "=================================================================\n"
  printf "$1"
  printf "=================================================================\n"
  printf "\n"
}

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
  focus_print "Checking if shell scripts modified \n"

  if [[ `get_modified_shell_scripts` ]]
  then
    focus_print "Shell script updated, perform git commit \n"

    get_modified_shell_scripts | xargs git add
    git commit -a -m "Update shell script $DATE"
    git push origin HEAD
  fi
}

flake_modified_prtcl() {
  focus_print "Checking if flakes and lock added or updated \n"

  need_update = false

  if [[ `get_modified_flakes` ]]
  then
    focus_print "Flakes updated \n"

    get_modified_shell_scripts | xargs git add
    git commit -a -m "Flakes updated or modified $DATE"
    git push origin HEAD

    $need_update = true
  fi

  if [[ `get_modified_lock` ]]
  then
    focus_print "Lock updated \n"

    get_modified_lock | xargs git add
    git commit -a -m "Lock updated $DATE"
    git push origin HEAD

    $need_update = true
  fi

  if [ $need_update ]
  then
    focus_print "Rebuild system \n"

    flake_rebuild .
  else
    focus_print "No changes \n"
  fi
}

flake_system_update() {
  cd ~/flake_setup/flakes

  focus_print "This script require sudo priviledge \n"
  sudo `focus_print "Sudo priviledge granted"`

  flake_update

  bash_modified_prtcl
  flake_modified_prtcl
}
