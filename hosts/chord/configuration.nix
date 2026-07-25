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

  me.services = {
    fuuka.enable = true;
  };

  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true; # required
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # for GTX 1060
    nvidiaSettings = true; # nvidia-settings
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  services.jellyfin = {
    hardwareAcceleration = {
      enable = true;
      device = "/dev/dri/renderD128";
    };

    transcoding = {
      enableHardwareEncoding = true;
      maxConcurrentStreams = 2;
      hardwareEncodingCodecs = {
        hevc = true;
        av1 = false;
      };
      hardwareDecodingCodecs = {
        h264 = true;
        hevc = true;
        mpeg2 = true;
        vc1 = true;
        vp8 = true;
        
        vp9 = false;
        av1 = false;
        hevc10bit = false;
        hevcRExt10bit = false;
        hevcRExt12bit = false;
      };
    };
  };
}
