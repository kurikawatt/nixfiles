{ config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot/systemd-boot.nix
    ../../configuration.nix # Global configuration
    ../../modules/fonts.nix
    ../../users/kurik/kurik.nix
  ];

  config.me.enableHomeManager = false;
  config.me.services.fuuka.enable = false;

  config.users.users.kurik.initialPassword = "password";

}
