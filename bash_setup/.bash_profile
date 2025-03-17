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

commit_push() {
  git commit -m "$1"
  git push origin HEAD
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
    commit_push "Update shell script $DATE"
  fi
}


flake_modified_prtcl() {
  focus_print "Checking if flakes and lock added or updated \n"

  need_update=false

  if [[ `get_modified_flakes` ]]
  then
    focus_print "Flakes updated \n"

    get_modified_flakes | xargs git add
    commit_push "Flakes updated or modified $DATE"

    need_update=true
  fi

  if [[ `get_modified_lock` ]]
  then
    focus_print "Lock updated \n"

    get_modified_lock | xargs git add
    commit_push "Lock updated $DATE"

    need_update=true
  fi

  if [[ "$need_update" = true ]]
  then
    cd ~/flake_setup/flakes
    focus_print "Rebuild system \n"

    flake_rebuild .
  else
    focus_print "No rebuild needed \n"
  fi
}

flake_system_update() {
  cd ~/flake_setup/flakes

  focus_print "This script require sudo priviledge \n"
  sudo echo "Sudo priviledge granted"

  flake_update

  cd ~/flake_setup

  bash_modified_prtcl
  flake_modified_prtcl

  flatpak update -y
}
