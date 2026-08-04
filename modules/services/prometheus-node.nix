{
  config,
  lib,
  ...
}:
let
  inherit (config.me.services.monitoring) prometheus;
in
lib.mkIf prometheus.node.enable {
  services.prometheus.exporters.node = {
    enable = true;
    port = prometheus.node.port;
    enabledCollectors = [
      "cpu"
      "meminfo"
      "loadavg"
      "stat"
      "filesystem"
      "diskstats"
      "netdev"
      "systemd"
    ];
  };

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [
    prometheus.node.port
  ];
}