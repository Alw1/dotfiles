{ ... }: {

  imports =
    [ ./hardware-configuration.nix ../../modules ../../users/alex/user.nix ];

  networking.hostName = "zorua";

  hyprland.enable = true;
  tuigreet.enable = true;
  gaming.enable = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  xserver = { videoDrivers = [ "amdgpu" ]; };

  system.stateVersion = "23.11";
}
