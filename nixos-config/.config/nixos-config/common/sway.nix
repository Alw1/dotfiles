{ pkgs, unstablePkgs, lib, config, ... }: {

  options.sway.enable = lib.mkEnableOption "Enable Sway";
  config = lib.mkIf config.sway.enable {
    programs = {
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
		xwayland.enable = true;
      };
      waybar = {
        enable = true;
        package = pkgs.waybar;
      };
      dconf.enable = true;
      nautilus-open-any-terminal = {
        enable = true;
        terminal = "kitty";
      };
    };

    environment.systemPackages = with pkgs; [
      sway
      swayidle
      swaylock
      swaybg
      wl-clipboard
      libnotify
      mako
      kitty
      grim
      slurp
      pavucontrol
      playerctl
      pulseaudioFull
      brightnessctl
      papers
      nautilus
      eog
      fuzzel
    ];
  };
}
