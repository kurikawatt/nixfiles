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
  };
}
