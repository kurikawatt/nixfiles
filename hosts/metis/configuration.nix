{ config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot/systemd-boot.nix
    ../../configuration.nix # Global configuration
    ../../modules/fonts.nix
    ../../users/kurik/kurik.nix
  ];

  sops.age.sshKeyPaths = [
    "/home/kurik/.ssh/id_ed25519"
  ];

  me.enableHomeManager = false;
}
