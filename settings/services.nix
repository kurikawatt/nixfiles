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

  options.me.services.prowlarr = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Prowlarr and usefull programs for gathering content";
    };
  };
}
