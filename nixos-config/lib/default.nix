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
        { networking.hostName = hostname; }
      ]
      ++ modules;
    };
}
