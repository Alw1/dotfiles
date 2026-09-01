{ config, lib, ... }:
let
  cfg = config.my.hardware.laptop;
in
{
  options.my.hardware.laptop.enable = lib.mkEnableOption "laptop specific settings";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    services = {
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
