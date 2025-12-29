{ pkgs, lib, config, ... }: {

  options.virtualization.enable =
    lib.mkEnableOption "Enable Virtualization (Docker & Virt-Manager)";
  config = lib.mkIf config.virtualization.enable {

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      docker-compose
      virtiofsd
      spice
      spice-gtk
      spice-protocol
	  gnome-boxes
    ];

    users.users.alex.extraGroups = [ "libvirtd" "docker" ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
	  docker.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
