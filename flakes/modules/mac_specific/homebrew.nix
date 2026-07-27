{config, ... }:

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
}
