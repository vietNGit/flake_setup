#!/bin/sh

IS_TEST_RUN=false

case "$1" in
  --test|-t)
    IS_TEST_RUN=true
    ;;
esac

echo "Running post macOS update script... \n"
echo "This script is intended to only be run after macOS updates wiping out Nix zsh symlinks leading to custom shell setup not being loaded properly. \n"
echo "Also, only applicable to nix darwin systems. \n"
echo "Check if darwin-rebuild is installed..."
if ! command -v darwin-rebuild >/dev/null 2>&1; then
    echo "Not darwin system, script is not applicable."
    exit 1
fi

echo "Darwin-rebuild found, checking if needed to rebuild system..."
if [ -n "${FLAKE_PROJECT_ROOT}" ]; then
    echo "FLAKE_PROJECT_ROOT is set, system already loaded. No rebuild needed."

    if [ "$IS_TEST_RUN" = false ]; then
        exit 0
    else
        echo "Test run mode enabled, proceeding to rebuild system for testing purposes..."
    fi
fi

echo "FLAKE_PROJECT_ROOT is not set, checking if profile.sh exists..."
if [ ! -f "./profile.sh" ]; then
    echo "profile.sh not found in current directory. Please ensure you are in the correct directory and that profile.sh exists."
    exit 1
fi

echo "profile.sh found, sourcing ..."
source ./profile.sh

echo "Running darwin-rebuild switch command:"
alias rebuild_darwin
echo ""
read -p "Proceed? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Proceeding..."
else
    echo "Rebuild aborted."
    exit 1
fi

rebuild_darwin

exit 0
