{
	description = "Hiru's system configuration";
	inputs = {
		master.url = "github:nixos/nixpkgs/master";
		stable.url = "github:nixos/nixpkgs/nixos-26.05";
		unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};
	outputs = { self, nixpkgs, ... } @inputs:
		let
			inherit (self) outputs;
			forSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
			};
		in
		{
			nixosConfigurations = {
				# TODO home manager
				optimus = nixpkgs.lib.nixosSystem
					{
						specialArgs = {
							inherit inputs outputs;
						};
						modules = [
							"./hosts/optimus/configuration.nix"
						];
					};

				# TODO setup metroplex
				#metroplex = nixpkgs.lib.nixosSystem
				#	{
				#	};
			};
		};
}
