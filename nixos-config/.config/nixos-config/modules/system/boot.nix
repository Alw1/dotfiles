{ config, lib, ... }:
let
  cfg = config.my.system.grub;
in
{
  options.my.system.grub.enable = lib.mkEnableOption "the GRUB bootloader";

  config = lib.mkIf cfg.enable {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/";
      };
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        devices = [ "nodev" ];
        # Keeps /boot and the store from accumulating old generations; the GC
        # in core/nix.nix can only collect what the boot menu no longer pins.
        configurationLimit = 10;
      };
    };
  };
}
