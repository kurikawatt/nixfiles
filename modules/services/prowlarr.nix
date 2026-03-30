{ config
, lib
, pkgs
, ...
}:
lib.mkIf config.me.services.prowlarr.enable {
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
}
