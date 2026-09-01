{ ... }:
{
  imports = [
    ./git.nix
    ./obs.nix
    ./theme.nix
  ];

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
