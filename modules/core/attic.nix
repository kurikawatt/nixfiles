{
  pkgs,
  config,
  ...
}:
let
  inherit (config.me.services) attic-server;
in
{
  # Use my attic cache for faster rebuild
  nix.settings = {
    substituters = 
      if attic-server.enable then [ "http://localhost:${toString attic-server.port}/compendium" ]
      else [ "http://172.16.195.2:8080/compendium" ];
    trusted-public-keys = [
      "compendium:sUVIH8kmLdxpo5pTLnlSaOcR/dNP4dTjDwanQFOKYV4="
    ];
  };

  environment.systemPackages = with pkgs; [ attic-client ];
}