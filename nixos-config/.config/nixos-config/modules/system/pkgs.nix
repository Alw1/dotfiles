{ pkgs, lib, ... }:
with pkgs;

let
  packages = {
    cliPrograms = [
      pokeget-rs
      yazi
      hyfetch
      fastfetch
      powertop
      gotop
      tree
      tmux
      stow
      pywal
      usbutils
      zip
      unzip
      xz
      ripgrep
    ];
    programmingUtils = [
      vim
      vscodium-fhs
      git
      gnumake
      gcc
      clang
      ghc
      go
      jdk
      julia
      pkg-config
      rustc
      rustfmt
      python3
      python312Packages.pip
      conda
      nodejs_20
      firefox
      cargo
      cabal-install
      haskell-language-server
	  metals
    ];
    video = [ vlc ];
    miscPrograms = [
      glib
      gsettings-desktop-schemas
      # kicad
      spotify
      wine
      discord
      libreoffice
      gparted
      gnome-disk-utility
      cheese
      firefox
    ];
  };
in {
  environment.systemPackages = lib.concatLists (lib.attrValues packages);
  fonts.packages = [ intel-one-mono jetbrains-mono font-awesome monaspace ]
    ++ builtins.filter lib.attrsets.isDerivation
    (builtins.attrValues pkgs.nerd-fonts);
}

