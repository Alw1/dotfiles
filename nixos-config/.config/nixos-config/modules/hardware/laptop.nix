{ config, lib, ... }: {

  options.laptop-settings.enable =
    lib.mkEnableOption "Laptop specific settings";
  config = lib.mkIf config.laptop-settings.enable {

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    services = {

      # Power saver settings
      power-profiles-daemon.enable = false;
      thermald.enable = true;
      upower.enable = true;
      auto-cpufreq = {
        enable = true;
        settings = {
          charger = {
            governor = "performance";
            turbo = "auto";
          };
          battery = {
            governor = "powersave";
            turbo = "auto";
          };
        };

      };
    };

  };
}
