focus_print() {
  COLOR=""

  case "$1" in
    --error|-e)
      COLOR="${_BOLD}${_RED}"
      shift
      ;;
    --warning|-w)
      COLOR="${_BOLD}${_YELLOW}"
      shift
      ;;
    --success|-s)
      COLOR="${_BOLD}${_GREEN}"
      shift
      ;;
    --info|-i)
      COLOR="${_BOLD}${_BLUE}"
      shift
      ;;
    --neutral|-n)
      COLOR=""
      shift
      ;;
    -*)
      echo "FATAL: Unrecognized option: $1"
      return 1
      ;;
    *)
      COLOR=""
      ;;
  esac

  # Remaining text becomes the message
  MESSAGE="$*"

  printf "\n"
  if [ -n "$COLOR" ]; then
    printf "%s=================================================================\n" "$COLOR"
    printf "%s\n" "$MESSAGE"
    printf "=================================================================%s\n" "$_RESET"
  else
    printf "=================================================================\n"
    printf "%s\n" "$MESSAGE"
    printf "=================================================================\n"
  fi
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
  focus_print "Checking if shell scripts modified"

  if [[ `get_modified_shell_scripts` ]]
  then
    focus_print -i "Shell script updated, perform git commit"

    get_modified_shell_scripts | xargs git add
    commit_push "Update shell script $DATE"
  fi
}

rebuild_flake_system_prctl() {
  case "$(uname -s)" in
    Linux)
      case "$1" in
        --check)
          focus_print -i "Checking NixOS system"
          rebuild_nixos_check
          ;;
        -c)
          focus_print -i "Checking NixOS system"
          rebuild_nixos_check
          ;;
        *)
          focus_print -i "Rebuild NixOS system"
          rebuild_nixos
          ;;
      esac
      ;;
    Darwin)
      case "$1" in
        --check)
          focus_print -i "Checking Darwin system"
          rebuild_darwin_check
          ;;
        -c)
          focus_print -i "Checking Darwin system"
          rebuild_darwin_check
          ;;
        *)
          focus_print -i "Rebuild Darwin system"
          rebuild_darwin
          ;;
      esac
      ;;
    *)
      focus_print -e "FATAL: Unrecognized system: $(uname -s)"
      return 1
      ;;
  esac
}

flake_modified_prtcl() {
  focus_print "Checking if flakes and lock added or updated"

  need_update=false

  if [[ `get_modified_flakes` ]]
  then
    focus_print -i "Flakes updated"

    get_modified_flakes | xargs git add

    if ! rebuild_flake_system_prctl --check; then
      focus_print -e "Rebuild system check failed, aborting"
      return 1
    fi
    focus_print -s "Check passed, commit and push changes"

    commit_push "Flakes updated or modified $DATE"

    need_update=true
  fi

  update_flake_lock
  if [[ `get_modified_lock` ]]
  then
    focus_print -i "Lock updated"

    get_modified_lock | xargs git add

    if ! rebuild_flake_system_prctl --check; then
      focus_print -e "Rebuild system check failed, aborting"
      return 1
    fi

    focus_print -s "Check passed, commit and push changes"

    commit_push "Lock updated $DATE"

    need_update=true
  fi

  if [[ "$need_update" = true ]]
  then
    rebuild_flake_system_prctl

    focus_print -s "System rebuilt successfully"
  else
    focus_print -s "No rebuild needed"
  fi
}

flake_system_update() {
  # CURRENT_DIR=$(pwd)
  focus_print "Moving to flake project root: $FLAKE_PROJECT_ROOT"
  cd $FLAKE_PROJECT_ROOT

  focus_print -w "This script require sudo priviledge"
  sudo -v || { focus_print -e "Failed to obtain sudo privileges"; return 1; }

  focus_print -s "Sudo privileges granted"

  shell_scripts_modified_prtcl
  flake_modified_prtcl

  # System specific update, although flatpak can be a module within nixos it self, might be removed in the future
  command -v flatpak >/dev/null 2>&1 && flatpak update -y

  # cd $CURRENT_DIR
}

alias fsu="flake_system_update"
