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
  modified_files | grep -e \.bash -e \.sh
}

get_modified_flakes() {
  modified_files | grep \.nix
}

get_modified_lock() {
  modified_files | grep \.lock
}

shell_scripts_modified_prtcl() {
  focus_print "Checking if shell scripts modified \n"

  if [[ `get_modified_shell_scripts` ]]
  then
    focus_print "Shell script updated, perform git commit \n"

    get_modified_shell_scripts | xargs git add
    commit_push "Update shell script $DATE"
  fi
}

rebuild_flake_system_prctl() {
  focus_print "Rebuild system \n"

  # TODO: add a check to see if current system is darwin or nixos and run the appropriate commands
  rebuild_darwin
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
    rebuild_flake_system_prctl
  else
    focus_print "No rebuild needed \n"
  fi
}

flake_system_update() {
  cd $FLAKE_PROJECT_ROOT

  focus_print "This script require sudo priviledge \n"
  sudo echo "Sudo priviledge granted"

  # Perform flake pkgs update
  # TODO: add a check to see if current system is darwin or nixos and run the appropriate commands
  darwin_flake_update

  shell_scripts_modified_prtcl
  flake_modified_prtcl

  command -v flatpak >/dev/null 2>&1 && flatpak update -y
}