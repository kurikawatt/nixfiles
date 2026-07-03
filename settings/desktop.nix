{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.me = {
    desktop = mkOption
      {
        type = types.enum [ "none" "mango" ];
        default = "mango";
        description = "";
      };
  };
}
