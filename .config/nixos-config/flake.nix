{
  description = "Alex Wyatt's NixOS Setup";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
