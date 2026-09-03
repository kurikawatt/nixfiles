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
        format = "{title} - {artist}";
        format-pause = "{title} - {artist}";
        format-stopped = "";

        tooltip-format = ''
          Title: {title}
          Artist: {artist}
          Album: {album}'';

        ignored-players = [
          "firefox"
        ];

      };

    };
    style = ''
      #mpris {
        color: #${osConfig.me.colors.foreground};
        margin: 5px;
        padding: 6px 12px;
      }

      #mpris.paused {
        color: #99a1c4;
      }
    '';
  };
}
