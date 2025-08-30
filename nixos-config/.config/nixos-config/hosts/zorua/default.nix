{ ... }: {

  imports =
    [ ./hardware-configuration.nix ../../modules ../../users/alex/user.nix ];

  hyprland.enable = true;
  tuigreet.enable = true;
  gaming.enable = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  programs.nix-ld.enable = true;
  services = {

    gvfs.enable = true;
    udisks2.enable = true;
    printing.enable = true;

    # displayManager.ly = {
    # 	enable = true;
    # 	settings = {
    # 	  animation = "colormix";
    # 	  load = true;
    # 	  save = true;
    # 	  clear_password = true;
    # 	};
    # };

    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true;
  };

  networking.hostName = "zorua";

  system.stateVersion = "23.11";
}
