{
  pkgs,
  config,
  lib,
  ...
}:
{

  options.hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  config = lib.mkIf config.hyprland.enable {
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
      config = {
        common = {
          default = [
            "hyprland"
            "gtk"
          ];
        };
      };
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
      hyprpolkitagent
      wl-clipboard
      libnotify
      blueman
      nautilus
      mako
      swaynotificationcenter
      kitty
      ghostty
      grim
      slurp
      playerctl
      pavucontrol
      brightnessctl
      networkmanagerapplet
      papers
      eog
      fuzzel
      matugen
      wofi
      rofi
      imagemagick
      glib
      gsettings-desktop-schemas
      nwg-look
    ];
  };
}
