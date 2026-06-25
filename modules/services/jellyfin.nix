{ config
, lib
, pkgs
, ...
}:
lib.mkIf config.me.services.jellyfin.enable {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  
  services.nginx.virtualHosts."jellyfin.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8096";
      proxyWebsockets = true;
    };
  };
 
  # To be able to use Hardware
  users.users.jellyfin.extraGroups = [
    "render"
    "video"
  ];

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [ 8096 ];
}
