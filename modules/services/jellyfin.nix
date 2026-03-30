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
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
