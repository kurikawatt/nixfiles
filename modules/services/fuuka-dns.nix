{ config
, lib
, pkgs
, ...
}:
lib.mkIf config.me.services.fuuka-dns.enable {
  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
    settings = {
      address = "/${config.networking.hostName}.fuuka/172.16.195.2";
      interface = "fuuka0";
      bind-interfaces = true;
    };
  };

  services.nginx = {
    enable = true;
  };

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [ 53 80 ];
  networking.firewall.interfaces."fuuka0".allowedUDPPorts = [ 53 ];
}
