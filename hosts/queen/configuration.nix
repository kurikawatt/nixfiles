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
  me.host.samba.mountMonolith = true;
  me.host.thatComputerIsForSchool = true;
  me.host.gpuType = "nvidia";

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
  };

  me.services.sync.enable = true;
  me.services.ollama.enable = true;
}
