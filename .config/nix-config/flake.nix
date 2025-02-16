{
	description = "My Nix Setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		#    home-manager = {
		# 	  url = "github:nix-community/home-manager/release-24.11";
		# 	  inputs.nixpkgs.follows = "nixpkgs";
		# };
	};
	outputs = { self, nixpkgs }: {
		nixosConfigurations.airfryer = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ ./hosts/airfryer ];
		};
	};
}
