{ unstablePkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../common
    ../../users/alex/user.nix
  ];

  hyprland.enable = true;
  gaming.enable = true;
  # virtualization.enable = true;

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

  programs.nix-ld.enable = true;
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

    displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        load = true;
        save = true;
        clear_password = true;
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
      # theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
    };
  };

  programs = {
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   enableLsColors = true;
    #   autosuggestions.enable = true;
    #   syntaxHighlighting.enable = true;
    #   shellAliases = {
    #     rotom-update = ''nix flake update --flake ~/nix-config'';
    #     rotom-upgrade = ''sudo nixos-rebuild switch --flake ~/nix-config#$HOST'';
    #   };
    # };

    firefox.enable = true;

	neovim = {
	     enable = true;
	     defaultEditor = true;
	     package = unstablePkgs.neovim-unwrapped;
    };
  };

  networking.hostName = "rotom";

  system.stateVersion = "23.11";
}
