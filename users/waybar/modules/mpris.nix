{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.waybar = {
    settings.main = {

      modules-left = [ "mpris" ];

      mpris = {
        format = "{player_icon} {title} - {artist}";
        format-pause = "{title} - {artist}";
        format-stopped = "";

        player-icons = {
          default = "♫";
        };

      };

    };
    style = ''
      
    '';
  };
}
