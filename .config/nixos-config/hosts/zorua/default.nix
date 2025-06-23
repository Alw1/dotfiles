{ unstablePkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../common
    ../../users/alex/user.nix
  ];

  hyprland.enable = true;
  tuigreet.enable = true;
  # GNOME.enable = true;
  gaming.enable = true;

  services.hardware.openrgb = {
 	 enable = true;
	 motherboard = "amd";
  };

  hardware.graphics.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

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
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "prohibit-password";
      };
    };

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
      videoDrivers = ["amdgpu"];
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
		 package = unstablePkgs.neovim-unwrapped;
    };
    firefox.enable = true;
  };

  networking.hostName = "zorua";

  system.stateVersion = "23.11";
}
