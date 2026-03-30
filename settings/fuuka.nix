{ config
, lib
, ...
}:
let
  inherit (lib) mkOption types;

  peer = {
    options = {
      ipv4 = mkOption {
        type = types.str;
        default = "172.16.195.0";
        description = "Peer IPv4 on fuuka";
      };
      publicKey = mkOption {
        type = types.str;
        default = "";
        description = "WireGuard's Public Key of peer";
      };
    };
  };
in
{
  options.me.services = {
    fuuka = {

      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Connect to fuuka (my VPN)";
      };

      hub = mkOption {
        type = types.str;
        default = "chord";
        description = "Define which peer is the hub";
      };

    };
  };

  options.me.services.fuuka.peers = mkOption {
    description = "List of all Peers on fuuka";
    type = types.attrsOf (types.submodule peer);
    default = {
      chord = {
        ipv4 = "172.16.195.1";
        publicKey = "sMoQytVwjqnxSq+MB+7ori5HZr32G866femOjuD17C0=";
      };
      aigis = {
        ipv4 = "172.16.195.12";
        publicKey = "NoMBDUInInr8FOij+5yb81WkVveSulARGKZSZgy/Rl0=";
      };
      queen = {
        ipv4 = "172.16.195.13";
        publicKey = "OOkD3dCKw7YOO99cCEQOOWoxwTnYLGZ/eebUG9hpuGk=";
      };
    };
  };
}
