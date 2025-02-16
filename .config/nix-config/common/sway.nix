{ config, pkgs, ... }: {
	config = {
		programs = {
			sway = {
				enable = true;
				wrapperFeatures.gtk = true;
			};
			xwayland.enable = true;
			nm-applet.enable = true;
			dconf.enable = true;
			nautilus-open-any-terminal = {
				enable = true;
				terminal = "kitty";
			};
		};

		environment.systemPackages = with pkgs; [
			sway
			swayidle
			swaylock
			swaybg
			waybar
			wl-clipboard
			libnotify 
			mako
			kitty
			grim
			slurp
			pavucontrol
			playerctl
			pulseaudioFull 
			brightnessctl
			networkmanagerapplet
			papers
			nautilus
			eog
			fuzzel
		];
	};
}
