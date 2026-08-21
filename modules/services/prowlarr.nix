{
  config,
  lib,
  pkgs,
  ...
}:
let 
  inherit (config.me.services) prowlarr;
in
lib.mkIf prowlarr.enable {

  users.groups.prowdl = { };

  services.deluge = {
    enable = true;
    web = {
      enable = true;
      port = prowlarr.deluge-port;
    };
    dataDir = prowlarr.deluge-dataDir;
    group = "prowdl";
  };

  services.nginx.virtualHosts."deluge.${config.networking.hostName}.${config.me.services.domain}" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString prowlarr.deluge-port}";
      proxyWebsockets = true;
    };
  };

  services.prowlarr = {
    enable = true;
    settings.server.port = prowlarr.prowlarr-port;
  };

  services.nginx.virtualHosts."prowlarr.${config.networking.hostName}.${config.me.services.domain}" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString prowlarr.prowlarr-port}";
      proxyWebsockets = true;
    };
  };

  services.sonarr = {
    enable = true;
    group = "prowdl";
    settings.server.port = prowlarr.sonarr-port;
  };

  services.nginx.virtualHosts."sonarr.${config.networking.hostName}.${config.me.services.domain}" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString prowlarr.sonarr-port}";
      proxyWebsockets = true;
    };
  };

  services.radarr = {
    enable = true;
    group = "prowdl";
    settings.server.port = prowlarr.radarr-port;
  };

  services.nginx.virtualHosts."radarr.${config.networking.hostName}.${config.me.services.domain}" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString prowlarr.radarr-port}";
      proxyWebsockets = true;
    };
  };

  services.bazarr = {
    enable = true;
    group = "prowdl";
    listenPort = prowlarr.bazarr-port;
  };

  services.nginx.virtualHosts."bazarr.${config.networking.hostName}.${config.me.services.domain}" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString prowlarr.bazarr-port}";
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
