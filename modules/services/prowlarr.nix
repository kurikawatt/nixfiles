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
      openFirewall = true;
    };
    group = "prowdl";
  };

  services.nginx.virtualHosts."deluge.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8112";
      proxyWebsockets = true;
    };
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.nginx.virtualHosts."prowlarr.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:9696";
      proxyWebsockets = true;
    };
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "prowdl";
  };

  services.nginx.virtualHosts."sonarr.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8989";
      proxyWebsockets = true;
    };
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "prowdl";
  };

  services.nginx.virtualHosts."radarr.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:7878";
      proxyWebsockets = true;
    };
  };

  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "prowdl";
  };

  services.nginx.virtualHosts."bazarr.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:6767";
      proxyWebsockets = true;
    };
  };
}
