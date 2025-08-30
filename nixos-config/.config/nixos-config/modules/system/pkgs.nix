{ pkgs, lib, ... }:
with pkgs;

let
  packages = {
    cliPrograms = [
      pokeget-rs
      ranger
      hyfetch
      fastfetch
      powertop
      gotop
      tree
      stow
      pywal
      usbutils
      openssl
      zip
      unzip
      xz
      ripgrep
    ];
    programmingUtils = [
      vim
      vscode
      git
      gnumake
      gcc
      clang
      ghc
      go
      jdk
      pkg-config
      rustc
      rustfmt
      python3
      python312Packages.pip
      nodejs_20
      firefox
      cargo
      cabal-install
    ];
    video = [ vlc ];
    miscPrograms = [
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

