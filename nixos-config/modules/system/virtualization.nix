{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.system.virtualization;
in
{
  options.my.system.virtualization = {
    enable = lib.mkEnableOption "virtualization (Docker & virt-manager)";

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Users to add to the libvirtd and docker groups.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      docker-compose
      gnome-boxes
      spice
      spice-gtk
      spice-protocol
      virt-manager
      virt-viewer
      virtiofsd
    ];

    users.users = lib.genAttrs cfg.users (_: {
      extraGroups = [
        "libvirtd"
        "docker"
      ];
    });

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };
      spiceUSBRedirection.enable = true;
      docker.enable = true;
    };

    services.spice-vdagentd.enable = true;
  };
}
