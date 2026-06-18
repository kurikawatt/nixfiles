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
      format-connected = "Fuuka";
      format-disabled = "";
      tooltip-format = "{ipaddr}/{cidr}\n↑ {bandwidthUpOctets} | ↓ {bandwidthDownOctets}";
    };
  };
}
