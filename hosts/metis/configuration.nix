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

  sops.age.sshKeyPaths = [
    "/home/kurik/.ssh/id_ed25519"
  ];

  me.enableHomeManager = false;

  # services
  me.services.jellyfin.enable = true;
  me.services.prowlarr.enable = true;
}
