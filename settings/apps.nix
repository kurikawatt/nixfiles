{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.me.apps = {

    retro.retroarch = {
      enable = mkEnableOption "";
    };

  };

}

