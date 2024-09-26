{
	description = "Lenovo laptop setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs : {
		nixosConfigurations = {
			nixosLaptop = nixpkgs.lib.nixosSystem rec {
				system = "x86_64-linux";

				specialArgs = {
					pkgs = import nixpkgs {
						inherit system;

						config.allowUnfree = true;
					};
					pkgs-unstable = import nixpkgs-unstable {
						inherit system;

						config.allowUnfree = true;
					};
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
