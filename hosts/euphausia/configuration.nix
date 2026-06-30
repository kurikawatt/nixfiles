{ config
, lib
, pkgs
, inputs
, ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ../../networks/wifi.nix
    ./disko.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  boot.initrd.availableKernelModules = [ "tpm_tis" "tpm_crb" "tpm_tis_core" ];

  hardware.enableRedistributableFirmware = true;

  # Linux Kernel Latest
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Auto open luks device
  boot.initrd.systemd.enable = true;

  # TPM
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  # Fingerprint
  services.fprintd.enable = false;

  security.pam.services.ly.fprintAuth = false;

  environment.systemPackages = with pkgs; [
    # SecureBoot
    sbctl
    tpm2-tools
    # Plugin TPM for age
    age-plugin-tpm
    age
  ];

  sops.gnupg.sshKeyPaths = [ ];
  sops.age.sshKeyPaths = [
    #"/home/kurik/.ssh/id_ed25519" # disabled because I use TPM keys 
  ];
  sops.age = {
    keyFile = "/etc/tpm_age";
    plugins = with pkgs; [ age-plugin-tpm ];
  };

  me.host.isLaptop = true;

  me.host.screen = {
    width = 2560;
    height = 1600;
    scale = 1.5;
  };

  me.services.fuuka.hub = "metis";
  me.services.sync.enable = true;
}
