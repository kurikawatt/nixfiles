{
  config,
  lib,
  ...
}:
let

  mediaMountpoint = "/media";

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
lib.mkIf config.me.host.mountMedias {

  sops.secrets = {
    "monolith-credentials" = {
      sopsFile = ../../secrets/smb-Monolith.yaml;
      path = "/etc/smb-secrets-monolith";
      mode = "0600";
    };
    "laika-credentials" = {
    sopsFile = ../../secrets/smb-Laika.yaml;
    path = "/etc/smb-secrets-laika";
    mode = "0600";
    };
  };

  fileSystems = {
    "${mediaMountpoint}/Monolith" = {
      device = "//192.168.1.13/kurik";
      fsType = "cifs";
      options = opts
      ++ [ "credentials=/etc/smb-secrets-monolith" ];
    };
    "${mediaMountpoint}/Laika" = {
      device = "//192.168.1.16/Medias";
      fsType = "cifs";
      options = opts
      ++ [ "credentials=/etc/smb-secrets-laika" "vers=3.0" ];
    };
  };

}