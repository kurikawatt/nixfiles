{ config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./disko.nix
    ../../modules/boot/systemd-boot.nix
    ../../configuration.nix # Global configuration
    ../../users/kurik/kurik.nix
    ../../networks/hub-fuuka0.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  sops.age.sshKeyPaths = [ "/home/kurik/.ssh/id_ed25519" ];

  me.enableHomeManager = false;
  me.services.fuuka.enable = false;
  me.services.fuuka.enableHub = true;
}
