{
  config,
  lib,
  modulesPath,
  ...
}:
###############################################################################
# PLACEHOLDER -- this file does NOT describe your actual disks yet.
#
# Replace it wholesale on the Surface Go 3 itself, once booted from the
# installer:
#
#   nixos-generate-config --no-filesystems --root /mnt
#   cp /mnt/etc/nixos/hardware-configuration.nix \
#      ~/.config/nixos-config/hosts/togepi/hardware-configuration.nix
#
# The UUIDs below are deliberately invalid so an accidental `nixos-rebuild`
# fails loudly rather than mounting the wrong disk.
###############################################################################
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # 64GB models are eMMC (mmcblk*), 128GB/256GB models are NVMe.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "sdhci_pci"
    "mmc_block"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/REPLACE-ME-ROOT-UUID";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/REPLACE-ME-BOOT-UUID";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
