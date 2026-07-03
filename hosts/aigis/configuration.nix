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
  ];

  me.host = {
    isLaptop = true;
    security = {
      secureboot = true;
      tpm2 = true;
      fingerprint = true;
    };
  };

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
