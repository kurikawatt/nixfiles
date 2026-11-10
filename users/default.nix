{ pkgs, 
  config,
  lib, 
  inputs,
  ...
}:
{
  config = lib.mkMerge [
    {
      users.mutableUsers = false;

      sops.secrets."${config.me.user}/password".neededForUsers = true;

      users.users."${config.me.user}" = {
        uid = config.me.uid;
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "tss"
        ];
        shell = pkgs.bash;
        home = config.me.home;
        hashedPasswordFile = config.sops.secrets."${config.me.user}/password".path;
        openssh.authorizedKeys.keys = config.me.authorizedSSHKeys;
      };
    }

    (lib.mkIf config.me.enableHomeManager {
        # Home manager 
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users."${config.me.user}" = ./home.nix;
        };
    })
  ];
}
