{ config
, lib
, pkgs
, ...
}:
{
  imports = [
    ../../configuration.nix # Global configuration
    ./hardware-configuration.nix # Hardware specific configuration
    ./drivers.nix
  ];

  me.host.bootloader = "systemd-boot";

  sops.age.sshKeyPaths = [ "/home/kurik/.ssh/id_ed25519" ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    protontricks.enable = true;
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
  };

  me.services.sync.enable = true;
}
