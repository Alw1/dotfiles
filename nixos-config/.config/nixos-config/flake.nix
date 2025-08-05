{
  description = "Alex Wyatt's NixOS Setup";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
        
        # You could add other common system-wide config here
        # networking.networkmanager.enable = true;
        # time.timeZone = "America/New_York";
      };

      # Common home-manager configuration
      homeManagerModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.alex = import ./users/alex/home.nix;
        };
      };

      # Helper function to create a host configuration
      mkHost = hostPath: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          hostPath
          commonModule
          home-manager.nixosModules.home-manager
          homeManagerModule
        ] ++ extraModules;
      };
    in
    {
      nixosConfigurations = {
        zorua = mkHost ./hosts/zorua [];
        porygon = mkHost ./hosts/porygon [ nixos-hardware.nixosModules.surface-common ];
        rotom = mkHost ./hosts/rotom [];
      };
    };
}
