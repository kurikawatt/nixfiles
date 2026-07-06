{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.me.services.prowlarr.enable {

  users.groups.prowdl = { };

  services.deluge = {
    enable = true;
    web = {
      enable = true;
      port = config.me.services.prowlarr.deluge-port;
    };
    group = "prowdl";
  };

  services.nginx.virtualHosts."deluge.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.me.services.prowlarr.deluge-port}";
      proxyWebsockets = true;
    };
  };

  services.prowlarr = {
    enable = true;
    settings.server.port = config.me.services.prowlarr.prowlarr-port;
  };

  services.nginx.virtualHosts."prowlarr.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.me.services.prowlarr.prowlarr-port}";
      proxyWebsockets = true;
    };
  };

  services.sonarr = {
    enable = true;
    group = "prowdl";
    settings.server.port = config.me.services.prowlarr.sonarr-port;
  };

  services.nginx.virtualHosts."sonarr.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.me.services.prowlarr.sonarr-port}";
      proxyWebsockets = true;
    };
  };

  services.radarr = {
    enable = true;
    group = "prowdl";
    settings.server.port = config.me.services.prowlarr.radarr-port;
  };

  services.nginx.virtualHosts."radarr.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.me.services.prowlarr.radarr-port}";
      proxyWebsockets = true;
    };
  };

  services.bazarr = {
    enable = true;
    group = "prowdl";
    listenPort = config.me.services.prowlarr.bazarr-port;
  };

  services.nginx.virtualHosts."bazarr.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.me.services.prowlarr.bazarr-port}";
      proxyWebsockets = true;
    };
  };

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [
    config.me.services.prowlarr.deluge-port
    config.me.services.prowlarr.prowlarr-port
    config.me.services.prowlarr.sonarr-port
    config.me.services.prowlarr.radarr-port
    config.me.services.prowlarr.bazarr-port
  ];
}
