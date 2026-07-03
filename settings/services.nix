{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.me.services.fuuka-dns = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable DNS for fuuka";
    };
  };

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

  options.me.services.sync = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Syncthing";
    };
  };

  options.me.services.attic-server = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Atticd to serve cache";
    };
    port = mkOption {
      type = types.int;
      default = 8080;
      description = "Atticd port";
    };
    cacheLocation = mkOption {
      type = types.str;
      default = "/srv/attic";
      description = "Attic cache location";
    };
  };
}
