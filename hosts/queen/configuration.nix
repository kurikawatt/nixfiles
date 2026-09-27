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
  me.host.desktop = "mangonoct";

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
  };

  me.services.sync.enable = true;
  me.services.ollama.enable = true;
  me.services.podman.enable = true;
}
