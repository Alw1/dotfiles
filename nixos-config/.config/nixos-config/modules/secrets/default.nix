{ lib, config, ... }: {
  options.secrets.enable = lib.mkEnableOption "sops-nix secrets management";

  config = lib.mkMerge [
    {
      sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    }
    (lib.mkIf config.secrets.enable {
      sops = {
        defaultSopsFile = ../../secrets/common.yaml;
        secrets."ssh-private-key" = {
          owner = "alex";
          path = "/home/alex/.ssh/id_ed25519";
          mode = "0600";
        };
      };
    })
  ];
}
