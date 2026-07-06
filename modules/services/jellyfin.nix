{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.me.services.jellyfin.enable {
  
  services.jellyfin.enable = true;
  
  services.nginx.virtualHosts."jellyfin.${config.networking.hostName}.${config.me.services.domain}" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.me.services.jellyfin.port}";
      proxyWebsockets = true;
    };
  };
 
  # To be able to use Hardware
  users.users.jellyfin.extraGroups = [
    "render"
    "video"
  ];

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [
    config.me.services.jellyfin.port
  ];
}
