{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.me.host = {

    isLaptop = mkOption {
      type = types.bool;
      default = false;
      description = "Enable laptop specific configuration";
    };

    bootloader = mkOption {
      type = types.enum [ "limine" "systemd-boot" ];
      default = "limine";
      description = "Define which bootloader is used";
    };

    desktop = mkOption {
        type = types.enum [ "none" "mango" ];
        default = "mango";
        description = "";
    };

    autoUpgrade = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "";
      };
      time = mkOption {
        type = types.str;
        default = "03:14"; # pi
        description = "Time for auto update";
      };
      rebootWindow = {
        begin = mkOption {
          type = types.str;
          default = "04:00";
          description = "Reboot window begin time";
        };
        end = mkOption {
          type = types.str;
          default = "05:00";
          description = "Reboot window end time";
        };
      };
    };

    enablePlymouth = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Plymouth splash";
    };

    samba = {
      mountMonolith = mkOption {
        type = types.bool;
        default = false;
        description = "Mount Samba share Monolith";
      };
      mountLaika = mkOption {
        type = types.bool;
        default = false;
        description = "Mount Samba share Laika";
      };
    };

    # obviously that GPU is for school !
    thatComputerIsForSchool = mkOption {
      type = types.bool;
      default = false;
      description = "";
    };

    gpuType = mkOption {
      type = types.enum [ "none" "intel" "amd" "nvidia" ];
      default = "none";
      description = "GPU Type";
    };

    screen = {
      width = mkOption {
        type = types.int;
        default = 1920;
        description = "Screen width";
      };
      height = mkOption {
        type = types.int;
        default = 1080;
        description = "Screen height";
      };
      scale = mkOption {
        type = types.float;
        default = 1.0;
        description = "Screen scale";
      };
    };

    security = {

      secureboot = mkOption {
        type = types.bool;
        default = false;
        description = "Host support of SecureBoot";
      };

      tpm2 = mkOption {
        type = types.bool;
        default = false;
        description = "Host support of TPM2";
      };

      fingerprint = mkOption {
        type = types.bool;
        default = false;
        description = "Host support of fingerprint auth";
      };

    };

  };
}
