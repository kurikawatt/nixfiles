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
  me.host.isDesktop = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
  };

  me.services = {
    sync.enable = true;
    ollama.enable = true;
    podman.enable = true;
  };

  me.host.specificPackages = [
    azahar
    deluge
    gimp
    archipelago
    poptracker
    prismlauncher
  ];
}
