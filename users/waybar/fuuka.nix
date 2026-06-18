{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
lib.mkIf osConfig.me.services.fuuka.enable {
  programs.waybar.settings.main = {
    modules-right = [ "network#fuuka" ];
    "network#fuuka" = {
      interface = "fuuka0";
      format = "Fuuka";
      tooltip-format = ''
        Strength : {signalStrength}%
        IP : {ipaddr}/{cidr}
        ↑ {bandwidthUpOctets} | ↓ {bandwidthDownOctets}
      '';
    };
  };
}
