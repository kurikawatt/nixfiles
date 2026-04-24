{ config
, lib
, pkgs
, ...
}:
let
  syncCfg = "${config.me.home}/.config/syncthing";
in
lib.mkIf config.me.services.sync.enable {

  sops.secrets."syncthing/guipassword" = {
    owner = config.me.user;
    path = "/tmp/syncthing_pw";
  };

  sops.secrets.sync-key = {
    sopsFile = ../../secrets/syncthing.yaml;
    owner = config.me.user;
    key = "${config.networking.hostName}/key";
  };

  sops.secrets.sync-cert = {
    sopsFile = ../../secrets/syncthing.yaml;
    owner = config.me.user;
    key = "${config.networking.hostName}/cert";
  };

  sops.templates."key.pem" = {
    path = "${syncCfg}/key.pem";
    owner = config.me.user;
    content = ''
      -----BEGIN PRIVATE KEY-----
      ${config.sops.placeholder.sync-key}
      -----END PRIVATE KEY-----
    '';
  };

  sops.templates."cert.pem" = {
    path = "${syncCfg}/cert.pem";
    owner = config.me.user;
    content = ''
      -----BEGIN CERTIFICATE-----
      ${config.sops.placeholder.sync-cert}
      -----END CERTIFICATE-----
    '';
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = config.me.user;
    dataDir = config.me.home;
    configDir = syncCfg;
    guiPasswordFile = config.sops.secrets."syncthing/guipassword".path;
    settings = {
      gui.user = config.me.user;
    };
    relay.enable = false;
    devices = { };
    folders = {
      "Documents" = {
        path = "${config.me.home}/Documents";
      };
    };
  };
}
