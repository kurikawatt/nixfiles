{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
lib.mkIf config.me.host.thatComputerIsForSchool {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    protontricks.enable = true;
  };
}
