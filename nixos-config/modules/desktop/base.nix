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
    extras.enable = lib.mkEnableOption "large optional desktop apps and the full Nerd Fonts set";
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

    fonts.packages = [
      pkgs.intel-one-mono
      pkgs.jetbrains-mono
      pkgs.font-awesome
      pkgs.monaspace
      # Waybar and the shell configs need the patched glyphs; the rest of the
      # Nerd Fonts collection is several GB and comes with `extras`.
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.symbols-only
    ]
    ++ lib.optionals cfg.extras.enable (
      builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
    );

    environment.systemPackages = [
      pkgs.glib
	  pkgs.obsidian
	  pkgs.openconnect
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
