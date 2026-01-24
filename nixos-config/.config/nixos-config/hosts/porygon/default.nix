{ ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../users/alex/user.nix
    ../common.nix
  ];

  networking.hostName = "porygon";

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
    */
    # Battery drain fix
    "pci=hpiosize=0"
    "acpi=force"
    "reboot=acpi"

    # Suspend fix - original parameters
    "acpi_sleep=nonvs"
    ''acpi_osi="Windows 2020"''

    # S2idle reliability improvements
    # "acpi_sleep=s2idle"
    # "intel_idle.max_cstate=1"
    # "idle=halt"
    #
    # # USB/device wake fixes (common cause of inconsistent wake)
    # "usbcore.autosuspend=-1"
    # "usbcore.blankMessageEndpoint=Y"
  ];

  system.stateVersion = "24.11";
}
