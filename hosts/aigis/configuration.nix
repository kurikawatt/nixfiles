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
     ../laptop-common/battery.nix
   ];

  boot.initrd.availableKernelModules = [ "tpm_tis" "tpm_crb" ];

  # TPM
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # SecureBoot
    sbctl
    tpm2-tools
    # Plugin TPM for age
    age-plugin-tpm
  ];

  sops.gnupg.sshKeyPaths = [ ];
  sops.age.sshKeyPaths = [ 
    #"/home/kurik/.ssh/id_ed25519" 
  ];
  sops.age = {
    keyFile = "/etc/tpm_age";
    plugins = with pkgs; [ age-plugin-tpm ];
  };
}
