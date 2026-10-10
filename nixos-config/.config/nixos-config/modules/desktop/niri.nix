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

    # Matches the Hyprland list: fuzzel, mako and kitty are what startup.kdl
    # and binds.kdl actually spawn. hypridle is the package rather than the
    # service because niri spawns it itself; swayidle was a second, unused idle
    # daemon alongside it.
    environment.systemPackages = with pkgs; [
      awww
      blueman
      brightnessctl
      eog
      fuzzel
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
      slurp
      wl-clipboard
      xwayland-satellite
    ];
  };
}
