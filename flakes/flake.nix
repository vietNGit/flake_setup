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
		in {
			nixosConfigurations = {
				lenovoLaptop = lib.nixosSystem {
					system = "x86_64-linux";
					specialArgs = inputs;
					modules = [ ./hosts/laptop/configuration.nix ];
				};
			};
		};

}