{ lib, ... }: {

  # =============================================================================
  # Nix Settings
  # =============================================================================
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  # =============================================================================
  # Locale & Time
  # =============================================================================
  time.timeZone = lib.mkDefault "America/New_York";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # =============================================================================
  # Audio (PipeWire) — enabled by default, disable per-host if needed
  # =============================================================================
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # =============================================================================
  # Common Services
  # =============================================================================
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

  # =============================================================================
  # Common Programs
  # =============================================================================
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    nix-ld.enable = true;
    firefox.enable = true;
  };
}
