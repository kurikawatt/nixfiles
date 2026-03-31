{ config
, lib
, ...
}:
let
  cfg = config.me;
  inherit (lib) mkOption types;
in
{
  imports = [
    ./fuuka.nix
    ./services.nix
  ];

  options.me = {

    user = mkOption {
      type = types.str;
      default = "kurik";
      description = "User's name";
    };

    home = mkOption {
      type = types.str;
      default = "/home/${cfg.user}";
      description = "User's home dir.";
    };

    enableHomeManager = mkOption {
      type = types.bool;
      default = true;
      description = "Build home using HomeManager";
    };

  };

}

