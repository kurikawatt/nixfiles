{ config
, lib
, ...
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

    enablePlymouth = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Plymouth splash";
    };

    mountMedias = mkOption {
      type = types.bool;
      default = false;
      description = "Mount Samba share at home";
    };

    screen = {
      width = mkOption {
        type = types.int;
        default = 1920;
        description = "";
      };
      height = mkOption {
        type = types.int;
        default = 1080;
        description = "";
      };
      scale = mkOption {
        type = types.float;
        default = 1.0;
        description = "";
      };
    };

  };
}
