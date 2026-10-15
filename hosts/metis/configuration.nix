{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./disko.nix
  ];

  me.host.bootloader = "systemd-boot";
  me.host.samba.mountMonolith = true;

  me.host.autoUpgrade.enable = true;

  me.host.desktop = "none";
  me.enableHomeManager = lib.mkForce false;

  me.services = {
    sync.enable = true;
    restic.enable = true;

    podman.enable = true;
  };

  #services.tailscale.serve.enable = true;
}
