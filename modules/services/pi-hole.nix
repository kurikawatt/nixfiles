{
  config,
  lib,
  ...
}:
let
  inherit (config.me.services) pihole;
in 
lib.mkIf pihole.enable {

  services.pihole-web = {
    enable = true;
    ports = [ 8042 ];
  };

  services.pihole-ftl = {
    enable = true;
    settings = {
      dns.upstreams = [
        "9.9.9.9" # quad9
        "1.1.1.1" # CloudFlare
      ];

      dns.hosts = [
        "172.16.195.1 chord.lab"
        "172.16.195.2 metis.lab"
      ];
    };
    lists = [
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "hagezi blocklist";
      }
    ];
  };

}