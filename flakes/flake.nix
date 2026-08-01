{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      # inputs.brew-src.url = "github:Homebrew/brew";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      ...
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macbookPro14
      darwinConfigurations."macbookPro14" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self; };
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager

          ({ config, ... }: {
            nixpkgs = {
              config.allowUnfree = true;
              hostPlatform = "aarch64-darwin";
            };
          })

          ./schemas/user-schema.nix

          ./hosts/macbook/darwin-configuration.nix
          ./hosts/macbook/user.nix

          ./modules/common/fonts.nix

          ./modules/mac_specific/apps.nix
          ./modules/mac_specific/homebrew.nix
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
