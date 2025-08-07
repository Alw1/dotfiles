{ ... }: {

  imports =
    [ ./hardware-configuration.nix ../../common ../../users/alex/user.nix ];

  hyprland.enable = true;
  gaming.enable = true;

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      clear_password = true;
    };
  };

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

    # Power Saver Settings
    power-profiles-daemon.enable = false; # Need to disable to enable tlp
    thermald.enable = true;
    upower.enable = true;
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          turbo = "auto";
        };
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

  boot.kernelParams = [
    # Fixes battery drain after laptop shutdown
    "pci=hpiosize=0"
    "acpi=force"
    "reboot=acpi"
    "mem_sleep_default=s2idle"

    # Fixes wake detection after suspend
    "i8042.noaux=1" # This is the big one for Surface keyboards
    "i8042.nomux=1" # Disable PS/2 multiplexing
    "i8042.reset=1" # Reset controller
    ''acpi_osi="Windows 2020"'' # Better ACPI compatibility
  ];

  programs = {
    firefox.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    nix-ld.enable = true;
  };

  networking.hostName = "porygon";

  system.stateVersion = "24.11";
}
