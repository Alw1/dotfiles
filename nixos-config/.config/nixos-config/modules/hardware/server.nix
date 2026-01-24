{ config, lib, pkgs, ... }: {
  options.server-settings.enable =
    lib.mkEnableOption "server specific settings";
  config = lib.mkIf config.server-settings.enable {
    services = {
      gitea = {
        enable = true;
        database.type = "mysql";

        # Core settings
        settings.server = {
          HTTP_PORT = 3000;
          DOMAIN = "git.example.com"; # Change to your domain
          ROOT_URL = "http://git.example.com/";
          SSH_PORT = 22;
          START_SSH_SERVER = true;
        };

        # Security settings
        settings.security = {
          DISABLE_GIT_HOOKS = false;
          INSTALL_LOCK = true;
        };

        # Service/registration settings
        settings.service = {
          DISABLE_REGISTRATION = true; # Uncomment to disable new registrations
          REQUIRE_SIGNIN_VIEW = true; # Require login to view repos
          DEFAULT_KEEP_EMAIL_PRIVATE = true;
          DEFAULT_ALLOW_CREATE_ORGANIZATION = false;
        };

        # Repository settings
        settings.repository = {
          DEFAULT_PRIVATE = true; # New repos private by default
          DISABLE_HTTP_GIT = false;
          ENABLE_PUSH_CREATE_USER = false;
        };

        # UI/UX settings
        settings.ui = {
          SHOW_USER_EMAIL = false;
          EXPLORE_PAGING_NUM = 20;
        };

        # Session/security
        settings.session = {
          COOKIE_SECURE = true;
          COOKIE_SAMESITE = "Lax";
        };
      };

      # MySQL database service
      mysql = {
        enable = true;
        package = lib.mkDefault pkgs.mysql80;
        initialDatabases = [{ name = "gitea"; }];
        initialScript = pkgs.writeText "gitea-mysql-init" ''
          CREATE USER 'gitea'@'localhost' IDENTIFIED BY 'change-this-password';
          GRANT ALL PRIVILEGES ON gitea.* TO 'gitea'@'localhost';
          FLUSH PRIVILEGES;
        '';
      };

      # Optional: reverse proxy (nginx) for HTTPS
      nginx = {
        enable = true;
        virtualHosts."git.example.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3000";
            proxyWebsockets = true;
          };
        };
      };
    };

    # SSL/TLS with Let's Encrypt
    security.acme = {
      acceptTerms = true;
      defaults.email = "admin@example.com"; # Change to your email
    };

    # Firewall settings
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      allowedUDPPorts = [ ];
    };
  };
}
