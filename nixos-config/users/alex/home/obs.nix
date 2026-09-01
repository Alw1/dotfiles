{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf osConfig.my.desktop.enable {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
