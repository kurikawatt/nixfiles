{
  config,
  lib,
  ...
}:
let
  host = config.networking.hostName;
  port = config.me.services.navidrome.port;
  data_dir = config.me.services.navidrome.data_dir;
in
lib.mkIf config.me.services.navidrome.enable {

  services.navidrome = {
    enable = true;

    settings = {
      Address = "${config.me.services.fuuka.peers.${host}.ipv4}";
      Port = port;
      MusicFolder = "${data_dir}/music";
      PlaylistsPath = "${data_dir}/playlists";
      EnableSharing = false;
    };
  };

  networking.firewall.interfaces."fuuka0".allowedTCPPorts = [ port ];

}