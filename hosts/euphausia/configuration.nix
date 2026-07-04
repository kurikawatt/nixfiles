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

  # to auto unlock luks part
  boot.initrd.systemd.enable = true;

  hardware.enableRedistributableFirmware = true;

  me.host = {
    isLaptop = true;
    thatComputerIsForSchool = true;
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
  
  me.services.sync.enable = true;
}
