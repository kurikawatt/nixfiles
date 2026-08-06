{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.me.services.domain = mkOption {
    type = types.str;
    default = "kurikawa.fr";
    description = "Base domain for services";
  };

  options.me.services.fuuka-dns = {
    enable = mkEnableOption "Enable DNS for fuuka";
  };

  options.me.services.jellyfin = {
    enable = mkEnableOption "Enable Jellyfin Server";
    port = mkOption {
      type = types.int;
      default = 8096;
      description = "Jellyfin port";
    };
  };

  options.me.services.prowlarr = {
    enable = mkEnableOption "Enable Prowlarr and usefull programs for gathering content";

    deluge-port = mkOption {
      type = types.int;
      default = 8112;
      description = "Deluge port";
    };

    deluge-dataDir = mkOption {
      type = types.str;
      default = "/var/lib/deluge";
      description = "Deluge Data Directory";
    };

    prowlarr-port = mkOption {
      type = types.int;
      default = 9696;
      description = "Prowlarr port";
    };

    sonarr-port = mkOption {
      type = types.int;
      default = 8989;
      description = "Sonarr port";
    };

    radarr-port = mkOption {
      type = types.int;
      default = 7878;
      description = "Radarr port";
    };

    bazarr-port = mkOption {
      type = types.int;
      default = 6767;
      description = "Bazarr port";
    };

  };

  options.me.services.pihole.enable = mkEnableOption "Enable PiHole";

  options.me.services.attic-server = {
    enable = mkEnableOption "Enable Atticd to serve cache";
    port = mkOption {
      type = types.int;
      default = 8080;
      description = "Atticd port";
    };
    cacheLocation = mkOption {
      type = types.str;
      default = "/srv/attic";
      description = "Attic cache location";
    };
  };

  options.me.services.ntfy = {
    enable = mkEnableOption "Enable ntfy";
    base-url = mkOption {
      type = types.str;
      default = "ntfy.kurikawa.fr";
      description = "ntfy base url";
    };
    http-port = mkOption {
      type = types.int;
      default = 8181;
      description = "ntfy http port";
    };
  };

  options.me.services.monitor-storage = {
    enable = mkEnableOption "";
  };

  options.me.services.monitoring = {
    prometheus = {
      server = {
        enable = mkEnableOption "Enable Prometheus Server";
        nodes = mkOption {
          type = types.listOf types.str;
          default = [];
          description = ""; 
        };
        port = mkOption {
          type = types.int;
          default = 9090;
          description = "";
        };
        grafana-port = mkOption {
          type = types.int;
          default = 3000;
          description = "";
        };
      };
      node = {
        enable = mkEnableOption "Enable Prometheus Probe (Node)";
        port = mkOption {
          type = types.int;
          default = 9000;
          description = "";
        };
      };
    };
  };
}
