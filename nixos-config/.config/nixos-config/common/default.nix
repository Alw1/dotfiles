{ ... }: {
  imports = [
    ./networking.nix
    ./gaming.nix
    ./pkgs.nix
    ./hyprland.nix
	./niri.nix
    ./gnome.nix
    ./sway.nix
    ./virtualization.nix
    ./zsh.nix
  ];
}
