{
  description = "Alex Wyatt's NixOS Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;

      myLib = import ./lib { inherit inputs; };

      hosts = lib.attrNames (
        lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts)
      );
    in
    {
      nixosConfigurations = lib.genAttrs hosts (
        hostname:
        myLib.mkHost {
          inherit hostname;
          path = ./hosts + "/${hostname}";
        }
      );

      nixosModules.default = ./modules;
    };
}
