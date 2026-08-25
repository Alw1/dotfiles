{
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/portable.nix

    /*
      Surface Go 3 (Amber Lake-Y, Intel Wi-Fi 6 AX201).

      Deliberately NOT importing nixos-hardware's microsoft-surface modules:
      those build a patched linux-surface kernel from source, which is not in
      the binary cache and takes hours to compile. These two are kernel
      neutral and fully cached -- Intel microcode and GPU (i915 + VA-API),
      plus fstrim.

      The Go series is one of the few Surface models that does not use IPTS
      for touch, so the touchscreen is plain HID-over-I2C and should work on
      the stock kernel. If touch, pen or cameras turn out to be broken, add
      `inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel` here
      and accept the kernel build.
    */
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  # 64GB/128GB eMMC, so nothing heavy beyond what profiles/portable.nix gives.
  # Firefox, Hyprland and the CLI baseline are already on.

  # Required for the AX201 wifi and Bluetooth firmware (iwlwifi). The surface
  # module used to set this for us; on the stock kernel it must be explicit or
  # the machine comes up with no wifi.
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
