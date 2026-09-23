{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (config.me.services.tailscale.enable) {

  services.tailscale = {
    enable = true;
    interfaceName = "ts0";
  };

}