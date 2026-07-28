{ pkgs, ... }:

{
  imports = [
    ../common/apps.nix
  ];

  system.activationScripts.applications.text = ''
    echo ""
    echo "skipping application linking..."
    echo ""
  '';

  environment.systemPackages = with pkgs; [
    alt-tab-macos
    middleclick
  ];

  environment.interactiveShellInit = ''
    SOURCE_FILE_PATH="$HOME/GitProjs/GitHub/vietNGit/flake_setup/shell_setup/profile.sh"

    [[ -f "$SOURCE_FILE_PATH" ]] && source "$SOURCE_FILE_PATH"
  '';
}
