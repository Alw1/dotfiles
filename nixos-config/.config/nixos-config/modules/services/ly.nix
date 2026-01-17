{ lib, config, ... }: {
  options.ly.enable = lib.mkEnableOption "Enable ly, the display manager";
  config = lib.mkIf config.ly.enable {

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
