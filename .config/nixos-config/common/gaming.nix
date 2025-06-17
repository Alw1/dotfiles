{ pkgs, config, lib, ... }: {

	options.gaming.enable = lib.mkEnableOption "Enable Steam and stuff";
	config = lib.mkIf config.gaming.enable {

		programs.steam = {
		  enable = true;
		  remotePlay.openFirewall = true;
		  dedicatedServer.openFirewall = true;
		  protontricks.enable = true;
		};

		environment.systemPackages = with pkgs; [
			melonDS
			prismlauncher
			snes9x
			lime3ds
		];
	};
}
