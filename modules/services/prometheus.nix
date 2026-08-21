{
  config,
  lib,
  ...
}:
let
  inherit (config.me.services.monitoring) prometheus;
in
lib.mkIf prometheus.server.enable {

  sops.secrets.grafana_secret_key = {
    owner = "grafana";
    group = "grafana";
    mode = "0400";
  };

  services.prometheus = {
    enable = true;
    port = prometheus.server.port;
    globalConfig.scrape_interval = "1m";
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "172.16.195.1:${toString prometheus.node.port}" ];
            labels = {
              node = "chord";
              env = "prod";
            };
          }
          {
            targets = [ "172.16.195.2:${toString prometheus.node.port}" ];
            labels = {
              node = "metis";
              env = "prod";
            };
          }
        ];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = prometheus.server.grafana-port;
      };
      security = {
        secret_key = "$__file{/run/secrets/grafana_secret_key}";
      };
    };

    provision = {
      enable = true;

      datasources.settings = {
        apiVersion = 1;
        datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            access = "proxy";
            url = "http://127.0.0.1:${toString prometheus.server.port}";
            isDefault = true;
          }
        ];
      };
    };
  };

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [
    prometheus.server.port
    prometheus.server.grafana-port
  ];
}