{
  config,
  lib,
  pkgs,
  ...
}:
let 
  inherit (config.me.services) incus;
in 
lib.mkIf incus.enable {

  # iptables is not supported by Incus
  networking.nftables.enable = true;

  networking.firewall.trustedInterfaces = [ "incus0" ];

  networking.firewall.interfaces."enp2s0".allowedTCPPorts = [
    8443
  ];

  virtualisation.incus = {
    enable = true;
    ui.enable = true; # WebUI

    preseed = {

      config = {
        "core.https_address" = ":8443";
      };

      networks = [
        {
          name = "incus0";
          type = "bridge";
          config = {
            # IPv4
            "ipv4.address" = "10.0.0.1/24";
            "ipv4.nat" = "true";
            "ipv4.dhcp" = "true";
            "ipv4.dhcp.ranges" = "10.0.0.10-10.0.0.254";

            # IPv6
            "ipv6.address" = "none";
          };
        }
      ];

      storage_pools = [
        {
          name = "default";
          driver = "dir";
          config = {
            source = "/srv/incus";
          };
        }
        {
          name = "chiyome";
          driver = "dir";
          config = {
            source = "/media/chiyome/incus_data";
          };
        }
      ];

      profiles = [
        {
          name = "default";
          config = {
            "limits.cpu" = "2";
            "limits.memory" = "4GiB";
          };
          devices = {
            eth0 = {
              name = "eth0";
              network = "incus0";
              type = "nic";
            };
            root = {
              path = "/";
              pool = "default";
              type = "disk";
            };
          };
        }
      ];
    };
  };

}