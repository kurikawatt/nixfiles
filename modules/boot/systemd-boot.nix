{
  config,
  lib,
  ...
}:
lib.mkIf (config.me.host.bootloader == "systemd-boot") {
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    configurationLimit = 5;
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
