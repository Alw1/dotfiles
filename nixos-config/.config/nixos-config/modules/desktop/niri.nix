{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.niri;
in
{
  options.my.desktop.niri = {
    enable = lib.mkEnableOption "Niri";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      niri.enable = true;
      hyprlock.enable = true;
      xwayland.enable = true;
      waybar.enable = true;
      dconf.enable = true;
    };

    security.polkit.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    # The script only reads /sys and calls notify-send, so it is shared with the
    # Hyprland session rather than duplicated under ~/.config/niri.
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
      hypridle
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
      swayidle
      swaynotificationcenter
      wl-clipboard
      wofi
      xwayland-satellite
    ];
  };
}
