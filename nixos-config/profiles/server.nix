{ ... }:
{
  imports = [ ../users/alex ];

  my = {
    packages.dev.enable = true;

    system.grub.enable = true;

    services = {
      tailscale.enable = true;
      gitea = {
        enable = true;
        domain = "git.example.com";
        acmeEmail = "admin@example.com";
      };
    };
  };
}
