{
  pkgs,
  config,
  lib,
  ...
}:
{
config = lib.mkMerge [
  {
    sops.secrets."kurik/password".neededForUsers = true;
    
    users.users.kurik = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "tss"
      ];
      shell = pkgs.bash;
      home = "/home/kurik";
      hashedPasswordFile = config.sops.secrets."kurik/password".path;
      openssh.authorizedKeys.keys = [];
    };
  }

  (lib.mkIf config.me.enableHomeManager {
    home-manager.users.kurik = ./home.nix;
  })
];
}
