{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
     ../../modules/boot/systemd-boot.nix
     ../../configuration.nix # Global configuration
     ./hardware-configuration.nix # Hardware specific configuration
     ./drivers.nix
     ../../modules/fonts.nix
     ../../users/kurik/kurik.nix
     ../../modules/desktop/hyprland.nix
   ];

   sops.age.sshKeyPaths = [ "/home/kurik/.ssh/id_ed25519" ];

   programs.steam = {
     enable = true;
     remotePlay.openFirewall = false;
     dedicatedServer.openFirewall = false;
   };
}
