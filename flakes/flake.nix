{

	description = "Lenovo laptop setup";

	inputs = {
		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixos-24.05";
		};
	};

	outputs = { self, nixpkgs, ... }@inputs :
		let
			lib = nixpkgs.lib;
			config = nixpkgs.config;
		in {
			nixosConfigurations = {
				nixosLaptop = lib.nixosSystem {
					system = "x86_64-linux";
					specialArgs = inputs;
					modules = [ ./hosts/laptop/configuration.nix ];

					config = {
						nix.gc = {
							automatic = true;
							dates = "weekly";
							options = "--delete-older-than +10";
						};
					};
				};
			};
		};

}