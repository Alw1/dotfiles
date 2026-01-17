{ lib, config, ... }: {
  options.GRUB.enable = lib.mkEnableOption "Enable GRUB";
  config = lib.mkIf config.GRUB.enable {

    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/";
      };
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };
    };
  };
}
