{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
{
  programs.waybar = {
    settings.main = {
      modules-right = [ "network" ]
      ++ (if osConfig.me.services.fuuka.enable then [ "network#fuuka" ] else []);
      network = {
        format-wifi = "{essid}";
        format-ethernet = "Wired";
        format-disconnected = "No Network";
        format-disabled = "Airplane Mode";
        tooltip-format = ''
          Strength : {signalStrength}%
          IP : {ipaddr}/{cidr}
          ↑ {bandwidthUpOctets} | ↓ {bandwidthDownOctets}
        '';
      };
    };
    style = ''
      #network {
        margin: 5px;
        padding: 6px 12px;
      }
    '';
  };
}
