{ pkgs
, config
, lib
, ...
}:
{
  config = lib.mkMerge [
    {
      sops.secrets."${config.me.user}/password".neededForUsers = true;

      users.users."${config.me.user}" = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "tss"
        ];
        shell = pkgs.bash;
        home = config.me.home;
        hashedPasswordFile = config.sops.secrets."${config.me.user}/password".path;
        openssh.authorizedKeys.keys = [ ];
      };
    }

    (lib.mkIf config.me.enableHomeManager {
      home-manager.users."${config.me.user}" = ./home.nix;
    })
  ];
}
