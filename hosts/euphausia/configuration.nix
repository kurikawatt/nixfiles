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
    gpuType = "amd";
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
  
  me.services = {
    sync.enable = true;
    ollama.enable = true;
  };

  # Framework specific things
  hardware.fw-fanctrl = {
    enable = true;                         # This is needed to enable the service
    config = {                             # This option is only needed if you want to add additional strategies
      defaultStrategy = "base";
      strategyOnDischarging = "laziest";   # Must not be set
      strategies = {
        "base" = {
          fanSpeedUpdateFrequency = 5;
          movingAverageInterval = 40;
          speedCurve = [
            { temp = 45; speed = 0; }
            { temp = 65; speed = 15; }
            { temp = 70; speed = 25; }
            { temp = 85; speed = 35; }
          ];
        };
      };
    };
    disableBatteryTempCheck = false;
  };
}
