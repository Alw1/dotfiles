{ unstable, ... }: {

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

  boot.kernelParams = [
    /* These parameters fix issues with linux on
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
  ];

	  services.ollama = {
	    enable = true;
	 package = unstable.ollama;
	    # Optional: preload models, see https://ollama.com/library
	    loadModels = [ "qwen3.5" ];
	  };
	
  system.stateVersion = "24.11";
}
