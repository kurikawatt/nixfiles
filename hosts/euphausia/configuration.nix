{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./disko.nix
  ];

  # Linux Kernel Latest
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd = {
    availableKernelModules = [ "tpm_tis" "tpm_crb" "tpm_tis_core" ];
    systemd.enable = true;
  };

  hardware.enableRedistributableFirmware = true;

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
    sbctl
    tpm2-tools
    age-plugin-tpm
    age
  ];

  sops.age = {
    keyFile = "/etc/tpm_age";
    plugins = with pkgs; [ age-plugin-tpm ];
  };

  # --- Host specific configuration --
  me.host = {
    isLaptop = true;
    screen = {
      width = 2560;
      height = 1600;
      scale = 1.5;
    };
  };

  me.services.sync.enable = true;
}
