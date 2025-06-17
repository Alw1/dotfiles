{ pkgs, unstablePkgs, lib, ... }: with pkgs;

let packages = {
    cliPrograms = [
      hyfetch
      fastfetch
      gotop
      tree
      ventoy-full
      stow
      pywal
      usbutils
	  chezmoi
	  yazi
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
    miscPrograms = [
      spotify
	  wine
      discord
      libreoffice
      gparted
      gnome-disk-utility
      mediawriter
      cheese
      woeusb
    ];
  };
in
{
  environment.systemPackages = lib.concatLists (lib.attrValues packages);

  fonts.packages = [
    intel-one-mono
    nerdfonts
    jetbrains-mono
    font-awesome
    monaspace
  ];
}

