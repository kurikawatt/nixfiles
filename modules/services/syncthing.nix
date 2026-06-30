{ config
, lib
, pkgs
, ...
}:
let
  syncCfg = "${config.me.home}/.config/syncthing";
  syncServ = "metis";
  syncDevices = if config.networking.hostName == syncServ then [ "queen" "aigis" "euphausia" ] else [ syncServ ];

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

    guiAddress = if config.networking.hostName == "metis" then "${fuuka.peers.metis.ipv4}:8384"
                 else "127.0.0.1:8384";

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

      devices = {
        metis = {
          name = "metis";
          id = "N7W6UEJ-3TG5IHS-GGJBYCT-QD4LE5H-TDUYEAK-INBT32R-OVF6QR6-O3ED6AV";
          autoAcceptFolders = true;
        };
        queen = {
          name = "queen";
          id = "RKCALQB-2PRNDQC-LSMIPLG-AZVEZCM-FYJSESK-XC67ENH-ZS55A47-CQCI5AX";
        };
        aigis = {
          name = "aigis";
          id = "CZVQROX-5U4FHMK-CU6AFJ3-MXVGLPA-NIVWTPM-3O6TNFQ-P7LIZ2N-JVNSJQH";
        };
        euphausia = {
          name = "euphausia";
          id = "E5HZE6F-QB5NWAK-4F7OMY5-NICYBXO-EXB3OOT-JRYLQSG-GWCVOV2-PGRHEQH";
        };
      };

      folders = {
        "Documents" = {
          path = "${config.me.home}/Documents";
          devices = syncDevices;
        };
        "Pictures" = {
          path = "${config.me.home}/Pictures";
          devices = syncDevices;
        };
        "Emu" = {
          path = "${config.me.home}/Emu";
          devices = syncDevices;
        };
      };
    };

  };

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.interfaces."fuuka0".allowedUDPPorts = [ 22000 21027 ];
}
