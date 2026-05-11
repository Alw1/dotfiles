{ pkgs, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../users/alex/user.nix
    ../common.nix
  ];

  networking.hostName = "rotom";

  laptop-settings.enable = true;
  GRUB.enable = true;
  ly.enable = true;
  hyprland.enable = true;
  gaming.enable = true;
  virtualization.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  boot.kernelParams = [
    /*
      These parameters fix issues with linux on
      		certain surface laptop modules:
      			- Battery draining after shutdown
      			- Suspend not working properly (unable to wake from suspend)
      			- Inconsistent wake from s2idle sleep mode

      Note: Surface Laptop 6 (Meteor Lake) has no S3 deep sleep; only s2idle is available.
    */

    # Restricts PCI I/O port window size to prevent battery drain after shutdown
    "pci=hpiosize=0"
    # Forces ACPI on even if firmware is flagged as problematic
    "acpi=force"
    # Uses ACPI reboot method to prevent hangs on reboot
    "reboot=acpi"
    # Skips saving/restoring buggy NVS memory regions during suspend
    "acpi_sleep=nonvs"
    # Exposes Windows 2020 ACPI paths to enable proper Surface device power management
    ''acpi_osi="Windows 2020"''
    # Disables USB autosuspend to prevent blocked or spurious wakes
    "usbcore.autosuspend=-1"
    # Explicitly force s2idle sleep state (Meteor Lake has no S3)
    "mem_sleep_default=s2idle"
    # Prevents EC from blocking/interfering with wake signals
    "acpi.ec_no_wakeup=1"
    # Disables deep display power states that can block resume
    "i915.enable_dc=0"
    # Disables panel self-refresh (known cause of resume issues)
    "i915.enable_psr=0"
  ];

  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    # Optional: preload models, see https://ollama.com/library
    loadModels = [
      "qwen3.6"
      "deepseek-v4-pro"
    ];
  };

  system.stateVersion = "24.11";
}
