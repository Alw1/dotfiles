{ lib, config, ... }: {
  options.GRUB.enable = lib.mkEnableOption "Enable GRUB";
  config = lib.mkIf config.GRUB.enable {

	# silent boot
    boot.plymouth.enable = true;
    boot.consoleLogLevel = 0;
    boot.initrd.verbose = false;

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
