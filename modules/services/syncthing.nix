{ config
, lib
, pkgs
, ...
}:
lib.mkIf config.me.services.sync.enable {

  sops.secrets."syncthing/guipassword" = {
    owner = config.me.user;
    path = "/tmp/syncthing_pw";
  };

  sops.secrets.sync-pem = {
    sopsFile = ../../secrets/syncthing.yaml;
    owner = config.me.user;
    key = "${config.networking.hostName}/pem";
  };

  sops.secrets.sync-cert = {
    sopsFile = ../../secrets/syncthing.yaml;
    owner = config.me.user;
    key = "${config.networking.hostName}/pem";
  };

  sops.templates."sync-cert.key".content = ''
    -----BEGIN CERTIFICATE-----
    ${config.sops.placeholder.sync-cert}
    -----END CERTIFICATE-----
  '';

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    key = config.sops.secrets.sync-pem.path;
    cert = config.sops.templates."sync-cert.key".path;
    user = config.me.user;
    dataDir = config.me.home;
    guiPasswordFile = config.sops.secrets."syncthing/guipassword".path;
    settings = {
      gui.user = config.me.user;
    };
    relay.enable = false;
    devices = {
      queen = {
        id = "2B7VK4Y-AITNDD2-6RAGAOL-7XVKHU7-5U6XZ5E-UV74AGW-M5KN7I2-YCTQBQQ";
      };
      metis = {
        id = "CSGQLB4-A433CFS-HZ76DY4-RNOI3LE-MOHOS42-XNH7C4H-HLOIQSZ-P3QNUQX";
      };
    };
    folders = {
      "Documents" = {
        path = "${config.me.home}/Documents";
      };
    };
  };
}
