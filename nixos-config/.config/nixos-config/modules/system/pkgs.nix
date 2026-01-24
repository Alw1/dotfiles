{ pkgs, lib, ... }:
with pkgs;

let
  packages = {
    cliPrograms = [
      pokeget-rs
      yazi
      hyfetch
      jq
      socat
      fastfetch
      powertop
      gotop
      tree
      tmux
      stow
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
      octaveFull
      pkg-config
      rustc
      rustfmt
      python3
      python312Packages.pip
      nodejs_20
      firefox
      cargo
      cabal-install
      haskell-language-server
    ];
    video = [ vlc ];
    miscPrograms = [
      glib
      spotify
      wine
      discord
      libreoffice
      gparted
      gnome-disk-utility
      claude-code
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

