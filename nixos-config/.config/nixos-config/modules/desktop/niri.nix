{ pkgs, lib, config, ... }: {

  options.niri.enable = lib.mkEnableOption "Enable Niri";
  config = lib.mkIf config.niri.enable {

    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
		xwayland-satellite
    ];
  };
}
