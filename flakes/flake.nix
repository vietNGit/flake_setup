{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/dea0d9eeca494734e596f3f4a813324d6af41265";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
