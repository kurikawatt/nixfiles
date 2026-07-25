{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (config.me.services) attic-server;
  inherit (config.me.services.fuuka) peers;

  url = "http://${peers.metis.ipv4}:${toString attic-server.port}";
in
{
  #sops.secrets."attic-tokens/compendium" = {
  #  restartUnits = [ "attic-watch-store.service" ];
  #};

  # Use my attic cache for faster rebuild
  #nix.settings = {
  #  substituters = [
  #    "${url}/compendium"
  #  ];
  #  trusted-public-keys = [
  #    "compendium:sUVIH8kmLdxpo5pTLnlSaOcR/dNP4dTjDwanQFOKYV4="
  #  ];
  #};

  environment.systemPackages = with pkgs; [ attic-client ];

  # Almost identical to ayko's (0x7E on codeberg) service, just
  # changed server & cache names
  #systemd.services.attic-watch-store = {
  #  description = "Attic watch store";
  #  wantedBy = [ "multi-user.target" ];
  #  environment.ATTIC_SERVER = url;
  #  serviceConfig = {
  #    ExecStartPre = pkgs.writeShellScript "attic-login" ''
  #      TOKEN=$(cat ${config.sops.secrets."attic-tokens/compendium".path})
  #      ${lib.getExe pkgs.attic-client} login metis ${url} $TOKEN
  #    '';
  #    ExecStart = "${lib.getExe pkgs.attic-client} watch-store compendium";
  #    Restart = "always";
  #    RestartSec = 3;
  #    KillMode = "control-group";
  #    KillSignal = "SIGTERM";
  #  };
  #};
}