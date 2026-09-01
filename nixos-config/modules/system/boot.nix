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
      };
    };
  };
}
