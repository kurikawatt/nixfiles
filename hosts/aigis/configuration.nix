{ config
, lib
, pkgs
, ...
}:
{
  imports = [
    ../../modules/boot/limine.nix
    ../../configuration.nix # Global configuration
    ./hardware-configuration.nix # Hardware specific configuration
    ../../modules/fonts.nix
  ];

  me.host.isLaptop = true;

  boot.initrd.availableKernelModules = [ "tpm_tis" "tpm_crb" ];

  # TPM
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  # Fingerprint
  services.fprintd.enable = true;

  security.pam.services.ly.fprintAuth = false;
  security.pam.services.swaylock.fprintAuth = false;

  environment.systemPackages = with pkgs; [
    # SecureBoot
    sbctl
    tpm2-tools
    # Plugin TPM for age
    age-plugin-tpm
  ];

  sops.gnupg.sshKeyPaths = [ ];
  sops.age.sshKeyPaths = [
    # "/home/kurik/.ssh/id_ed25519" # disabled because I use TPM keys 
  ];
  sops.age = {
    keyFile = "/etc/tpm_age";
    plugins = with pkgs; [ age-plugin-tpm ];
  };

  me.services.fuuka.hub = "metis";
  me.services.sync.enable = true;
  me.desktop = "mango";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    protontricks.enable = true;
  };
}
