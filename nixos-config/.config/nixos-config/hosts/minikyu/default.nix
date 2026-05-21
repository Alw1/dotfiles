{ ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../users/alex/user.nix
  ];

  networking.hostName = "minikyu";

  GRUB.enable = true;

  server-settings.enable = true;

  system.stateVersion = "25.11";
}
