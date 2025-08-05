{ ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../common
    ../../users/alex/user.nix
  ];

  hyprland.enable = true;
  tuigreet.enable = true;
  gaming.enable = true;

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

  services = {

    gvfs.enable = true;
    udisks2.enable = true;
    printing.enable = true;

    power-profiles-daemon.enable = false; # Need to disable to enable tlp
    thermald.enable = true;
    upower.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;
      };
    };

    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

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

  programs = {
    firefox.enable = true;

	neovim = {
	     enable = true;
	     defaultEditor = true;
    };

    programs.nix-ld.enable = true;
  };

  networking.hostName = "porygon";

  system.stateVersion = "24.11";
}
