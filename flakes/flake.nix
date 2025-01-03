{
	description = "Lenovo laptop setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		# nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		ibus.url = "github:NixOS/nixpkgs/nixos-24.05";
	};

	outputs = { self, nixpkgs, ibus, ... }@inputs :
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
			# overlays = [
      #   (final: prev: {
			# 		sambaFull = prev.sambaFull.override {
			# 			enableCephFS = false;
			# 		};
      #   })
      # ];
		};

		# pkgs-stable = import inputs.nixpkgs-stable {
		# 	system = systemSettings.system;
		# 	config = {
		# 		allowUnfree = true;
		# 		allowUnfreePredicate = (_: true);
		# 	};
		# };

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
					# inherit pkgs-stable;
					inherit ibus-pkgs;

					inherit systemSettings;
					inherit inputs;
				};


				modules = [
					./hosts/laptop/configuration.nix
					./modules/virt-machine.nix
					./modules/podman.nix
					./modules/apps.nix
					./modules/gaming.nix
				];
			};
		};
	};
}
