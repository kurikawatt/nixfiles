{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostname = config.networking.hostName;
  fuukaHub = config.me.services.fuuka.hub;

  fuukaPeers = config.me.services.fuuka.peers;
  port = config.me.services.fuuka.hubListenPort;
in
lib.mkIf config.me.services.fuuka.enableHub {
  networking.wireguard.enable = true;

  networking.firewall.allowedUDPPorts = [ port ];

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  networking.firewall.extraCommands = ''
    iptables -A FORWARD -i fuuka0 -o fuuka0 -j ACCEPT
    iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
  '';

  # Looking for my precious secrets
  sops.secrets."fuuka0/${hostname}/privatekey" = { };
  sops.secrets."fuuka0/${fuukaHub}/endpoint" = { };

  networking.wg-quick.interfaces.fuuka0 = {
    autostart = true;
    address = [ fuukaPeers.${hostname}.ipv4 ];
    listenPort = port;
    privateKeyFile = config.sops.secrets."fuuka0/${hostname}/privatekey".path;
    dns = [ "1.1.1.1" "8.8.8.8" ];
    peers = lib.mapAttrsToList
      (name: peerInfo: {
        publicKey = peerInfo.publicKey;
        allowedIPs = [ "${peerInfo.ipv4}/32" ];
        persistentKeepalive = 30;
      })
      fuukaPeers;
  };

  services.nginx = {
    enable = true;
  };

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [ 22 53 80 8080 ];
  networking.firewall.interfaces."fuuka0".allowedUDPPorts = [ 22 53 ];
}
