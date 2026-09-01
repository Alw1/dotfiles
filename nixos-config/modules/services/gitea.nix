{ config, lib, ... }:
let
  cfg = config.my.services.gitea;
in
{
  options.my.services.gitea = {
    enable = lib.mkEnableOption "a Gitea forge behind nginx";

    domain = lib.mkOption {
      type = lib.types.str;
      example = "git.example.com";
      description = "Public domain the forge is served on.";
    };

    acmeEmail = lib.mkOption {
      type = lib.types.str;
      example = "admin@example.com";
      description = "Contact address for Let's Encrypt registration.";
    };

    httpPort = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "Local port Gitea listens on behind the reverse proxy.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.gitea = {
      enable = true;
      database.type = "mysql";

      settings.server = {
        HTTP_PORT = cfg.httpPort;
        DOMAIN = cfg.domain;
        ROOT_URL = "https://${cfg.domain}/";
        SSH_PORT = 22;
        START_SSH_SERVER = true;
      };

      settings.security = {
        DISABLE_GIT_HOOKS = false;
        INSTALL_LOCK = true;
      };

      settings.service = {
        DISABLE_REGISTRATION = true;
        REQUIRE_SIGNIN_VIEW = true;
        DEFAULT_KEEP_EMAIL_PRIVATE = true;
        DEFAULT_ALLOW_CREATE_ORGANIZATION = false;
      };

      settings.repository = {
        DEFAULT_PRIVATE = true;
        DISABLE_HTTP_GIT = false;
        ENABLE_PUSH_CREATE_USER = false;
      };

      settings.ui = {
        SHOW_USER_EMAIL = false;
        EXPLORE_PAGING_NUM = 20;
      };

      settings.session = {
        COOKIE_SECURE = true;
        COOKIE_SAMESITE = "Lax";
      };
    };

    services.nginx = {
      enable = true;
      virtualHosts.${cfg.domain} = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString cfg.httpPort}";
          proxyWebsockets = true;
        };
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = cfg.acmeEmail;
    };

    networking.firewall.allowedTCPPorts = [
      22
      80
      443
    ];
  };
}
