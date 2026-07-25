{
  config,
  lib,
  ...
}:
let
  opts = [ 
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=300"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "user"
    "users"
    "uid=${toString config.me.uid}"
    "gid=100" # my group
  ];
in
lib.mkIf config.me.host.samba.mountMonolith {

  sops.secrets = {
    "monolith-credentials" = {
      sopsFile = ../../secrets/smb-Monolith.yaml;
      path = "/etc/smb-secrets-monolith";
      mode = "0600";
    };
  };

  fileSystems = {
    "/media/Monolith" = {
      device = "//192.168.1.13/kurik";
      fsType = "cifs";
      options = opts
      ++ [ "credentials=/etc/smb-secrets-monolith" ];
    };
  };

}