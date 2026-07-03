{
  lib,
  config,
  ...
}:
lib.mkIf config.me.host.isLaptop {
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}
