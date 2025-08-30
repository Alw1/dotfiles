{ ... }: {

  imports =
    [ ./hardware-configuration.nix ../../modules ../../users/alex/user.nix ];

  # laptop specific settings
  laptop-settings.enable = true;

  # Bootloader
  GRUB.enable = true; 

  # Display Manager
  ly.enable = true; 

  # Window Manager
  hyprland.enable = true; 

  # Gaming software and settings
  gaming.enable = true;

  # Audio 
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services = {

    gvfs.enable = true;
    udisks2.enable = true;
    printing.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

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

  programs = {

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    nix-ld.enable = true;
  };

  networking.hostName = "porygon";

  system.stateVersion = "24.11";
}
