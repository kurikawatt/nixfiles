{
  config,
  lib,
  ...
}:
let
  inherit (config.me.host) autoUpgrade;
in
{
  
  system.autoUpgrade = {
    enable = autoUpgrade.enable;
    dates = autoUpgrade.time;
    allowReboot = true;
    rebootWindow = {
      lower = autoUpgrade.rebootWindow.begin;
      upper = autoUpgrade.rebootWindow.end;
    };
    runGarbageCollection = true;
  };

}