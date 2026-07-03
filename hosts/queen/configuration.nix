{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix # Hardware specific configuration
    ./drivers.nix
  ];

  me.host.bootloader = "systemd-boot";
  me.host.mountMedias = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    protontricks.enable = true;
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
  };

  me.services.sync.enable = true;
}
