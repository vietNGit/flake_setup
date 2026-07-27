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

      fonts.packages = with pkgs; [
        nerd-fonts.meslo-lg
      ];

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

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macbookPro14
    darwinConfigurations."macbookPro14" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        configuration
        ./schemas/user-schema.nix
        ./hosts/macbook/darwin-configuration.nix
        ./hosts/macbook/user.nix
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
        ({ config, ... }: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.${config.custom.users.viet.username} = ./home.nix;
        })
      ];
    };
  };
}
