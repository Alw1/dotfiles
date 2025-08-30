{ lib, config, ... }: {
  options.ly.enable = lib.mkEnableOption "Enable ly, the display manager";
  config = lib.mkIf config.ly.enable {

    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        clear_password = true;
      };
    };

  };
}
