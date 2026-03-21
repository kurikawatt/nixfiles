{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
     ../../modules/boot/limine.nix
     ../../configuration.nix # Global configuration
     ./hardware-configuration.nix # Hardware specific configuration
     ../../modules/fonts.nix
     ../../users/kurik/kurik.nix
     ../../networks/wifi.nix
     ../../modules/desktop/hyprland.nix
   ];

  # TPM
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };
}
