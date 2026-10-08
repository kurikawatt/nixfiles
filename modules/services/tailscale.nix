{
  config,
  lib,
  pkgs,
  ...
}:
let 
  inherit (config.me.services) tailscale;
in
lib.mkIf (tailscale.enable) {

  services.tailscale = {
    enable = true;
    interfaceName = tailscale.interfaceName;
  };

  networking.firewall.interfaces."ts0".allowedTCPPorts =[
    22
  ];

  networking.firewall.interfaces."ts0".allowedUDPPorts =[
    22
  ];
}