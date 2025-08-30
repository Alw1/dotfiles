{
  description = "Alex Wyatt's NixOS Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url =
      "github:NixOS/nixos-hardware/26ed7a0d4b8741fe1ef1ee6fa64453ca056ce113";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ... }:
    let
      system = "x86_64-linux";

      # Create overlay for unstable packages
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

        time.timeZone = "America/New_York";
        i18n.defaultLocale = "en_US.UTF-8";

        nix = {
          gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
          };

          settings.auto-optimise-store = true;
          settings.experimental-features = [ "nix-command" "flakes" ];
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
        porygon = mkHost ./hosts/porygon
          [ nixos-hardware.nixosModules.microsoft-surface-common ];

        # Surface Laptop 3
        rotom = mkHost ./hosts/rotom [ ];
      };
    };
}
