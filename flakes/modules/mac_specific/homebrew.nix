{ config, lib, ... }:

{
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;
    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = config.custom.users.viet.username;

    # Automatically migrate existing Homebrew installations
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    enableZshIntegration = true;

    # masApps = {
    #   Bitwarden = 1352778147;
    # };
    brews = [
      "mas"
    ];
    casks = [
      "google-chrome"
      "firefox"
      "zen"

      # "bitwarden"
      "discord"
      "notion"
      "steam"
      "raycast"
      "duplicati"

      "ghostty"
      "kate"
      "visual-studio-code"
      "orbstack"

      "wpsoffice"

      "betterdisplay"
      "alt-tab"
      "logi-options+"
      "rectangle"
      "middleclick"
      "macs-fan-control"
      "stats"

      "proton-mail"
      "protonvpn"
      "proton-pass"

      "cloudflare-warp"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };


  system.activationScripts.homebrew.text = lib.mkAfter ''
    if [ -x "${config.homebrew.prefix}/bin/brew" ]; then
      brew="${config.homebrew.prefix}/bin/brew"

      echo ""
      echo "Running custom post-activation Homebrew cleanup..."
      sudo --user=${config.homebrew.user} --set-home "$brew" cleanup --prune=all
      sudo --user=${config.homebrew.user} --set-home "$brew" autoremove
      echo ""
    fi
  '';
}
