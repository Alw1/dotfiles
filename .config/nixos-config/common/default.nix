{ ... }: {
	imports = [
		./networking.nix
		./gaming.nix
		./pkgs.nix
		./hyprland.nix
		./gnome.nix
		./sway.nix
		./virtualization.nix
		./greetd.nix
		./zsh.nix
	];
}
