{ pkgs, ... }: {

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
    };
  };

  gtk = {
    enable = true;
    theme = {
      # package = pkgs.sierra-gtk-theme;
      name = "Adwaita";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Intel One Mono";
      package = pkgs.intel-one-mono;
      size = 11;
    };
  };

  programs.git = {
	enable = true;
	userName = "Alex Wyatt";
	userEmail = "alexander@jdwyatt.com";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
