{

	description = "Lenovo laptop setup";

	inputs = {
		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixos-24.05";
		};
	};

	outputs = { self, nixpkgs, ... } :
		let
			lib = nixpkgs.lib;
		in {
			nixosConfigurations = {
				*hostname-here* = lib.nixosSystem {
					system = "x86_64-linux";
					modules = [ /etc/nixos/configuration.nix ];
				};
			};
		};

}