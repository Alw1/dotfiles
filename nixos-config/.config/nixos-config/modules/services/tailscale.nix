{ ... }:
{
  # sops.secrets."tailscale-authkey" = {
  #   sopsFile = ../../secrets/common.yaml;
  # };

  services.tailscale = {
    enable = true;
    # authKeyFile = config.sops.secrets."tailscale-authkey".path;
    openFirewall = true;
  };
}
