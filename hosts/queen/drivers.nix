{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.boot.kernelPackages) nvidiaPackages;
  branch = "production";
in 
{
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true; # required
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    branch = branch;
    package = nvidiaPackages.${config.hardware.nvidia.branch};
    nvidiaSettings = true; # nvidia-settings
  };
}
