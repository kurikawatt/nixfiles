{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
let
  inherit (osConfig.me) colors;
in
{
  services.mako = {
    enable = true;
    settings = {
      layer = "overlay";
      anchor = "top-center";
      width = 512;
      height = 256;
      margin = 10;
      padding = 24;
      font = "Cascadia Code 12";
      text-color = "#${colors.foreground}";
      background-color = "#${colors.background}";
      border-color = "#ec4067";
      default-timeout = 2500;
      "urgency=critical" = {
        default-timeout = 0;
      };
    };
  };
}