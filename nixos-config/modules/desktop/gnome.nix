{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.gnome;
in
{
  options.my.desktop.gnome.enable = lib.mkEnableOption "GNOME";

  config = lib.mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      atomix
      cheese
      epiphany
      evince
      geary
      gedit
      gnome-characters
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour
      hitori
      iagno
      tali
      totem
    ];
  };
}
