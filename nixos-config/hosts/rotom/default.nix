{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/laptop.nix
  ];

  my.hardware.sdr.enable = true;

  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   # openFirewall = true;
  # };

  boot.kernelParams = [
    /*
      These parameters fix issues with linux on certain surface laptop models:
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
  ];

  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    loadModels = [
	  "qwen3-coder:30b"
    ];
  };

  services.xserver.libinput = {
    enable = true;
    touchpad.disableWhileTyping = false;
  };

  system.stateVersion = "24.11";
}
