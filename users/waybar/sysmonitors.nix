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
      ++ [ "group/cpu-temp" "memory" "tray" ];

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

      battery = {
        format = "{capacity}%";
        interval = 10;
        states = {
          warning = 30;
          critical = 10;
        };
        tooltip = false;
      };

    };

    style = ''

      #battery,
      #custom-cpu-temp {
        margin: 5px;
      }

      #tray {
        margin: 10px;
      }

      #custom-cpu-temp {
        padding: 6px 6px;
        color: #e0def4;
      }

      #custom-cpu-temp.critical {
        color: #eb6f92;
        font-weight: bold;
      }
      
      #battery {
        color: #061826;
        background-color: #3e8fb0;
      }

      #battery.warning {
        background-color: #f6c177;
      }

      #battery.critical,
      #battery.urgent {
        background-color: #eb6f92;
      }

      #battery.charging {
        background-color: #01CB5F;
      }
    '';

  };
}
