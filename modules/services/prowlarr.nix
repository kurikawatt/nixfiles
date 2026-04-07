{ config
, lib
, pkgs
, ...
}:
lib.mkIf config.me.services.prowlarr.enable {

  users.groups.prowdl = { };

  services.deluge = {
    enable = true;
    web = {
      enable = true;
      openFirewall = true;
    };
    group = "prowdl";
  };
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "prowdl";
    #dataDir = "/tmp/sonarr";
  };
  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "prowdl";
  };
}
