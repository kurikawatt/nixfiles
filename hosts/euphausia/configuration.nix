{ config
, lib
, pkgs
, inputs
, ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ../../modules/boot/limine.nix
    ../../configuration.nix # Global configuration
    ../../modules/fonts.nix
    ../../networks/wifi.nix
    #../../modules/desktop/hyprland.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
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

  environment.systemPackages = with pkgs; [
    # SecureBoot
    sbctl
    tpm2-tools
    # Plugin TPM for age
    age-plugin-tpm
  ];

  sops.gnupg.sshKeyPaths = [ ];
  sops.age.sshKeyPaths = [
    "/home/kurik/.ssh/id_ed25519" # disabled because I use TPM keys 
  ];
  #sops.age = {
  #  keyFile = "/etc/tpm_age";
  #  plugins = with pkgs; [ age-plugin-tpm ];
  #};

  me.services.fuuka.hub = "violet";
}
