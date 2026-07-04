{
  pkgs,
  config,
  ...
}:
let
  inherit (config.me.services) attic-server;
  inherit (config.me.services.fuuka) peers;
in
{
  # Use my attic cache for faster rebuild
  nix.settings = {
    substituters = [
      "http://${peers.metis.ipv4}:${toString attic-server.port}/compendium"
    ];
    trusted-public-keys = [
      "compendium:sUVIH8kmLdxpo5pTLnlSaOcR/dNP4dTjDwanQFOKYV4="
    ];
  };

  environment.systemPackages = with pkgs; [ attic-client ];
}