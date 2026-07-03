{
  config,
  ...
}:
let 
  inherit (config) me;
in
{

  sops.secrets."networks-env" = {
    sopsFile = ../../secrets/networks.env;
    format = "dotenv";
    owner = "kurik";
  };

  networking = {

    firewall.enable = true;

    networkmanager = {
      enable = true;

      # Auto configure all wifis networks that may be used if laptop
      # else, it won't do anything
      ensureProfiles = if me.host.isLaptop then
        {
          environmentFiles = [
            config.sops.secrets."networks-env".path
          ];

          profiles = {

            Home = {
              connection = {
                id = "Home";
                type = "wifi";
                autoconnect = true;
	              autoconnect-priority = 1;
              };
              wifi.ssid = "$HOME_SSID";
              wifi-security = {
                key-mgmt = "wpa-psk";
                psk = "$HOME_PASS";
              };
            };

            Home_5Ghz = {
              connection = {
                id = "Home5";
                type = "wifi";
	              autoconnect = true;
	              autoconnect-priority = 2;
              };
              wifi.ssid = "$HOME_SSID_5";
              wifi-security = {
                key-mgmt = "wpa-psk";
                psk = "$HOME_PASS_5";
              };
            };

            Kuri = {
              connection = {
                id = "Kuri";
	              type = "wifi";
	              autoconnect = true;
	              autoconnect-priority = 0;
              };
              wifi.ssid = "$KURI_SSID";
              wifi-security = {
                key-mgmt = "wpa-psk";
	              psk = "$KURI_PASS";
              };
            };

            Eduroam = {
              connection = {
                id = "eduroam";
	              type = "wifi";
	              autoconnect = true;
	              autoconnect-priority = 1;
              };
              "802-1x" = {
                anonymous-identity = "$EDUROAM_ANONYMOUS";
	              eap = "ttls;";
	              identity = "$EDUROAM_LOGIN";
	              password = "$EDUROAM_PASS";
	              phase2-auth = "mschapv2";
              };
              wifi = {
                mode = "infrastructure";
	              ssid = "eduroam";
              };
              wifi-security = {
                auth-alg = "open";
	              key-mgmt = "wpa-eap";
              };
            };

          };
        }
      else {};
    };
    
  };
}