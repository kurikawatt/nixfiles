{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
lib.mkIf osConfig.me.host.isLaptop {
  programs.waybar = {
    settings.main = {
      battery = {
        format = "bat: {capacity}%";
        interval = 10;
        states = {
          warning = 30;
          critical = 10;
        };
        tooltip = false;
      };
    };
    style = ''
      #battery {
        color: #3e8fb0;
      }

      #battery.warning {
        color: #f6c177;
      }

      #battery.critical,
      #battery.urgent {
        color: #eb6f92;
      }

      #battery.charging {
        color: #01CB5F;
      }
    '';
  };
}
