{ ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/services/tailscale.nix
    ../../users/alex/user.nix
  ];

  networking.hostName = "minikyu";

  server-settings.enable = true;

  system.stateVersion = "25.11";
}
