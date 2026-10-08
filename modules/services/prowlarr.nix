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
    };
    dataDir = prowlarr.deluge-dataDir;
    group = "prowdl";
  };

  services.prowlarr = {
    enable = true;
    settings.server.port = 9696;
  };

  services.sonarr = {
    enable = true;
    group = "prowdl";
    settings.server.port = 8989;
  };

  services.radarr = {
    enable = true;
    group = "prowdl";
    settings.server.port = 7878;
  };

  services.tailscale.serve.services = {
    "deluge" = {
      endpoints = {
        "tcp:8112" = "http://127.0.0.1:8112";
      };
      advertised = true;
    };
    "prowlarr" = {
      endpoints = {
        "tcp:9696" = "http://127.0.0.1:9696";
      };
      advertised = true;
    };
    "sonarr" = {
      endpoints = {
        "tcp:8989" = "http://127.0.0.1:8989";
      };
      advertised = true;
    };
    "radarr" = {
      endpoints = {
        "tcp:7878" = "http://127.0.0.1:7878";
      };
      advertised = true;
    };
  };

  networking.firewall.interfaces."ts0".allowedTCPPorts = [
    8112 9696 8989 7878
  ];
}
