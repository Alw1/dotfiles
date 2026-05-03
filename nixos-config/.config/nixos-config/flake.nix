{
  description = "Alex Wyatt's NixOS Setup";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";

      # overlay for unstable packages
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];

      # Common configuration module
      commonModule = { config, pkgs, ... }: {
        nixpkgs = {
          inherit overlays;
          config.allowUnfree = true;
        };
      };

      homeManagerModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.alex = import ./users/alex/home.nix;
        };
      };

      mkHost = hostPath: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            hostPath
            commonModule
            home-manager.nixosModules.home-manager
            homeManagerModule
          ] ++ extraModules;
        };

    in {
      nixosConfigurations = {
        # PC
        zorua = mkHost ./hosts/zorua [ ];

        # Surface Laptop 6
        rotom = mkHost ./hosts/rotom [];

        # Home server (mini PC)
        minikyu = mkHost ./hosts/minikyu [];
      };
    };
}
