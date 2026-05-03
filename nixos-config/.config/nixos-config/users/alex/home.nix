{ pkgs, ... }:
{
  home.username = "alex";
  home.homeDirectory = "/home/alex";
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors";
    size = 15;
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      icon-theme = "WhiteSur-dark";
    };
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
    font = {
      name = "Intel One Mono";
      package = pkgs.intel-one-mono;
      size = 11;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  programs.git = {
    enable = true;
    settings.user = {
      name = "Alex Wyatt";
      email = "alexander@jdwyatt.com";
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
