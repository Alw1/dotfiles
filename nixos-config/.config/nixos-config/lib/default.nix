{ inputs }:
{
  mkHost =
    {
      hostname,
      path,
      system ? "x86_64-linux",
      modules ? [ ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs hostname; };
      modules = [
        path
        ../modules
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        { networking.hostName = hostname; }
      ]
      ++ modules;
    };
}
