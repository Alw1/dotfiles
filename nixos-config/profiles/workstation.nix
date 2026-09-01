{ ... }:
{
  imports = [ ../users/alex ];

  my = {
    packages.dev.enable = true;

    desktop = {
      enable = true;
      extras.enable = true;
      hyprland.enable = true;
	  niri.enable = true;
    };

    services = {
      ly.enable = true;
      tailscale.enable = true;
    };

    system = {
      grub.enable = true;
      gaming.enable = true;
      virtualization = {
        enable = true;
        users = [ "alex" ];
      };
    };
  };
}
