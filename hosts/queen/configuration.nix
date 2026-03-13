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
}
