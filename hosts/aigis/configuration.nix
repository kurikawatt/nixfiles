{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  me.host = {
    isLaptop = true;
    isDesktop = true;
    security = {
      secureboot = true;
      tpm2 = true;
      fingerprint = true;
    };
  };

  me.services.sync.enable = true;
}
