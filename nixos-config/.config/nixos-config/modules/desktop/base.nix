{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop;
in
{
  options.my.desktop = {
    enable = lib.mkEnableOption "graphical desktop support";
    extras.enable = lib.mkEnableOption "large optional desktop apps";
    obs.enable = lib.mkEnableOption "OBS Studio and its plugins (~2 GiB, pulls CEF)";
  };

  config = lib.mkIf cfg.enable {
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

    programs.firefox.enable = true;

    # Every config here asks for Intel One Mono (kitty, waybar, fuzzel) with
    # Font Awesome for waybar's icons; symbols-only supplies the patched glyphs
    # as a fallback. Whole Nerd Fonts families are ~250 MiB-1 GiB each, so they
    # are deliberately not installed.
    fonts.packages = [
      pkgs.intel-one-mono
      pkgs.font-awesome
      pkgs.nerd-fonts.symbols-only
    ];

    # openconnect comes from core/networking.nix, which every host imports.
    environment.systemPackages = [
      pkgs.glib
      pkgs.obsidian
      pkgs.mediawriter
    ]
    ++ lib.optionals cfg.extras.enable (
      with pkgs;
      [
        audacity
        cheese
        discord
        gnome-disk-utility
        gnome-settings-daemon
        gparted
        libreoffice
        octaveFull
        spotify
        unstable.arduino
        unstable.arduino-ide
        vlc
        vscodium-fhs
        wine
      ]
    );
  };
}
