{
  description = "Alex Wyatt's NixOS Setup";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

	# nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      system = "x86_64-linux";

      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

    in
    {
      nixosConfigurations = {
       zorua = nixpkgs.lib.nixosSystem {
          inherit system;
		modules = [
            ./hosts/zorua
            { nixpkgs.config.allowUnfree = true; }
            { _module.args.unstablePkgs = unstablePkgs; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./users/alex/home.nix;
            }
          ];
        };

        rotom = nixpkgs.lib.nixosSystem {
          inherit system;
		modules = [
            ./hosts/rotom
            { nixpkgs.config.allowUnfree = true; }
            { _module.args.unstablePkgs = unstablePkgs; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./users/alex/home.nix;
            }
          ];
        };
      };
    };
}
