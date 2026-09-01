{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.niri;

  # Keep multi-line block bodies lined up inside the braces.
  indent = lib.concatMapStringsSep "\n" (l: lib.optionalString (l != "") "    ${l}");
in
{
  options.my.desktop.niri = {
    enable = lib.mkEnableOption "Niri";

    # Override output settings per host to avoid scaling issues
    outputs = lib.mkOption {
      type = lib.types.attrsOf lib.types.lines;
      default = { };
      example = lib.literalExpression ''
        {
          "eDP-1" = '''
            mode "2256x1504@60"
            scale 1.6
          ''';
        }
      '';
      description = "Niri `output` blocks, keyed by output name; the value is the block body.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.etc."niri/outputs.kdl".text = lib.concatStrings (
      lib.mapAttrsToList (name: body: ''
        output "${name}" {
        ${indent (lib.splitString "\n" (lib.removeSuffix "\n" body))}
        }
      '') cfg.outputs
    );

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
