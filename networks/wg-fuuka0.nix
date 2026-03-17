{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostname = config.networking.hostName; 
  fuukaHub = "chord";

  peers = {
    chord = {
      ipv4 = "172.16.195.1";
      publickey = "sMoQytVwjqnxSq+MB+7ori5HZr32G866femOjuD17C0=";
    };
    aigis = {
      ipv4 = "172.16.195.12";
      publickey = "NoMBDUInInr8FOij+5yb81WkVveSulARGKZSZgy/Rl0=";
    };
    queen = {
      ipv4 = "172.16.195.13";
      publickey = "OOkD3dCKw7YOO99cCEQOOWoxwTnYLGZ/eebUG9hpuGk=";
    };
  };
in
{
  config.networking.wireguard.enable = true;

  # Looking for my precious secrets
  config.sops.secrets."fuuka0/${hostname}/privatekey" = {};
  config.sops.secrets."fuuka0/${fuukaHub}/endpoint" = {};

  config.sops.templates."fuuka0.conf".content =
  ''
[Interface]
Address = ${peers.${hostname}.ipv4}/32
PrivateKey = ${config.sops.placeholder."fuuka0/${hostname}/privatekey"}

[Peer]
PublicKey = ${peers.${fuukaHub}.publickey}
AllowedIPs = 172.16.195.0/24
Endpoint = ${config.sops.placeholder."fuuka0/${fuukaHub}/endpoint"}
  '';

  config.networking.wg-quick.interfaces.fuuka0 = {
    autostart = true;
    configFile = config.sops.templates."fuuka0.conf".path;
  };
}
