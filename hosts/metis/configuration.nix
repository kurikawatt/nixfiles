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
    ../../users/kurik/kurik.nix
  ];

  disko.devices.disk.main.device = "/dev/sda";

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
    fstype = "ext4";
    options = [ "fmask=0777" "dmask=0777" ];
  };

  sops.age.sshKeyPaths = [
    "/home/kurik/.ssh/id_ed25519"
  ];

  me.enableHomeManager = false;

  # services
  me.services.jellyfin.enable = true;
  me.services.prowlarr.enable = true;
}
