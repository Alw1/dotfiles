{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/workstation.nix
  ];

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  system.stateVersion = "23.11";
}
