{ config, lib, ... }:
let
  cfg = config.my.services.ly;
in
{
  options.my.services.ly.enable = lib.mkEnableOption "the ly display manager";

  config = lib.mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        session_log = ".local/state/ly-session.log";
        auth_fails = 5;
        clear_password = true;
      };
    };
  };
}
