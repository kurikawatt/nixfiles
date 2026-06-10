{ config
, lib
, pkgs
, ...
}:
lib.mkIf config.me.services.jellyfin.enable {
  services.jellyfin = {
    enable = true;
    #openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
  services.nginx.virtualHosts."jellyfin.${config.networking.hostName}.fuuka" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8096";
      proxyWebsockets = true;
    };
  };
}
