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

  services.prowlarr = {
    enable = true;
    settings.server.port = prowlarr.prowlarr-port;
  };

  services.sonarr = {
    enable = true;
    group = "prowdl";
    settings.server.port = prowlarr.sonarr-port;
  };

  services.radarr = {
    enable = true;
    group = "prowdl";
    settings.server.port = prowlarr.radarr-port;
  };

  services.bazarr = {
    enable = true;
    group = "prowdl";
    listenPort = prowlarr.bazarr-port;
  };

  networking.firewall.interfaces."ts0".allowedTCPPorts = [
    config.me.services.prowlarr.deluge-port
    config.me.services.prowlarr.prowlarr-port
    config.me.services.prowlarr.sonarr-port
    config.me.services.prowlarr.radarr-port
    config.me.services.prowlarr.bazarr-port
  ];
}
