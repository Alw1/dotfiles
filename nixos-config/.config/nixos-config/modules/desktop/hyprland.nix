{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.hyprland;
in
{
  options.my.desktop.hyprland.enable = lib.mkEnableOption "Hyprland";

  config = lib.mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      hyprlock.enable = true;
      waybar.enable = true;
      dconf.enable = true;
    };

    services.hypridle.enable = true;
    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = [
        "hyprland"
        "gtk"
      ];
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    systemd.user.services.battery-check = {
      description = "Battery level check and notification";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "%h/.config/hypr/scripts/battery-check.sh";
      };
    };

    systemd.user.timers.battery-check = {
      description = "Battery level check timer";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "2min";
      };
    };

    environment.systemPackages = with pkgs; [
      awww
      blueman
      brightnessctl
      eog
      fuzzel
      ghostty
      glib
      grim
      gsettings-desktop-schemas
      hyprpolkitagent
      imagemagick
      kitty
      libnotify
      mako
      matugen
      nautilus
      networkmanagerapplet
      nwg-look
      papers
      pavucontrol
      playerctl
      rofi
      slurp
      swaynotificationcenter
      wl-clipboard
      wofi
    ];
  };
}
