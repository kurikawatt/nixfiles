{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.attic.nixosModules.atticd
    ./disko.nix
  ];

  me.host.bootloader = "systemd-boot";
  me.host.samba.mountMonolith = true;

  me.host.autoUpgrade.enable = true;

  me.host.desktop = "none";
  me.enableHomeManager = lib.mkForce false;

  me.services = {
    attic-server.enable = true;
    sync.enable = true;
    fuuka.enable = lib.mkForce false;
    fuuka.hub.enable = true;
    restic.enable = true;

    podman.enable = true;
  };
}
