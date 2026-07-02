focus_print() {
  printf "\n"
  printf "==================================================================\n"
  printf "$1"
  printf "==================================================================\n"
  printf "\n"
}

commit_push() {
  git commit -S -m "$1"
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
  case "$(uname -s)" in
    Linux)
      focus_print "Rebuild NixOS system \n"
      rebuild_nixos
      ;;
    Darwin)
      focus_print "Rebuild Darwin system \n"
      rebuild_darwin
      ;;
    *)
      echo "FATAL: Unrecognized system: $(uname -s)"
      exit 1
      ;;
  esac
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
  update_flake_lock

  shell_scripts_modified_prtcl
  flake_modified_prtcl

  # System specific update, although flatpak can be a module within nixos it self, might be removed in the future
  command -v flatpak >/dev/null 2>&1 && flatpak update -y
}

alias fsu="flake_system_update"
