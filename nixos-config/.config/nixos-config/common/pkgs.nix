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
      ghc
      go
      jdk
      rustc
      rustfmt
      python3
      python312Packages.pip
      nodejs_20
      cargo
      cabal-install
    ];
    video = [ 
		vlc 
	];
    miscPrograms =
      [ spotify wine discord libreoffice gparted gnome-disk-utility cheese firefox];
  };
in {
  environment.systemPackages = lib.concatLists (lib.attrValues packages);

  fonts.packages = [ intel-one-mono jetbrains-mono font-awesome monaspace ]
    ++ builtins.filter lib.attrsets.isDerivation
    (builtins.attrValues pkgs.nerd-fonts);
}

