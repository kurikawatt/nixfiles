{
  config,
  lib,
  ...
}:
let
  inherit (config.me.services) attic-server;
in
lib.mkIf attic-server.enable {
  services.atticd = {
    enable = false;

    environmentFile = "/etc/atticd.env";

    settings = {
      listen = "[::]:${toString attic-server.port}";

      jwt = { };

      storage = {
        type = "local";
        path = attic-server.cacheLocation;
      };

      chunking = {
        nar-size-threshold = 64 * 1024; # 64 KiB
        min-size = 16 * 1024; # 16 KiB
        avg-size = 64 * 1024; # 64 KiB
        max-size = 256 * 1024; # 256 KiB
      };
    };
  };
}