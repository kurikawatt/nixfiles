{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.me.services) jellyfin;
in
lib.mkIf jellyfin.enable {
  
  services.jellyfin.enable = true;
 
  # To be able to use Hardware
  # + prowdl bc it may be usefull
  users.users.jellyfin.extraGroups = [
    "render"
    "video"
    "prowdl"
  ];

  networking.firewall.allowedTCPPorts = [
    8096 # http
  ];

  services.tailscale.serve.services."jellyfin" = {
    endpoints = {
      "tcp:80" = "http://127.0.0.1:8096";
    };
    advertised = true;
  };
}
