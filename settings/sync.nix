{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;

  device = {
    options = {
      name = mkOption {
        type = types.str;
        default = null;
        description = "Device name";
      };
      id = mkOption {
        type = types.str;
        default = null;
        description = "Device ID";
      };
      autoAcceptFolders = mkOption {
        type = types.bool;
        default = true;
        description = "Auto accept new folders";
      };
    };
  };

  folder = {
    options = {
      path = mkOption {
        type = types.str;
        default = null;
        description = "Sync folder path";
      };
      devices = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Sync folder across these devices";
      };
    };
  };

  syncDevices = lib.mapAttrsToList (_: device: device.name) config.me.services.sync.devices;
in
{

  options.me.services.sync = {
    
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Syncthing";
    };

    devices = mkOption {
      description = "All Syncthing devices";
      type = types.attrsOf (types.submodule device);
      default = {
        metis = {
          name = "metis";
          id = "N7W6UEJ-3TG5IHS-GGJBYCT-QD4LE5H-TDUYEAK-INBT32R-OVF6QR6-O3ED6AV";
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
    };

    folders = mkOption {
      description = "";
      type = types.attrsOf (types.submodule folder);
      default = {
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
}
