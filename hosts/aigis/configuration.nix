{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/boot/limine.nix
    ../../configuration.nix # Global configuration
    ./hardware-configuration.nix # Hardware specific configuration
    ../../modules/fonts.nix
  ];

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
