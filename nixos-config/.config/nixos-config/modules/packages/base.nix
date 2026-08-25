{ pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    nix-ld.enable = true;
  };

  environment.systemPackages = with pkgs; [
    claude-code
    fastfetch
    git
    gotop
    hyfetch
    jq
    pokeget-rs
    powertop
    python3
    python312Packages.pip
    ripgrep
    socat
    stow
    tmux
    tree
    unzip
    usbutils
    vim
    xz
    yazi
    zip
  ];
}
