{ ... }:
# Lean desktop for storage constrained machines: Hyprland and the necessities,
# nothing else. Deliberately omits `my.packages.dev`, `my.desktop.extras`,
# gaming and virtualization -- add them per host if a given machine can afford
# the disk.
{
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
