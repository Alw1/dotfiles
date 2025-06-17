{ pkgs, lib, config, ... }: {

  options.virtualization.enable = lib.mkEnableOption "Enable Virtualization (Docker & Virt-Manager)";
  config = lib.mkIf config.virtualization.enable
    {

      environment.systemPackages = with pkgs; [
        virt-manager
        virt-viewer
        docker-compose
        virtiofsd
        spice
        spice-gtk
        spice-protocol
      ];

      virtualisation.docker.enable = true;
      users.users.alex.extraGroups = [ "libvirtd" "docker" ];

      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            swtpm.enable = true;
            ovmf.enable = true;
            ovmf.packages = [ pkgs.OVMFFull.fd ];
          };
        };
        spiceUSBRedirection.enable = true;
      };
      services.spice-vdagentd.enable = true;
    };
}
