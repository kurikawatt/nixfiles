{ config
, lib
, pkgs
, inputs
, ...
}:
{
  programs.waybar = {
    
    settings.main = {

      modules-left = [ "group/cpu-temp" "memory" ];

      "group/cpu-temp" = {
        orientation = "horizontal";
        modules = [ "cpu" "custom/cpu-temp" ];
      };

      cpu = {
        interval = 10;
        format = "cpu : {usage}% ";
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

    };

    style = ''
      #custom-cpu-temp {
        color: #e0def4;
      }

      #custom-cpu-temp.critical {
        color: #eb6f92;
        font-weight: bold;
      }
    '';

  };
}
