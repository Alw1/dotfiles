{ inputs, ... }:
{
  imports = [ ./system.nix ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = { inherit inputs; };
    users.alex = import ./home;
  };
}
