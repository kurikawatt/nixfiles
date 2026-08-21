{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.me = {

    user = mkOption {
      type = types.str;
      default = "user";
      description = "User's name";
    };

    uid = mkOption {
      type = types.int;
      default = 1000;
      description = "User uid";
    };

    home = mkOption {
      type = types.str;
      default = "/home/${config.me.user}";
      description = "User's home dir.";
    };

    mail = mkOption {
      type = types.str;
      default = "${config.me.user}@${config.networking.hostName}";
      description = "User's public mail";
    };

    enableHomeManager = mkEnableOption "Enable Home-Manager for this user";

    authorizedSSHKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Authorized SSH Key for this user";
    };

  };

}

