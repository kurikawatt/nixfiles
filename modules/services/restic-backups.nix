{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.me) home;
in
lib.mkIf (config.me.services.restic.enable) {
  
  sops.secrets."restic/password" = { };

  services.restic.backups."syncthing-monolith" = {
    initialize = true;
    repository = "/media/Monolith/backups/sync";
    passwordFile = config.sops.secrets."restic/password".path;
    paths = [
      "${home}/Documents"
      "${home}/Pictures"
    ];
    exclude = [
      "*/.stfolder"
      "*/.stversions"
      "*/.stignore"
      "*/.thumbnails"
    ];
    timerConfig = {
      OnCalendar = "20:00";
    };
    pruneOpts = [
      "--keep-daily 14"
    ];
  };
}