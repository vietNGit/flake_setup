{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, ... }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      users.users.vietmacbook = {
        home = "/Users/vietmacbook";
      };

      fonts.packages = with pkgs; [
        nerd-fonts.meslo-lg
      ];

      # programs.zsh.enable = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
          direnv
          git
          htop
          fastfetch
          bat
          mkalias
          tree
          tmux
          zoxide
          btop

          fd
          ripgrep
          fzf
          lazygit
          neovim

          # duplicati
          obsidian
          brave
        ];

      environment.interactiveShellInit = ''
        SOURCE_FILE_PATH="$HOME/GitProjs/GitHub/vietNGit/flake_setup/shell_setup/profile.sh"

        [[ -f "$SOURCE_FILE_PATH" ]] && source "$SOURCE_FILE_PATH"
      '';

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
          "battle-net"
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

          "proton-mail-bridge"
          "proton-mail"
          "protonvpn"
          "proton-pass"

          "cloudflare-warp"
        ];
        onActivation= {
          cleanup = "zap";
          autoUpdate = true;
          upgrade = true;
        };
      };

      security.pam.services.sudo_local.touchIdAuth = true;
      system.primaryUser = "vietmacbook";

      system.activationScripts.applications.text = ''
        echo ""
        echo "skipping application linking..."
        echo ""
      '';

      system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;


      # system.activationScripts.applications.text = let
      #   env = pkgs.buildEnv {
      #     name = "system-applications";
      #     paths = config.environment.systemPackages;
      #     pathsToLink = ["/Applications"];
      #   };
      # in
      #   pkgs.lib.mkForce ''
      #     # Set up applications.
      #     echo "setting up /Applications..." >&2
      #     rm -rf /Applications/Nix\ Apps
      #     mkdir -p /Applications/Nix\ Apps
      #     find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      #     while read -r src; do
      #       app_name=$(basename "$src")
      #       echo "copying $src" >&2
      #       ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      #     done
      #   '';

      # system.applications.enable = true;

      nix.gc = {
        # 1. Enable automated garbage collection
        automatic = true;

        # 2. Schedule when it runs using launchd's calendar format
        interval = {
          Weekday = 0; # 0 is Sunday, 1 is Monday, etc.
          Hour = 3;
          Minute = 0;
        };

        # 3. Pass flags to the underlying nix-collect-garbage command
        options = "--delete-older-than 5d";
      };

      # Optional but highly recommended: auto-optimize the store
      # to hard-link duplicate files and save extra space.
      nix.settings.auto-optimise-store = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macbookPro14
    darwinConfigurations."macbookPro14" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "vietmacbook";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.vietmacbook = ./home.nix;
        }
      ];
    };
  };
}
