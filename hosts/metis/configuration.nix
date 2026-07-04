{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.attic.nixosModules.atticd
    ./disko.nix
  ];

  me.host.bootloader = "systemd-boot";
  me.host.mountMedias = true;

  me.desktop = "none";
  me.enableHomeManager = false;

  me.services = {
    jellyfin.enable = true;
    attic-server.enable = true;
    prowlarr.enable = true;
    sync.enable = true;
    fuuka.enable = false;
    fuuka.enableHub = true;
    ntfy.enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };
  
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
