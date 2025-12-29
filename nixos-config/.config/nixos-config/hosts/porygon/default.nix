{ ... }: {

  imports =
    [ ./hardware-configuration.nix ../../modules ../../users/alex/user.nix ../common.nix];

  networking.hostName = "porygon";

  laptop-settings.enable = true;
  GRUB.enable = true; 
  ly.enable = true; 
  hyprland.enable = true; 
  gaming.enable = true;
  virtualization.enable = true;

  boot.kernelParams = [
	/*
		These parameters fix two issues with linux on 
		certain surface laptop modules:
			- Battery draining after shutdown 
			- Suspend not working properly (unable to wake from suspend)
	*/

	# Battery drain fix
    "pci=hpiosize=0"
    "acpi=force"
    "reboot=acpi"

	# Suspend fix
    "acpi_sleep=nonvs"
    ''acpi_osi="Windows 2020"''
  ];

  system.stateVersion = "24.11";
}
