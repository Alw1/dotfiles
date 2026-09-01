{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.system.gaming;
in
{
  options.my.system.gaming.enable = lib.mkEnableOption "gaming related software";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      protontricks.enable = true;
    };

    environment.systemPackages = with pkgs; [
      melonds
      prismlauncher
    ];
  };
}
