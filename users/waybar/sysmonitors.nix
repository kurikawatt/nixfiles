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

      modules-left = (if osConfig.me.host.isLaptop then [ "battery" ] else [])
      ++ [ "group/cpu-temp" "memory" ];

      modules-right = [ "tray" ];

      "group/cpu-temp" = {
        orientation = "horizontal";
        modules = [ "cpu" "custom/cpu-temp" ];
      };

      cpu = {
        interval = 10;
        format = "cpu : {usage}%";
      };

      "custom/cpu-temp" = {
        exec = "~/scripts/average-cpu-temp.sh";
        interval = 10;
        return-type = "json";
        format = "({}°C)";
      };

      memory = {
        interval = 10;
        format = "mem : {used:0.1f}/{total:0.1f}Go";
      };

      tray = {
        spacing = 10;
        icon-size = 16;
      };

    };

    style = ''
      #battery,
      #custom-cpu-temp {
        margin: 5px;
        color: #${osConfig.me.colors.foreground};
      }

      #tray {
        margin: 10px;
      }

      #custom-cpu-temp {
        padding: 6px 6px;
      }

      #cpu, #memory {
        color: #${osConfig.me.colors.foreground};
      }

      #custom-cpu-temp.critical {
        color: #eb6f92;
        font-weight: bold;
      }
    '';

  };
}
