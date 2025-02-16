{pkgs, lib, ... }: {
	imports = [
		./fonts.nix
		./programs.nix
		./sway.nix
		./hyprland.nix
	];

	nix = {
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 7d";
		};

		settings.auto-optimise-store = true;
		settings.experimental-features = ["nix-command" "flakes"];
	};
}
