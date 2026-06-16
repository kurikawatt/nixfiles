{ config
, lib
, pkgs
, ...
}:
let
  hostname = config.networking.hostName;
  fuukaHub = config.me.services.fuuka.hub;

  peers = config.me.services.fuuka.peers;
in
lib.mkIf config.me.services.fuuka.enable {
  networking.wireguard.enable = true;

  # Looking for my precious secrets
  sops.secrets."fuuka0/${hostname}/privatekey" = { };
  sops.secrets."fuuka0/${fuukaHub}/endpoint" = { };

  sops.templates."fuuka0.conf".content =
    ''
      [Interface]
      Address = ${peers.${hostname}.ipv4}/24
      PrivateKey = ${config.sops.placeholder."fuuka0/${hostname}/privatekey"}

      [Peer]
      PublicKey = ${peers.${fuukaHub}.publicKey}
      AllowedIPs = 172.16.195.0/24
      Endpoint = ${config.sops.placeholder."fuuka0/${fuukaHub}/endpoint"}
      PersistentKeepAlive = 30
    '';

  networking.wg-quick.interfaces.fuuka0 = {
    autostart = true;
    configFile = config.sops.templates."fuuka0.conf".path;
  };

  networking.hosts = lib.listToAttrs
    (
      lib.mapAttrsToList
        (name: peer: {
          name = peer.ipv4;
          value = [ "${name}.fuuka" ];
        })
        peers
    );

  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
    settings = {
      address = lib.mapAttrsToList (name: peer: 
        "/${name}.fuuka/${peer.ipv4}"
      ) peers;
      interface = "fuuka0";
      bind-interfaces = true;
    };
  };
}
