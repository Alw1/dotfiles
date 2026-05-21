{
  description = "Alex Wyatt's NixOS Setup";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      sops-nix,
      ...
    }:
    let
      homeManagerModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.alex = import ./users/alex/home.nix;
        };
      };

      mkOverlays = system: [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];

      mkCommonModule =
        system:
        { config, pkgs, ... }:
        {
          nixpkgs = {
            overlays = mkOverlays system;
            config.allowUnfree = true;
          };
        };

      mkHost =
        system: hostPath: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            hostPath
            (mkCommonModule system)
            home-manager.nixosModules.home-manager
            homeManagerModule
            sops-nix.nixosModules.sops
          ]
          ++ extraModules;
        };

    in
    {
      nixosConfigurations = {
        # PC
        zorua = mkHost "x86_64-linux" ./hosts/zorua [ ];

        # Surface Laptop 6
        rotom = mkHost "x86_64-linux" ./hosts/rotom [ ];

        # Home server (mini PC)
        minikyu = mkHost "x86_64-linux" ./hosts/minikyu [ ];
      };
    };
}
