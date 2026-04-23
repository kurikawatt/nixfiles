{ config
, lib
, pkgs
, ...
}:
lib.mkIf config.me.services.sync.enable {

  sops.secrets."syncthing/guipassword" = {
    owner = "syncthing";
    path = "/tmp/syncthing_pw";
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiPasswordFile = config.sops.secrets."syncthing/guipassword".path;
    settings = {
      gui.user = config.me.user;
    };
  };
}
