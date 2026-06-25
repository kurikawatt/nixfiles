{ config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/boot/systemd-boot.nix
    ../../configuration.nix # Global configuration
    ../../modules/fonts.nix
  ];

  disko.devices.disk.main.device = "/dev/sda";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
      libvdpau-va-gl
    ];
  };

  sops.secrets."credentials" = {
    sopsFile = ../../secrets/smb-Monolith.yaml;
    path = "/etc/smb-secrets";
    mode = "0600";
  };

  fileSystems."/media/Monolith" = {
    device = "//192.168.1.13/kurik";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
      in
      [ "${automount_opts},credentials=/etc/smb-secrets,uid=1000,gid=100,dir_mode=0777,file_mode=0777,noperm" ];
  };

  fileSystems."/media/Eva02" = {
    device = "/dev/disk/by-label/Eva02";
    fsType = "ext4";
    options = [ "auto" "nofail" ];
  };

  sops.age.sshKeyPaths = [
    "/home/kurik/.ssh/id_ed25519"
  ];

  me.desktop = "none";
  me.enableHomeManager = false;

  # services
  me.services.jellyfin.enable = true;

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

  me.services.prowlarr.enable = true;
  me.services.sync.enable = true;

  me.services.fuuka.enable = false;
  me.services.fuuka.enableHub = true;
}
