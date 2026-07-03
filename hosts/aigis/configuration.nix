{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  me.host = {
    isLaptop = true;
    security = {
      secureboot = true;
      tpm2 = true;
      fingerprint = true;
    };
  };

  me.services.fuuka.hub = "metis";
  me.services.sync.enable = true;
  me.desktop = "mango";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    protontricks.enable = true;
  };
}
