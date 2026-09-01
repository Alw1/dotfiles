{
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../users/alex

    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  my = {
    hardware = {
      laptop.enable = true;
      sdr.enable = true;
    };

    desktop = {
      enable = true;
      hyprland = {
        enable = true;
        monitors = [ ",preferred,auto,1.6" ];
      };
    };

    services = {
      ly.enable = true;
      tailscale.enable = true;
    };

    system.grub.enable = true;
  };

  # Required for the AX201 wifi and Bluetooth firmware (iwlwifi).
  hardware.enableRedistributableFirmware = true;

  # Tablet: let the accelerometer drive screen rotation.
  hardware.sensor.iio.enable = true;

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      disableWhileTyping = true;
    };
  };

  # The Type Cover is detachable, so a lid switch event should not suspend a
  # docked tablet mid-task; handle it as a normal screen blank instead.
  services.logind.settings.Login.HandleLidSwitchExternalPower = lib.mkDefault "ignore";

  system.stateVersion = "26.05";
}
