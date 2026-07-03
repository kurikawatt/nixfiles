{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./disko.nix
  ];

  me.host = {
    isLaptop = true;
    screen = {
      width = 2560;
      height = 1600;
      scale = 1.5;
    };
    security = {
      secureboot = true;
      tpm2 = true;
      fingerprint = false;
    };
  };

  # Linux Kernel Latest
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.systemd.enable = true;

  hardware.enableRedistributableFirmware = true;

  me.services.sync.enable = true;
}
