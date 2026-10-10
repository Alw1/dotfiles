{ ... }: {
  imports = [ ../users/alex ];

  my = {
    hardware.laptop.enable = true;

    desktop = {
      enable = true;
      hyprland.enable = true;
    };

    services = {
      ly.enable = true;
      tailscale.enable = true;
    };

    system.grub.enable = true;
  };
}
