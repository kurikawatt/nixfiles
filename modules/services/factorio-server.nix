{
  config,
  lib,
  pkgs,
  ...
}:
let

in
lib.mkIf config.me.services.factorio-server.enable {

  services.factorio = {
    enable = true;
    openFirewall = true;
  };

}