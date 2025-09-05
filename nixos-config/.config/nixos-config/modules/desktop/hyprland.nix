{ pkgs, config, lib, ... }: {

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
      extraPortals =
        [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
      config = { common = { default = [ "hyprland" "gtk" ]; }; };
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    environment.systemPackages = with pkgs; [
      swww
      hyprpolkitagent
      wl-clipboard
      libnotify
      blueberry
      nautilus
      mako
      kitty
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
    ];
  };
}
