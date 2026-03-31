{ config
, lib
, pkgs
, ...
}:
lib.mkIf config.me.services.prowlarr.enable {
  services.deluge = {
    enable = true;
    web = {
      enable = true;
      openFirewall = true;
    };
  };
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
  services.sonarr = {
    enable = true;
    openFirewall = true;
    #dataDir = "/tmp/sonarr";
  };
}
