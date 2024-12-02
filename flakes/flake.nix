{
	description = "Lenovo laptop setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
		ibus.url = "github:NixOS/nixpkgs/nixos-24.05";
	};

	outputs = { self, nixpkgs, nixpkgs-stable, ibus, ... }@inputs :
	let
		systemSettings = {
			system = "x86_64-linux";
		};
		lib = nixpkgs.lib;

		pkgs = import inputs.nixpkgs {
			system = systemSettings.system;
			config = {
				allowUnfree = true;
				allowUnfreePredicate = (_: true);
			};
		};

		pkgs-stable = import inputs.nixpkgs-stable {
			system = systemSettings.system;
			config = {
				allowUnfree = true;
				allowUnfreePredicate = (_: true);
			};
		};

		ibus-pkgs = import inputs.ibus {
			system = systemSettings.system;
			config = {
				allowUnfree = true;
				allowUnfreePredicate = (_: true);
			};
		};
	in {
		nixosConfigurations = {
			nixosLaptop = nixpkgs.lib.nixosSystem rec {
				system = systemSettings.system;

				specialArgs = {
					# pass config variables from above
					inherit pkgs;
					inherit pkgs-stable;
					inherit ibus-pkgs;

					inherit systemSettings;
					inherit inputs;
				};


				modules = [
					./hosts/laptop/configuration.nix
					./modules/virt-machine.nix
					./modules/apps.nix
					./modules/gaming.nix
				];
			};
		};
	};
}
