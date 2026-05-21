{ ... }: {

  imports =
    [ ./hardware-configuration.nix ../../modules ../../users/alex/user.nix ];

  networking.hostName = "zorua";

  GRUB.enable = true;
  hyprland.enable = true;
  ly.enable = true;
  gaming.enable = true; 

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  system.stateVersion = "23.11";
}
