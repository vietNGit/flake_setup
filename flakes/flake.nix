{

	description = "Lenovo laptop setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs :
		let
			system = "x86_64-linux";
			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${system};
			pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
		in {
			nixosConfigurations = {
				nixosLaptop = lib.nixosSystem {
					inherit system;
					specialArgs = {
						inherit inputs;
						inherit pkgs-unstable;
					};
					modules = [
						./hosts/laptop/configuration.nix
						./modules/unstable-pkgs.nix
					];
				};
			};
		};

}