{ config
, lib
, pkgs
, modulesPath
, ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
    ../../configuration.nix # Global configuration
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot.initrd.availableKernelModules = [ "ata_piix" "virtio_pci" "virtio_scsi" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  sops.age.sshKeyPaths = [ "/home/kurik/.ssh/id_ed25519" ];

  me.enableHomeManager = false;
  me.services.fuuka.enable = false;
  me.services.fuuka.enableHub = true;
}
