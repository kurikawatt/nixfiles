{ config
, lib
, ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.me.services.jellyfin = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Jellyfin Server";
    };
  };
}
