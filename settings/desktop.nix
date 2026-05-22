{ config
, lib
, ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.me = {
    desktop = mkOption
      {
        type = types.enum [ "hyprland" "noctalia" "mango" ];
        default = "noctalia";
        description = "";
      };
  };
}
