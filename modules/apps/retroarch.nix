{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.me.apps.retro.retroarch.enable {

  environment.systemPackages = [
    (pkgs.retroarch.withCores (cores: [
      cores.mgba # GBA
      cores.melonds # DS
      cores.pcsx2 # PS2
    ]))
  ];

}
