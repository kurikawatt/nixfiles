{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) types;

  mango_base_cfg = config.programs.mango;
  mango_base_lib = import (inputs.mangowm.outPath + "/nix/lib.nix") lib;

  settings_type =
    with types;
    let
      value_type = nullOr (oneOf [
        bool
        int
        float
        str
        path
        (attrsOf value_type)
        (listOf value_type)
      ]);
    in
    value_type;

  config_to_text = mango_base_lib.toMango {
    topCommandsPrefixes = mango_base_cfg.topPrefixes;
    bottomCommandsPrefixes = mango_base_cfg.bottomPrefixes;
  } mango_base_cfg.settings
  + lib.optionalString (mango_base_cfg.autostart_sh != "")
  ''
    exec_once=/etc/mango/autostart.sh
  '';

  generate_conf = pkgs.runCommand "mango.conf" { } ''
    cp ${pkgs.writeText "mango.conf" config_to_text} "$out"
    ${mango_base_cfg.package}/bin/mango -c "$out" -p || exit 1
  '';

  write_autostart_sh = pkgs.writeShellScript "autostart.sh"
    mango_base_cfg.autostart_sh;
in
{
  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  options.programs.mango = {

    autostart_sh = lib.mkOption {
      type = types.lines;
      default = "";
      description = "Commands to run at mango startup";
    };

    settings = lib.mkOption {
      type = settings_type;
      default = { };
      description = "Mango settings, as you write them in config.conf";
    };

    topPrefixes = lib.mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "";
    };

    bottomPrefixes = lib.mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "";
    };
  };

  config = lib.mkIf mango_base_cfg.enable {
    environment.etc = {
      "mango/config.conf".source = generate_conf;
      "mango/autostart.sh" = lib.mkIf (mango_base_cfg.autostart_sh != "") {
        source = write_autostart_sh;
        mode = "0755";
      };
    };
  };

}