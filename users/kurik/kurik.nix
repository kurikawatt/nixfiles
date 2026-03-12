{
  pkgs,
  config,
  ...
}:
{
  sops.secrets."kurik/password".neededForUsers = true;

  users.users.kurik = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.bash;
    home = "/home/kurik";
    hashedPasswordFile = config.sops.secrets."kurik/password".path;
  };

  home-manager.users.kurik = ./home.nix;

}
