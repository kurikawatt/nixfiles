{
  config,
  lib,
  pkgs,
  ...
}:
let
  syncCfg = "${config.me.home}/.config/syncthing";
  inherit (config.me.services) fuuka;
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
    owner = config.me.user;
    content = ''
      -----BEGIN PRIVATE KEY-----
      ${config.sops.placeholder.sync-key}
      -----END PRIVATE KEY-----
    '';
  };

  sops.templates."cert.pem" = {
    owner = config.me.user;
    content = ''
      -----BEGIN CERTIFICATE-----
      ${config.sops.placeholder.sync-cert}
      -----END CERTIFICATE-----
    '';
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = false;

    guiAddress = "0.0.0.0:8384";

    user = config.me.user;
    dataDir = config.me.home;
    configDir = syncCfg;

    key = config.sops.templates."key.pem".path;
    cert = config.sops.templates."cert.pem".path;

    guiPasswordFile = config.sops.secrets."syncthing/guipassword".path;
    relay.enable = false;

    settings = {
      gui.user = config.me.user;

      options = {
        relaysEnabled = false;
        urAccepted = -1;
      };

      devices = config.me.services.sync.devices;

      folders = config.me.services.sync.folders;
    };

  };

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.interfaces."fuuka0".allowedUDPPorts = [ 22000 21027 ];
}
