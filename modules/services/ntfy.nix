{
  config,
  lib,
  ...
}:
let
  inherit (config.me.services.fuuka) peers;
  inherit (config.networking) hostName;
in
lib.mkIf config.me.services.ntfy.enable {

  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "https://${config.me.services.ntfy.base-url}";
      listen-http = ":${toString config.me.services.ntfy.http-port}";
    };
  };

  services.nginx = {
    virtualHosts.${config.me.services.ntfy.base-url} = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://localhost:${toString config.me.services.ntfy.http-port}";
        proxyWebsockets = true;
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = config.me.mail;
  };

}