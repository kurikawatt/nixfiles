{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./disko.nix
  ];

  me.host.bootloader = "systemd-boot";

  me.desktop = "none";
  me.enableHomeManager = false;

  me.host.samba.mountMonolith = true;

  me.services = {
    fuuka.enable = true;
    jellyfin.enable = true;
    prowlarr = {
      enable = true;
    };
  };

  hardware.graphics.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.nvidia = {
    modesetting.enable = true; # required
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # for GTX 1060
    nvidiaSettings = true; # nvidia-settings
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  services.jellyfin = {
    transcoding = {
      enableHardwareEncoding = true;
      maxConcurrentStreams = 2;
      hardwareEncodingCodecs = {
        hevc = true;
        av1 = true;
      };
      hardwareDecodingCodecs = {
        av1 = true;
        h264 = true;
        hevc = true;
        mpeg2 = true;
        vc1 = true;
        vp8 = true;
        vp9 = true;
        
        hevc10bit = false;
        hevcRExt10bit = false;
        hevcRExt12bit = false;
      };
    };
  };
}
