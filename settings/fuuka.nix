{ config
, lib
, ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.me.services = {
    fuuka = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Connect to fuuka (my VPN)";
      };
    };
  };
}
